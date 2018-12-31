#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: ./hipstafy-daemon.sh <start|stop|status|restart>" >&2
    exit 1
fi

pidfile="hipstafy-wait.pid"
outfile="hipstafy.out"
errfile="hipstafy.err"

start () {
    if [ -f $pidfile ]; then
        echo "Hipstafy daemon is already running. Stop or restart the existing instance."
    else
        nohup ./hipstafy-wait.sh hipstafy-dropbox >$outfile 2>$errfile &
        pid="$!"
        echo $pid > $pidfile
        echo "Hipstafy daemon [$pid] has been started."
    fi
}

stop () {
    if [ ! -f $pidfile ]; then
        echo "There is no daemon to stop."
    else
        pid=$(cat $pidfile)
        kill -9 $pid 2>/dev/null
        rm $pidfile
        echo "Hipstafy daemon [$pid] has been stopped."
    fi
}

case $1 in
    start)
        start 
        ;;
    stop)
        stop
        ;;
    status)
        if [ ! -f $pidfile ]; then
            echo "There is no daemon currently running."
        else
            pid=$(cat $pidfile)
            statuscode=$(kill -0 $pid 2>/dev/null; echo $?)
            if [ $statuscode -eq 0 ]; then
                echo "Hipstafy daemon [$pid] is still alive."
            else
                echo "Hipstafy daemon [$pid] is dead."
            fi
        fi
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo -e "Invalid option. Available options are: \n-start\n-stop\n-status\n-restart"
        ;;
esac
