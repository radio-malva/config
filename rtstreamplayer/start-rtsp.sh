#! /bin/bash -eux

rtstreamplayer=$HOME/rtstreamplayer/src/rtstreamplayer/rtstreamplayer-main

function onExit {
	#echo "$SECONDS  seconds uptime. killed=${killed:-false}" | mail -s "RMPI player finished" $EMAIL &
	:
}

trap onExit EXIT

#ssh base 'rec  -q  -t raw -r 48000 -b 16 - 2> pi-rec.log | oggenc -C 2  -r -R 48000  -Q -q 5 - 2> pi-oggenc.log' |ogg123 - -d wav  -f - | ~/rtstreamplayer/rtstreamplayer /dev/stdin >> ~/rtsp.log 2>&1
#~/bin/grafana-register.sh "PlayerStart,host=rpi playerStarted=1" || true
if false
then
	: | mail -s "RMPI player started" $EMAIL & 
fi
$rtstreamplayer |&  tee >(rotatelogs -l rtsp.%Y.%m.%d 86400  )  | grep  'snd_pcm_recover.*underrun' |while read LINE     
do 
	${killed:-false} && echo already killed && continue
	killed=true
	( echo $SECONDS seconds. $LINE ; killall -v -KILL rtstreamplayer-main ) |& mail -s "alsa underrun"  $EMAIL &
done

