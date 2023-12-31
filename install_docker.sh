#!/bin/bash

# 检查是否已安装 Docker
function check_docker_installed() {
    if command -v docker &>/dev/null; then
        echo "Docker 已安装。"
        docker_version=$(docker --version | awk '{print $3}')
        echo "Docker 版本：$docker_version"
        return 0
    else
        echo "Docker 未安装。"
        return 1
    fi
}

# 安装 Docker Engine
function install_docker_engine() {
    echo "安装 Docker Engine..."

    if [ -f /etc/os-release ]; then
        source /etc/os-release
        case "$ID" in
            ubuntu|debian)
                sudo apt update
                sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
                curl -fsSL https://download.docker.com/linux/$ID/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$ID $VERSION_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt update
                sudo apt install docker-ce docker-ce-cli containerd.io -y
                ;;
            centos|fedora)
                sudo dnf install -y dnf-plugins-core
                sudo dnf config-manager --add-repo https://download.docker.com/linux/$ID/docker-ce.repo
                sudo dnf install docker-ce -y
                ;;
            *)
                echo "不支持的 Linux 发行版。"
                exit 1
                ;;
        esac
    else
        echo "无法确定 Linux 发行版。"
        exit 1
    fi
}

# 安装 Docker Compose
function install_docker_compose() {
    echo "安装 Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

# 卸载 Docker Engine
function uninstall_docker_engine() {
    echo "卸载 Docker Engine..."
    sudo apt purge docker-ce docker-ce-cli containerd.io -y
    sudo apt autoremove -y
    sudo rm -rf /var/lib/docker
}

# 卸载 Docker Compose
function uninstall_docker_compose() {
    echo "卸载 Docker Compose..."
    sudo rm -f /usr/local/bin/docker-compose
}

# 主函数
function main() {
    check_docker_installed

    echo "请选择操作选项："
    echo "1. 安装 Docker Engine"
    echo "2. 安装 Docker Compose"
    echo "3. 安装 Docker Engine 和 Docker Compose"
    echo "4. 卸载 Docker Engine"
    echo "5. 卸载 Docker Compose"
    echo "6. 退出"

    read -p "请输入选项的编号： " choice

    case "$choice" in
        1)
            install_docker_engine
            ;;
        2)
            install_docker_compose
            ;;
        3)
            install_docker_engine
            install_docker_compose
            ;;
        4)
            uninstall_docker_engine
            ;;
        5)
            uninstall_docker_compose
            ;;
        6)
            echo "退出脚本。"
            exit 0
            ;;
        *)
            echo "无效的选项编号。"
            exit 1
            ;;
    esac

    echo "操作完成！请注销并重新登录以使 Docker 用户组更改生效（如果适用）。"
}

main
