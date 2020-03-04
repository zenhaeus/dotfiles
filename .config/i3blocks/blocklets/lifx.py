#!/usr/bin/env python

import lifxlan as ll
import sys


"""
    A small script to control the LIFX light in my room
    and display it's brightness on the i3blocks bar

    Arguments:
        1. mode: 'get', 'set', 'change'
        2. mode (required for set)
"""
MAX_BRIGHTNESS = 2**16 - 1

lights = {
    'Office': ll.Light('D0:73:D5:22:C0:78', '192.168.1.50'),
    'Bedroom': ll.Light('D0:73:D5:01:14:BF', '192.168.1.51'),
    'Hall': ll.Light('D0:73:D5:2D:5A:D3', '192.168.1.52'),
    'Kitchen': ll.Light('D0:73:D5:2D:66:F4', '192.168.1.53'),
    'TV': ll.Light('D0:73:D5:25:55:E4', '192.168.1.54'),
    'Dining': ll.Light('D0:73:D5:2D:15:AB', '192.168.1.55'),
}


def set_brightness(level, cur_color, light):
    """ Sets the brightness of the light to the corresponding value
        using a range of [0, 100]
    """
    new_brightness = level_to_brightness(level)

    new_color = (cur_color[0], cur_color[1], new_brightness, cur_color[3])
    print("New Color: ", new_color)
    light.set_color(new_color)


def change_brightness(level_change, cur_color, light):
    """ Change the brightness by the given amount
    """
    # Convert level change to new level
    cur_brightness = cur_color[2]
    print("Current brightness: ", cur_brightness)
    old_level = brightness_to_level(cur_brightness)
    new_level = old_level + level_change
    print("Old level: {}, new Level: {}".format(old_level, new_level))
    set_brightness(new_level, cur_color, light)


def brightness_to_level(brightness):
    return int(round(100 * brightness / MAX_BRIGHTNESS))


def level_to_brightness(level):
    """ Convert level (int [0, 100]) to brightness (int [0, 65535])
    """
    # Make sure level is in range
    if level < 0:
        level = 0
    elif level > 100:
        level = 100

    return int(round(level / 100 * MAX_BRIGHTNESS))


def main():
    light = lights['Office']

    if len(sys.argv) == 2 and sys.argv[1] == 'get':
        color = light.get_color()
        level = brightness_to_level(color[2])
        print(f"{level}%")

    elif len(sys.argv) == 3:
        cur_color = light.get_color()

        if sys.argv[1] == 'set':
            # Set brightness to desired amound
            new_level = int(sys.argv[2])
            set_brightness(new_level, cur_color, light)

        elif sys.argv[1] == 'change':
            # Change brightness by desired amount
            level_change = int(sys.argv[2])
            change_brightness(level_change, cur_color, light)


if __name__ == '__main__':
    main()
