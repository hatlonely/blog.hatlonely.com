---
title: 制作 win11 安装U盘
date: "2023-05-02 17:24"
tags: ["win11", "装系统", "启动盘"]
categories: ["win11"]
---

## 前置条件

1. 一个U盘，容量不低于 16G
2. 一台 windows 电脑（需要讲 U 盘格式化成 exFAT）

## 制作步骤

1. 进入微软官网下载[镜像](https://www.microsoft.com/zh-cn/software-download/windows11)
    - 下载 Windows 11 磁盘映像（ISO）
    - 选择下载项，按需选择，笔者选择的是 Windows 11（multi-edition ISO）
        - Windows 11（multi-edition ISO）包含家庭版，专业版，教育版
        - Windows 11 家庭版（仅限中国），仅包含家庭版，比专业版少了一些家庭不是很必要的软件
2. 下载安装 [UltraISO](https://cn.ultraiso.net/xiazai.html)，免费下载试用即可，如果已有安装，可以跳过此步骤
3. 打开 UltraISO 软件，点击**继续试用**即可
4. 点击**文件**->**打开**步骤 1 中下载的镜像
5. 点击**启动**->**写入硬盘映像**，勾选**刻入校验**，点击**写入**，等待刻入完成即可，大概需要十多分钟

## 参考链接

- 微软官网 windows 11 镜像: <https://www.microsoft.com/zh-cn/software-download/windows11>
- UltraISO 下载: <https://cn.ultraiso.net/xiazai.html>
