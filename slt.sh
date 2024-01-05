#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

echo "请输入视频链接:"
read -r video_url

# 获取视频缩略图 URL
thumbnail_url=$($YT_DLP_COMMAND --get-thumbnail "$video_url")

# 提取缩略图文件名
thumbnail_filename=$(basename "$thumbnail_url")

# 打印缩略图 URL
echo "视频缩略图 URL: $thumbnail_url"

# 用户选择是否下载缩略图，默认下载
read -p "是否下载缩略图？ (y/n, 默认为y): " download_thumbnail
download_thumbnail=${download_thumbnail:-y}

if [ "$download_thumbnail" == "y" ]; then
    # 下载缩略图到 /root 目录下，并保留原始文件名
    $YT_DLP_COMMAND --skip-download --get-thumbnail "$video_url" -o "/root/$thumbnail_filename"
    
    if [ $? -eq 0 ]; then
        echo "缩略图已下载到 /root/$thumbnail_filename！"
    else
        echo "下载缩略图失败。"
    fi
else
    echo "不下载缩略图。"
fi
