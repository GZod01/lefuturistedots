#!/bin/python3

import datetime

s = str(datetime.datetime.now())

import subprocess


subprocess.call(['xdotool', 'key', *(list(s))])


