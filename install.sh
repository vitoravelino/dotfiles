#!/usr/bin/env bash

# variables
MISSING_DEPENDENCIES=()
LEAP_VERSION='15.3'
OS_VERSION=$(sed -n '/^ID="/s/^.*=//p' /usr/lib/os-release | cut -d'"' -f2)
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'
DOTFILES=$PWD/dotfiles

# support functions
get_latest_tag() {
  curl --silent "https://api.github.com/repos/$1/tags" | grep -Po '"name": "\K.*?(?=")' | head -1
}

check_dependency() {
  package=$2

  if [ -z $package ]; then
    package=$1
  fi

  if ! [ -x "$(command -v $1)" ]; then
    MISSING_DEPENDENCIES+=($package)
  fi
}

check_dependencies() {
  check_dependency 'git'

  if ! [ ${#MISSING_DEPENDENCIES[@]} -eq 0 ]; then
    echo 'Installing missing dependencies...'
    sudo zypper -n in ${MISSING_DEPENDENCIES[@]}
  fi
}

check_os() {
  if [ "$OS_VERSION" = "opensuse-leap" ]; then
    REPO_OS_ID="openSUSE_Leap_$LEAP_VERSION"
    NVIDIA_REPO_OS_ID="leap/$LEAP_VERSION"
  elif [ $OS_VERSION = "opensuse-tumbleweed" ]; then
    REPO_OS_ID='openSUSE_Tumbleweed'
    NVIDIA_REPO_OS_ID='tumbleweed'
  else
    echo 'Error: OS not supported! You are not running openSUSE Leap or Tumbleweed.'
    exit 1
  fi
}

check_mode() {
  if [ "$1" == "--laptop" ]; then
    MODE='laptop'
  fi

  if [ "$1" == "--desktop" ]; then
    MODE='desktop'
  fi

  if [[ $MODE != "desktop" && $MODE != "laptop" ]]; then
    echo 'A valid argument should be passed: install.sh [--laptop|--desktop]'
    exit 1
  fi
}

# main
if ! [ $# -eq 1 ]; then
  echo 'An argument should be passed: install.sh [--laptop|--desktop]'
  exit 1
fi

check_mode $1
check_dependencies
check_os

# cloning repo
git clone https://github.com/vitoravelino/dotfiles.git
cd $DOTFILES

sudo zypper -n dup --allow-vendor-change --from packman

# devel
sudo zypper -n in --type pattern devel_basis
sudo zypper -n in libopenssl-devel readline-devel libssh2-devel re2c sqlite3-devel libcurl-devel gd-devel oniguruma-devel postgresql18-server-devel libzip-devel

# apps
APPS='vlc vlc-codecs keepassxc dropbox hexchat libreoffice screenfetch sensors pulseaudio-equalizer htop inkscape optipng xdotool sshfs obs-studio obs-v4l2sink docker alacritty code discord flatpak wine lutris zsh bat nautilus pavucontrol redshift guvcview fortune gimp flash-player mpd ncmpcpp brave-browser steam'

# winget upgrade
# winget search glaze
# winget upgrade Microsoft.DevHome
# winget search uninstalr
# winget install flux.flux
# winget search keepass
# winget search 7zip
# winget search legcord
# winget search nextcloud
# winget search uget
# winget search zen
# winget search crystal
# winget search cpuid
# winget search corsair
# winget search logitech
# winget search epic
# winget search zen
# winget search winstall
# winget search vim
# winget install sharex
# winget install ShareX.ShareX
# winget install --exact --id MartiCliment.UniGetUI --source winget

sudo zypper -n in $APPS

# fonts
sudo zypper -n in google-tinos-fonts google-arimo-fonts google-cousine-fonts fetchmsttfonts noto-coloremoji-fonts

# flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update
sudo flatpak install -y flathub com.slack.Slack
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
sudo flatpak install -y flathub org.onlyoffice
sudo flatpak install -y flathub com.wps.Office
sudo flatpak install -y flathub com.jetbrains.IntelliJ-IDEA-Community

# fzf
FZF=$HOME/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $FZF
$FZF/install --key-bindings --completion --no-update-rc

# mise
curl https://mise.run | sh
mise install

npm -g install yarn
pip install bpytop
GO111MODULE=on go get github.com/rhysd/dotfiles
yarn global add diff-so-fancy eslint

# docker-compose
pip install docker-compose

# Qogir gtk theme
git clone https://github.com/vitoravelino/Qogir-theme.git
./Qogir-theme/install.sh -t standard -w square -c standard
rm -rf Qogir-theme

# zsh
chsh -s /usr/bin/zsh

# docker group
sudo usermod -aG docker $USER

# symlink all dotfiles
DOTFILES_REPO_PATH=$DOTFILES/common dotfiles link

if [ $MODE == 'laptop' ]; then
  DOTFILES_REPO_PATH=$DOTFILES/laptop dotfiles link
fi

if [ $MODE == 'desktop' ]; then
  DOTFILES_REPO_PATH=$DOTFILES/desktop dotfiles link
fi

# lockscreen
multilockscreen -u ~/pictures/wallpaper.png --fx blur

# antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh

# misc
mkdir -p ~/pictures/screenshots

echo -e "\n${GREEN}Installation complete.${NC}\n"

FIREFOX_COLOR='https://color.firefox.com/?theme=XQAAAAIbAQAAAAAAAABBqYhm849SCia2CaaEGccwS-xMDPsqvOJTAr7MdSg-aIfxWLr1G9WC4LDSwLkx4w-id2jtOOMTunRBOZ722UBF6EvpdolmhlxmD3Or25T8oURi63VMsqda6LPDxPAVCtpokseuG-7zgywuccYqLcmbMinsEmMbl9u1Ho6VqTsj2mghJ82wuI84X8lEKKFlTTbQ1ZyMvSGKaTOUMDGnzD5aU5XH4DoQ6-EnaORmANQs0vSn0f_cHn4A'

## NOTE: dependency was fixed but I'll leave this here in case it happens again
# echo -e "* Install polybar manually and link libjsoncpp with '${YELLOW}sudo ln -s /usr/lib64/libjsoncpp.so.24 /usr/lib64/libjsoncpp.so.22${NC}'"
echo -e "* StreamerFX OBS plugin is built for ubuntu and needs some links:"
echo -e "  sudo ln -s /usr/lib64/libavutil.so.56.51 /usr/lib64/libavutil.so.56\n  sudo ln -s /usr/lib64/libavcodec.so.58.91 /usr/lib64/libavcodec.so.58\n  sudo ln -s /usr/lib64/libswscale.so.5.7 /usr/lib64/libswscale.so.5"
echo -e "* Setup dropbox by running '${YELLOW}dropbox start -i${NC}'"
echo -e "* Setup your SSH and PGP keys"
echo -e "* Check if ${YELLOW}/etc/pam.d/i3lock${NC} is using ${YELLOW}login${NC} and not ${YELLOW}system-auth${NC}"
echo -e "* Set eq preset on pulseaudio equalizer"
echo -e "* Set OpenWeatherMap API key: ${YELLOW}echo KEY_VALUE > ~/.config/openweathermap_key${NC}"
echo -e "* Change steam (wine) shortcut name ${YELLOW}~/.local/share/applications/wine/Programs/Steam/Steam.desktop${NC}"
echo -e "* Set Firefox config ${YELLOW}ui.context_menus.after_mouseup${NC} to ${YELLOW}true${NC}"
echo -e "* If Firefox Color is not restored, visit ${FIREFOX_COLOR}"
