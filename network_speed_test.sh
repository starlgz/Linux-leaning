#!/bin/bash

# 获取所有可用的测速服务器列表
function get_speedtest_servers() {
    speedtest-cli --list | grep -oP '(?<=\[\d+\] ).*(?= -)'
}

# 使用speedtest-cli在指定服务器上测量网络速度
function network_speed_test() {
    local server_id=$1
    local server_name=$2

    echo "正在测试服务器：$server_name [$server_id]..."
    speedtest-cli --server $server_id
    echo "====================================="
}

# 执行网络测速
function main() {
    local servers=$(get_speedtest_servers)
    local IFS=$'\n'

    for server_info in $servers; do
        local server_id=$(echo $server_info | grep -oP '^\[\d+\]' | tr -d '[]')
        local server_name=$(echo $server_info | grep -oP '(?<=- ).*$')

        network_speed_test $server_id "$server_name"
    }
}

main
