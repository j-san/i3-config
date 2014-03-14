#! /bin/bash

max_brightness=$(cat /sys/class/backlight/acpi_video0/max_brightness)
brightness=$(cat /sys/class/backlight/acpi_video0/brightness)

if (($1="down" && $brightness>0))
then
     let brightness=$brightness-1
fi
if (($1="up" && $brightness<$max_brightness))
then
     let brightness=$brightness+1

fi

echo $brightness > /sys/class/backlight/acpi_video0/brightness