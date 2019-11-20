#!/usr/bin/python

import dbus
import os

def get_object(bus, playername):
    try:
        return bus.get_object(f"org.mpris.MediaPlayer2.{playername}", "/org/mpris/MediaPlayer2")
    except dbus.exceptions.DBusException:
        exit

def print_song_artis(dbus_object):
    if os.environ.get('BLOCK_BUTTON'):
        control_iface = dbus.Interface(dbus_object, 'org.mpris.MediaPlayer2.Player')
        if (os.environ['BLOCK_BUTTON'] == '1'):
            control_iface.Previous()
        elif (os.environ['BLOCK_BUTTON'] == '2'):
            control_iface.PlayPause()
        elif (os.environ['BLOCK_BUTTON'] == '3'):
            control_iface.Next()

    iface = dbus.Interface(dbus_object, 'org.freedesktop.DBus.Properties')
    props = iface.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
    print(str(props['xesam:artist'][0]) + " - " + str(props['xesam:title']))
    exit

bus = dbus.SessionBus()
for player in ['spotify', 'ncspot']:
    dbus_object = get_object(bus, player)
    if dbus_object is not None:
        print_song_artis(dbus_object)


