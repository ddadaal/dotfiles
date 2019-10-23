# Configure i3 with
#   - alacritty as the default terminal
#   - rofi as the application launcher

echo "Install and configure alacritty..."
sudo pacman -S alacritty --needed

echo "Install and configure rofi..."
sudo pacman -S rofi --needed

echo "Install font-awesome..."
sudo pacman -S ttf-font-awesome --needed

echo "Install dejavu..."
sudo pacman -S ttf-dejavu --needed

echo "Copying i3 config..."
cp ~/.config/i3/config ~/.config/i3/config.backup
cp .i3/config ~/.config/i3

echo "Copying .profile..."
cp ~/.profile ~/.profile.backup
cp .profile ~

echo "Reload i3..."
i3-msg reload

echo "i3 configuration complete. Please y to logout and relogin to see all changes."
read i
if [ "$i" == "y" ]; then
	i3-msg exit
fi

