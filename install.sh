
#!/bin/sh

# variables
ASDF_BRANCH=v0.7.8

RUBY_VERSION=2.6.6
GOLANG_VERSION=1.14.1
NODE_VERSION=12.16.1
ERLANG_VERSION=22.3.1
ELIXIR_VERSION=1.10.2

# repositories
sudo zypper ar -c https://download.opensuse.org/repositories/Virtualization:containers/openSUSE_Leap_15.1/Virtualization:containers.repo
sudo zypper ar -c https://download.opensuse.org/repositories/mozilla/openSUSE_Leap_15.1/mozilla.repo
sudo zypper ar -c http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.1/ packman
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper --gpg-auto-import-keys ref
sudo zypper -n dup --allow-vendor-change --from packman
sudo zypper -n dup --allow-vendor-change --from mozilla

# devel
sudo zypper -n in --type pattern devel_basis
sudo zypper -n in libopenssl-devel readline-devel libssh2-devel

# apps
sudo zypper -n in vlc vlc-codecs keepassxc dropbox hexchat libreoffice screenfetch sensors pulseaudio-equalizer htop inkscape optipng xdotool sshfs obs-studio vlc vlc-codecs docker-compose tilix code discord flatpak

# flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update
sudo flatpak install -y flathub com.slack.Slack
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
# sudo flatpak install -y flathub com.teamspeak.TeamSpeak
sudo flatpak install -y flathub com.wps.Office
# sudo flatpak install -y flathub com.dropbox.Client

# Tilix
dconf load /com/gexperts/Tilix/ < tilix.dconf

# bat
wget https://download.opensuse.org/repositories/openSUSE:/Factory/standard/x86_64/bat-0.12.1-2.3.x86_64.rpm
sudo zypper -n in bat-0.12.1-2.3.x86_64.rpm
rm -rf bat-0.12.1-2.3.x86_64.rpm

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --key-bindings --completion --no-update-rc

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_BRANCH
. $HOME/.asdf/asdf.sh

# golang
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang $GOLANG_VERSION
asdf global golang $GOLANG_VERSION

# ruby
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby $RUBY_VERSION
asdf global ruby $RUBY_VERSION

# nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs $NODE_VERSION
asdf global nodejs $NODE_VERSION

asdf reshim && npm -g install yarn diff-so-fancy

# erlang/elixir
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang $ERLANG_VERSION
asdf global erlang $ERLANG_VERSION

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install elixir $ELIXIR_VERSION
asdf global elixir $ELIXIR_VERSION

asdf reshim

# perfect eq preset
mkdir -p $HOME/.config/pulse/presets
wget -P $HOME/.config/pulse/presets https://raw.githubusercontent.com/rsommerard/pulse-presets/master/Perfect%20EQ.preset

# gsettings
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close

# qogir theme and icons
sudo zypper -n in gtk2-engines gtk2-engine-murrine
git clone https://github.com/vinceliuice/Qogir-theme.git
./Qogir-theme/install.sh -t standard -l gnome -w square -c standard
rm -rf Qogir-theme
gsettings set org.gnome.desktop.interface gtk-theme "Qogir-win"

git clone https://github.com/vinceliuice/Qogir-icon-theme.git
./Qogir-icon-theme/install.sh
rm -rf Qogir-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Qogir'

# antigen
mkdir -p $HOME/.antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh

# dotfiles to its proper places
mkdir -p $HOME/.ssh
mkdir -p $HOME/.config/fontconfig

cp {.aliases,.exports,.gemrc,.curlrc,.zshrc,.vimrc,.gitconfig} $HOME
cp .ssh/config $HOME/.ssh
cp .antigen/config $HOME/.antigen

# spotify
echo 'Go to https://github.com/megamaced/spotify-easyrpm and install it via 1-click yast install'