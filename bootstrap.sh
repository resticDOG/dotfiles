#!/usr/bin/env bash

set -e

# declare colors
WHITE='\033[0;37m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'

log_text() {
  case $1 in 
    info)
      echo -e "$WHITE$2$WHITE"
      ;;
    success)
      echo -e "$GREEN$2$GREEN"
      ;;
    error)
      echo -e "$RED$2$RED" 
      ;;
  esac
}

info() {
  echo -e "$(log_text "info" "$1")"
}

success() {
  echo -e "$(log_text "success" "$1")"
}

error() {
  echo -e "$(log_text "error" "$1")"
  exit 1
}

ask() {
  while true; do
    read -p "$(log_text "info" "$1")" answer
    case $answer in
      [Yy]* ) 
        $2
        break
        ;;
      [Nn]* ) 
        break
        ;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

# 定义包管理器和要安装的软件包列表
declare -A PKG_MANAGERS=(
    ["ubuntu"]="apt-get install -y"
    ["debian"]="apt-get install -y"
    ["archlinux"]="pacman -S"
    ["redhat"]="yum install -y"
)

# 安装必要的包
# gcc make ripgrep python3 nodejs unzip 为neovim安装的依赖
PACKAGES="zsh git neovim tmux gcc make ripgrep unzip"

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
        error "Unsupported distribution!" >&2
    fi
}

# 安装 zsh oh-my-push
install_oh_my_zsh() {
    if [[ -z "$(command -v zsh)" ]]; then
        error "Zsh is not installed. install it first."
    fi
    # 通过判断oh-my-zsh的安装目录判断是否安装了oh-my-zsh
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Installing oh-my-zsh..."
        export RUNZSH=no
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        source $HOME/.zshrc
        # 安装zsh-autosuggestions
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else
      info "oh-my-zsh already installed. skipping..."
    fi
}

# 安装 nvm 并安装node最新版本
install_nvm_node() {
  if [[ -c "$(command -v node)" ]]; then
    info "node already installed. skipping..."
  fi
  if [[ ! -d $HOME/.nvm ]]; then
    local nvm_version=$(curl -L -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    info "Installing nvm..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh)"
    source $HOME/.nvm/nvm.sh
    nvm install node
    nvm use node
  else
    info "nvm already installed. skipping..."
  fi
}

# 安装 python3 和 pip
install_python3() {
  if [[ -c "$(command -v python3)" ]]; then
    info "python3 already installed. skipping..."
  fi
  if [[ ! -d $HOME/.pyenv ]]; then
    info "Installing pyenv..."
    sh -c "$(curl -fsSL https://pyenv.run)"
    cat >> $HOME/.bashrc << 'EOF'
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
    source $HOME/.bashrc >&2
    local latest=$(pyenv install -l | grep -e '^\s*3\.[0-9]*\.[0-9]*$' | tail -1)
    info "Installing python3 version: $latest"
    pyenv install $latest
    pyenv global $latest
    rm $HOME/.bashrc >&2
  fi
}

# 安装软件包
install_packages() {
    if [ -n "${PKG_MANAGERS[$DISTRO]}" ]; then
        info "Installing packages for $DISTRO: $PACKAGES"
        sudo ${PKG_MANAGERS[$DISTRO]} --noconfirm $PACKAGES >&2
    else
        error "Unsupported distribution: $DISTRO" >&2
    fi
}

# 创建 dotter local 配置文件并初始化
init_dotter() {
  if [[ ! -f ".dotter/local.toml" ]]; then
    info "Apply dotter config"
    cat > ".dotter/local.toml" << 'EOF'
packages = ["bash", "zsh", "tmux", "nvim"]
EOF
    ./dotter deploy --force
  fi
}


# 主函数
main() {
    get_distro
    ask "It's a freash install (y/n)？" install_packages
    ask "It's ok to install Oh-my-zsh (y/n)？" install_oh_my_zsh
    ask "It's ok to install Nodejs (y/n)？" install_nvm_node
    ask "It's ok to install Python3 (y/n)？" install_python3
    ask "Create dotter local config file and deploy it (y/n)？" init_dotter
    success "All done. Enjoy your new shell!"
    success "If you want to customize it, please modify the \".dotter/local.toml\" file, then deploy it again."
    success "If you want to know more about, please visit https://github.com/resticDOG/dotfiles"
}

main
