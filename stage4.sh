grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable ssh
systemctl enable zfs-import-cache
systemctl enable zfs-import-scan
systemctl enable zfs-mount
systemctl enable zfs-share
systemctl enable zfs-zed
systemctl enable zfs.target



useradd -mU -s /bin/zsh -G \
sys,log,network,floppy,scanner,power,rfkill,users,video,storage,optical,lp,audio,wheel,adm \
gamlet

passwd gamlet

passwd

visudo

cp -rp /etc/xdg/reflector/reflector.conf /etc/xdg/reflector/reflector.conf.ORIG

echo -e '--country RU
--protocol https
--latest 5
--sort rate
--save /et c/pacman.d/mirrorlist' > /etc/xdg/reflector/reflector.conf
exit

