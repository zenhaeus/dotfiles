#!/bin/bash

CONFIG=~/.config/i3blocks/config
CONFIG_BASE=~/.config/i3blocks/config.base
CONFIG_DESKTOP=~/.config/i3blocks/config.desktop
CONFIG_LAPTOP=~/.config/i3blocks/config.laptop

NODE=$(uname -n)
if [ "$NODE" = "joey-desktop" ]; then
    cat $CONFIG_BASE $CONFIG_DESKTOP > $CONFIG
elif [ "$NODE" = "carbon-joey" ]; then
    cat $CONFIG_BASE $CONFIG_LAPTOP > $CONFIG
else
    cat $CONFIG_BASE > $CONFIG
fi
