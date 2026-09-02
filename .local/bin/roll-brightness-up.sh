#!/bin/bash
CURRENT=$(brightnessctl --class=backlight -m | awk -F ',' '{print $4}')

NEXT=1%

case $CURRENT in
    1%)
        NEXT=25%
        ;;
    75%)
        NEXT=100%
        ;;
    50%)
        NEXT=75%
        ;;
    25%)
        NEXT=50%
        ;;
    *)
        NEXT=100%
        ;;
esac

brightnessctl --class=backlight set $NEXT
