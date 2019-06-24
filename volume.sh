# volume manager 
# usage: sh volume.sh (UP|DOWN)

VOLUME=$(amixer sget Master | grep -oP '([0-9]+)%' | head -n 1 | sed s/%//)
UP="UP"
if (( $VOLUME >= 100 )); then
	if [ "$1" == "$UP" ]; then
		pactl set-sink-volume 0 100% && pactl set-sink-volume 1 100%
	else
		pactl set-sink-volume 0 -5% && pactl set-sink-volume 1 -5%
	fi
else
	if [ "$1" == "$UP" ]; then
		pactl set-sink-volume 0 +5% && pactl set-sink-volume 1 +5%
	else
		pactl set-sink-volume 0 -5% && pactl set-sink-volume 1 -5%
	fi	
fi

