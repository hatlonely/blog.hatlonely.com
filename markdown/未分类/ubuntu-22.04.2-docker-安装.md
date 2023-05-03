---
title: ubuntu 22.04.2 docker 安装
date: "2023-5-3 20:25:01"
tags: ["docker", "ubuntu"]
categories: ["ubuntu"]
---

1. 设置 apt 仓库

```shell
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

2. 安装 docker

```shell
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. 检查是否安装成功

```shell
sudo docker run hello-world
```

## 参考链接

- docker 官网安装教程 [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
