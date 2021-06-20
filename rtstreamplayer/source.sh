#! /bin/bash -eu

#~/bin/grafana-register.sh "SourceStart,host=rpi sourceStarted=1" > /dev/null 2>&1 || true

ssh base 'rec  -q  -t raw -r 48000 -b 16 - 2>> pi-rec.log | oggenc -C 2  -r -R 48000  -Q -q 5 - 2>> pi-oggenc.log' |  ogg123 - -q -d wav  -f - 2> >(rotatelogs -l src.%Y.%m.%d 86400 ) 
