#!/bin/bash

read -p "请输入要下载音频的 YouTube 视频链接：" video_url

# 构建命令
command="yt-dlp -x --audio-format mp3 $video_url"

# 执行命令
echo "正在下载音频..."
$command

echo "音频下载完成！"
