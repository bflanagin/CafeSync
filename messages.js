function check_messages(user) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";
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

function retrieve_messages(room,theid) {
    //remote = 1;
    //console.log("sending to server: "+currentmessage+" : "+mesgdate);

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";
   // console.log(url)
    // whowith = "Chat";

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
                    var sync = 1;
                     while(sync < (fromserver.length -1)) {
                        var messageblock = fromserver[sync].split("::");
                        var lr = 0;
                             save_messages(messageblock[0],messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[5],messageblock[6],messageblock[7],messageblock[8],messageblock[9]);


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
   // console.log("sending to server: "+currentmessage+" : "+mesgdate);
   // console.log("from RC:"+room);

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

}


function send_messages(user,message) {
    var mesgdate = new Date();
        messageField.text = "";
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


    var testStr = "SELECT  *  FROM CHATS WHERE name='"+name+"' AND date='"+mesgdate+"' AND message='"+themessage+"' AND speaker='"+thespeaker+"'";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

            var pull = tx.executeSql(testStr);
          //  console.log("From save_messages database input "+data);

            if(pull.rows.length == 0) {
             //   console.log("Inserting");

            tx.executeSql(userStr,data);

                        if(thespeaker != usercardNum) {

                         dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+thespeaker+"' AND `id` !=''";
                       db.transaction(function(tx) {

                           var pull = tx.executeSql(dataStr1);

                           otherperson = pull.rows.item(0).name;

                    });

                        } else {
                            otherperson = "";
                        }


                    if(themessage == "<begin>") {
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

            if(connected.search(pull.rows.item(num).id) != -1 && accepted.search(pull.rows.item(num).id) !=-1) {

                var humanDate = new Date(pull.rows.item(num).date*1);


            collectedContacts.append({
                                         who:pull.rows.item(num).id,
                                         speaker:pull.rows.item(num).name,
                                         timecode:humanDate.toLocaleDateString(),
                                         message:pull.rows.item(num).company,
                                         //avatar:pull.rows.item(num).avatar
                                         avatar:ava

                                     });

            }

            num = num + 1;
        }

    });

}

function show_chat(room) {

    var sync = 0;
    var reverseroom = room.split(",")[1]+","+room.split(",")[0];
    var getstuff = "SELECT  * FROM CHATS WHERE `name` ='"+room+"' OR `name` ='"+reverseroom+"' ORDER BY date ASC";

    console.log(room);

     chatlog.clear();

    var you;
    var them;

    if(room.split(",")[0] == usercardNum) {
        you = room.split(",")[0];
        them = room.split(",")[1];
    } else {
        you = room.split(",")[1];
        them = room.split(",")[0];
    }

    db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

        var chat = tx.executeSql(getstuff);

     while(sync < chat.rows.length) {

         //console.log(chat.rows.item(sync).speaker);

        if(chat.rows.item(sync).speaker == you || chat.rows.item(sync).speaker == them) {

            //console.log(chat.rows.item(sync).speaker);

        var lr = 0;
        var dataStr1;
         var text = chat.rows.item(sync).message;
         if(text.search("<begin>") == -1){
             var otherperson;

             var otherava;

             if(them != usercardNum ) {
                    dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+them+"' AND `id` !=''";

              var pull = tx.executeSql(dataStr1);

              otherperson = pull.rows.item(0).name;
                whowith = otherperson;
              if(pull.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pull.rows.item(0).avatar
                           if(otherava.search("/9j/4A") != -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

              }


             }

             var humanDate = new Date(chat.rows.item(sync).date*1);
             var maybemore = "";
             if(chat.rows.item(sync).message.search("http") != -1) {
                 maybemore = "<img src="+chat.rows.item(sync).message+">";
             } else {
                 maybemore = "<p>"+chat.rows.item(sync).message+"</p>";
             }

            chatlog.append({who:chat.rows.item(sync).speaker,
                            speaker:otherperson,
                            timecode:humanDate.toLocaleDateString(),
                            message:maybemore
                           });
                chatLog.positionViewAtEnd();
         }

        }

        sync = sync + 1;
    }

    });

}

function show_conversations(room) {
    var sync = 0;
    var dataStr1;
    var otherperson;
    var otherava;
    var you;
    var them;
    var convers = [];

     conversed.clear();

   // var reverseroom = room.split(",")[1]+","+room.split(",")[0];
    //var getstuff = "SELECT  * FROM CHATS WHERE `name` LIKE '"+room+",%' OR `name` ='%,"+room+"' AND `speaker` ='"+room+",%' OR `speaker` ='%,"+room+"' ORDER BY date DESC";



    var getstuff = "SELECT  * FROM CHATS WHERE `name` LIKE '"+room+",%' OR `name` LIKE '%,"+room+"' AND `speaker` LIKE '"+room+",%' OR `speaker` LIKE '%,"+room+"' ORDER BY date DESC";

     db.transaction(function(tx) {

         tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

        var pull = tx.executeSql(getstuff);
         var pulls;
         //console.log("from show_conversations room "+ room + " number of conversations " + pull.rows.length);



    while(sync < pull.rows.length) {

         if(pull.rows.item(sync).speaker.split(",").length == 2) {

             if(pull.rows.item(sync).speaker.split(",")[0] == usercardNum) {
                 you = pull.rows.item(sync).speaker.split(",")[0];
                 them = pull.rows.item(sync).speaker.split(",")[1];
             } else {
                 you = pull.rows.item(sync).speaker.split(",")[1];
                 them = pull.rows.item(sync).speaker.split(",")[0];
             }


                dataStr1 = "SELECT  name,avatar  FROM SavedCards WHERE `id` ='"+them+"' AND `id` !=''";

             pulls = tx.executeSql(dataStr1);

                    otherperson = pulls.rows.item(0).name;

            if(pulls.rows.item(0).avatar.length < 4) { otherava = "img/default_avatar.png"} else {otherava = pulls.rows.item(0).avatar
                         if(otherava.search("/9j/4A") != -1) { otherava = "data:image/jpeg;base64, "+otherava.replace(/ /g, "+");}

            }
            if(convers.toString().search(pull.rows.item(sync).name) == -1 ) {
                convers.push(pull.rows.item(sync).name);

                var humanDate = new Date(pull.rows.item(sync).date*1);


           conversed.append({
                                who:pull.rows.item(sync).name,
                                speaker:otherperson,
                                timecode:humanDate.toLocaleDateString(),
                                message:pull.rows.item(sync).message,
                                avatar:otherava,
                                cardStatus:"We've talked"

                            });
        }

         }
        sync = sync + 1;
}
    });

}

