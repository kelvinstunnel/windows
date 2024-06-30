#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server version:"
    echo "1. Windows Server 10"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 10
        img_file="windows10.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=beaf4f9b-b317-4f24-b7f7-713f6d6d0380&P1=1719802126&P2=601&P3=2&P4=F%2fas4vggQDwoGjvogNigCcQ7%2bf7xgPhixzkBx4kpkNxSBiD5qAt9AwQ6%2fxJbJaX4EUtkvQDACJ7k9tKSXFjTvZH3GwFjy%2b940R4vIOyYckdcfiz9qx8mOS%2bEHVxybJiQx4pNhH5DDfbDO8kiG%2f%2f3f9fabI6xp%2f36Rt00xLzNQgR5o2EQGUJYMc9PBwpVVM48EwIH6JyVJSmQNDESedgleaZy8ZyaEpQ4lN2huTRxUfECotRjRpXdm2CxsLu2hjeeeDdyazzaee%2fZ5LhKfRt52Z7s%2bDxZtsZ%2fYu9jKGRob6OujTmjtQfNmpDW0sjlKyVK4Ttfsbi6D8WuDevrOTnlRA%3d%3d"
        iso_file="windows10.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected Windows Server version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 30G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
