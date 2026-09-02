#!/bin/bash

WP_DIR=~/Pictures/Wallpapers

IMG_PATH=$(find ${WP_DIR} -type f | sort -R | head -n1)

cat > ~/.config/swaybg/env << EOF
IMG_PATH=${IMG_PATH}
EOF

systemctl restart --user swaybg.service
