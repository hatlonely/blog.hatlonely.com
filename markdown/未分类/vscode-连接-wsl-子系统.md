---
title: vscode 连接 wsl 子系统
date: "2023-5-3 16:27:23"
tags: ["wsl", "vscode", "win11"]
categories: ["win11"]
---

wsl + vscode = 几乎完美的 linux 开发体验

## 总体架构

先来看一张微软官方的技术架构图

![wsl+vscode](https://code.visualstudio.com/assets/docs/remote/wsl/architecture-wsl.png)

可以看到其明显的 Client/Server 架构。

服务端 VS Code Server 运行在 WSL 子系统内部。程序的运行调试，以及终端命令都在 WSL 内部进行。
其文件系统包含两部分，一部分是子系统内部的文件系统，还有一部分是 windows 的文件系统，被直接 mount 到了子系统里面。这样就可以实现子系统对 windows 文件系统的访问。

客户端 VS Code 主要功能就是提供 UI 界面。

这样的结构将 VS Code 的实际运行环境和 UI 分开了，VS Code Server 其实也可以运行在真实的 Linux 主机上面，不过这种方式，文件系统就不能直接 mount 了。总之，这种 CS 架构给 VS Code 的开发带来了极大的灵活性和便利性。

## 安装

1. 安装 wsl，参考[win11-安装-wsl-linux-子系统](win11-安装-wsl-linux-子系统.md)；
2. 安装 vscode，应用商店（Microsoft Store）搜索 visual studio code；
3. vscode 中使用 wsl，`ctrl + shift + p`，调出命令框，键入 `wsl:`，选择 `wsl: reopen folder in windows` 即可
    - 首次打开会自动在子系统中安装需要的组件（注意需要联网）

## 常见问题

### 换行符不同导致大量变更

windows 和 linux 系统的默认换行符不同，可能会导致 git 判断所有文件都已经出现变更。可以在 windows 设置强制使用 linux 换行符。打开 powershell 输入如下命令即可替换所有的换行符为 linux 换行符：

```shell
git config core.autocrlf false
git rm --cached -r .
git reset --hard
```

全局设置不自动转换行符：

```shell
git config --global core.autocrlf false
```

vscode 中设置使用 Linux 换行符：

`ctrl + shift + p` 调出命令框 -> 输入 `open settings` -> 查找 `files.eol` 配置项 -> 改为 `\n` 即可。

## 参考链接

- wsl vscode 教程: <https://learn.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-vscode>
- vscode wsl 文档: <https://code.visualstudio.com/docs/remote/wsl>
