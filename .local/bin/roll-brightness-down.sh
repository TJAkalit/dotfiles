#!/bin/bash
CURRENT=$(brightnessctl --class=backlight -m | awk -F ',' '{print $4}')

NEXT=100%

case $CURRENT in
    100%)
        NEXT=75%
        ;;
    75%)
        NEXT=50%
        ;;
    50%)
        NEXT=25%
        ;;
    25%)
        NEXT=1%
        ;;
    *)
        NEXT=1%
        ;;
esac

brightnessctl --class=backlight set $NEXT
