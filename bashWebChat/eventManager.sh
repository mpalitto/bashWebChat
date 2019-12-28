#!/bin/bash
echo "STARTING EVENT MANAGER"
declare -A pipes
declare -A users
pipe=4
function openPipe { cmd=$(echo "exec $2>$1"); eval $cmd; let pipe++; }
function closePipe { cmd=$(echo "exec $1>&-"); eval $cmd; }

function send2users {
    echo SEND2USERS "${!users[@]}" 
    for pid in "${!users[@]}"; do
      echo SENDING TO: ${users[$pid]:5}
      echo "$1" > $pid.webChatEventPipe
    done
}

#per ricevere dai vari threads

while read type value; do
  echo "EM: $type $value"
  # se il thread si sta registrando aggiungilo alla lista
  if [ $type = "newPID" ]; then
    echo "NUOVO PID: $value"
    pipes[$value]=$pipe
    openPipe $value.webChatEventPipe $pipe

  # se il thread sta terminando lo rimuovo dalla lista
  elif [ ${type:0:6} = "rmUser" ]; then
    PID=${type:8}
    echo "THREAD PID: $PID USER: ${users[$PID]} DISCONNESSO"
    send2users "rmUser::${users[$PID]:5}"
    unset users[$PID] #rimuovi user da lista di users
    UL="userList::"$(for pid in ${!users[@]}; do echo -n "<div style='display:inline-block'><img src='/img_${users[$pid]:0:3}.png' alt='Avatar' height=30' width='30'>${users[$pid]:5}</div>"; done)
    echo "$UL"
    send2users "$UL"
    closePipe ${pipes[$PID]} # chiudi pipe
    unset pipes[$PID] # rimuovi dalla lista delle pipes
    rm $PID.webChatEventPipe # rimuovi pipe
    ls *.webChatEventPipe
    # manda la lista degli users aggiornata
    #send2users "userList$(for pid in ${!users[@]}; do echo -n "::${users[$pid]}"; done)"
    #send2users "userList$(for pid in ${!users[@]}; do echo -n "<div><img src="/img_${users[$pid][0]}.png" alt="Avatar" style="width:5%">${users[$pid][1]}"; done)</div>"

  elif [ ${type:0:9} = "newUser::" ]; then
    pid=${type:9}
    users[$pid]=$value # sex::name - aggiungi il nuovo utente alla lista
    send2users "newUser::$value"
    # manda la lista degli users aggiornata
    UL="userList::"$(for pid in ${!users[@]}; do echo -n "<div style='display:inline-block'><img src='/img_${users[$pid]:0:3}.png' alt='Avatar' height=30' width='30'>${users[$pid]:5}</div>"; done)
    #echo "$UL"
    send2users "$UL"
  else
    # invia evento a tutti i threads
     send2users "$value"
  fi
done

trap "echo CLOSING EVENT MANAGER; closePipe; rm webChatEventPipe; exit 0" SIGINT

