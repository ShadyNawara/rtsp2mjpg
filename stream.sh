#!/bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

ffserver -hide_banner -loglevel ${FFSERVER_LOG_LEVEL} &
cvlc -I dummy ${RTSP_URL} --sout "#transcode{vcodec=mjpg,quality=1,fps=3,acodec=none,width=1280,height=720}:standard{access=http{mime=multipart/x-mixed-replace; boundary=7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:8091/videostream.cgi}" 2>/dev/null
ffmpeg -hide_banner -loglevel ${FFMPEG_LOG_LEVEL} -rtsp_transport tcp ${FFMPEG_INPUT_OPTS} -i ${RTSP_URL} ${FFMPEG_OUTPUT_OPTS} http://127.0.0.1:8090/feed.ffm

