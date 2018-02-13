function check_messages(user) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";
    //console.log(user);

    var party = ""
    if(user.search(",") != -1) {
            party =user;
            roomId = user;
         } else {
           party = usercardNum+','+user;
            roomId = party;
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
                        send_messages(usercardNum+","+user,"<begin>");
                        }

                } else if(messagelist != http.responseText){
                        messagelist =http.responseText;
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

function retrieve_messages(room,theid) {
    //remote = 1;
    //console.log("sending to server: "+currentmessage+" : "+mesgdate);
    chatlog.clear();
    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";
   // console.log(url)
     whowith = "Chat";

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
                    var sync = 1;
                     while(sync < fromserver.length) {
                        var messageblock = fromserver[sync].split("::");
                        var lr = 0;
                   //save_chat(messageblock[0],messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[5],messageblock[6],messageblock[7],messageblock[8],messageblock[9]);
                        var dataStr1;
                         if(messageblock[8].search("<begin>") == -1){
                             var otherperson;

                             var otherava;
                             //console.log(messageblock[9]);
                             if(messageblock[9] != usercardNum) {
                           dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+messageblock[9].split(",")[0]+"' AND `id` !=''";
                          db.transaction(function(tx) {

                              var pull = tx.executeSql(dataStr1);

                              otherperson = pull.rows.item(0).name;
                                whowith = otherperson;
                              if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                                           if(otherava.search("/9j/4A") != -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

                              }

                          });
                             } /*else if(messageblock[9].split(",")[1] != usercardNum) {
                                  dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+messageblock[9].split(",")[1]+"' AND `id` !=''";
                                 db.transaction(function(tx) {

                                     var pull = tx.executeSql(dataStr1);

                                     otherperson = pull.rows.item(0).name;

                                     if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                                                  if(otherava.search("/9j/4A") != -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

                                     }

                                 });



                             } */

                                //currentmessage = messageblock[8];

                             chatlog.append({who:messageblock[9],
                                            speaker:otherperson,
                                            timecode:messageblock[7],
                                            message:messageblock[8]});

                         }

                        sync = sync + 1;
                    }

                }

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ theid +"&devid=" + devId + "&appid=" + appId + "&name="+ room +"&type=retrieve" );

}


function retrieve_conversations(room) {
    //remote = 1;
    //console.log("sending to server: "+currentmessage+" : "+mesgdate);
  //  console.log("from RC:"+room);
    conversed.clear();
    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";
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
                            if(messageblock[2].split(",")[0] != usercardNum) {
                          dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+messageblock[2].split(",")[0]+"' AND `id` !=''";


                         db.transaction(function(tx) {

                             var pull = tx.executeSql(dataStr1);

                             otherperson = pull.rows.item(0).name;

                             if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                                          if(otherava.search("/9j/4A") != -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

                             }

                         });
                            } else {
                                 dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+messageblock[2].split(",")[1]+"' AND `id` !=''";
                                db.transaction(function(tx) {

                                    var pull = tx.executeSql(dataStr1);

                                    otherperson = pull.rows.item(0).name;

                                    if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                                                 if(otherava.search("/9j/4A") != -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

                                    }

                                });



                            }

                            save_messages(userid,messageblock[2]," "," "," "," "," ",messageblock[3],messageblock[4],messageblock[2]);


                        var lr = 0;


                             conversed.append({
                                                  who:messageblock[2],
                                                  speaker:otherperson,
                                                  timecode:messageblock[3],
                                                  message:messageblock[4],
                                                  avatar:otherava,

                                              });



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

}


function send_messages(user,message) {
    var mesgdate = new Date();

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";
    console.log("send message "+user+":"+message);
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
                messageField.text = "";
                //createdb();
                //save_messages(userid,user," "," "," "," "," ",mesgdate.getTime(),message,usercardNum);
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid + "&devid=" +devId+ "&appid="+appId+"&message=" + message + "&name="+ user + "&part_id=''&part_names=''&part_avatar=''&speaker=" + usercardNum+"&date="+mesgdate.getTime()+"&room=''&avatar=''&type=sending");


}

function retrieve_users(search) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/info.php";
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
                var fromserver = server.split("><");
                var users = 0;
                findpeeps.clear();

                while(users < fromserver.length - 1) {

                findpeeps.append({
                            name:fromserver[users].split("::")[1],
                            theid:fromserver[users].split("::")[0],
                            avatar:"default",
                            lastseen:"yesterday"
                                 });

                users = users +1;
                }

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id +"&search="+search+"&type=users" );

}


function save_messages(theid,name,avatar1,part_id,part_names,part_avatar,roomid,mesgdate,themessage,thespeaker) {

   // var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var dataStr1;
    var otherperson;
    var data = [theid,name,avatar1,part_id,part_names,part_avatar,roomid,mesgdate,themessage,thespeaker];

     //console.log("From save_messages "+data);

    var userStr = "INSERT INTO CHATS VALUES(?,?,?,?,?,?,?,?,?,?)";


    var testStr = "SELECT  *  FROM CHATS WHERE name='"+name+"' AND date='"+mesgdate+"' AND message='"+themessage+"'";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

            var pull = tx.executeSql(testStr);
           // console.log("From save_messages database input "+data);

            if(pull.rows.length == 0) {
               // console.log("Inserting");

            tx.executeSql(userStr,data);

                    if(name.split(",")[0] != usercardNum) {
                        dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+name.split(",")[0]+"' AND `id` !=''";
                       db.transaction(function(tx) {

                           var pull = tx.executeSql(dataStr1);

                           otherperson = pull.rows.item(0).name;

                    });

                    } else {

                         dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+name.split(",")[1]+"' AND `id` !=''";
                       db.transaction(function(tx) {

                           var pull = tx.executeSql(dataStr1);

                           otherperson = pull.rows.item(0).name;

                    });

                    }

                    if(themessage == "<begin>") {
                    notificationClient.notification = "New Chat from: "+otherperson;
                    } else {
                        totalNewMessages = totalNewMessages + 1;
                        notificationClient.notification = "New Message from: "+otherperson;
                    }



                       // console.log("Already there");
            }

        });



}

function contactlist() {

    var dataStr1 = "SELECT  *  FROM SavedCards WHERE `id` !='"+usercardNum+"' AND `id` !=''";
    collectedContacts.clear();
    db.transaction(function(tx) {

        var pull = tx.executeSql(dataStr1);
        var num = 0;
        while(pull.rows.length > num) {
            var ava;
            if(pull.rows.item(num).avatar.length < 4) { ava = "img/default_avatar.png"} else {ava = pull.rows.item(num).avatar
                         if(ava.search("/9j/4A") != -1) { ava = "data:image/jpeg;base64, "+ava.replace(/ /g, "+");}

            }

            if(connected.search(pull.rows.item(num).id) != -1) {

            collectedContacts.append({
                                         who:pull.rows.item(num).id,
                                         speaker:pull.rows.item(num).name,
                                         timecode:1243542,
                                         message:pull.rows.item(num).company,
                                         //avatar:pull.rows.item(num).avatar
                                         avatar:ava

                                     });

            }

            num = num + 1;
        }

    });

}

