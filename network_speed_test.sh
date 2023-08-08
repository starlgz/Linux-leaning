#!/bin/bash

# 安装speedtest-cli（如果未安装）
if ! command -v speedtest &>/dev/null; then
    echo "安装speedtest-cli..."
    sudo apt update
    sudo apt install speedtest-cli -y
fi

# 测速函数
function network_speed_test() {
    local server_name="$1"
    local server_id="$2"

    echo "正在测试服务器：$server_name [$server_id]..."
    speedtest-cli --server "$server_id" > /dev/null
    echo "====================================="
}

# 执行网络测速
function main() {
    # 手动选择测速服务器，包含3个中国服务器和其他一些国际服务器
    local servers=(
        "中国上海移动" "30487"
        "中国北京电信" "35403"
        "中国广州电信" "5083"
        "新加坡" "1902"
        "美国西部" "6739"
    )

    for ((i=0; i<${#servers[@]}; i+=2)); do
        network_speed_test "${servers[i]}" "${servers[i+1]}"
    done
}

main
