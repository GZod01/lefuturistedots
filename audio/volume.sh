#!/usr/bin/sh

# volume manager

function usage() {
	echo "usage: sh volume.sh <UP|DOWN|(number between 0 and 999)>"
}

function setvol() {
    # old simple version
	#pactl set-sink-volume 0 $1 > /dev/null 2>&1
	#pactl set-sink-volume 1 $1 > /dev/null 2>&1

    # new more complex version
    # for each sink id, apply the command to set the sink volume
    pactl list short sinks | awk '{print $1}' | xargs -I SINK_ID pactl set-sink-volume SINK_ID $1
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
