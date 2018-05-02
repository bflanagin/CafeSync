function check_log(user) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php";
    //console.log(user);

    var party = ""
    if(user.search(",") != -1) {
            party =user;
            messagePage.roomId = user;
         } else {
           party = usercardNum+','+user;
            messagePage.roomId = party;
        }

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

                if(http.responseText == "0") {
                        if(user != 0) {
                        send_messages(user,"<begin>");
                        }

                } else if(messagePage.messagelist != http.responseText){
                        messagePage.messagelist =http.responseText;
                        retrieve_messages(user,userid);

                   // notificationClient.notification = "New Message from "+user;
                }
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ userid + "&users="+party+"&type=check" );

}

function retrieve_log(room,theid) {
    //remote = 1;
    //console.log("sending to server: "+currentmessage+" : "+mesgdate);

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php";
   // console.log(url)
    // whowith = "Chat";

   // console.log(room,theid);

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
                var raw = http.responseText;
                if(raw == "1") {
                   //console.log("up to date");
                    // remote = 0;
                } else {
                   //console.log("from server: "+raw);
                    var fromserver = raw.split("><");
                    var sync = 0;
                     while(sync < (fromserver.length)) {
                        var messageblock = fromserver[sync].split("::");
                        var lr = 0;
                            if(room == theid) {
                             save_log(userid,messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[7]);
                            } else {
                                remotelog[sync] = [room,messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[7]];
                                //console.log(remotelog);
                            }

                        sync = sync + 1;
                    }

                      if( remotelog.length > 0 ) {
                       //  remotelogGet.stop();
                         show_log(room);
                     }

                }

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid +"&devid=" + devId + "&appid=" + appId + "&name="+ room +"&type=retrieve" );

}


/* function retrieve_log(room) {
    //remote = 1;
   // console.log("sending to server: "+currentmessage+" : "+mesgdate);
   // console.log("from RC:"+room);

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php";
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
                var raw = http.responseText;
                if(raw == "1") {
                   //console.log("up to date");
                    // remote = 0;
                } else {
                   //console.log("from RC server: "+raw);
                    var fromserver = raw.split("><");
                    var sync = 1;
                    var dataStr1;
                    var dataStr2;
                    var you;
                    var otherperson;
                    var otherava;
                    var ava;
                     while(sync < fromserver.length) {
                        var messageblock = fromserver[sync].split("::");


                            save_messages(userid,messageblock[2]," "," "," "," "," ",messageblock[3],messageblock[4],messageblock[2]);


                        var lr = 0;





                        sync = sync + 1;
                    }

                }

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid +"&devid=" + devId + "&appid=" + appId + "&name="+ usercardNum +"&type=chats" );

} */


function send_log(user,message) {
    var mesgdate = new Date();

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php";
    //console.log("send message "+user+":"+message);
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
                      log.fupdate = true;
                //createdb();
               // save_log(userid,user,usercardNum,message,0,mesgdate.getTime());
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid + "&devid=" +devId+ "&appid="+appId+"&message=" + message + "&name="+ user + "&speaker=" + usercardNum+"&date="+mesgdate.getTime()+"&room=0&type=sending");


}


function save_log(theid,roomid,name,themessage,branch,mesgdate) {

   // var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var dataStr1;
    var otherperson;
    var data = [theid,roomid,name,themessage,branch,mesgdate,];

    // console.log("From save_log "+data);

    var userStr = "INSERT INTO NARRATIVE VALUES(?,?,?,?,?,?)";


    var testStr = "SELECT  *  FROM NARRATIVE WHERE roomid='"+roomid+"' AND updated ='"+mesgdate+"' AND speaker='"+name+"'";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS NARRATIVE (id TEXT, roomid TEXT,speaker TEXT, speech TEXT,branch INT, updated TEXT)');

            var pull = tx.executeSql(testStr);
          //  console.log("From save_messages database input "+data);
           //    console.log("from Saved "+ pull.rows.length);
            if(pull.rows.length == 0) {
                //console.log("Inserting");

                        tx.executeSql(userStr,data);

                       // if(thespeaker != usercardNum) {

                    //     dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+thespeaker+"' AND `id` !=''";
                   //    db.transaction(function(tx) {

                    //       var pull = tx.executeSql(dataStr1);

                   //        otherperson = pull.rows.item(0).name;

                  //  });

                      // } else {
                         // otherperson = "";
                       //}


                  /*  if(themessage == "<begin>") {
                    notificationClient.notification = "New Chat from: "+otherperson;
                    } else {
                        if(messagePage.showroom == true && messagePage.roomId == name) {
                            console.log("updating chat");
                                var humanDate = new Date(mesgdate*1);

                            if(lastmessage != mesgdate) {

                            chatlog.append({who:thespeaker,
                                            speaker:otherperson,
                                            timecode:humanDate.toLocaleDateString(),
                                            message:themessage
                                           });
                                chatLog.positionViewAtEnd();

                            lastmessage =mesgdate;
                            }

                        }

                        totalNewMessages = totalNewMessages + 1;
                        if(thespeaker !=usercardNum) {
                        notificationClient.notification = "New Message from: "+otherperson;
                        }
                    } */



                       // console.log("Already there");
            }

        });



}



