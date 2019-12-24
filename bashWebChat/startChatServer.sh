#!/bin/bash

#start the webserver
sudo /home/matteo/dev/simpleWebServer/startWebServer.sh &
PIDs=$!

function openPipe { exec 3>$1; } # apre pipe passata per argomento
function closePipe { exec 3>&-; rm $1; } # chiude pipe

#event manager riceve i messaggi tramite il pipe webChatEventPipe
mkfifo webChatEventPipe
./eventManager.sh < webChatEventPipe 2>&1 > .eventManager.log  &
openPipe webChatEventPipe


trap "closePipe webChatEventPipe; sudo kill -9 $PIDs; rm *webChatEventPipe; exit" SIGINT

websocketd --port=8080 --staticdir=. ./chatWorker.sh