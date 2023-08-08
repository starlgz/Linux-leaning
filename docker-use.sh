#!/bin/bash

# ANSI颜色码
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
RESET="\033[0m"

# 安装Docker
function install_docker() {
    echo -e "${GREEN}正在安装Docker...${RESET}"
    # 根据Linux发行版添加安装Docker的命令
}

# 卸载Docker
function uninstall_docker() {
    echo -e "${RED}正在卸载Docker...${RESET}"
    # 根据Linux发行版添加卸载Docker的命令
}

# 运行Docker容器
function run_docker_container() {
    echo -e "${YELLOW}请输入您要运行的镜像名称：${RESET}"
    read image_name
    echo -e "${YELLOW}请输入您要使用的容器名称：${RESET}"
    read container_name

    echo -e "${CYAN}请选择容器运行选项：${RESET}"
    echo -e "${CYAN}1. 在前台运行容器${RESET}"
    echo -e "${CYAN}2. 在后台运行容器${RESET}"
    read -p "请输入选项编号: " choice

    case "$choice" in
        1) docker run -it --name "$container_name" "$image_name" ;;
        2) docker run -d --name "$container_name" "$image_name" ;;
        *) echo -e "${RED}无效的选项，请重试。${RESET}" ;;
    esac
}

# 查看Docker容器状态
function check_container_status() {
    echo -e "${YELLOW}请输入您要查看状态的容器名称：${RESET}"
    read container_name
    docker ps -a -f name="$container_name"
}

# 停止Docker容器
function stop_docker_container() {
    echo -e "${YELLOW}请输入您要停止的容器名称：${RESET}"
    read container_name
    docker stop "$container_name"
}

# 移除Docker容器
function remove_docker_container() {
    echo -e "${YELLOW}请输入您要移除的容器名称：${RESET}"
    read container_name
    docker rm "$container_name"
}

# 列出所有Docker容器
function list_all_containers() {
    echo -e "${BLUE}正在列出所有Docker容器...${RESET}"
    docker ps -a
}

# 列出Docker镜像
function list_docker_images() {
    echo -e "${BLUE}正在列出Docker镜像...${RESET}"
    docker images
}

# 拉取Docker镜像
function pull_docker_image() {
    echo -e "${YELLOW}请输入您要拉取的镜像名称：${RESET}"
    read image_name
    docker pull "$image_name"
}

# 删除Docker镜像
function remove_docker_image() {
    echo -e "${YELLOW}请输入您要删除的镜像名称：${RESET}"
    read image_name
    docker rmi "$image_name"
}

# 显示Docker版本
function show_docker_version() {
    echo -e "${GREEN}正在显示Docker版本信息...${RESET}"
    docker --version
}

# 主函数
function main() {
    while true; do
        echo -e "${MAGENTA}===== Docker 菜单 =====${RESET}"
        echo -e "${GREEN}1. 安装/卸载 Docker${RESET}"
        echo -e "${GREEN}2. 运行/停止 Docker容器${RESET}"
        echo -e "${GREEN}3. 查看Docker容器状态${RESET}"
        echo -e "${GREEN}4. 移除Docker容器${RESET}"
        echo -e "${GREEN}5. 列出所有Docker容器${RESET}"
        echo -e "${GREEN}6. 列出Docker镜像${RESET}"
        echo -e "${GREEN}7. 拉取/删除Docker镜像${RESET}"
        echo -e "${GREEN}8. 显示Docker版本${RESET}"
        echo -e "${RED}0. 退出${RESET}"
        read -p "请输入选项编号: " choice

        case "$choice" in
            1) 
                echo -e "${MAGENTA}请选择安装/卸载Docker选项：${RESET}"
                echo -e "${CYAN}1. 安装Docker${RESET}"
                echo -e "${CYAN}2. 卸载Docker${RESET}"
                read -p "请输入选项编号: " install_choice
                case "$install_choice" in
                    1) install_docker ;;
                    2) uninstall_docker ;;
                    *) echo -e "${RED}无效的选项，请重试。${RESET}" ;;
                esac
                ;;
            2) 
                echo -e "${MAGENTA}请选择运行/停止Docker容器选项：${RESET}"
                echo -e "${CYAN}1. 运行Docker容器${RESET}"
                echo -e "${CYAN}2. 停止Docker容器${RESET}"
                read -p "请输入选项编号: " run_choice
                case "$run_choice" in
                    1) run_docker_container ;;
                    2) stop_docker_container ;;
                    *) echo -e "${RED}无效的选项，请重试。${RESET}" ;;
                esac
                ;;
            3) check_container_status ;;
            4) remove_docker_container ;;
            5) list_all_containers ;;
            6) list_docker_images ;;
            7) 
                echo -e "${MAGENTA}请选择拉取/删除Docker镜像选项：${RESET}"
                echo -e "${CYAN}1. 拉取Docker镜像${RESET}"
                echo -e "${CYAN}2. 删除Docker镜像${RESET}"
                read -p "请输入选项编号: " image_choice
                case "$image_choice" in
                    1) pull_docker_image ;;
                    2) remove_docker_image ;;
                    *) echo -e "${RED}无效的选项，请重试。${RESET}" ;;
                esac
                ;;
            8) show_docker_version ;;
            0) echo -e "${RED}正在退出...${RESET}"; exit 0 ;;
            *) echo -e "${RED}无效的选项，请重试。${RESET}" ;;
        esac
    done
}

main
