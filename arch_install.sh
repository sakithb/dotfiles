# move config files
mv -f ./config ~/.config

# Install yay

pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

yay -S - < packages.list

systemctl enable lightdm
systemctl enable NetworkManager
systemctl enable preload

echo "export QT_QPA_PLATFORMTHEME=qt5ct" > ~/.profile

chsh -s /bin/fish $1

sudo -u $1 xdg-user-dirs-update
sudo -u $1 xdg-user-dirs-gtk-update

# Move wallpapers
mv Wallpapers ~/.Pictures/Wallpapers