function show_log(room) {

    var sync = 0;
  //  var reverseroom = room.split(",")[1]+","+room.split(",")[0];
    var getstuff = "SELECT  * FROM NARRATIVE WHERE `roomid` ='"+room+"' ORDER BY updated DESC";

    //console.log(room);

     statlist.clear();
    narrativeList = 0;

  /*  var you;
    var them;

    if(room.split(",")[0] == usercardNum) {
        you = room.split(",")[0];
        them = room.split(",")[1];
    } else {
        you = room.split(",")[1];
        them = room.split(",")[0];
    } */

if(room != usercardNum) {
       // console.log("from show log "+remotelog);

    //[152,,,,,,152,152,152,Hello World!,0,1523901344883]


    narrativeList = remotelog.length;

     var dataStr = "SELECT name,company,alias,avatar FROM SavedCards WHERE id="+room;
     var dataStr1 = "SELECT name,company,alias,avatar FROM TempCards WHERE id="+room;
    var otherperson = "";
    var otherCompany = "";
    var otherava = "";

       db.transaction(function(tx) {
       tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT,cardsop INT)');

      var pull = tx.executeSql(dataStr);
      var pull1 =  tx.executeSql(dataStr1);
           if(pull.rows.length == 1) {
               otherperson = pull.rows.item(0).name;
               otherCompany = pull.rows.item(0).company;
               if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                           if(otherava.search("/9j/4A") != -1 && otherava.search("data:image/jpeg;base64") == -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

              }

           } else if(pull1.rows.length == 1){
               otherperson = pull1.rows.item(0).name;
               otherCompany = pull1.rows.item(0).company;
               if(pull1.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull1.rows.item(0).avatar
                            if(otherava.search("/9j/4A") != -1 && otherava.search("data:image/jpeg;base64") == -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

               }
           } else {
               otherava = "./img/default_avatar.png";
           }

       });


    for(var num =1;num < remotelog.length;num = num + 1) {

       // console.log("from show log "+remotelog[num]);
        var currentpost = remotelog[num];

 var humanDate = new Date(currentpost[5]*1);
   var maybemore = "";
   if(currentpost[3].search("http") != -1) {
       maybemore = "<img src="+currentpost[3]+">";
   } else {
       maybemore = "<p>"+currentpost[3]+"</p>";
   }

  statlist.append({who:otherperson,
                   compname:otherCompany,
                  status: maybemore,
                  date: humanDate.toLocaleDateString(),
                  card:currentpost[0],
                  imgsource:otherava,
                 });

    }

      statlistView.positionViewAtBeginning();




} else { db.transaction(function(tx) {

             tx.executeSql('CREATE TABLE IF NOT EXISTS NARRATIVE (id TEXT, roomid TEXT,speaker TEXT, speech TEXT,branch INT, updated TEXT)');

        var chat = tx.executeSql(getstuff);

        narrativeList = chat.rows.length;

     while(sync < chat.rows.length) {

           //console.log(sync,chat.rows.item(sync).speech);
         //console.log(chat.rows.item(sync).speaker);

       // if(chat.rows.item(sync).speaker == you || chat.rows.item(sync).speaker == them) {

            //console.log(chat.rows.item(sync).speaker);

        var lr = 0;
        var dataStr1;
         var text = chat.rows.item(sync).speech;
         //if(text.search("<begin>") == -1){
             var otherperson;
             var otherCompany;

             var otherava;

             if(room != usercardNum ) {
                    dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+room+"' AND `id` !=''";

              var pull = tx.executeSql(dataStr1);

              otherperson = pull.rows.item(0).name;
              otherCompany = pull.rows.item(0).company;
              //  whowith = otherperson;
              if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                           if(otherava.search("/9j/4A") != -1 && otherava.search("data:image/jpeg;base64") == -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

              }


             } else {
                otherperson = username;
                otherCompany = usercompany;
             }

             var humanDate = new Date(chat.rows.item(sync).updated*1);
             var maybemore = "";
             if(chat.rows.item(sync).speech.search("http") != -1) {
                 maybemore = "<img src="+chat.rows.item(sync).speech+">";
             } else {
                 maybemore = "<p>"+chat.rows.item(sync).speech+"</p>";
             }

            statlist.append({who:otherperson,
                             compname:otherCompany,
                            status: maybemore,
                            date: humanDate.toLocaleDateString(),
                            card:usercardNum,
                            imgsource:otherava,
                           });
                statlistView.positionViewAtBeginning();
        // }

        //}

        sync = sync + 1;
    }

    });
}

}

