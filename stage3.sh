ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

#echo -e '
#ru_RU.UTF-8 UTF-8
#en_US.UTF-8 UTF-8' >> /etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8/ru_RU.UTF-8/' /etc/locale.gen
locale-gen

echo 'KEYMAP=ru
FONT=cyr-sun16' > /etc/vconsole.conf
echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf

echo "asmodeus" > /etc/hostname
echo -e '127.0.0.1 localhost\n::1 localhost\n127.0.1.1 asmodeus.serpukhov.biz asmodeus' >> /etc/hosts

mkinitcpio -p linux

pacman -S networkmanager network-manager-applet os-prober reflector rsync terminus-font xdg-user-dirs xdg-utils zsh grml-zsh-config


systemctl enable zfs-import-cache
systemctl enable zfs-import-scan
systemctl enable zfs-mount
systemctl enable zfs-share
systemctl enable zfs-zed
systemctl enable zfs.target


zgenhostid $(hostid)

echo "edit /etc/default/grub "
echo " GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quite video=1920x1080"
 GRUB_CMDLINE_LINUX="root=ZFS=zroot/ROOT/default"
