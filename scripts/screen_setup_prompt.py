#!/usr/bin/python3

import os
import pydymenu
# from https://pythonawesome.com/pydymenu-pythonic-wrapper-for-fzf-and-rofi/

commands = [
    {
        'name': "Only HDMI",
        'id': 'home_hdmi'
    },
    {
        'name': "Laptop screen only",
        'id': "laptop"
    },
    {
        'name': "Auto",
        'id': 'auto'
    },
    {
        'name': "HDMI + laptopscreen",
        'id': 'home_hdmi_edp'
    },
    {
        'name': "VGA + HDMI + laptopscreen",
        'id': 'home_vga_hdmi_edp'
    },
    {
        'name': "Only VGA",
        'id': 'home_vga'
    },
]

selected = pydymenu.rofi(
    list(map(lambda c: c['name'], commands)),
    prompt="Pick a command"
)
if len(selected) == 0:
    exit()

res = list(filter(lambda cmd: cmd['name'] == selected[0], commands))
if len(res) == 0:
    print('invalid selection')
    exit()

conf_id = res[0]['id']


os.system('sh /home/' + os.getenv('USER') +
          '/dots/scripts/screen_setup.sh ' + conf_id)
