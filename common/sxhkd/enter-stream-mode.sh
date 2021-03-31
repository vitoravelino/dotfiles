#!/bin/bash 

for i in `bspc query -N -d`
do
  `bspc node $i -t floating`
  # polybar 32px
  # gap 6px
  
  # window height: resolution height - 32 - 6 - 6
  # where is this additional 2px? should be 1006
  # coming from?
  `xdotool windowsize $i 1574 1004`
  # top gap: 32 - 6
  `xdotool windowmove $i 6 38`
done