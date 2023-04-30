---
title: hexo+nginx 制作一个静态博客镜像
date: 2023-04-30 22:47
tags: ["hexo", "nginx", "docker", "stellar"]
categories: ["博客"]
---

hexo 是一个快速高效的博客框架，支持 markdown 编写，有非常丰富的主题样式，还有非常多插件可以选择。

hexo 原生就支持一键部署到 Github Pages 和 Heroku 等平台。也有一些场景，我们需要放到自己的服务器上，
就可以考虑制作一个 docker 镜像，这样可以比较方便地部署和维护。当前这个网站就是使用这种方式部署在一个家庭的网络环境内。

## 

## 参考链接

- hexo 官网: <https://hexo.io/zh-cn/>
- hexo 主题: <https://hexo.io/themes/>
- stellar 主题文档: <https://xaoxuu.com/wiki/stellar/#start>
- element 主题项目地址: <https://github.com/artchen/hexo-theme-element>