umount /mnt/boot/efi
zfs umount -a
zpool export zroot
echo "Do reboot now"
