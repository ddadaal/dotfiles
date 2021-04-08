# initialization for zsh

# Prevent running script as root
if [ "$EUID" -eq 0 ]; then
	echo "Please don't run this script as root."
	exit
fi

# Install git and zsh
sudo pacman -S git zsh paru binutils --needed

# Install antigen
paru -S antigen


# Copy zshrc
echo "Backup existing .zshrc..."
mv ~/.zshrc ~/.zshrc.backup

echo "Copy .zshrc"
cp .zshrc ~

# Copy p10k conf
cp .p10k.zsh ~/

# Change default shell to zsh
chsh $(id -nu) -s /bin/zsh

echo "Run zsh to init"
