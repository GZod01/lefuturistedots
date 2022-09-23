import os
import pydymenu
# from https://pythonawesome.com/pydymenu-pythonic-wrapper-for-fzf-and-rofi/

commands = [
  {
    'name': "Launch xkill to kill windows",
    'command': "xkill"
  },
  {
    'name': "Type random string",
    'command': "~/dots/scripts/type_random_str.sh"
  },
  {
    'name': "Type current datetime",
    'command': "~/dots/scripts/type_datetime.sh"
  },
  {
    'name': "Sandbox 1",
    'command': "~/dots/scripts/sandbox1.sh"
  },
  {
    'name': "Capture focused workspace (no bar)",
    'command': "~/dots/scripts/capture_focused_workspace.sh"
  },
  {
    'name': "Capture focused container",
    'command': "~/dots/scripts/capture_focused_container.sh"
  },
  {
    'name': "Launch spectrum analyser",
    'command': "~/dots/scripts/spectrum_analyser.sh"
  },
  {
    'name': "Screen setup",
    'command': "~/dots/scripts/screen_setup_prompt.py"
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
    'name': "Emoji picker (Mod+Alt+;)",
    'command': "~/dots/scripts/emoji_picker.sh"
  },
  {
    'name': "Unicode char picker (Mod+Alt+')",
    'command': "~/dots/charpicker/global.py"
  },
  {
    'name': "Send current date to clipboard",
    'command': "~/dots/scripts/date_to_clipboard.sh"
  },
  {
    'name': "Send current datetime to clipboard",
    'command': "~/dots/scripts/datetime_to_clipboard.sh"
  },
  {
    'name': "Send random string to clipboard",
    'command': "~/dots/scripts/random_str_to_clipboard.sh"
  },
  {
    'name': "Send fake lorem ipsum string to clipboard",
    'command': "~/dots/scripts/lorem_to_clipboard.sh"
  },
  {
    'name': "Open clipboard history (Mod+o)",
    'command': "~/dots/scripts/clipboard_history.sh"
  },
  {
    'name': "Remap keyboard",
    'command': "~/dots/scripts/remap.sh"
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
