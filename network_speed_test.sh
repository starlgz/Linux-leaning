#!/bin/bash

# 安装speedtest-cli（如果未安装）
if ! command -v speedtest &>/dev/null; then
    echo "安装speedtest-cli..."
    sudo apt update
    sudo apt install speedtest-cli -y
fi

# 测速函数
function network_speed_test() {
    local server_info="$1"
    local server_id=$(echo "$server_info" | grep -oP '^\[\d+\]' | tr -d '[]')
    local server_name=$(echo "$server_info" | grep -oP '(?<=- ).*$')

    echo "正在测试服务器：$server_name [$server_id]..."
    speedtest-cli --server "$server_id"
    echo "====================================="
}

# 获取所有可用的测速服务器列表
function get_speedtest_servers() {
    speedtest-cli --list | grep -oP '(?<=\[\d+\] ).*(?= -)'
}

# 执行网络测速
function main() {
    local servers=$(get_speedtest_servers)
    local IFS=$'\n'

    for server_info in $servers; do
        network_speed_test "$server_info"
    done
}

main
