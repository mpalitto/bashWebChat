#!/bin/bash

# chat server
# ad ogni connessione viene eseguito in un nuovo thread
PID=$$
# quando un messaggio e ricevuto deve essere comunicato a tutti i thread
# questo avviene tramite un gestore di eventi
# ad ogni thread viene associato un pipe da cui riceve i messaggi da event manager
# lo stdin serve per ricevere messaggi da websocket e cioe da client
# lo stdout serve per mandare messaggi al client tramite websocket

#  user1 <-websocket-> thread[user1] <-pipes-> eventManager <-pipes-> thread[user2] <-websocket-> user2

# invia evento a event manager
function send2Event { echo $1 >webChatEventPipe; }

# per ricevere il messaggio da event manager creo il pipe associato a questo thread
# creo pipe per ascoltare event manager
mkfifo $PID.webChatEventPipe
# ascolto event manager e inoltro a client quanto ricevuto (inoltro a stdout che collegato a websocket)
# questo processo esegue in background e una volta chiuso il suo pipe, termina
(while read line; do echo $line; done) < $PID.webChatEventPipe &

# registra questo thread con event manager
send2Event "newPID $PID"

#ON-OPEN il codice viene avviato
#le comunicazioni da client avvengono nei seguenti formati
#newUser sex::name           - nuovo user si e aggiunto alla chat, sex puo' essere [lui|lei]
#rmUser                       - user si e scollegato dalla chat 
#newMsg  <html user>message   - 
# websocket collegato a stdin da cui ricevo messaggi da client dello user
while read cmd value; do
  #inoltra quanto ricevuto da utente a event manager aggiungendo il PID
  send2Event "${cmd}::$PID $value"
done

#ON-CLOSE stdin viene chiuso e si esce dal while loop
# qui devo mandare un messaggio agli altri threads che l'utente si e' disconnesso

#invia ai vari clients che utente si disconnette da chat
echo SENDING TERMINATION EVENT > .eventManager.log
send2Event "rmUser::$PID"
