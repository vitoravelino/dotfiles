#!/bin/bash

xrandr --newmode "2560x1080" 230.00 2560 2720 2992 3424 1080 1083 1093 1120 -hsync +vsync
xrandr --addmode Virtual1 2560x1080

xrandr --newmode "1920x1080" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 1920x1080

xrandr --output Virtual1 --mode 2560x1080
