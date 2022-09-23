#!/bin/sh

lock() {
    sh $HOME/dots/scripts/lock.sh --nofork
    $HOME/dots/scripts/remap.sh
}

lock &
systemctl suspend

