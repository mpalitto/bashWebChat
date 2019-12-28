FROM debian:stretch
RUN apt-get update
RUN apt-get -y install socat wget 
RUN wget https://github.com/joewalnes/websocketd/releases/download/v0.3.1/websocketd-0.3.1_amd64.deb
RUN dpkg -i websocketd-0.3.1_amd64.deb
COPY bashWebChat/. bashWebChat/
COPY simpleWebServer/. simpleWebServer/
RUN chmod +x bashWebChat/startChatServer.sh bashWebChat/chatWorker.sh bashWebChat/eventManager.sh simpleWebServer/simpleWebServer.sh simpleWebServer/startWebServer.sh
CMD ["/bashWebChat/startChatServer.sh"]