function latest_log(from,cardNum) {

    var latestLog = "";

     var getstuff = "SELECT  * FROM NARRATIVE WHERE `roomid` ='"+cardNum+"' ORDER BY updated DESC";

    db.transaction(function(tx) {

             tx.executeSql('CREATE TABLE IF NOT EXISTS NARRATIVE (id TEXT, roomid TEXT,speaker TEXT, speech TEXT,branch INT, updated TEXT)');

        var chat = tx.executeSql(getstuff);
            if(chat.rows.length != 0) {
                latestLog = chat.rows.item(0).speech;
            }

    });

   // console.log(from,cardNum,latestLog);

    return latestLog;
}


function latest_log_remote (from,cardNum) {

    var latestLog = "";


    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php";
   // console.log(url)
    // whowith = "Chat";

   // console.log(room,theid);

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
                var raw = http.responseText;
                if(raw == "1") {
                   //console.log("up to date");
                    // remote = 0;
                } else {
                  // console.log("from server: "+raw);
                    var fromserver = raw.split("><");
                    var messageblock;
                        //console.log(fromserver[1].split("::"));
                        if(fromserver[1] != undefined) {
                        messageblock = fromserver[1].split("::");

                        } else {
                            messageblock = "";
                        }

                        var lr = 0;
                            if(cardNum == from) {
                             save_log(userid,messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[7]);
                            } else {
                                latestLog = messageblock[3];

                               // console.log(latestLog);
                                if(latestLog != undefined) {
                                    if(from == "othercard") {
                                    cardStatus = messageblock[3];
                                    } else {
                                        cardStatus = qsTr("Status: ")+messageblock[3];
                                    }
                                     return latestLog;
                                }
                            }


                    }

                }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid +"&devid=" + devId + "&appid=" + appId + "&name="+ cardNum +"&type=retrieve&latest=1" );



}


function show_log_remote(room) {

    var sync = 0;
  //  var reverseroom = room.split(",")[1]+","+room.split(",")[0];
    var getstuff = "SELECT  * FROM NARRATIVE WHERE `roomid` ='"+room+"' ORDER BY updated ASC";

    //console.log(room);

     statlist.clear();


    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php";
   // console.log(url)
    // whowith = "Chat";

   // console.log(room,theid);

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
                var raw = http.responseText;
                if(raw == "1") {
                   //console.log("up to date");
                    // remote = 0;
                } else {
                  // console.log("from server: "+raw);
                    var fromserver = raw.split("><");
                    var messageblock;
                        //console.log(fromserver[1].split("::"));
                        if(fromserver[1] != undefined) {
                        messageblock = fromserver[1].split("::");

                        } else {
                            messageblock = "";
                        }

                  /*      var lr = 0;
                            if(cardNum == usercardNum) {
                             save_log(userid,messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[7]);
                            } else {
                                latestLog = messageblock[3];

                               // console.log(latestLog);
                                if(latestLog != undefined) {
                                    if(from == "othercard") {
                                    cardStatus = messageblock[3];
                                    } else {
                                        cardStatus = qsTr("Status: ")+messageblock[3];
                                    }
                                     return latestLog;
                                }
                            } */

                          /*  statlist.append({who:otherperson,
                                             compname:otherCompany,
                                            status: maybemore,
                                            date: humanDate.toLocaleDateString(),

                                           });
                                statlistView.positionViewAtEnd(); */


                    }

                }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid +"&devid=" + devId + "&appid=" + appId + "&name="+ cardNum +"&type=retrieve&latest=1" );



        // }

        //}

        sync = sync + 1;

}


function dump() {

    db.transaction(function(tx) {

             tx.executeSql('DROP TABLE NARRATIVE');

    });

}



