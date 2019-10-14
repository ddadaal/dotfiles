# initialization for zsh
# Need to have zsh installed

# Install oh-my-zsh
if ! [ -d ~/.oh-my-zsh ]; then
    echo "Install oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    echo "Change default shell to zsh..."
    chsh -s /bin/zsh
fi
# Install plugins

echo "Install plugins..."

echo "Install zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Install zsh-completions..."
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "Install zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Copy zshrc

echo "Backup existing .zshrc..."
mv ~/.zshrc ~/.zshrc.backup
echo "Copy .zshrc"
cp .zshrc ~
