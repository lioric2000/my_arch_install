#echo " run vim /etc/fstab  and comment all zroot lines"
perl -pi -e 's:zpool/:#zpool/:g' /etc/fstab
echo -e '[archzfs]
Server = https://archzfs.com/$repo/x86_64' >> /etc/pacman.conf

wget https://rchzfs.com/archzfs.gpg
pacman-key -a archzfs.gpg
pacman-key -r F75D9D76
pacman-key --lsign-key F75D9D76

pacman -S zfs-linux

echo "/etc/mkinitcpio.conf"
echo "HOOKS=(base udev autodetect modconf block keyboard zfs filesystems)"
