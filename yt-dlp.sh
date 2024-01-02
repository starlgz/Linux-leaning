#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

download_video() {
    $YT_DLP_COMMAND "$1" $2
}

list_formats() {
    $YT_DLP_COMMAND -F "$1"
}

list_subs() {
    $YT_DLP_COMMAND --list-subs "$1"
}

download_video_menu() {
    read -p "请输入视频链接: " url

    # 列出视频格式和质量选项
    list_formats "$url"

    # 选择视频格式和质量
    read -p "选择一个数字对应的视频格式和质量: " format_number

    # 是否下载字幕
    read -p "是否下载字幕？ (y/n): " download_subtitles

    if [ "$download_subtitles" == "y" ]; then
        # 列出字幕格式选项
        list_subs "$url"

        # 选择字幕格式
        read -p "选择一个数字对应的字幕格式: " subtitle_format
        options="--format $format_number --outtmpl '%(title)s.%(ext)s' --write-sub --sub-format $subtitle_format"
    else
        options="--format $format_number --outtmpl '%(title)s.%(ext)s'"
    fi

    download_video "$url" "$options"
    echo "视频下载完成！"
}

main_menu() {
    while true; do
        echo "=== yt-dlp 视频下载菜单 ==="
        echo "1. 下载视频"
        echo "2. 查看视频格式和质量"
        echo "3. 查看字幕格式"
        echo "4. 退出程序"
        
        read -p "请选择操作 (1-4): " choice
        
        case $choice in
            1)
                download_video_menu
                ;;
            2)
                read -p "请输入视频链接: " url
                list_formats "$url"
                ;;
            3)
                read -p "请输入视频链接: " url
                list_subs "$url"
                ;;
            4)
                echo "退出程序。"
                exit 0
                ;;
            *)
                echo "无效的选择，请重新输入。"
                ;;
        esac
    done
}

main_menu
