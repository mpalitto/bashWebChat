<!DOCTYPE html>
<html>
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>CHAT</title>
      <link rel="stylesheet" type="text/css" href="w3.css">
      <script type="text/javascript" src="chatSocket.js"></script>
  </head>

  <body onload="onEntry('<%$sex%>', '<%$name%>')">

<div class="w3-row w3-white" style="margin-left: 22px; padding-top: 44px; margin-right: 22px">
<!--div class="w3-card-4 xtest w3-col m8"--> 
<div class="w3-card-4"> 
          <%if [ "$sex" = "lui" ]; then%>
  <header class="w3-container w3-blue">
	  <%else%>
  <header class="w3-container w3-pink">
	  <%fi%>
    <div id="userList" style="white-space: nowrap"> <h4>User List: </h4> </div>
  </header>
  <div class="w3-container" style="overflow:auto; height:400px;">
    <p id="chatBox"></p>
  </div>
  
          <%if [ "$sex" = "lui" ]; then%>
  <footer class="w3-container w3-blue">
     <div style="white-space: nowrap">
            <div style="display:inline-block"><img src="/img_lui.png" alt="Avatar" height="40" width="40"><%$name%></div>
	  <%else%>
  <footer class="w3-container w3-pink">
     <div style="white-space: nowrap">
            <div style="display:inline-block"><img src="/img_lei.png" alt="Avatar" height="40" width="40"><%$name%></div>
	  <%fi%>
          <input name="usermsg" type="text" id="usermsg" size="50" style="display:inline-block" onkeypress="return runScript(event)"/>
          <button class="w3-button w3-green" onclick="onSendMessage('<%$sex%>', '<%$name%>')" style="display:inline-block"/>Send</button>
          <button class="w3-button w3-red" onclick="window.location.assign('/')" style="display:inline-block">Close</button>
     </div>
  </footer>

</div>
</div>
<script>
function runScript(e) {
    //See notes about 'which' and 'key'
    if (e.keyCode === 13) {
        //var tb = document.getElementById("scriptBox");
        //eval(tb.value);
        onSendMessage('<%$sex%>', '<%$name%>');
        return false;
    }
}
</script>
  </body>
</html>
