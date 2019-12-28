if [ "$1" = "stop" ]; then
  sudo docker stop bash-web-chat
  exit 0
fi
trap "sudo docker ps" EXIT
if [ "$(sudo docker container ls -a | sed -n '/bash-web-chat/{s/.*/found/;p}')" = "found" ]; then
   echo "container bash-web-chat already exists, would you like to [s] start or [r] remove it and start a new one [s|r]?"
   while true; do
     read answer
     if [ $answer = 'r' ]; then
       sudo docker rm bash-web-chat
       sudo docker run -dit --name bash-web-chat -p 80:80 -p 8080:8080 bash-web-chat
       exit 0
     elif [ $answer = 's' ]; then
       sudo docker start bash-web-chat
       exit 0
     else
       echo "answer not understood... try again"
     fi
   done
else
   sudo docker run -dit --name bash-web-chat -p 80:80 -p 8080:8080 bash-web-chat
fi
