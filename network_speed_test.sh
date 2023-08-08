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

# 执行网络测速
function main() {
    # 手动选择测速服务器，包含3个中国服务器和其他一些国际服务器
    local servers=(
        "[5862] 中国上海移动 - CMC"
        "[3633] 中国北京电信 - China Telecom Beijing"
        "[5083] 中国广州电信 - China Telecom Guangzhou"
        "[18220] 新加坡 - Singtel (Singapore)"
        "[1902] 印度班加罗尔 - Excitel (Bangalore, India)"
        "[3630] 韩国首尔SKB - SK Broadband (Seoul, Korea)"
        "[24218] 俄罗斯莫斯科 - Rostelecom (Moscow, Russia)"
        "[24220] 西班牙马德里 - Telefonica (Madrid, Spain)"
    )

    for server_info in "${servers[@]}"; do
        network_speed_test "$server_info"
    done
}

main
