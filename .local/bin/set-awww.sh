#!/bin/bash

WP_DIR=~/Pictures/Wallpapers
IMG_PATH=""

MANUAL_IMG=${1}

function get_next_img {
    IMG_PATH=$(find ${WP_DIR} -type f | sort -R | head -n1)
}

if [[ -z ${MANUAL_IMG} ]]; then
    get_next_img
else
    IMG_PATH=${MANUAL_IMG}
fi

awww img ${IMG_PATH} --transition-type any --transition-fps 144
