wdir=$(pwd)
wdir=${wdir::-12}
echo "starting: $wdir/simpleWebServer/simpleWebServer.sh"
socat TCP4-LISTEN:80,fork EXEC:"/bin/bash $wdir/simpleWebServer/simpleWebServer.sh"
#socat TCP4-LISTEN:80 EXEC:"/bin/bash /home/matteo/dev/simpleWebServer/simpleWebServer.sh"
