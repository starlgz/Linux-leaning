#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

if [ $# -eq 0 ]; then
    echo "请输入视频链接"
    exit 1
fi

video_url=$1

# 列出视频格式和质量选项
formats=$($YT_DLP_COMMAND -F "$video_url")

echo "可用视频格式和质量选项："
echo "$formats"

# 选择视频格式和质量
read -p "选择一个数字对应的视频格式和质量: " format_number

options="--format $format_number"

$YT_DLP_COMMAND "$video_url" $options
echo "视频下载完成！"
