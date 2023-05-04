---
title: win11-IPsec/L2TP-vpn-客户端设置
date: "2023-05-02 16:38"
tags: ["vpn", "win11", "l2tp"]
categories: ["win11"]
---

## 前置条件

已有 VPN 服务器 IPsec/L2TP 连接信息，必要信息样例如下：

```
Server IP: 123.45.67.89
IPsec PSK: RDinT71PKXywdkoVD4dG
Username: vpnuser
Password: hJ7hmxY86avKK9tP
```

## 设置步骤

1. 进入【设置】->【网络和 Internet】->【VPN】->【添加 VPN】
2. 添加 VPN 连接
    - 连接名称: vpn
    - 服务器名称或地址: `<Server IP>`
    - VPN 类型: 使用预共享秘钥的 L2TP/IPsec
    - 预共享秘钥: `<IPsec PSK>`
    - 用户名（可选）: `<Username>`
    - 密码（可选）: `<Password>`
3. 保存后连接即可（首次连接报错，参考常见问题）

## 快速连接

方法一：点击桌面左下角任务栏中的**网线图标** -> 点击 VPN 即可连接
方法二: [Wox](win11-效率工具-wox) 安装 VPN 插件，`alt + space` 调出 Wox 后，键入 `vpn` 即可

## 常见问题

### 连接网络连接错误

> 无法建立计算机与 VPN 服务器之间的网络连接，因为远程服务器未响应。这可能是因为未将计算机与远程服务器之间的某种网络设备(如防火墙、NAT、路由器等)配置为允许 VPN 连接。请与管理员或服务提供商联系以确定哪种设备可能产生此问题

**原因**

VPN 服务器和客户端 NAT 之间有兼容性问题

**解决方案**

1. 按 `win` 键搜索应用，输入 `cmd`，以管理员身份运行命令提示符
2. 输入如下指令

```shell
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f
```

3. 重启电脑后生效

## 参考链接

- setup-ipsec-vpc 项目地址: <https://github.com/hwdsl2/setup-ipsec-vpn>
- 客户端设置: <https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients-zh.md>
