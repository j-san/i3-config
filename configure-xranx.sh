#!/bin/bash

IN="LVDS-1"
EXT="DP-2"

if (xrandr | grep "$EXT disconnected"); then
    xrandr --output $EXT --off --output $IN --auto
else
    xrandr --output $IN --auto --primary --output $EXT --auto --right-of $IN
fi