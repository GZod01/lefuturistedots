#!/usr/bin/python
import sys
import os
import subprocess

proc = subprocess.Popen('stint', stdout=subprocess.PIPE)

# decode output from the command
color_raw = proc.stdout.read().decode()

# take the first line
color_raw = color_raw.split('\n')[0]

print(f'{color_raw=}')

color_rgb = [int(x) for x in color_raw.strip().split(' ')]

print(f'{color_rgb=}')

color_hex = '#' + ''.join(['{0:02x}'.format(x) for x in color_rgb])

print(f'{color_hex=}')

rgb_string = f'{color_rgb[0]}, {color_rgb[1]}, {color_rgb[2]}'

output = color_hex
if 'rgb_raw' in sys.argv:
	output = rgb_string
if 'rgb' in sys.argv:
	output = f'rgb({rgb_string})'
if 'rgba' in sys.argv:
	output = f'rgba({rgb_string}, 1)'

# copy the requested format in the clipboard
os.system(f"echo '{output}' | xclip -selection c")

print(f'Put "{output}" into the clipboard')

# finally, send a notification
os.system(f'notify-send --app-name="Color picker" "{output}"')
