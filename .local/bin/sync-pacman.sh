#!/bin/bash
(
    /usr/bin/cat \
        packages.txt \
        packages-local.txt 2> /dev/null) |\
grep -v '#' | awk '{if ($NF) print}' |\
sudo pacman -S --needed -
