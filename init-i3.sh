# Configure i3 with
#   - alacritty as the default terminal
#   - rofi as the application launcher

install_if_not () {
	if pacman -Q | grep "$1"; then
		echo "$1 has already installed."
	else
		echo "Install $1..."
		sudo pacman -S $1
	fi
}

echo
echo "Install and configure alacritty..."
install_if_not alacritty

echo
echo "Install and configure rofi..."
install_if_not rofi

echo
echo "Install font-awesome..."
install_if_not ttf-font-awesome

echo
echo "Copying i3 config..."
cp ~/.i3/config ~/.i3/config.backup
cp .i3/config ~/.i3

echo
echo "Copying .profile..."
cp ~/.profile ~/.profile.backup
cp .profile ~

echo
echo "Reload i3..."
i3-msg reload

echo
echo "i3 configuration complete. Please y to logout and relogin to see all changes."
read i
if [ "$i" == "y" ]; then
	i3-msg exit
fi

