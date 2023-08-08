#!/bin/bash

# Author: startlgz

# 开启BBR
enable_bbr() {
    echo "正在开启BBR..."
    
    # 检查是否已经开启BBR
    if lsmod | grep "tcp_bbr" &> /dev/null; then
        echo "BBR已经开启。"
    else
        echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
        echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
        sysctl -p
        
        echo "BBR已开启。"
    fi
}

# 关闭BBR
disable_bbr() {
    echo "正在关闭BBR..."
    
    # 检查是否已经关闭BBR
    if ! lsmod | grep "tcp_bbr" &> /dev/null; then
        echo "BBR已经关闭。"
    else
        sed -i '/net\.core\.default_qdisc = fq/d' /etc/sysctl.conf
        sed -i '/net\.ipv4\.tcp_congestion_control = bbr/d' /etc/sysctl.conf
        sysctl -p
        
        echo "BBR已关闭。"
    fi
}

# 主菜单
while true; do
    clear
    echo "BBR管理脚本"
    echo "1. 开启BBR"
    echo "2. 关闭BBR"
    echo "3. 退出"
    read -p "请选择一个选项： " choice
    
    case $choice in
        1)
            enable_bbr
            read -p "按回车键继续..."
            ;;
        2)
            disable_bbr
            read -p "按回车键继续..."
            ;;
        3)
            echo "正在退出..."
            exit 0
            ;;
        *)
            echo "无效的选项。请重新选择。"
            read -p "按回车键继续..."
            ;;
    esac
done
