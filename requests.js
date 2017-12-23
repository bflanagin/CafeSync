function send_request(room,requestid) {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/areas.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
               // console.log(http.responseText);
               // var server = http.responseText;
                requests.state = "Hide";

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id +"&roomid="+room+"&requestid="+requestid+"&name="+username+"&type=send" );


}
function check_requests() {


    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/areas.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                //console.log(http.responseText);
               var server = http.responseText;
                if(server != 0) {
                    requests.type = 1;
                    requests.state = "Show";

                    chat_controls = "Hide";
                    theme_controls.state = "Hide";

                    var requestedby = server.split("><")[1].split("::")[0];
                    requests.theroom = server.split("><")[1].split("::")[2];
                    requests.invitename = server.split("><")[1].split("::")[1];
                }
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id +"&type=check" );

}

function accept_request(room) {

send_chat(room,"<joined>");
   var d = new Date();
save_chat(id,username,avatar1,part_id,part_names,part_avatar,room,d,"<joined>",username);
 requests.state = "Hide";
    roomid = room;


    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/areas.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                console.log(http.responseText);

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&roomid="+room+"&type=recieved" );

}

function decline_request(room) {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/"+devId+"/"+appId+"/scripts/areas.php";
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                console.log(http.responseText);

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&roomid="+room+"&type=recieved" );


}
