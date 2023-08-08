#!/bin/bash

# 安装Docker
function install_docker() {
    echo "正在安装Docker..."
    # 根据Linux发行版添加安装Docker的命令
}

# 卸载Docker
function uninstall_docker() {
    echo "正在卸载Docker..."
    # 根据Linux发行版添加卸载Docker的命令
}

# 运行Docker容器
function run_docker_container() {
    echo "请输入您要运行的镜像名称："
    read image_name
    echo "请输入您要使用的容器名称："
    read container_name

    echo "请选择容器运行选项："
    echo "1. 在前台运行容器"
    echo "2. 在后台运行容器"
    read -p "请输入选项编号: " choice

    case "$choice" in
        1) docker run -it --name "$container_name" "$image_name" ;;
        2) docker run -d --name "$container_name" "$image_name" ;;
        *) echo "无效的选项，请重试。" ;;
    esac
}

# 查看Docker容器状态
function check_container_status() {
    echo "请输入您要查看状态的容器名称："
    read container_name
    docker ps -a -f name="$container_name"
}

# 停止Docker容器
function stop_docker_container() {
    echo "请输入您要停止的容器名称："
    read container_name
    docker stop "$container_name"
}

# 移除Docker容器
function remove_docker_container() {
    echo "请输入您要移除的容器名称："
    read container_name
    docker rm "$container_name"
}

# 列出所有Docker容器
function list_all_containers() {
    echo "正在列出所有Docker容器..."
    docker ps -a
}

# 列出Docker镜像
function list_docker_images() {
    echo "正在列出Docker镜像..."
    docker images
}

# 拉取Docker镜像
function pull_docker_image() {
    echo "请输入您要拉取的镜像名称："
    read image_name
    docker pull "$image_name"
}

# 删除Docker镜像
function remove_docker_image() {
    echo "请输入您要删除的镜像名称："
    read image_name
    docker rmi "$image_name"
}

# 显示Docker版本
function show_docker_version() {
    echo "正在显示Docker版本信息..."
    docker --version
}

# 主函数
function main() {
    while true; do
        echo "===== Docker 菜单 ====="
        echo "1. 安装/卸载 Docker"
        echo "2. 运行/停止 Docker容器"
        echo "3. 查看Docker容器状态"
        echo "4. 移除Docker容器"
        echo "5. 列出所有Docker容器"
        echo "6. 列出Docker镜像"
        echo "7. 拉取/删除Docker镜像"
        echo "8. 显示Docker版本"
        echo "0. 退出"
        read -p "请输入选项编号: " choice

        case "$choice" in
            1) 
                echo "请选择安装/卸载Docker选项："
                echo "1. 安装Docker"
                echo "2. 卸载Docker"
                read -p "请输入选项编号: " install_choice
                case "$install_choice" in
                    1) install_docker ;;
                    2) uninstall_docker ;;
                    *) echo "无效的选项，请重试。" ;;
                esac
                ;;
            2) 
                echo "请选择运行/停止Docker容器选项："
                echo "1. 运行Docker容器"
                echo "2. 停止Docker容器"
                read -p "请输入选项编号: " run_choice
                case "$run_choice" in
                    1) run_docker_container ;;
                    2) stop_docker_container ;;
                    *) echo "无效的选项，请重试。" ;;
                esac
                ;;
            3) check_container_status ;;
            4) remove_docker_container ;;
            5) list_all_containers ;;
            6) list_docker_images ;;
            7) 
                echo "请选择拉取/删除Docker镜像选项："
                echo "1. 拉取Docker镜像"
                echo "2. 删除Docker镜像"
                read -p "请输入选项编号: " image_choice
                case "$image_choice" in
                    1) pull_docker_image ;;
                    2) remove_docker_image ;;
                    *) echo "无效的选项，请重试。" ;;
                esac
                ;;
            8) show_docker_version ;;
            0) echo "正在退出..."; exit 0 ;;
            *) echo "无效的选项，请重试。" ;;
        esac
    done
}

main
