pacman -S --needed xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk
yay -S amd-vulkan-prefixes

echo -e 'options amdgpu si_support=1
options amdgpu cik_support=1' >> /etc/modprobe.d/amdgpu.conf


pacman -S --needed xorg sddm
pacman -S --needed plasma kde-applications

systemctl enable sddm.service
systemctl enable NetworkManager.service
