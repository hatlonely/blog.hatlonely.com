---
title: stable diffusion win11 安装
date: "2023-5-13 22:15:43"
tags: ["stable diffusion", "win11", "ai"]
categories: ["stable diffusion"]
---

先来看下安装后的结果

![](/images/stable-diffusion-win11-%E5%AE%89%E8%A3%85/stable-diffusion-webui.png)

很多资源都在 github 上面，网络不好，需要 vpn，没有稳定的 vpn 安装过程不太顺畅。

## 关于硬件

显卡要求比较高 3090 显卡，出图的时候直接打满，512 * 768 的图，需要 10 秒左右。
显存需要比较大，不然出比较大的图可能会直接报内存错误，3090 的显存是 24G。
不过也可以出个小图，再用高分辨率修复。对 CPU 要求相对不高（相比显卡），12700KF 没有压力。

## 安装 python

```shell
winget install -e --id Python.Python -v 3.10.11
```

## 安装 git

参考[win11-git-开发环境](/2023/05/13/win11-git-开发环境)

## 安装 cuda 开发包

cuda 官网选择自己的显卡型号，下载并安装对应的开发包

> **注**：不安装也可以跑，但是不会使用 GPU，出图速度非常慢

## 安装 stable diffusion

参考 [stable-diffusion-webui 项目](https://github.com/AUTOMATIC1111/stable-diffusion-webui) README 即可

1. 下载 stable-diffusion-webui 项目

```shell
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
```

2. 双击 `webui-user.bat` 即可运行
    - 首次运行，会需要安装很多 python 包和 github 库，如果不成功就手动找资源安装一下
3. 成功运行提示运行在本地的 URL 链接，默认为 <http://127.0.0.1:7860>，在浏览器中打开链接即可

## 中文汉化

1. 运行 stable-diffusion-webui，并在浏览器中打开网址 <http://127.0.0.1:7860>
2. **Extensions** -> **Avaliable** -> localization 前面的勾去掉 -> 点 Load
3. **Search** 中输入 zh，选择 `zh_Hans Localization localization` 安装

## 中英对照

有些资料是英文的，为了找到原来的按钮，中文对照比较方便一点。参考 [stable-diffusion-webui 中英对照插件项目](https://github.com/journey-ad/sd-webui-bilingual-localization) README 即可

1. **Extension** -> **Install from URL** `https://github.com/journey-ad/sd-webui-bilingual-localization`
2. **Setting** -> **User interface** -> **Localization** 设置为 `None`
3. **Apply settings** -> **Reload UI**
4. **Setting** -> **Bilingual Localization**，选择 `zh-Hans(Stable)`
5. **Apply settings** -> **Reload UI**

## controlnet 插件

**Extensions** -> **Install from URL** `https://github.com/Mikubill/sd-webui-controlnet.git`
或者直接在插件中搜索 `controlnet` 安装

## 模型下载

默认只有一个模型，可以自己去 <https://civitai.com/> 自己下载各种风格的模型。需要 vpn 才可访问，但是下载不需要 vpn，模型下载速度很快。

- 标签为 `checkpoint` 是主要的模型，一般放到 `models/Stable-diffusion` 目录下，每次出图都需要一个模型
- 标签为 `lora` 的模型是风格模型，一般放到 `models/Lora` 目录下，每次出图可以在提示词（prompt）中指定风格模型，也可以指定多种风格，并为每种风格指定权重

## 链接

- [stable-diffusion-webui 项目地址](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
- [civitai 模型下载](https://civitai.com/)
- [cuda 开发工具](https://developer.nvidia.com/cuda-downloads)
- [stable-diffusion-webui 中英对照插件项目地址](https://github.com/journey-ad/sd-webui-bilingual-localization)
- [stable-diffusion-webui controlnet 插件](https://github.com/Mikubill/sd-webui-controlnet)
