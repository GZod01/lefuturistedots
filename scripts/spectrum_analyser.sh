#!/usr/bin/sh
parec -d alsa_output.pci-0000_00_1f.3.analog-stereo.monitor |\
                               baudline -stdin -channels 2 \
                               -samplerate 88200 \
                               -record
