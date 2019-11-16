#!/bin/bash

BASE_CONFIG="~/.config/i3blocks/config.base"
CONFIG="~/.config/i3blocks/config"
NODE=$(uname -n)
if [ "$NODE" = "joey-desktop" ]; then
    cat $BASE ~/.config/i3blocks/config.desktop > $CONFIG
elif [ "$NODE" = "carbon-joey" ]; then
    cat $BASE ~/.config/i3blocks/config.laptop > $CONFIG
else
    cat $BASE > $CONFIG
fi
