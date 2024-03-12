#!/usr/bin/env bash

# 定义包管理器和要安装的软件包列表
declare -A PKG_MANAGERS=(
    ["ubuntu"]="apt-get install -y"
    ["debian"]="apt-get install -y"
    ["archlinux"]="pacman -S"
    ["redhat"]="yum install -y"
)

PACKAGES="git neovim tmux"

# 获取发行版名称
get_distro() {
    if [ -f /etc/lsb-release ]; then
        DISTRO="ubuntu"
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/arch-release ]; then
        DISTRO="archlinux"
    elif [ -f /etc/redhat-release ]; then
        DISTRO="redhat"
    else
        echo "Unsupported distribution!" >&2
        exit 1
    fi
}

# 安装软件包
install_packages() {
    if [ -n "${PKG_MANAGERS[$DISTRO]}" ]; then
        echo "Installing packages for $DISTRO: $PACKAGES"
        sudo ${PKG_MANAGERS[$DISTRO]} $PACKAGES
    else
        echo "Unsupported distribution: $DISTRO" >&2
        exit 1
    fi
}

# 主函数
main() {
    get_distro
    install_packages
}

main
