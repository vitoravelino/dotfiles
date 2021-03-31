#!/bin/bash 

for i in `bspc query -N -d`
do
  `bspc node $i -t tiled`
done