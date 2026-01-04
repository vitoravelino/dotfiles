brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

# cli
brew install coreutils curl git mise
brew install fzf gnupg pinentry-mac htop bat wget ripgrep jq eza btop neofetch grep watch btop neovim fd lazygit wget gnu-sed watchman tldr dust duf zoxide

# langs
cp mise.toml ~/.config/mise/config.toml
mise install

# langs cli tools
go install github.com/rhysd/dotfiles@latest
npm install -g pnpm neovim diff-so-fancy eslint
pnpm create expo@next
gem install neovim
pip install -U yt-dlp httpie
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default stable

# casks
brew install --cask keepassxc visual-studio-code legcord slack steam alacritty vlc spotify flameshot telegram font-iosevka sf-symbols android-studio imageoptim latest orbstack arc zed obs deskpad tailscale syncthing-app iina zen-browser cyberduck responsively ente-auth mullvad-vpn

chmod +x /Applications/flameshot.app/Contents/MacOS/flameshot

echo "https://color.firefox.com/?theme=XQAAAAIbAQAAAAAAAABBqYhm849SCia2CaaEGccwS-xMDPsqvOJTAr7MdSg-aIfxWLr1G9WC4LDSwLkx4w-id2jtOOMTunRBOZ722UBF6EvpdolmhlxmD3Or25T8oURi63VMsqda6LPDxPAVCtpokseuG-7zgywuccYqLcmbMinsEmMbl9u1Ho6VqTsj2mghJ82wuI84X8lEKKFlTTbQ1ZyMvSGKaTOUMDGnzD5aU5XH4DoQ6-EnaORmANQs0vSn0f_cHn4A"

defaults write com.apple.screencapture location "~/Pictures"
chflags nohidden ~/Library
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# gnupg
# https://gist.github.com/phortuin/cf24b1cca3258720c71ad42977e1ba57
