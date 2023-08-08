#!/bin/bash

# Author: 满天繁星

# 开启BBR
enable_bbr() {
    echo "正在开启BBR..."
    
    # 检查是否已经开启BBR
    if lsmod | grep "tcp_bbr" &> /dev/null; then
        echo -e "\e[32mBBR已经开启。\e[0m"
    else
        echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
        echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
        sysctl -p
        
        echo -e "\e[32mBBR已开启。\e[0m"
    fi
}

# 关闭BBR
disable_bbr() {
    echo "正在关闭BBR..."
    
    # 检查是否已经关闭BBR
    if ! lsmod | grep "tcp_bbr" &> /dev/null; then
        echo -e "\e[32mBBR已经关闭。\e[0m"
    else
        sed -i '/net\.core\.default_qdisc = fq/d' /etc/sysctl.conf
        sed -i '/net\.ipv4\.tcp_congestion_control = bbr/d' /etc/sysctl.conf
        sysctl -p
        
        echo -e "\e[32mBBR已关闭。\e[0m"
    fi
}

# 检查BBR状态
check_bbr_status() {
    echo "正在检查BBR状态..."
    
    if lsmod | grep "tcp_bbr" &> /dev/null; then
        echo -e "\e[32mBBR已经开启。\e[0m"
    else
        echo -e "\e[32mBBR未开启。\e[0m"
    fi
}

# 主菜单
while true; do
    clear
    echo -e "\e[33mBBR管理脚本\e[0m"
    echo -e "1. \e[34m开启BBR\e[0m"
    echo -e "2. \e[34m关闭BBR\e[0m"
    echo -e "3. \e[34m检查BBR状态\e[0m"
    echo -e "4. \e[31m退出\e[0m"
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
            check_bbr_status
            read -p "按回车键继续..."
            ;;
        4)
            echo "正在退出..."
            exit 0
            ;;
        *)
            echo "无效的选项。请重新选择。"
            read -p "按回车键继续..."
            ;;
    esac
done
