#!/bin/bash
(
    /usr/bin/cat \
        packages-aur.txt \
        packages-aur-local.txt 2> /dev/null) |\
grep -v '#' | awk '{if ($NF) print}' |\
yay -S --needed -
