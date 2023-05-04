---
title: golang singleflight 库
date: "2023-5-5 01:28:52"
tags: ["singleflight", "golang", "并发", "缓存"]
categories: ["golang"]
---

我们在访问后端数据的时候通常都会并发访问，为了减轻后端的压力，通常会使用缓存，对于命中缓存的数据，直接使用本地的数据，从而大大地减少了对后端的访问压力。但是在没有命中缓存的场景，数据还是会直接打到后端，从而对后端造成压力，甚至直接击穿缓存，打爆后端服务。

其中有一个场景，多协程同时并发访问相同的数据而又没有命中缓存的场景，是可以用 `golang.org/x/sync/singleflight` 优化的。singleflight 可以将多个相同的请求合并起来，仅访问一次后端，从而大大减少对后端的压力。

## 函数签名

`golang.org/x/sync/singleflight` 主要包含 `singleflight.Group` 结构。该结构主要提供三个方法

- `Do(key, fn)`：同步执行 fn，同时执行相同的 key 只会执行第一次 fn，阻塞等待结果返回
- `DoChan(key, fn)`: 异步执行 fn，同时执行相同的 key 只会执行第一次 fn，立即返回 chan
- `Forget(key)`: 忘记当前正在执行的 key，后面的 `Do/DoChan` 方法将发起新的 fn 调用

## Do

阻塞等待结果返回的调用

```go
Do(key string, fn func() (interface{}, error)) (v interface{}, err error, shared bool)
```

参数

- `key`: 键，该键上有正在执行的请求，就不会发起新的请求调用
- `fn`: 后端请求调用逻辑

返回

- `v`: 返回结果
- `err`: 错误
- `shared`: 该结果是否与其他调用共享

举个例子

```go
func TestSingleFlightDo(t *testing.T) {
	var sf singleflight.Group

	for i := 0; i < 10; i++ {
		res, err, shared := sf.Do("key", func() (interface{}, error) {
			return "value", nil
		})
		fmt.Println(res, err, shared)
	}
}
```

上面的例子中发起了 10 个 func 调用，Do 方法会阻塞等待结果返回，因此每次都会等待调用完成，才会发起下一条调用，这些调用不是同时发生，不会共享结果，会输出

```text
value0 <nil> false
value1 <nil> false
value2 <nil> false
value3 <nil> false
value4 <nil> false
value5 <nil> false
value6 <nil> false
value7 <nil> false
value8 <nil> false
value9 <nil> false
```

再来看一个并发的例子

```go
func TestSingleFlightDoParallel(t *testing.T) {
	var wg sync.WaitGroup
	var sf singleflight.Group

	ress := make([]interface{}, 10)
	errs := make([]interface{}, 10)
	shared := make([]bool, 10)
	for i := 0; i < 10; i++ {
		wg.Add(1)
		go func(i int) {
			ress[i], errs[i], shared[i] = sf.Do("key", func() (interface{}, error) {
				time.Sleep(2 * time.Second)
				return fmt.Sprintf("value%d", i), nil
			})
			wg.Done()
		}(i)
	}

	wg.Wait()
	for i := 0; i < 10; i++ {
		fmt.Println(ress[i], errs[i], shared[i])
	}
}
```

这个例子中并发执行了 10 个调用，并且执行的 key 相同，因此只会发起一次调用，所有的结果都返回该次调用的结果，输出如下

```
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
value9 <nil> true
```

## DoChan

上面的 Do 在并发执行的时候，需要手动创建协程，还要引入 `sync.WaitGroup` 来处理父子协程之间的同步，使用上面不是特别方便。DoChan 提供了异步执行机制，可以立即返回一个 chan，在需要使用时，从 chan 中取出结果即可。

```go
DoChan(key string, fn func() (interface{}, error)) <-chan Result
```

参数

- `key`: 键，该键上有正在执行的请求，就不会发起新的请求调用
- `fn`: 后端请求调用逻辑

返回

- `chan Result`: 返回结果 chan

```go
func TestSingleFlightDoChan(t *testing.T) {
	var sf singleflight.Group
	chs := make([]<-chan singleflight.Result, 10)

	for i := 0; i < 10; i++ {
		chs[i] = sf.DoChan("key", func() (interface{}, error) {
			time.Sleep(2 * time.Second)
			return "value", nil
		})
	}

	for i := 0; i < 10; i++ {
		res := <-chs[i]
		fmt.Println(res.Val, res.Err, res.Shared)
	}
}
```

这个例子中和上面的 `TestSingleFlightDoParallel` 一样。可以看出来，使用 DoChan 之后，就不需要使用 `sync.WaithGroup` 机制来等待同步等待结果返回了。

## Forget

不难发现，singleflight 的机制可能会因为某一个请求一直没有返回，而阻塞所有的请求。因此 singleflight 提供了 `Forget` 机制，可以在任何时候主动调用 `Forget`，从而在下次调用时立马发起新的请求。

```go
Forget(key string)
```

参数

- key: 要忘记的键，忘记之后，新的调用将发起新的请求

```go
func TestSingleFlightForget(t *testing.T) {
	var sf singleflight.Group

	// 构造一个超时的请求
	ch1 := sf.DoChan("key", func() (interface{}, error) {
		time.Sleep(2 * time.Second)
		return nil, errors.New("timeout")
	})

	// 之后的请求发现已有一个请求，不会发起新的请求，从而都会超时
	for i := 0; i < 10; i++ {
		ch2 := sf.DoChan("key", func() (interface{}, error) {
			return "value", nil
		})
		select {
		case res := <-ch2:
			fmt.Println(res.Val, res.Err, res.Shared)
		case <-time.After(100 * time.Millisecond):
			fmt.Println("timeout")
		}
	}

	// 忘记前面的 key
	sf.Forget("key")

	// 之后的请求将重新发起新的请求，从而拿到正确的结果
	for i := 0; i < 10; i++ {
		ch2 := sf.DoChan("key", func() (interface{}, error) {
			return "value", nil
		})
		select {
		case res := <-ch2:
			fmt.Println(res.Val, res.Err, res.Shared)
		case <-time.After(100 * time.Millisecond):
			fmt.Println("timeout")
		}
	}

	// 最初的请求在函数体返回之后，返回超时
	res := <-ch1
	fmt.Println(res.Val, res.Err, res.Shared)
}
```

就如这个例子所展示的，Forget 在主要用于处理超时的场景。输出如下：

```
timeout
timeout
timeout
timeout
timeout
timeout
timeout
timeout
timeout
timeout
value <nil> false
value <nil> false
value <nil> false
value <nil> false
value <nil> false
value <nil> false
value <nil> false
value <nil> false
value <nil> false
value <nil> false
<nil> timeout true
```

## 参考链接

- [源码地址](https://github.com/hatlonely/hellogolang/blob/master/internal/buildin/singleflight_test.go)
