#!/bin/bash

NODE=$(uname -n)
if [ "$NODE" = "joey-desktop" ]; then
    cat ~/.config/i3blocks/config.base ~/.config/i3blocks/config.desktop > ~/.config/i3blocks/config
elif [ "$NODE" = "carbon-joey" ]; then
    cat ~/.config/i3blocks/config.base ~/.config/i3blocks/config.laptop > ~/.config/i3blocks/config
else
    cat ~/.config/i3blocks/config.base > ~/.config/i3blocks/config
fi
