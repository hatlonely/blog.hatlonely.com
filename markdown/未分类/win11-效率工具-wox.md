---
title: win11 效率工具 wox
date: "2023-5-3 02:38:21"
tags: ["wox", "win11", "效率"]
categories: ["win11"]
---

## 安装

1. 应用商店 **Microsoft Store** 搜索 `python`，下载 Python 3.11；
2. 下载最新的 [wox 版本](https://github.com/Wox-launcher/Wox/releases)，下载并 `Wox.exe` 和 `Everything.exe`
3. 任务栏中右键图标，设置 Wox
    - **General** -> **Language** -> 设置成**中文** -> 勾选**启动拼音模块**
    - **主题** -> 选择 **BlurBlack**
4. 通过快捷键 `alt + space` 可以调起命令板

## 插件

在 <http://www.wox.one/plugin> 浏览插件，安装插件的方式也很简单，直接在输入框中输入安装命令即可。

- `wpm install Clipboard History`: 历史剪切板。键入 `cb` 调起；
    - 剪切板需要通过 `cb` 调起，不太直接
    - 重启 wox 后，剪切板会丢失，没有持久化的历史剪切板，这一点体验差很多
- `wpm install IP Address`: 查看本机 ip 地址，包括公网和私网。键入 `ipadr` 调起；
- `wpm install 有道翻译`: 有道翻译。键入 `yd` 调起；
- `wpm install GUIDGen`: GUID 生成器。键入 `guid` 调起，`-g` 参数重新生成；
- `wpm install JSON`: json 格式化，复制 json 到剪切板，键入 `json`，即可在剪切板中得到格式化的 `json`；
    - 格式化有些不太对
- `wpm install VPN`: 快速链接和断开 vpn。键入 `vpn` 调起；
- `wpm install Timestamp`: 本地时间和时间戳互转。键入 `ts` 调起；
    - 依赖比较老的 python 版本，python 3.11 上无法使用

## 使用体验

总体上来说和 mac 下的 Alfred 在体验上有较大差距。

剪切板功能没有单独的快捷键，必须输入前缀才能调起，对于剪切板重度用户来说，体验上差了很多。
此外没有持久化的能力，每次重启电脑都会导致剪切板清空，这和 Alfred 可以自己设置保存剪切板时间相比，
简直就是一个不可用状态，要知道赋值粘贴一个月前之前的数据也是非常常见的，比如每个月需要重复做得工作。

依赖 python 3.7 的环境，大部分组件也都是基于 python 3.7 开发，而 python 3.7 和最新的 python 3.9+ 版本
并不兼容，这导致必须要安装老的 python 3.7 的版本，插件才不会出现兼容性问题。看项目也好多年没有更新了，
大概率后面也不会改了。

## 参考链接

- 项目地址: <https://github.com/Wox-launcher/Wox>
- 下载地址: <https://github.com/Wox-launcher/Wox/releases>
- 插件地址: <http://www.wox.one/plugin>
