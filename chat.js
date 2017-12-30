function check_chat(id) {

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
               console.log(http.responseText);


            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ id + "&type=check" );


}

function retrieve_chat(room,theid) {
    remote = 1;
    //console.log("sending to server: "+currentmessage+" : "+mesgdate);

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
                   //console.log("from server: "+raw);
                    var fromserver = raw.split("><");
                    var sync = 1;
                     while(sync < fromserver.length) {
                        var messageblock = fromserver[sync].split("::");
                        var lr = 0;
                   save_chat(messageblock[0],messageblock[1],messageblock[2],messageblock[3],messageblock[4],messageblock[5],messageblock[6],messageblock[7],messageblock[8],messageblock[9]);

                         if(messageblock[8].search("<background;;") == -1){

                                currentmessage = messageblock[8];
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
    http.send("&id="+ theid +"&devid=" + devId + "&appid=" + appId + "&room="+ room + "&message="+currentmessage+"&date="+mesgdate+"&type=retrieve" );

}

function send_chat(room,message) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/chats.php";

   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
               // console.log(http.responseText);

                //createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ id + "&devid=" +devId+ "&appid="+appId+"&message=" + message + "&name="+ username + "&part_id="+part_id+ "&part_names="+part_names+ "&part_avatar="+part_avatar+ "&speaker=" + username +"&date="+mesgdate+"&room="+ room + "&avatar="+ avatar1 + "&type=sending");


}

function retrieve_users(search) {

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


function save_chat(theid,name,avatar1,part_id,part_names,part_avatar,roomid,mesgdate,themessage,thespeaker) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    var data = [theid,name,avatar1,part_id,part_names,part_avatar,roomid,mesgdate,themessage.replace(/\'/g,"&#x27;"),thespeaker];

    var userStr = "INSERT INTO CHATS VALUES(?,?,?,?,?,?,?,?,?,?)";


    var testStr = "SELECT  *  FROM CHATS WHERE id='"+theid+"' AND date='"+mesgdate+"' AND message='"+themessage.replace(/\'/g,"&#x27;")+"'";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

            var pull = tx.executeSql(testStr);

            if(pull.rows.length == 0) {

            tx.executeSql(userStr,data);

                    }

        });

         db.transaction(function(tx) {

             tx.executeSql('CREATE TABLE IF NOT EXISTS AREAS (id TEXT, roomid TEXT,party INT,lastdate TEXT,lastmessage TEXT)');

            var updateArea = "UPDATE AREAS SET lastdate='"+Date()+"',party='"+part_id.split(";").length+"',lastmessage='"+currentmessage.replace(/\'/g,"&#x27;")+"' WHERE roomid='"+roomid+"'";



            tx.executeSql(updateArea);

         });

}
