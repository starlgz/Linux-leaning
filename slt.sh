#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

echo "请输入视频链接:"
read -r video_url

# 下载缩略图（格式为jpg）
$YT_DLP_COMMAND --output "%(title)s_thumbnail.jpg" --write-thumbnail "$video_url"

echo "缩略图已下载！"
