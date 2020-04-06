# Configure a Linux desktop environment with
# - Fonts (Chinese fonts, nerd-fonts-complete and more)
# - fcitx (more configuration is needed)


echo "Install fonts..."
sudo pacman -S adobe-source-code-pro-fonts wqy-bitmapfont wqy-microhei wqy-zenhei adobe-source-han-sans-cn-fonts ttf-font-awesome ttf-dejavu nerd-fonts-complete --needed

echo "Install fcitx and input methods..."
sudo pacman -S fcitx fcitx-configtool fcitx-im fcitx-rime --needed

echo "To configure fcitx, copy .xprofile to ~ on X, or copy the contents of .xprofile to /etc/environments on wayland"
