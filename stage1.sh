#!/bin/bash
#Prepare console
loadkeys ru
setfont ter-c32b
#setfont cyr-sun16

#check disk
ls /sys/firmware/efi/efivars
lsblk
echo "Введите имя диска: "
read MYDISK

#Partitioniong disk
#parted -a opt ${MYDISK}
#print # Display current partition table
#mklabel gpt # Create new partition table, will destroy data!
#mkpart primary 5MB% 512MB # Boot/EFI
#mkpart primary 512MB 100% # remaining space
#set 1 boot on # Boot flag
#set 1 esp on # EFI flag
#quit
#parted --script ${MYDISK} mklabel gpt mkpart P1 5MB% 512MB mkpart P2 512MB 100% set P1 boot on set P1 esp on
#parted --script ${MYDISK} mklabel gpt mkpart non-fs 5MB% 512MB mkpart primary 512MB 100% set 1 bios_grub on set 2 boot on

#prepare boot
BDISK=`echo "${MYDISK}1"`
mkfs.vfat ${BDISK}

#prepare zfs
modprobe zfs
lsmod |grep -i zfs

ZDISK=`echo "${MYDISK}2"`

#zpool create -f \
#             -o ashift=12         \
#             -O acltype=posixacl       \
#             -O relatime=on            \
#             -O xattr=sa               \
#             -O dnodesize=legacy       \
#             -O normalization=formD    \
#             -O mountpoint=none        \
#             -O canmount=off           \
#             -O devices=off            \
#             -R /mnt                   \
#             zroot /dev/disk/by-id/id-to-partition-partx

zpool create -f \
  -O ashift=12 \
  -O acltype=posixacl \
  -O relatime=on \
  -O xattr=sa \
  -O dnodesize=auto \
  -O normalization=formD \ 
  -O mountpoint=none \
  -O canmount=off \
  -O devices=off \ #-O atime=off \
  -R /mnt zroot ${ZDISK}
  
zpool status

zfs create -o mountpoint=none zroot/data
zfs create -o mountpoint=none zroot/ROOT
zfs create -o mountpoint=/ -o canmount=noauto zroot/ROOT/default
zfs create -o mountpoint=/home zroot/data/home
zfs create -o mountpoint=/var -o canmount=off     zroot/var
zfs create                                        zroot/var/log
zfs create -o mountpoint=/var/lib -o canmount=off zroot/var/lib
zfs create                                        zroot/var/lib/libvirt
zfs create                                        zroot/var/lib/docker

zpool export zroot
zpool import -d ${ZDISK}  -R /mnt zroot -N

zfs mount zroot/ROOT/default
zfs mount -a

df -k

zpool set bootfs=zroot/ROOT/default zroot
zpool set cachefile=/etc/zfs/zpool.cache zroot

mkdir -p /mnt/{etc/zfs,boot/efi}
cp /etc/zfs/zpool.cache /mnt/etc/zfs/zpool.cache
mount ${BDISK} /mnt/boot/efi


pacman -Syy

pacstrap /mt base base-devel dkms git amd-ucode linux linux-firmware linux-headers nani vim grub efibootmgr openssh wget

genfstab -U -p /mnt >> /mnt/etc/fstab
echo " run command and then run next stage2.sh "
echo "arch-chroot /mnt"




