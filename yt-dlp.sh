#!/bin/bash

download_video() {
    yt_dlp "$1" $2
}

update_ytdlp() {
    echo "正在检查并更新 yt-dlp..."
    yt_dlp --update
}

list_formats() {
    echo "可用视频格式和质量选项："
    yt_dlp --list-formats "$1"
}

download_video_menu() {
    read -p "请输入视频链接: " url

    # 列出视频格式和质量选项
    list_formats "$url"

    # 选择视频格式和质量
    read -p "选择一个数字对应的视频格式和质量: " format_number

    # 是否下载字幕
    read -p "是否下载字幕？ (y/n): " download_subtitles

    options="--format $format_number --outtmpl '%(title)s.%(ext)s'"
    
    if [ "$download_subtitles" == "y" ]; then
        options="$options --write-sub"
    fi

    download_video "$url" "$options"
    echo "下载完成！"
}

update_ytdlp_menu() {
    read -p "是否更新yt-dlp到最新版本？ (y/n): " update_option
    
    if [ "$update_option" == "y" ]; then
        update_ytdlp
        echo "yt-dlp 已更新到最新版本！"
    fi
}

thumbnail_menu() {
    read -p "写入缩略图到磁盘或列出可用缩略图？ (write/list/none): " thumbnail_option
    
    if [ "$thumbnail_option" == "write" ]; then
        read -p "写入所有缩略图格式到磁盘？ (y/n): " write_thumbnail_option
        options="--write-all-thumbnails"
        download_video "$url" "$options"
        echo "缩略图已写入磁盘！"
    elif [ "$thumbnail_option" == "list" ]; then
        options="--list-thumbnails"
        download_video "$url" "$options"
        echo "已列出可用的缩略图！"
    else
        echo "不执行任何缩略图相关操作。"
    fi
}

exit_menu() {
    echo "退出程序。"
    exit 0
}

main_menu() {
    while true; do
        echo "=== yt-dlp 使用功能菜单 ==="
        echo "1. 下载视频"
        echo "2. 更新 yt-dlp"
        echo "3. 缩略图相关操作"
        echo "4. 退出程序"
        
        read -p "请选择操作 (1-4): " choice
        
        case $choice in
            1)
                download_video_menu
                ;;
            2)
                update_ytdlp_menu
                ;;
            3)
                thumbnail_menu
                ;;
            4)
                exit_menu
                ;;
            *)
                echo "无效的选择，请重新输入。"
                ;;
        esac
    done
}

main_menu
rm -f "$0"
