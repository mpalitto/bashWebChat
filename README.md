# bashWebChat
WEB CHAT running **BASH script** on server side using **socat** as webserver and **websocketd** as websocket server

![image](https://user-images.githubusercontent.com/7433768/71541813-f0182400-295e-11ea-82bb-4f809cd516ad.png)

Insert your name and press the picture that best rappresent you

**he** enter the chat
![image](https://user-images.githubusercontent.com/7433768/71541856-5604ab80-295f-11ea-9b7a-d365f1fe20cc.png)

**she** enter the chat
![image](https://user-images.githubusercontent.com/7433768/71541875-92380c00-295f-11ea-9ef4-aa542d2ccb8e.png)

**he** gets **her** text
![image](https://user-images.githubusercontent.com/7433768/71541875-92380c00-295f-11ea-9ef4-aa542d2ccb8e.png)

## Installation for Linux
There are 2 options **Dockerized** and **Vanilla**
### Dockerized installation
pre-requisites: docker installed

if you need to install **docker** on debian/ubuntu `sudo apt install docker.io`

1. clone or dowload repo
2. **cd** into the **bashWebChat** dir
3. `chmod +x startWebChat.sh`
4. `source build-bashWebChat.sh`

#### Use instructions
To start the **Web Chat** type: `./startWebChat`

If a container for the WebChat already exists it will ask if to start it or to delete it and create and run a new container, if container does not yet exist, it doesn't promot any choice and will create and run the WebChat container.

The last option cound be useful if changes are made to the WebChat code and a new build is available (which can be update by typing `source build-bashWebChat`.

N.B. the ports used by the **Web Chat** are **:80** for the HTML pages and **:8080** for websocket

Open web browser to **localhost**

### Vanilla installation
1. install **socat** `apt install socat`
2. download and install websocketd 

```
wget https://github.com/joewalnes/websocketd/releases/download/v0.3.1/websocketd-0.3.1_amd64.deb
dpkg -i websocketd-0.3.1_amd64.deb
```
3. download or clone repo
4 **cd** into bashWebChat dir
5. make some file executable
```
chmod +x bashWebChat/startChatServer.sh bashWebChat/chatWorker.sh bashWebChat/eventManager.sh simpleWebServer/simpleWebServer.sh simpleWebServer/startWebServer.sh
```
#### Use instructions

1. `cd bashWebChat` at this point you shoud be into **/home/user/.../bashWebChat/bashWebChat** dir
2. `sudo ./startWebChat`
3. open browser to **localhost**
