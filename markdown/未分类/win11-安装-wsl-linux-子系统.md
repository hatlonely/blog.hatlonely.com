---
title: win11-安装-wsl-linux-子系统
date: "2023-5-3 01:27:47"
tags: ["wsl", "win11", "ubuntu"]
categories: ["win11"]
---

wsl 是 Windows Subsystem for Linux 的缩写，可以在 Windows 下通过虚拟化平台运行 linux 子系统，从而使用 linux 下的命令，这对于程序员来说，极大地方便了开发，特别是服务端开发。

## wsl 安装

直接在应用商店（Microsoft Store）中搜索 wsl 即可，安装 `Windows Subsystem for Linux` 以及 `Ubuntu 22.04.2 LTS`

## 常见问题

### 运行子系统报错

> WslRegisterDistribution failed with error: 0x80370114

**原因**

win11 专业版默认没有开启虚拟化服务服务，对应的软件也没有安装，需要手动安装

**解决方案**

1. **设置**->**应用**->**可选功能**-> 滚动到最下面**更多 Windows 功能**
2. 启用**适用于 Linux 的 Windows 子系统**和**虚拟机平台**功能
3. 重启电脑

## 参考链接

- Fix the WslRegisterDistribution Failed Error With 0x80070032 Code: <https://softwarekeep.com/help-center/fix-the-wslregisterdistribution-failed-error-with-0x80070032-code>
