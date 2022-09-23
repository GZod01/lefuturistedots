#!/bin/python3
from i3ipc import Connection, Event
import subprocess

log = print

"""
Small python utility intended to help me in various ways
The goal is to listen, capture and sink keyboard inputs (no input are sent to the windows), no x11 windows should be created.
We listen for key press in true vim fashion and do things depending.

Example of what I would do:
we have a verb: p for position

like:

ptb = Place Top Bottom
plb = Place Left Bottom
pbl = Place Bottom Left (any order!)

top = t
bottom = b
left = l
right = r

"""
verbs = {'p': 'place'}


import time

from Xlib import X, XK, protocol
from Xlib.display import Display
from Xlib.ext import record

display = None
root = None

def lookup_keysym(keysym):
    for name in dir(XK):
        if name[:3] == "XK_" and getattr(XK, name) == keysym:
            return name[3:]
    return "[%d]" % keysym

mode = 'place'
place_ins = []

def handler(reply):
    global mode, place_ins
    data = reply.data
    while len(data):
        event, data = protocol.rq.EventField(None).parse_binary_value(data, display.display, None, None)
        if event.type == X.KeyPress:
            keycode = event.detail
            # capture event and don't send to other windows
            keysym = display.keycode_to_keysym(event.detail, 0)
            print(keycode, keysym, lookup_keysym(keysym))
            key = lookup_keysym(keysym)
            if key in ['BackSpace', 'Escape']:
                exit()
            if key == 'p':
                # place something
                mode = 'place'
            if mode == 'place':
                if key == 't':
                    place_ins.append('top')
                if key == 'b':
                    place_ins.append('bottom')
                if key == 'r':
                    place_ins.append('right')
                if key == 'l':
                    place_ins.append('left')
                
                print(place_ins)
                if len(place_ins) >= 2:
                    log('place', place_ins)
                    mode = 'default'
                    place_ins = []


def main():
    # i3 = Connection()
    # i3_win = i3.get_tree().find_focused()

    # is_floating = win.floating in ['auto_on', 'user_on']
    # if not is_floating:
    #     log("window not floating")

    global display, root
    display = Display()
    root = display.screen().root

    ctx = display.record_create_context(
        0,
        [record.AllClients],
        [{
            'core_requests': (0, 0),
            'core_replies': (0, 0),
            'ext_requests': (0, 0, 0, 0),
            'ext_replies': (0, 0, 0, 0),
            'delivered_events': (0, 0),
            'device_events': (X.KeyReleaseMask, X.ButtonReleaseMask),
            'errors': (0, 0),
            'client_started': False,
            'client_died': False,
        }]
    )
    display.record_enable_context(ctx, handler)
    display.record_free_context(ctx)

    display.screen().root.grab_key(10, 0, True,X.GrabModeSync, X.GrabModeSync)

    while True:
        # Infinite wait, doesn't do anything as no events are grabbed.
        event = root.display.next_event()

if __name__ == '__main__':
    main()
    
