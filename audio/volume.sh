#!/usr/bin/sh

# volume manager

function usage() {
	echo "usage: sh volume.sh <UP|DOWN|(number between 0 and 999)>"
}

function setvol() {
	pactl set-sink-volume 0 $1 > /dev/null 2>&1
	pactl set-sink-volume 1 $1 > /dev/null 2>&1
	# TODO: add a loop to set volume for all connected devices not just for the first 2
}

function main() {
	VOLUME=$(amixer sget Master | grep -oP '([0-9]+)%' | head -n 1 | sed s/%//)

	# verify number of arguments
	if (( $# != 1 )); then
		usage
		return 1
	fi

	if [ $1 == 'UP' ]; then
		if (( $VOLUME >= 100 )); then
			setvol '100%'
			return 0
		fi
		setvol '+5%'
		return 0
	fi

	if [ $1 == 'DOWN' ]; then
		setvol '-5%'
		return 0
	fi

	if (echo $1 | grep --extended-regexp -q '^(0+)?[0-9]{1,3}$'); then
		setvol $1'%'
		return 0
	fi

	usage

	return 1
}

# expand all arguments with $@
main $@
