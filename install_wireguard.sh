#!/bin/bash

# 一键安装和配置 WireGuard VPN

# 安装依赖
apt update
apt install -y iproute2 openresolv iptables
apt install -y wireguard-tools --no-install-recommends

# 下载必要的文件
curl -L https://www.baipiao.eu.org/wireguard/wg-quick.sh -o wg-quick.sh
curl -L https://www.baipiao.eu.org/wireguard/wireguard-go-linux-amd64 -o wireguard-go
curl -L https://www.baipiao.eu.org/warp/warp-linux-amd64 -o warp
curl -L https://www.baipiao.eu.org/wireguard/wireguard-go.sh -o wireguard-go.sh

# 赋予执行权限
chmod +x wg-quick.sh wireguard-go warp

# 将 wireguard-go 移动到 /usr/bin 目录下
cp wireguard-go /usr/bin/wireguard-go

# 手动修改 WireGuard 配置文件
# 请使用你喜欢的文本编辑器打开 wireguard-go.sh 文件，并按照需要修改其中的 WireGuard 配置信息

# 运行 WireGuard 配置脚本
./wireguard-go.sh
