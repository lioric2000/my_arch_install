zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -R "${MNT}" \
    -O acltype=posixacl \
    -O canmount=off \
    -O compression=zstd \
    -O dnodesize=auto \
    -O normalization=formD \
    -O relatime=on \
    -O xattr=sa \
    -O mountpoint=none \
    rpool \   
   $(for i in ${DISK}; do
      printf '%s ' "${i}-part2";
     done)

zfs create -o mountpoint=none rpool/data
zfs create -o mountpoint=none rpool/ROOT

zfs create -o mountpoint=/ -o canmount=noauto rpool/ROOT/default
zfs create -o mountpoint=/home rpool/data/home
zfs create -o mountpoint=/var -o canmount=off     rpool/var
zfs create                                        rpool/var/log
zfs create -o mountpoint=/var/lib -o canmount=off rpool/var/lib
zfs create                                        rpool/var/lib/libvirt
zfs create                                        rpool/var/lib/docker
