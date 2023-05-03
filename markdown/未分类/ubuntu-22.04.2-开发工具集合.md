---
title: ubuntu 22.04.2 开发工具集合
date: "2023-5-3 20:54:09"
tags: ["golang", "ubuntu", "开发环境"]
categories: ["ubuntu"]
---

## apt 更新

```shell
sudo apt update
sudo apt upgrade -y
```

## zsh

```shell
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh
```

## jq

```shell
sudo apt install -y jq
jq --version
```

## kubectl

```shell
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

## golang

```shell
sudo apt install -y golang-go
go version
```

## 目录树

```shell
sudo apt install -y tree
```

## 参考链接

- [Install and Set Up kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [How to install Go on Ubuntu 22.04](https://www.fosslinux.com/68795/install-go-on-ubuntu.htm)
