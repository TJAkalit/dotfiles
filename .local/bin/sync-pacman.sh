#!/bin/bash
(
    /usr/bin/cat \
        ~/.config/packages.txt \
        ~/.config/packages-local.txt) |\
grep -v '#' | awk '{if ($NF) print}' |\
sudo pacman -S --needed -
