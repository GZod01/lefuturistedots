#!/usr/bin/bash

PATH=/sbin:/usr/sbin:/bin:/usr/bin

echo -n $(date +'%Y-%m-%d %H:%M:%S') >> /home/mbess/resume.log

case "$1" in
    pre)
            #code execution BEFORE sleeping/hibernating/suspending
            echo " going to suspend!" >> /home/mbess/resume.log
    ;;
    post)
            #code execution AFTER resuming
            echo " resumed!" >> /home/mbess/resume.log
	    sleep 3
	    runuser -u mbess env DISPLAY=":0" XAUTHORITY="/home/mbess/.Xauthority" sh /home/mbess/dots/scripts/remap.sh |& tee /home/mbess/remap-resume.log
	    echo -n $(date +'%Y-%m-%d %H:%M:%S') >> /home/mbess/resume.log
            echo " end of resume script" >> /home/mbess/resume.log
    ;;
esac

exit 0

