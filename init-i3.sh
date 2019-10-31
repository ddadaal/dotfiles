# Configure i3 with
#   - fonts includiing source code pro and wqy chinese fonts
#   - fcits as input method
#   - urxvt as the default terminal
#   - correct Xresources including urxvt config and dpi settings
#   - rofi as the application launcher
#   - firefox as the default browser

echo "Install fonts..."
sudo pacman -S adobe-source-code-pro-fonts wqy-bitmapfont wqy-microhei wqy-zenhei adobe-source-han-sans-cn-fonts ttf-font-awesome ttf-dejavu --needed

echo "Install fcitx and input methods..."
sudo pacman -S fcitx fcitx-configtool fcitx-im fcitx-libpinyin --needed
cp .xprofile ~

echo "Install firefox..."
sudo pacman -S firefox --needed

echo "Install and configure rofi..."
sudo pacman -S rofi --needed

echo "Copying i3 config..."
cp ~/.config/i3/config ~/.config/i3/config.backup
mkdir ~/.config/i3
cp i3config ~/.config/i3/config

echo "Copying i3 status config"
mkdir ~/.config/i3status
cp i3statusconfig ~/.config/i3status/config

echo "Copying .profile..."
cp ~/.profile ~/.profile.backup
cp .profile ~

echo "Copying .Xresources..."
cp .Xresources ~
xrdb ~/.Xresources

echo "Reload i3..."
i3-msg reload

echo "i3 configuration complete. Please y to logout and relogin to see all changes."
read i
if [ "$i" == "y" ]; then
	i3-msg exit
fi

