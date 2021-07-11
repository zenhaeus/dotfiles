#!/usr/bin/env python

import platform
import re

""" A small script to inject special configurations into the base configuration.
    The file from which to read the parts that are injected is decided by the
    name of the machine on which the script is run.
"""

TEMPLATE_START_STRING = "#$#"
TEMPLATE_END_STRING = "#!#"


def parse_special(special):
    """ Read the special config blocks and store in a dictionary
    """
    special_name = ""
    specials = {}
    for line in special:
        if check_template_start(line):
            special_name = line.split(":")[1]
            specials[special_name] = []
        elif check_template_end(line):
            special_name = ""
        elif special_name != "":
            specials[special_name].append(line)

    return specials


def replace_base(base, specials):
    """ Replace all special lines with their blocks in the special config
    """
    new_config = []
    for line in base:
        new_config.append(line)
        if check_template_start(line):
            # Found template line, try to add special
            special = line.split(":")[1]
            if special in specials:
                new_config.extend(specials[special])

    return new_config


def check_template_start(line):
    return line[0:3] == TEMPLATE_START_STRING

def check_template_end(line):
    return line[0:3] == TEMPLATE_END_STRING

def main():
    host = platform.node()

    base_file = open("~/.config/i3/config.base", 'r')
    if host == "joey-desktop":
        special_file = open("~/.config/i3/config.desktop", 'r')
    elif host == "carbon-joey":
        special_file = open("~/.config/i3/config.laptop", 'r')
    else:
        exit()


    base = base_file.readlines()
    special = special_file.readlines()

    special_dict = parse_special(special)

    new_config = replace_base(base, special_dict)


    config_file = open("~/.config/i3/config", 'w')
    config_file.writelines(new_config)


if __name__ == "__main__":
    main()
