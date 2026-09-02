#!/bin/bash
grep -v '#' ~/.config/packages.txt | awk '{if ($NF) print}' | sudo pacman -S --needed -
