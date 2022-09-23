#!/bin/python3

# A script that listen to various event and act on it in order to help with various situation in i3wm, add custom behavious, add missing features and various hack.
from i3ipc import Connection, Event
import datetime
import time
import logging
import sys
# import subprocess

logger = logging.getLogger('i3_overlay')
logger.setLevel(logging.INFO)
formatter = logging.Formatter(fmt="%(asctime)s %(name)s.%(levelname)s: %(message)s", datefmt="%Y.%m.%d %H:%M:%S")
handler = logging.StreamHandler(stream=sys.stdout)
handler.setFormatter(formatter)
logger.addHandler(handler)

def log(*args):
    logger.info(' '.join([str(x) for x in args]));

i3 = None
while True:
    try:
        i3 = Connection()
    except:
        log("Could not connect to i3 ipc socket, retrying in 1 sec")
        time.sleep(1)
        continue
    log("Connected to i3 ipc socket")
    break

FLOATING_GAP : int = 200

log('Started i3 overlay', str(datetime.datetime.now()))

"""
Very dumb hack to ensure that floating window do not go out of the current workspace
In the future we might to crazier stuff
"""
def on_window(_, e):
    if e.change == 'new' or e.change == 'floating':
        # plog.pprint(e.ipc_data)
        if e.container.floating not in ["auto_on", "user_on"]:
            return

        log('analysing floating window event...')
        
        win = i3.get_tree().find_focused()
        workspace = win.workspace()

        log(f"event: {e.change}, workspace: {workspace.name}, win: \"{win.window_title}\"")

        wr = workspace.rect
        geo = e.container.geometry

        # stick to top : x: 13, y: 30
        new_x, new_y = geo.x, geo.y

        act = []
        
        # First, check if the width and height is too much
        new_width, new_height = geo.width, geo.height
        log(geo.width, geo.height, wr.width, wr.height)
        if geo.width > wr.width - FLOATING_GAP:
            new_width = wr.width - FLOATING_GAP
            act.append('position')
        if geo.height > wr.height- FLOATING_GAP:
            new_height = wr.height - FLOATING_GAP
            act.append('position')

        # Then check if they appear in the right place
        # If not, we default them in the top left corner
        # or we set them in the middle
        if geo.x < 13:
            # new_x = 13
            new_x = int(wr.width/2 - new_width/2)
            act.append('move')

        if geo.y < 30:
            new_y = 30
            act.append('move')

        if geo.x + new_width > wr.width - FLOATING_GAP:
            new_x = int(wr.width/2 - new_width/2)
            act.append('move')

        if geo.y + new_height > wr.height - FLOATING_GAP:
            new_y = 30
            act.append('move')

        cmds = []
        if 'move' in act:
            log("act on position", new_x, new_y)
            cmds.append(f"move position {new_x}px {new_y}px")
            # subprocess.call([
            #     "xdotool", "windowmove",
            #     str(e.container.window),
            #     str(new_x),
            #     str(new_y)
            # ])

        if 'position' in act:
            log("act on size", new_width, new_height)
            cmds.append(f"resize set {new_width}px {new_height}px")

        for cmd in cmds:
            log(f"i3 cmd: {cmd}")
            i3.command(cmd)

i3.on(Event.WINDOW, on_window)
i3.main()

