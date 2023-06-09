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
