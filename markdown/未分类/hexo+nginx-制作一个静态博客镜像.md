---
title: hexo+nginx 制作一个静态博客镜像
date: 2023-04-30 22:47
tags: ["hexo", "nginx", "docker", "stellar"]
categories: ["博客"]
banner: hexo,stellar
---

hexo 是一个快速高效的博客框架，支持 markdown 编写，有非常丰富的主题样式，还有非常多插件可以选择。

hexo 原生就支持一键部署到 Github Pages 和 Heroku 等平台。也有一些场景，我们需要放到自己的服务器上，
就可以考虑制作一个 docker 镜像，这样可以比较方便地部署和维护。当前这个网站就是使用这种方式部署在一个家庭的网络环境内。

## 开发目录结构

这里没有依赖 hexo 的目录结构，而是将文章放到了一个叫 markdown 的目录中，hexo 目录存储 hexo 相关的配置，asset 存放一些静态资源。

## 镜像制作

hexo 依赖 node 环境，直接使用 node 镜像构建，生成静态资源后，拷贝到 nginx 镜像中。

首先参考 [hexo 官网](https://hexo.io/zh-cn/docs/) 安装 hexo：

```shell
npm install -g hexo-cli
npm install -g hexo
```

在参考 [stellar 主题](https://xaoxuu.com/wiki/stellar/theme-settings/) 配置主题：

```shell
npm install hexo-theme-stellar
```

拷贝文章，静态资源和配置到 hexo 中，再执行 `hexo generate` 生成静态资源目录 `public`。

最后将 public 目录拷贝到 nginx 的 `/usr/share/nginx/html` 目录即可。

## 完整的 Dockerfile

```dockerfile
FROM node:20.0.0-alpine3.17 AS build

# npm 访问国外比较慢，设置淘宝源加速
RUN npm config set registry https://registry.npm.taobao.org

# 安装 hexo
RUN npm install -g hexo-cli
RUN npm install -g hexo

# 初始化博客，安装 stellar 主题
RUN hexo init output && \
    rm -rf output/source/_posts/hello-world.md && \
    cd output && npm install hexo-theme-stellar && npm install

COPY asset asset
COPY hexo hexo
COPY markdown markdown

# 拷贝文章到 hexo 目录
RUN { \
      for path in $(find markdown -type f -name "*.md"); do \
	    cp ${path} output/source/_posts; \
	  done \
    } && \
    cp hexo/* output && \
	mkdir -p output/source/images && \
	cp asset/* output/source/images

# 生成静态文件
RUN cd output && hexo generate

FROM nginx:1.24

# 拷贝静态文件到 nginx 中
COPY --from=build /output/public /usr/share/nginx/html
```

## 参考链接

- hexo 官网: <https://hexo.io/zh-cn/>
- hexo 主题: <https://hexo.io/themes/>
- stellar 主题文档: <https://xaoxuu.com/wiki/stellar/#start>
- 源码: <https://github.com/hatlonely/blog.hatlonely.com>
