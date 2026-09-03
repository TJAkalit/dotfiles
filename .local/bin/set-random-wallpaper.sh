#!/bin/bash
CONFIG=~/.config/swaybg/env
WP_DIR=~/Pictures/Wallpapers
IMG_PATH=""
MANUAL_IMG=${1}
CURRENT_IMG=$(cat ${CONFIG} | sed 's/IMG_PATH=//g')

function get_next_img {
    IMG_PATH=$(find ${WP_DIR} -type f | sort -R | head -n1)
}

function reload {
    cat > ${CONFIG} << EOF
    IMG_PATH=${IMG_PATH}
EOF
    systemctl restart --user swaybg.service
}

if [[ -z ${MANUAL_IMG} ]]; then
    get_next_img
    while [[ $CURRENT_IMG == $IMG_PATH ]]; do
        get_next_img
    done
else
    IMG_PATH=${MANUAL_IMG}
fi


if [[ ${CURRENT_IMG} != ${IMG_PATH} ]]; then
    reload
fi
