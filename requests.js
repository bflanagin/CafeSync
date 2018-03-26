function send_request(requestid,message) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/areas.php";
   // console.log(url)
    var d = new Date();
    var room = requestid+usercardNum+d.getTime();

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
               // var server = http.responseText;
               // requests.state = "Hide";

            }

        }

    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ userid +"&roomid="+room+"&requestid="+requestid+"&name="+usercardNum+"&message="+message+"&type=send" );


}

function check_requests() {

    var old_requests = requests;
    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/areas.php";
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
               var server = http.responseText;

                    requestlog.clear();
                    requests = 0;

                    for(var num = 1;num < server.split("><").length;num = num + 1) {

                             var requestedby = server.split("><")[num].split("::")[0];
                             var values = server.split("><")[num];

                            var stat = "";

                           if(values.split("::")[4] != "1") {

                        if(requestedby == usercardNum) {

                            switch(values.split("::")[4]) {
                            case "0": stat = "Sent";break;
                            case "1": stat = "Accepted";break;
                            case "2": stat = "Denied";break;
                            default: stat = "Sent";break;
                            }

                                 requestlog.append({
                                              who:values.split("::")[1],
                                              speaker: values.split("::")[6],
                                              timecode:"?",
                                              message:values.split("::")[2],
                                              direction: 0,
                                              status: stat,
                                              requestid:values.split("::")[3],


                                          });

                                } else {
                                        switch(values.split("::")[4]) {
                                        case "0": stat = "New";break;
                                        case "1": stat = "Accepted";break;
                                        case "2": stat = "Denied";break;
                                        default: stat = "New";break;
                                             }
                                     requests = requests + 1;
                            requestlog.append({

                                         who:values.split("::")[0],
                                         speaker: values.split("::")[5],
                                         timecode:"?",
                                         message:values.split("::")[2],
                                         direction: 1,
                                         status: stat,
                                         requestid:values.split("::")[3],

                                     });

                        }

                    } else {
                               if(requestedby == usercardNum) {
                            accepted = values.split("::")[1]+","+accepted;
                                } else {
                                 accepted = values.split("::")[0]+","+accepted;
                               }
                           }

                    }

                    if(requests > old_requests) {
                        notificationClient.notification = "New Connection Requests.";
                    }

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ userid +"&name="+ usercardNum +"&type=check" );

}

function accept_request(room) {

//send_chat(room,"<joined>");
  // var d = new Date();
//save_chat(id,username,avatar1,part_id,part_names,part_avatar,room,d,"<joined>",username);
 //requests.state = "Hide";
 var roomid = room;


    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/areas.php";
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
              //  console.log(http.responseText);

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ userid + "&roomid="+room+"&type=update&status=1" );

}

function decline_request(room) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/areas.php";
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

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ userid + "&roomid="+room+"&type=update&status=2");


}


