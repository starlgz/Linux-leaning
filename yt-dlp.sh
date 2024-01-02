#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

echo "请输入视频链接:"
read -r video_url

# 列出视频格式和质量选项
formats=$($YT_DLP_COMMAND -F "$video_url")

echo "可用视频格式和质量选项："
echo "$formats"

# 选择视频格式和质量
read -p "选择一个数字对应的视频格式和质量: " video_format_number

# 下载视频和音频并合并
download_options="--format $video_format_number -o '%(title)s.%(ext)s'"
$YT_DLP_COMMAND "$video_url" $download_options
