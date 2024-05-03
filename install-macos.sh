brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

brew install coreutils curl git

# install asdf

# copy tool-versions

# lan
asdf install
asdf reshim
rustup default stable

# gnupg
# https://gist.github.com/phortuin/cf24b1cca3258720c71ad42977e1ba57

# cli
brew install fzf gnupg pinentry-mac htop bat wget ripgrep jq eza btop neofetch grep cloudflared watch btop neovim fd lazygit wget gnu-sed

# language-based cli tools
go install github.com/rhysd/dotfiles@latest
npm install -g pnpm yarn neovim diff-so-fancy eslint
yarn create expo@next
gem install neovim
pip install -U yt-dlp httpie

# casks
brew install dropbox firefox keepassxc visual-studio-code discord slack steam alacritty vlc spotify borders flameshot telegram font-iosevka sf-symbols android-studio imageoptim latest orbstack arc zed obs

chmod +x /Applications/flameshot.app/Contents/MacOS/flameshot

echo "https://color.firefox.com/?theme=XQAAAAIbAQAAAAAAAABBqYhm849SCia2CaaEGccwS-xMDPsqvOJTAr7MdSg-aIfxWLr1G9WC4LDSwLkx4w-id2jtOOMTunRBOZ722UBF6EvpdolmhlxmD3Or25T8oURi63VMsqda6LPDxPAVCtpokseuG-7zgywuccYqLcmbMinsEmMbl9u1Ho6VqTsj2mghJ82wuI84X8lEKKFlTTbQ1ZyMvSGKaTOUMDGnzD5aU5XH4DoQ6-EnaORmANQs0vSn0f_cHn4A"
