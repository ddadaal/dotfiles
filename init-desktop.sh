# Configure a Linux desktop environment with
# - Fonts (Chinese fonts, nerd-fonts-complete and more)
# - fcitx (more configuration is needed)

echo "Install fonts..."
./init-fonts.sh

echo "Install fcitx and input methods..."
sudo pacman -S fcitx fcitx-configtool fcitx-im fcitx-rime --needed

echo "Run the following if on X:"
echo "cp .xprofile ~/"
echo ""
echo "Run the following if on Wayland"
echo "sudo su"
echo "cat .xprofile >> /etc/environment"

echo "If on GNOME, install https://extensions.gnome.org/extension/261/kimpanel/ for better desktop environment integration"
echo "Now entering fcitx-config-gtk3."
fcitx-config-gtk3

# echo "Install ibus and rime"
# sudo pacman -S ibus-rime ibus --needed

# echo "Setup autostart"
# cp ./ibus-daemon.desktop ~/.config/autostart/

# echo "Running ibus-daemon"
# nohuo ibus-daemon --xim & disown

# echo "Running ibus-setup"
# ibus-setup

# echo "Add the Rime IME in Settings - Region & Language - Input Sources"
