#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <user_folder>"
  exit 1
fi

user_folder=$1

# Remove directories under Documents, excluding Projects
find "$user_folder/Documents"/* -maxdepth 0 -type d -not -path '*/Projects*' -exec rm -rf {} +

# Remove files under Desktop, Downloads, Pictures, and Videos
rm -rf "$user_folder/Desktop"/*
rm -rf "$user_folder/Downloads"/*
rm -rf "$user_folder/Pictures"/*
rm -rf "$user_folder/Videos"/*

# Remove files under the user's folder, excluding main folders
find "$user_folder"/* -maxdepth 0 -type d \
-not -path "*/Templates*" \
-not -path "*/Public*" \
-not -path "*/Pictures*" \
-not -path "*/My Pictures*" \
-not -path "*/Music*" \
-not -path "*/Downloads*" \
-not -path "*/Documents*" \
-not -path "*/Desktop*" \
-not -path "*/Videos*" \
-exec rm -rf {} +

# Remove Chrome
apt-get purge google-chrome-stable
rm "$user_folder/.config/google-chrome/" -rf
rm -rf "$user_folder/.config/chromium"

# Remove Telegram
apt remove telegram
rm -rf "$user_folder/.local/share/TelegramDesktop/"

# Remove Firefox
snap remove firefox
rm -Rf /etc/firefox/
rm -Rf "$user_folder/usr/lib/firefox*"

# Remove Docker
apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
rm -rf /var/lib/docker
rm -rf /var/lib/containerd

# Clean Bash history
cat /dev/null > "$user_folder/.bash_history"

# Clean Cache
rm -rf "$user_folder/.cache/*"

# Clean Trash
rm -rf "$user_folder/.local/share/Trash/*"

# Delete script
cat /dev/null > "$user_folder/Android/decimation.sh"
