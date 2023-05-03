---
title: ubuntu 22.04.2 golang 开发环境
date: "2023-5-3 20:54:09"
tags: ["golang", "ubuntu", "开发环境"]
categories: ["ubuntu"]
---

1. 安装 golang

```shell
sudo apt update
sudo apt upgrade -y
sudo apt install -y golang-go
```

2. 查看 go 版本，安装成功会输出 go 版本

```shell
go version
```

3. 卸载 golang

```shell
sudo apt-get remove golang-go
```

## 参考链接

- [How to install Go on Ubuntu 22.04](https://www.fosslinux.com/68795/install-go-on-ubuntu.htm)
