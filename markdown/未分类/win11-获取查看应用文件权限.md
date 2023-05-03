---
title: win11 获取查看应用文件权限
date: "2023-5-3 11:45:57"
tags: ["win11", "Microsoft Store"]
categories: ["win11"]
---

windows11 默认隐藏了从应用商店安装的应用的文件夹，并且普通用户没有访问权限。有时一些软件依赖需要这些应用的路径，就不太方便了。

## 显示隐藏文件

windows11 的应用安装目录在 `C:\Program Files\WindowsApps`，这个文件夹默认是隐藏的。

通过如下方式可以显示隐藏目录：

1. 进入 `C:\Program Files` 目录
2. 菜单栏的 **...**；
3. 找到**选项**；
4. 选择**查看**选项卡；
5. 打开**显示隐藏的文件、文件夹和驱动器**。

此时点击目录会提示没有权限访问。

## 授权用户访问权限

普通用户没有访问 `C:\Program Files\WindowsApps` 的权限。需要将用户添加到超级管理员组才可以。

1. 双击目录，按找提示点击**继续**授权；
2. 进入 **安全选项卡** -> 点击**高级** -> 点击**变更**；
3. 在弹出用户或用户组对话框点击**高级**，然后**立即查找**，找到自己的用户名，点击**确认**即可。

现在可以进入目录了。

## 参考链接

- [Where are Microsoft Store Apps Installed in Windows 11?](https://allthings.how/where-are-microsoft-store-apps-installed-in-windows-11/)
