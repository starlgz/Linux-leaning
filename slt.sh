#!/bin/bash

# 设置yt-dlp命令
YT_DLP_COMMAND="yt-dlp"
# 设置ffmpeg命令
FFMPEG_COMMAND="ffmpeg"

# 提示用户输入视频链接
echo "请输入视频链接:"
read -r video_url

# 获取视频缩略图 URL
thumbnail_url=$($YT_DLP_COMMAND --get-thumbnail "$video_url")

# 打印缩略图 URL
echo "视频缩略图 URL: $thumbnail_url"

# 用户选择是否下载缩略图，默认下载
read -p "是否下载缩略图？ (y/n, 默认为y): " download_thumbnail
download_thumbnail=${download_thumbnail:-y}

if [ "$download_thumbnail" == "y" ]; then
    # 下载缩略图
    $YT_DLP_COMMAND --write-thumbnail --skip-download "$video_url"
    echo "缩略图已下载！"

    # 检查缩略图格式并手动转换为JPEG
    thumbnail_extension="${thumbnail_url##*.}"
    if [ "$thumbnail_extension" == "webp" ]; then
        thumbnail_filename="${thumbnail_url##*/}"
        thumbnail_filename="${thumbnail_filename%.*}"
        jpeg_filename="$thumbnail_filename.jpg"
        
        # 使用ffmpeg手动转换为JPEG
        $FFMPEG_COMMAND -i "$thumbnail_filename.webp" "$jpeg_filename"
        
        echo "缩略图已手动转换为JPEG格式: $jpeg_filename"
    fi
else
    echo "不下载缩略图。"
fi
