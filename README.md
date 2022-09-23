# Personal dots files

## Configuration

- Laptop model: Aspire E 15 E5 575 52BT 
[Aspire E15 on acer website](https://www.acer.com/ac/en/IN/content/model/NX.GE6SI.006)
- KERNEL: x86_64 Linux 5.0.10-arch1-1-ARCH
- CPU: Intel Core i5-7200U @ 4x 3.1GHz
- GPU: Intel HD Graphics 620
- RAM: 8 GB DDR4
- SSD: 128 GB
- HDD: 1 TB
- Archlinux
- Graphics Server: X
- Desktop environment: i3wm
    - i3status
- Shell: fish
- ~1483 packages installed
- Technologies
    - PHP
    - Node.js
    - Java 10
    - Docker
    - Python3
    - Ruby
    - Lua
- Tools
    - sharenix or other equivalent tool
        - Take a (full/region) screenshot, store it on /tmp
        - Upload it on lefuturiste server or on imgur if failed
        - Copy url in clipboard
        - Ability to manage last images saved (CRUD)
        - In gnome file manager or others, have a way to get the last image quickely to be uploaded
    - [ssher](https://github.com/lefuturiste/ssher) (cli as node package)
	- [batterytator](https://github.com/lefuturiste/batterytator) (battery monitoring solutions)
    - Jetbrains
        - PHPStorm
        - Idea
        - CLion
        - PyCharm
    - Chromium
    - Firefox developer edition
    - Insomnia
    - VSCode
    - Subl3
    - feh (image viewer)
    - Tunderbird
    - Discord
    - Whatsapp
    - Spotify
    - Android Studio
    - Arduino IDE
    - GitKraken
    - Audacity
    - Shotcut
    - FileZilla
    - Mongodb compass
    - Pulse Audio
    - Etcher
    - Inkscape
    - OBS
    - xflux (Xorg version of [https://justgetflux.com/](https://justgetflux.com/))
	- MySQL client: [mycli.net](https://www.mycli.net/)
	

### Setup ssh keys

`ssh-keygen -t rsa -b 4096 -C [email]`

optionaly, add to ssh agent:

`eval "$(ssh-agent -s)"` 

or

`ssh-add ~/.ssh/id_rsa`

more: [Github docs](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

### Scan for hosts on network

`sudo arp-scan --interface=wlp2s0 192.168.0.0/24`

### Switch monitor configuration

when double monitors: `xrandr --output HDMI-1 --right-of eDP-1`

when single montor: `xrand --auto`

### Switch audio device using pulse audio

- First list all the audio devices available and grep the name and index: `pacmd list-sinks | grep -E 'index:|name:'`

- Then switch the defautl sink with the audio device index for new apps: `pacmd set-default-sink $index`

- Then you have to switch all the existing app which output sound now
    - List all the applications using sound and apply a filter to only see the name and index: `pacmd list-sink-inputs | awk '/index:/{print $2}`
    - And just switch this app to the new device id: `pacmd move-sink-input $appId $sinkId`

### Control volume of all output device at the same time

use `pactl set-sink-volume $sinkId $absoluteOrRelativeValue`

see `volume.sh`

### Control media from cli

Use `playerctl`

### Wifi control

You can use `nmcli` util to show a gui

#### Get wireless interface

`iwconfig`

#### Get status of all devices

`nmcli device`

#### Connect to a specific network

`nmcli device wifi connect {ssid} password {password}`

### Control laptop screen brigthnesss

Use [haikarainen/light](https://github.com/haikarainen/light)

### Use Flux

`xflux -l 49.1754262 -g 1.3301737`

### Disable middle button click paste

Use the [XMousePasteBlock package](https://github.com/milaq/XMousePasteBlock).

Install with `yay`: `yay xmousepasteblock`.

Then create a systemd service or put the `xmousepasteblock` command in startup script.

### Change rofi theme

Use the `rofi-theme-selector` command.

### Automatically resize wallpaper

https://www.reddit.com/r/linux/comments/6odeur/i3_automatically_resize_wallpaperconky_on

Install xeventbind from aur/xeventbind-git

### X11 Keyboard config

in /etc/X11/xorg.conf.d/00-keyboard.conf

```
Section "InputClass"
	Identifier "system-keyboard"
	MatchIsKeyboard "on"
	Option "XkbLayout" "us_qwerty-fr"
	#Option "XkbOptions" "caps:swapescape"
	Option "XkbOptions" "caps:none"
EndSection
```

### Special keyboard setup

I:

- Use the [qwerty-fr](http://marin.jb.free.fr/qwerty-fr/) keyboard layout
- Remapped caplocks to escape action: because I use vim a lot, I needed a quick way to access the Escape key (to for example exit insert mode).
- Remapped escape to backtick action (to access it quickely and make use of the escape key as I don't need the caplock action)

I use the script in `./scripts/remap.sh` to setup the remap.

However the remap is "forgot" everytime I go to suspend mode or change my keyboard I have to resolve it by some kind of hack.

To hook into systemd, I created a script `./scripts/systemd_sleep_hook.sh` that reside in `/lib/systemd/system-sleep/`.

I also forced the script to run after i3lock unlocked.

## Start from scratch

Procedure to install a new workstation with this config (or in case of a fire):

- install archlinux on the computer
- make sure basic archlinux commands works
- install git via pacman: `pacman -S git yay`
- clone dot repository
- install all the others packages using yay (will take a long long time)
- run auto config scripts

