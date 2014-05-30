#!/bin/bash -ex

IN="LVDS-1"
EXT="DP-2"

if (xrandr | grep "$EXT connected"); then
    xrandr --output $IN --auto --primary --output $EXT --auto --right-of $IN
else
    xrandr --output $EXT --off --output $IN --auto
fi