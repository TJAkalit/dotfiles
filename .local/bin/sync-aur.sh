#!/bin/bash
(
    /usr/bin/cat \
        ~/.config/packages-aur.txt \
        ~/.config/packages-aur-local.txt 2> /dev/null) |\
grep -v '#' | awk '{if ($NF) print}' |\
yay -S --needed -
