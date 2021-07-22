#!/bin/sh

last=$(date +%s)
while :; do
        now=$(date +%s)
        delta=$((now-last))
        last=$now
        if (( delta > 10 )); then
                echo "*** iteration took $delta seconds ***"
        fi

        fid=$(( RANDOM % 20 ))
	(
		trap "rmdir file$fid.lock" EXIT
		while ! mkdir file$fid.lock > /dev/null 2>&1; do
			echo "waiting for lock on file$fid"
			sleep 0.5
		done

		date > file$fid
		echo "file$fid: $(cat file$fid)"
	)
        sleep 1
done
