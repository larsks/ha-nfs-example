#!/bin/sh

last=$(date +%s)
while :; do
        now=$(date +%s)
        delta=$((now-last))
        last=$now
        if (( delta > 10 )); then
                echo "*** iteration took $delta seconds ***"
        fi

        fid=$(( RANDOM % 100 ))
        date > file$fid
        echo "file$fid: $(cat file$fid)"
        sleep 1
done
