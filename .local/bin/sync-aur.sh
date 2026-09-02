#!/bin/bash
grep -v '#' ~/.config/packages-aur.txt | awk '{if ($NF) print}' | yay -S --needed -
