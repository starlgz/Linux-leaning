#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

echo "请输入视频链接:"
read -r video_url

# 列出视频格式和质量选项
formats=$($YT_DLP_COMMAND -F "$video_url")

echo "可用视频格式和质量选项："
echo "$formats"

# 选择视频格式和质量
read -p "选择一个或多个数字对应的视频格式和质量 (用逗号分隔): " format_numbers

IFS=',' read -ra formats_array <<< "$format_numbers"

options=""
for format_number in "${formats_array[@]}"; do
  options+="--format $format_number "
done

$YT_DLP_COMMAND "$video_url" $options
echo "视频下载完成！"
