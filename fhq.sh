#!/bin/bash

# 安装 nftables（如果尚未安装）
if ! command -v nft &> /dev/null; then
    echo "安装 nftables..."
    sudo apt update
    sudo apt install nftables -y
    echo "nftables 已安装。"
fi

function add_rule() {
    read -p "请输入表格名: " table
    read -p "请输入链名: " chain
    read -p "请输入规则: " rule
    sudo nft add rule $table $chain $rule
    echo "规则已添加。"
}

function delete_rule() {
    read -p "请输入表格名: " table
    read -p "请输入链名: " chain
    read -p "请输入要删除的规则的位置: " rule_position
    sudo nft delete rule $table $chain $rule_position
    echo "规则已删除。"
}

while true; do
    clear
    echo "===== nftables 防火墙管理菜单 ====="
    echo "1. 查看当前规则"
    echo "2. 添加规则"
    echo "3. 删除规则"
    echo "4. 保存配置到文件"
    echo "5. 加载配置文件"
    echo "6. 创建新表格"
    echo "7. 创建新链"
    echo "8. 显示帮助"
    echo "9. 退出"

    read -p "请选择操作 [1-9]: " choice

    case $choice in
        1)
            sudo nft list ruleset
            ;;
        2)
            add_rule
            ;;
        3)
            delete_rule
            ;;
        4)
            sudo nft list ruleset > /etc/nftables.conf
            echo "配置已保存到 /etc/nftables.conf。"
            ;;
        5)
            sudo nft -f /etc/nftables.conf
            echo "配置文件已加载。"
            ;;
        6)
            read -p "请输入新表格名称: " new_table
            sudo nft add table ip $new_table
            echo "表格 $new_table 已创建。"
            ;;
        7)
            read -p "请输入表格名: " table
            read -p "请输入新链名称: " new_chain
            sudo nft add chain $table $new_chain { type filter hook input priority 0\; policy drop\; }
            echo "链 $new_chain 已创建。"
            ;;
        8)
            echo "帮助信息..."
            ;;
        9)
            echo "再见！"
            exit 0
            ;;
        *)
            echo "无效的选择，请重新输入。"
            ;;
    esac

    read -p "按 Enter 键继续..."
done
