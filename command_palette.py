import os
import pydymenu
# from https://pythonawesome.com/pydymenu-pythonic-wrapper-for-fzf-and-rofi/

commands = [
  {
    'name': "Launch spectrum analyser",
    'command': "~/dots/scripts/spectrum_analyser.sh"
  },
  {
    'name': "Switch to HDMI1",
    'command': "~/dots/scripts/i3_migrate_output.py HDMI1"
  },
  {
    'name': "Switch to eDP1",
    'command': "~/dots/scripts/i3_migrate_output.py eDP1"
  },
  {
    'name': "Pick color as HEX (Mod+P)",
    'command': "~/dots/scripts/pick_color.py"
  },
  {
    'name': "Pick color as RGB",
    'command': "~/dots/scripts/pick_color.py rgb"
  },
  {
    'name': "Pick color as RGBA",
    'command': "~/dots/scripts/pick_color.py rgba"
  },
  {
    'name': "Refresh xrandr",
    'command': "xrandr --auto"
  },
  {
    'name': "Switch audio device (Mod+F12)",
    'command': "node ~/dots/audio/switch_device.js" 
  },
  {
    'name': "Send test notif",
    'command': "notify-send 'this is a test notif'"
  },
  {
    'name': "Refresh wallpapers",
    'command': "~/dots/scripts/refresh_wallpapers.sh"
  },
  {
    'name': "Emoji picker (Mod+;)",
    'command': "emoji-picker"
  }
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

cmd = res[0]

os.system(cmd['command'])
