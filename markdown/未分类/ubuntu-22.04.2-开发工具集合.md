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

## make

```shell
sudo apt install -y make
```

## java

```shell
sudo apt install -y openjdk-17-jdk
sudo apt install -y openjdk-17-jre
```

## bash

Ubuntu 22.04 默认的 sh 改成了 dash，通过如下命令，重新修改回 bash

```shell
sudo dpkg-reconfigure dash
# 选择 No
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
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod 755 kubectl && sudo mv kubectl /usr/bin/kubectl
```

## helm

```shell
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt install -y apt-transport-https
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm
```

安装 helm-diff 插件

```shell
helm plugin install https://github.com/databus23/helm-diff
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
