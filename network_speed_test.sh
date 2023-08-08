#!/bin/bash

# 安装speedtest-cli（如果未安装）
if ! command -v speedtest &>/dev/null; then
    echo "安装speedtest-cli..."
    sudo apt update
    sudo apt install speedtest-cli -y
fi

# 测速函数
function network_speed_test() {
    echo "开始测试服务器：$1"
    speedtest-cli --server "$2" > /dev/null
    echo "====================================="
}

# 执行网络测速
function main() {
    network_speed_test "中国上海移动" 5862
    network_speed_test "中国北京电信" 3633
    network_speed_test "中国广州电信" 5083
    network_speed_test "新加坡" 18220
    network_speed_test "美国西部" 5117
}

main
