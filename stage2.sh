#echo " run vim /etc/fstab  and comment all zroot lines"
perl -pi -e 's:zpool/:#zpool/:g' /etc/fstab
