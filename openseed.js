

function oseed_auth(name,email,passphrase) {

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com:8675/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authPOST.php";
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
                userid = http.responseText;
                //createdb();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email + "&passphrase=" + passphrase);
}




function heartbeat() {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/heartbeat.php";
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

                heart = http.responseText;
                updateinterval = 5500;

               //console.log(heart);

            }

        }


            if(heart == "OffLine") {
                updateinterval = 500 + updateinterval;
                 }
       heartbeats.interval = updateinterval;
    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ userid);

    //

}


function checkcreds(field,info) {

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com:8675/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authCHECK.php";
   /// console.log("sending "+info);
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                uniquemail = 100;
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {

                uniquemail = 101;
                console.log("Incorrect AppID");
            } else {
                //console.log(http.responseText);
                //id = http.responseText;
                if(field == "email") {
                    uniquemail = http.responseText;
                }
                if(field == "username") {
                    uniquename = http.responseText;
                }

                if(field == "account") {
                    uniqueaccount = http.responseText;
                }

                if(field == "passphrase") {
                    uniqueid = http.responseText;
                   // console.log(uniqueid);

                }
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&type="+ field + "&info=" + info);


}




function datasync (id,cnum) {
        //console.log("datasync:" + id);
    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/sync.php?id=" + id;
    var carddata = "";

    //console.log(url);

    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            carddata = http.responseText;
                //console.log(carddata);
            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

            carddata = http.responseText;

    var cid = carddata.substring(carddata.search("<id>")+4,carddata.search("</id>"));
    var cardnum = carddata.substring(carddata.search("<cardid>")+8,carddata.search("</cardid>"));
    var name = carddata.substring(carddata.search("<name>")+6,carddata.search("</name>"));
    var phone = carddata.substring(carddata.search("<phone>")+7,carddata.search("</phone>"));

    var email = carddata.substring(carddata.search("<email>")+7,carddata.search("</email>"));
    var company = carddata.substring(carddata.search("<company>")+9,carddata.search("</company>"));
    var alias = carddata.substring(carddata.search("<alias>")+7,carddata.search("</alias>"));
    var motto = carddata.substring(carddata.search("<motto>")+7,carddata.search("</motto>"));

    var send = carddata.substring(carddata.search("<send>")+6,carddata.search("</send>"));
    var usealias = carddata.substring(carddata.search("<usealias>")+10,carddata.search("</usealias>"));
    var contact = carddata.substring(carddata.search("<contact>")+9,carddata.search("</contact>"));

    var main = carddata.substring(carddata.search("<main>")+6,carddata.search("</main>"));
    var link1 = carddata.substring(carddata.search("<link1>")+7,carddata.search("</link1>"));
    var link2 = carddata.substring(carddata.search("<link2>")+7,carddata.search("</link2>"));
    var link3 = carddata.substring(carddata.search("<link3>")+7,carddata.search("</link3>"));
    var link4 = carddata.substring(carddata.search("<link4>")+7,carddata.search("</link4>"));

    var avatar = carddata.substring(carddata.search("<avatar>")+8,carddata.search("</avatar>"));
    var cardbk = carddata.substring(carddata.search("<cardbk>")+8,carddata.search("</cardbk>"));
    var cardcat = carddata.substring(carddata.search("<cardcat>")+9,carddata.search("</cardcat>"));
    var cardsav = carddata.substring(carddata.search("<cardsav>")+9,carddata.search("</cardsav>"));
    var cardtem = carddata.substring(carddata.search("<cardtem>")+9,carddata.search("</cardtem>"));
    var cardsop = carddata.substring(carddata.search("<cardsop>")+9,carddata.search("</cardsop>"));



if (cid.length > 4) {


    if(cnum == 0) {
        usercardNum =cardnum;
        username = name.replace(/&#x27;/g,"'");
        userphone = phone;
        useremail = email;
        usercompany = company.replace(/&#x27;/g,"'");
        usercat = cardcat;
        useralias = alias;
        usermotto = motto.replace(/&#x27;/g,"'");

        usermain = main;
        website1 = link1;
        website2 = link2;
        website3 = link3;
        website4 = link4;
        avimg = avatar;
        carddesign = cardbk;

        stf= torf(send);
        atf= torf(usealias);
        ctf= torf(contact);

        if(firstrun.state == "Active") {
            firstrun.state = "InActive";

        }
        syncandsave.start();
        connections(usercardNum);


}

             }

if (cardsop == 2) {

         } else {


}
 }
        }
    }
        http.open('GET', url.trim(), true);
        http.send(null);

}


function upload_data(Id,name,phone,email,company,ali,motto,send,ua,sc,main,l1,l2,l3,l4,av,cardback,cardcat,cardsav,cardtem,cardsop) {

   console.log("uploading data");

   // motto = motto.replace(/+/g,"&plus;");
    var http = new XMLHttpRequest();
   /* var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/addcard.php?id=" + Id + "&name=" + name + "&phone="+ phone + "&email=" + email +
                "&company=" + company + "&alias=" + ali + "&motto=" + motto + "&send=" + send + "&ua=" + ua + "&sc=" + sc +"&main=" + main + "&l1=" + l1 + "&l2=" + l2 + "&l3=" + l3
                + "&l4=" + l4 + "&avatar=" + av + "&cardback=" + cardback + "&cardcat=" + cardcat +"&cardsav=" + cardsav + "&cardtem="+cardtem+"&cardsop="+ cardsop; */
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/addcardPOST.php";

    if(av.split("/")[0] == "file:") {
             var test = av.split("/");
                var last = av.split("/")[test.length - 1];
        var dataStr = "SELECT * FROM `LIBRARY` WHERE file = '"+last+"'";

        db.transaction(function(tx) {
            var base64 = "";

            var pull =  tx.executeSql(dataStr);

            if(pull.rows.length != 0) {
                base64 = pull.rows.item(0).base64;
               // sendimage(userid,base64.toString().replace(/ /g,"+"),0);
                av = base64.toString().replace(/+/g," ");
                //av = base64.toString().substring(0,20);
          // av = "https://openseed.vagueentertainment.com:8675/profilePic/"+userid.substring(0,6);

            //av = pull.rows.item(0).file;
            }

        });



    }


    //console.log(send,ua,sc);

    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);

            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                console.log(http.responseText);
               // userid = http.responseText;

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("id=" + Id + "&name=" + name + "&phone="+ phone + "&email=" + email +
              "&company=" + company + "&alias=" + ali + "&motto=" + motto + "&send=" + send + "&ua=" + ua + "&sc=" + sc +"&main=" + main + "&l1=" + l1 + "&l2=" + l2 + "&l3=" + l3
              + "&l4=" + l4 + "&avatar=" + av + "&cardback=" + cardback + "&cardcat=" + cardcat +"&cardsav=" + cardsav + "&cardtem="+cardtem+"&cardsop="+ cardsop);

    gc();

}

function retrieve_data(id) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/updateloc.php";

    //console.log("Retreiving Data");
    var carddata = "";
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            carddata = http.responseText;

            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                if(tempc != http.responseText) {
                   tempc = http.responseText;
                    //console.log(tempc);


                   // cardload.start();
                }
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id=" + id + "&cords="+ currentcords);

gc();
//return 0;
}

function torf (num) {
    if (num == 0) {
        //console.log(num);
        return ("false");
    } else {
        //console.log(num);
        return ("true");
    }
}





function sync_cards(id,opt) {
        var http = new XMLHttpRequest();
        var url;
         var carddata = "";
        //var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);


        //console.log("remotesaved = "+remotesaved.length+" and contains"+remotesaved);
        var dataStr = "SELECT * FROM SavedCards WHERE 1";
        db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT,cardsop INT)');

        var pull =  tx.executeSql(dataStr);
                var record = 0;
            while (pull.rows.length > record) {
               // console.log(pull.rows.item(record).id);
                if(cardsyncsaved.search(pull.rows.item(record).id) == -1) {
                cardsyncsaved = pull.rows.item(record).id +","+cardsyncsaved;
                }
                record = record + 1;
            }

        });

    var dataStrt = "SELECT * FROM TempCards WHERE 1";
    db.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');

    var pull =  tx.executeSql(dataStr);
            var record = 0;
        while (pull.rows.length > record) {
            if(cardsynctemp.search(pull.rows.item(record).id) == -1) {
            cardsynctemp = pull.rows.item(record).id +","+cardsynctemp;
            }
            record = record + 1;
        }

       // console.log("from Sync_cards: "+cardsynctemp);

    });

        if (remotesaved.length < cardsyncsaved.length) {
                //console.log("Syncing Saved Remote Cards");
            if(opt == 2) {

                url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/updatecards.php?id=" + id+"&cardsav="+cardsyncsaved+"&cardtem="+cardsynctemp;
            } else {

                url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/updatecards.php?id=" + id+"&cardsav="+cardsyncsaved;
            }
                //console.log("Uploading list:"+cardsyncsaved);

                   // console.log(url);

            carddata = "";
            http.onreadystatechange = function() {
                if (http.readyState == 4) {
                    carddata = http.responseText;


                    if(http.responseText == 100) {

                        console.log("Incorrect DevID");

                    } else if(http.responseText == 101) {
                        console.log("Incorrect AppID");
                    } else {


                    }
                }
            }
                    http.open('GET', url, true);
                    http.send(null);
        }

        if (cardsyncsaved.length < remotesaved.length ) {
            //console.log("Syncing local saved cards");

            var cardlist = remotesaved.split(",");
            var num = 0;


            while(cardlist[num].length > 0) {
                update_card(cardlist[num],"saved");
                num = num + 1;
            }
        }

        if (opt == 3) {

                url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/updatecards.php?id=" + id+"&cardsav="+cardsyncsaved;

                //console.log("Uploading list:"+cardsyncsaved);

                    //console.log(url);

            carddata = "";
            http.onreadystatechange = function() {
                if (http.readyState == 4) {
                    carddata = http.responseText;


                    if(http.responseText == 100) {

                        console.log("Incorrect DevID");

                    } else if(http.responseText == 101) {
                        console.log("Incorrect AppID");
                    } else {


                    }
                }
            }
                    http.open('GET', url.trim(), true);
                    http.send(null);
        }



gc();

}


function get_list(id,list) {

    var http = new XMLHttpRequest();
    var url;
     var carddata = "";



    switch(list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
        carddata = "";
        //console.log(url);
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                        remotesaved = carddata;
                        sync_cards(userid,0);
                        //console.log("from interwebs saved "+carddata);


                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
       break;



    case "temp":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
        carddata = "";
        //console.log(url);
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                        //if(carddata.length != remotetemp) {
                        remotetemp = carddata;



                        var tnum = 0;
                        while (remotetemp.split(",")[tnum] != null) {
                            if(remotetemp.split(",")[tnum] != "") {
                                // update_card(remotetemp.split(",")[tnum],list);
                                 check_for_update(remotetemp.split(",")[tnum],list);
                                justpulled = tnum;
                            }
                            tnum = tnum + 1;
                        }

                     //   }

                        //console.log("updatig temp list "+ remotetemp);
                       // cardlist_update.running = true;
                       // cardload.running = true;
                    //if(remotetemp.split(",") > ptotal) {

                    //}
                    //console.log("get list "+remotetemp);
                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
        break;


    case "region":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
        carddata = "";

        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                        remotetemp = carddata;
                        var tnum = 0;
                        while (remotetemp.split(",")[tnum] != null) {
                            if(remotetemp.split(",")[tnum] != "") {
                                // update_card(remotetemp.split(",")[tnum],list);
                                 check_for_update(remotetemp.split(",")[tnum],list);
                                justpulled = tnum;
                            }
                            tnum = tnum + 1;
                        }

                       // console.log("updatig region list "+remotetemp);
                        //cardlist_update.running = true;
                        //cardload.running = true;

                        //sync_cards(userid,0);
                        //console.log("from interwebs temp "+carddata);

                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
        break;

    case "global":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
        carddata = "";
        console.debug(url);
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                        remotetemp = carddata;
                        var tnum = 0;
                        while (remotetemp.split(",")[tnum] != null) {
                            if(remotetemp.split(",")[tnum] != "") {
                                   // update_card(remotetemp.split(",")[tnum],list);
                                    check_for_update(remotetemp.split(",")[tnum],list);
                                justpulled = tnum;
                            }
                            tnum = tnum + 1;
                        }
                        //console.log("updatig Global list");
                        //cardlist_update.running = true;
                        cardload.running = true;
                        //sync_cards(userid,0);
                        //console.log("from interwebs temp "+carddata);

                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);

        break;

    default:break;

    }


}

function check_for_update(id,list) {
    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/lastupdated.php?id="+userid+"&cid="+id;

    var thelist = "TempCard";

    switch(list) {
        case "temp":thelist = "TempCards";break;
        case "region":thelist = "RegCards";break;
        case "global":thelist = "GlobCards";break;
        case "saved":thelist = "SavedCards";break;
        default:thelist ="TempCards";break;
    }

    //console.log(url);
    var updateIt = 0;
    if(id != 'undefined') {

        var carddata = "";
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                    carddata = http.responseText;
                  //  console.log("from check for web update on "+id+" last updated "+carddata);

                    db.transaction(function(tx) {
                           tx.executeSql('CREATE TABLE IF NOT EXISTS Stats(id TEXT, name TEXT,data TEXT, frequency INT)');

                            var testStatupdated = "SELECT data FROM Stats WHERE id= '"+id+"' AND name = 'updated'";
                            var testExist = "SELECT id FROM `"+thelist+"` WHERE id= '"+id+"'";


                            var pull = tx.executeSql(testStatupdated);
                            var epull = tx.executeSql(testExist);

                             //console.log("from check for update id exists "+pull.rows.length);
                              // console.log("from check for update "+pull.rows.item(0).data);

                                if(epull.rows.length == 1) {
                                        //console.log("Found Card");
                                         if(pull.rows.length == 1) {
                                         //    console.log("Found Stat");
                                            if(pull.rows.item(0).data == carddata) {
                                                 updateIt = 0;
                                                      //  console.log("everything is good for "+id);
                                                        if(list != "saved") {
                                                       // remote_delete(userid,list,id);
                                                        }
                                                } else {
                                                        updateIt = 1;
                                                        //console.log(pull.rows.item(0).data+ " "+ carddata);
                                                      //  console.log("Stat needs updates "+id);

                                                        if(usercardNum != id) {
                                                                 notification1.visible = true; notification1.themessage = "Updating card!";
                                                                update_card(id,list);
                                                             }
                                                }
                                            } else {
                                                    updateIt = 2;
                                                   // console.log("No Card found "+id);
                                                    if(usercardNum != id) {

                                                            update_card(id,list);
                                                        }
                                            }
                                     } else {
                                            updateIt = 3;
                                            //console.log("No Card Found "+id);

                                            if(usercardNum != id) {
                                                  //  notification1.visible = true; notification1.themessage = "New Cards found! "+id;
                                                 update_card(id,list);
                                                }
                                        }
                                });
                }

            }
        }
        http.open('GET', url.trim(), true);
        http.send(null);




}

    return updateIt;


}


function update_card(id,list) {


    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/updatecard.php?id=" + userid+"&cid="+id+"&list="+list;
    //console.log(url);
   // var updatetype = check_for_update(id,list);

   // console.log("from Update card "+updatetype);

   // if(updatetype != 0) {

        //console.log("getting card "+id);

    var carddata = "";
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            carddata = http.responseText;


            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {



                var cardpos = carddata.split(";&;");

                var cid = cardpos[0];
                var name = cardpos[1];
                var phone = cardpos[2];

                var email = cardpos[3];
                var company = cardpos[4];
                var calias = cardpos[5];
                var motto = cardpos[6];

                var main = cardpos[7];
                var link1 = cardpos[8];
                var link2 = cardpos[9];
                var link3 = cardpos[10];
                var link4 = cardpos[11];

                var avatar = cardpos[12];
                var cardbk = cardpos[13];
                var cardcat = cardpos[14];
                var cardsop = cardpos[15];
                var lastseen = cardpos[16];
                var updated = cardpos[17];

                var updata = "";
                var upfreq = 0;
                var statname = "";




                var data = [cid,name,phone,email,company,calias,motto,main,link1,link2,link3,link4,avatar,cardbk,cardcat,cardsop];
                var dataT = [cid,name,phone,email,company,calias,motto,main,link1,link2,link3,link4,avatar,cardbk,lastseen,cardcat,cardsop];

                var dataLS = [cid,"lastseen",lastseen,0];
                var dataLU = [cid,"updated",updated,0];


               // var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

                var dataStr = "INSERT INTO SavedCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                var dataStrT = "INSERT INTO TempCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                var dataStrR = "INSERT INTO RegCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                var dataStrG = "INSERT INTO GlobCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

                var dataStats = "INSERT INTO Stats VALUES(?,?,?,?)";


                var update = "UPDATE SavedCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
                var updateT = "UPDATE TempCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
                var updateR = "UPDATE RegCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
                var updateG = "UPDATE GlobCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";

                var updateLSStats = "UPDATE Stats SET data='"+lastseen+"',frequency='"+upfreq+"' WHERE id='"+cid+"' AND name='lastseen'";
                var updateLUStats = "UPDATE Stats SET data='"+updated+"',frequency='"+upfreq+"' WHERE id='"+cid+"' AND name='updated'";

                var testStr = "SELECT  name  FROM SavedCards WHERE id='"+cid+"'";
                var testStrT = "";
                var testStrR = "";
                var testStrG = "";

                var testStatlastseen = "";
                var testStatupdated = "";

                    if(cid != "") {
                        testStrT = "SELECT  name  FROM TempCards WHERE id='"+cid+"'";
                        testStrR = "SELECT  name  FROM RegCards WHERE id='"+cid+"'";
                        testStrG = "SELECT  name  FROM GlobCards WHERE id='"+cid+"'";

                        testStatlastseen = "SELECT name FROM Stats WHERE id='"+cid+"' AND name = 'lastseen'";
                         testStatupdated = "SELECT name FROM Stats WHERE id='"+cid+"' AND name = 'updated'";
                    }

                db.transaction(function(tx) {

                    tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT,cardsop INT)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');

                    tx.executeSql('CREATE TABLE IF NOT EXISTS GlobCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS RegCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');

                    tx.executeSql('CREATE TABLE IF NOT EXISTS Stats(id TEXT, name TEXT,data TEXT, frequency INT)');

                        var duplicate;
                    switch(list) {
                    case "saved": if(testStr != "") {duplicate = tx.executeSql(testStr);
                                                            if(duplicate.rows.length == 0) {tx.executeSql(dataStr, data);} else {tx.executeSql(update);}
                                                    };break;
                    case "temp": if(testStrT != "") {duplicate = tx.executeSql(testStrT);
                                                                if(duplicate.rows.length == 0) {if(name.length > 2 || company.length > 2) { tx.executeSql(dataStrT, dataT);} } else {tx.executeSql(updateT);}
                                                    };break;
                    case "region":if(testStrR != "") {duplicate = tx.executeSql(testStrR);
                                        if(duplicate.rows.length == 0) {if(name.length > 2 || company.length > 2) {tx.executeSql(dataStrR, dataT);} } else {tx.executeSql(updateR);}
                                         };break;
                    case "global":if(testStrG != "") {duplicate = tx.executeSql(testStrG);
                                        if(duplicate.rows.length == 0) {if(name.length > 2 || company.length > 2) {tx.executeSql(dataStrG, dataT);}} else {tx.executeSql(updateG);}
                                         };break;

                    }


                    if(testStatlastseen != "") {
                   var statLSdup = tx.executeSql(testStatlastseen);
                        if(statLSdup.rows.length == 0) {tx.executeSql(dataStats, dataLS);} else {
                            upfreq = statLSdup.rows.frequency + 1;
                            tx.executeSql(updateLSStats);}
                    }
                    if(testStatupdated != "") {
                   var statLUdup = tx.executeSql(testStatupdated);
                        if(statLUdup.rows.length == 0) {tx.executeSql(dataStats, dataLU);} else {
                            upfreq = statLUdup.rows.frequency + 1;
                            tx.executeSql(updateLUStats);}

                    }



                   });

            }

        }
    }
    http.open('GET', url.trim(), true);
    http.send(null);
//}

gc();
}

function remote_delete(id,list,cid) {

    var http = new XMLHttpRequest();
    var url;
     var carddata = "";

        //console.log("deleting");
        get_list_updater.stop();
        gpsupdate.stop();
        heartbeats.stop();

    switch(list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/deleteref.php?id=" + id+"&list="+list+"&cid="+cid;
        carddata = "";
       // console.log("removing "+cid+" from server saved");
       //console.log(url);
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                        var remotesaved = carddata;
                        //sync_cards(userid,0);
                        //console.log("from Server: "+carddata);
                        get_list_updater.restart();
                        gpsupdate.restart();
                        heartbeats.restart();

                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
       break;



    case "temp":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/deleteref.php?id=" + id+"&list="+list+"&cid="+cid;
        carddata = "";
        console.log(url);
        //console.log("removing from server temp");
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                        console.log(carddata);
                        remotetemp = carddata;
                        var tnum = 0;
                       while (remotetemp.split(",")[tnum] != null) {
                            update_card(remotetemp.split(",")[tnum],"temp");
                           tnum = tnum + 1;
                             get_list_updater.restart();
                        }

                        //sync_cards(userid,0);
                        //console.log("from interwebs temp "+carddata);
                    //

                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
        break;

    default:get_list_updater.restart();break;

    }


}



function remote_delete_list(id,list,cid_list) {

    var http = new XMLHttpRequest();
    var url;
     var carddata = "";

        //console.log("deleting");
        get_list_updater.stop();

    switch(list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/deleteref.php?id=" + id+"&list="+list+"&cid="+cid;
        carddata = "";
        //console.log("removing from server saved");
       //console.log(url);

        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                       // var remotesaved = carddata;
                        sync_cards(userid,0);
                        //console.log("from interwebs saved "+carddata);
                        get_list_updater.restart();

                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
       break;



    case "temp":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/deleteref.php?id=" + id+"&list="+list+"&cid="+cid_list;
        carddata = "";
        //console.log(url);
        //console.log("removing from server temp");
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                carddata = http.responseText;


                if(http.responseText == 100) {

                    console.log("Incorrect DevID");

                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                        carddata = http.responseText;
                     //   console.log(carddata);
                      //  remotetemp = carddata;
                        //var tnum = 0;
                     //  while (remotetemp.split(",")[tnum] != null) {
                      //      update_card(remotetemp.split(",")[tnum],"temp");
                      //     tnum = tnum + 1;
                             //get_list_updater.restart();
                      //  }

                        //sync_cards(userid,0);
                        //console.log("from interwebs temp "+carddata);
                    //

                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
        break;

    default:get_list_updater.restart();break;

    }


}

function website_snap(id,url,sitenum) {

    var http = new XMLHttpRequest();
    //var url;
     var carddata = "";

    url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/snaps.php?id="+id+"&url="+url+"&sitenum="+sitenum;
    //carddata = "";
    //console.log(url);

    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            carddata = http.responseText;

            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                carddata = http.responseText;
                thesource = carddata;
            }

        }
    }
    http.open('GET', url.trim(), true);
    http.send(null);

    return carddata;
}

function onetime(id,action) {

    var http = new XMLHttpRequest();
     var carddata = "";
    var url = "";
    if (action < 3) {
     url = "https://openseed.vagueentertainment.com:8675/corescripts/onetime.php?devid=" + devId + "&appid=" + appId + "&cardid="+ id+"&create="+action;
    //carddata = "";
    //console.log(url);

    http.onreadystatechange = function() {
        if (http.readyState == 4) {
                carddata = http.responseText;


            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                carddata = http.responseText;
                onetimecode = carddata;

            }

        }
    }
    http.open('GET', url.trim(), true);
    http.send(null);
} else {
        url = "https://openseed.vagueentertainment.com:8675/corescripts/onetime.php?devid=" + devId + "&appid=" + appId + "&cardid="+ id+"&create="+action;
       //carddata = "";
       //console.log(url);

       http.onreadystatechange = function() {
           if (http.readyState == 4) {
                   carddata = http.responseText;


               if(http.responseText == 100) {

                   console.log("Incorrect DevID");

               } else if(http.responseText == 101) {
                   console.log("Incorrect AppID");
               } else {
                   carddata = http.responseText;
                    update_card(carddata,"saved")
               }

           }
       }
       http.open('GET', url.trim(), true);
       http.send(null);

    }
    //return carddata;


}

// Anouncement stuff //

function get_eula() {
    var http = new XMLHttpRequest();
    var url = "http://vagueentertainment.com/standard-license.html"

    db.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS announcements (id TEXT, name TEXT,type TEXT,version INT,seen INT)');
    });

    http.onreadystatechange = function() {

        if (http.readyState == 4) {

                message = http.responseText.split('<body lang="en-US" dir="ltr">')[1].split("</body>")[0];
              //console.log(http.responseText);

            }

        }

    http.open('GET', url.trim(), true);

    http.send(null);

}

function get_news(log) {
    var http = new XMLHttpRequest();
    var url = "http://vagueentertainment.com/"+log+".html"

    db.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS announcements (id TEXT, name TEXT,type TEXT,version INT,seen INT)');
    });

    http.onreadystatechange = function() {

        if (http.readyState == 4) {



                message = http.responseText.split('<body lang="en-US" dir="ltr">')[1].split("</body>")[0];
              //console.log(http.responseText);

            }

        }

    http.open('GET', url.trim(), true);

    http.send(null);

}

function announcement_seen(type) {

     var data = [id,username,type,1,1];
    var insert = "INSERT INTO announcements VALUES(?,?,?,?,?)";
    db.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS announcements (id TEXT, name TEXT,type TEXT,version INT,seen INT)');

        tx.executeSql(insert,data);


    });


}



//Image stuff //

/* function store_img (where,file,effect,private,comment,thedate,picture_index,id,flattr,patreon) {

   //var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 10000000000);


    var thefile ="";
    var testStr = "";
    var insert = "";
    var justfile = "";

    var data ="";

    //console.log(where);

    //var testStr = "SELECT  *  FROM LIBRARY WHERE file='"+thefile+"' AND effect='"+effect+"' AND thedate='"+thedate+"'";

    switch(where) {
     case "Library": testStr = "SELECT * FROM LIBRARY WHERE picture_index ='"+picture_index+"'";
         thefile = paths.split(",")[2].trim()+file.split(":;:")[1].trim()+".jpg"+":;:"+file.replace(/ /g,"+");
         insert = "INSERT INTO LIBRARY VALUES(?,?,?,?,?,?,?)";
         justfile =file.split(":;:")[1].trim()+".jpg";
         data = [id,where,justfile,thedate,private,picture_index,base64];

                        break;
     case "Stream": testStr = "SELECT * FROM STREAM WHERE picture_index ='"+picture_index+"'";
         thefile = paths.split(",")[3].trim()+id+file.split(":;:")[1].trim()+".jpg"+":;:"+file.replace(/ /g,"+");
         insert = "INSERT INTO STREAM VALUES(?,?,?,?,?,?,?,?,?)";
         justfile =id+file.split(":;:")[1].trim()+".jpg";
         data = [id+"::"+flattr+"::"+patreon,where,justfile,effect,comment,thedate,private,picture_index,base64];

                    break;

     default: testStr = "SELECT * FROM LIBRARY WHERE picture_index ='"+picture_index+"'";
         thefile = paths.split(",")[2].trim()+file.split(":;:")[1].trim()+".jpg"+":;:"+file.replace(/ /g,"+");
         insert = "INSERT INTO LIBRARY VALUES(?,?,?,?,?,?,?,?,?)";
         justfile =file.split(":;:")[1].trim()+".jpg";
         data = [id,where,justfile,effect,comment,thedate,private,picture_index,base64];

                        break;
    }




    var base64 = file.split(":;:")[0].replace(/ /g,"+");

    //var base64 = "na";



 try {
    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS LIBRARY (id TEXT,thedir TEXT,file TEXT,effect INT,comment TEXT,thedate TEXT,private INT,picture_index INT,base64 BLOB)');
        tx.executeSql('CREATE TABLE IF NOT EXISTS STREAM (id TEXT,thedir TEXT,file TEXT,effect INT,comment TEXT,thedate TEXT,private INT,picture_index INT,base64 BLOB)');

            var pull = tx.executeSql(testStr);

           // console.log(pull.rows.length);
            if(pull.rows.length == 0) {

               fileio.image = thefile;
                tx.executeSql(insert,data);
                fetchedimage = fetchedimage + 1;
                //console.log(fetchedimage+" adding "+justfile);
            }



    });
 } catch (err) {
        console.log("Error creating file: " + err);
 }

    //console.log(newimages+"/"+fetchedimage);


    if(newimages >= 61) {
        fullnumber = newimages;
        newimages = 60;

        info = fetchedimage+"/"+newimages+" (of "+fullnumber+")";

    } else {
        if(fullnumber == 0) {
        info = fetchedimage+"/"+newimages;
        } else {
            info = fetchedimage+"/"+newimages+" (of "+fullnumber+")";
        }
    }

    if(fetchedimage == 5) {
        progress.state = "minimal";
        switch(where) {
            case "Library":thefooter.state = "Show"; reload.running = true;break;
            case "Stream":thefooter.state = "Show"; stream_reload.running = true;break;
            default:thefooter.state = "Show"; reload.running = true;break;
        }

    }



    if(fetchedimage == newimages) {
        progress.state = "midscreen";
        syncing = 0;
    switch(where) {
    case "Library":thefooter.state = "Show"; reload.running = true;progress.visible = false;break;
    case "Stream":thefooter.state = "Show"; stream_reload.running = true;progress.visible = false;break;
    default:thefooter.state = "Show"; reload.running = true;progress.visible = false;break;
    }

    }
    gc();
} */


function sendimage(userid,file,private) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/profilePic.php";

    //var sending = file.split(":;:")[0];
    var retrieved;
   // console.log(url)

    //console.log(sending);

    var d = new Date();
    var thedate = d.getMonth()+1+"-"+d.getDate()+"-"+d.getFullYear();
   /* if(date == " ") {
        date = thedate;
    } else {
        date = date;
    } */

    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                retrieved = http.responseText;
                console.log(retrieved);
                //return retrieved;
                //update_index(file,retrieved);
            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id="+ userid + "&file="+file.trim()+"&private="+private+"&type=IMAGE&action=sending" );

}


function update_index(file,retrieved) {

   // var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1000000);

    var thefile = file.split(":;:")[1].trim()+".jpg";

            var base64 = file.split(":;:")[0].replace(/ /g,"+");

       // info = "Updating Index";



     var insert = "UPDATE LIBRARY SET picture_index='"+retrieved+"' WHERE file='"+thefile+"' AND base64 = '"+base64+"'";
    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS LIBRARY (id TEXT,thedir TEXT,file TEXT,thedate TEXT,private INT,picture_index INT,base64 BLOB)');

            //var pull = tx.executeSql(testStr);

            tx.executeSql(insert);


            //reload.running = true;
    });


    //progress.visible = false;
  //  info = " ";

}


function serviceConnect(service,account) {

    var http = new XMLHttpRequest();
    var retrieved;
    var pagedata;
    var profilepic;

switch(service) {
case "twitter":  {
        var url = "https://www.twitter.com/"+account;
    http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;

           profilepic = pagedata.substring(pagedata.search("https://pbs.twimg.com/profile_images/"),(pagedata.search("https://pbs.twimg.com/profile_images/") + 150));
           profilepic = profilepic.split('"')
           var mission = pagedata.substring(pagedata.search('<p class="ProfileHeaderCard-bio u-dir" dir="ltr">'),pagedata.search('<div class="ProfileHeaderCard-location ">'));
           avatar = profilepic[0];
           profilename = profilepic[2];
           info = mission;
        }

    }
}
    http.open('GET', url, true);
    http.send(null);

} break;


case "tumblr":  {
        var url = "https://"+account+".tumblr.com/";
    http.onreadystatechange = function() {
        if (http.readyState == 4) {

            pagedata = http.responseText;

            if(http.responseText == 100) {
                console.log(http.responseText);

            } else if(http.responseText == 101) {
                console.log(http.responseText);

            } else {

                pagedata = http.responseText;
                //sitedata = pagedata;

              //  banner = pagedata.substring(pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image='),pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image=') + 200).split('"')[5];

                 profilename = pagedata.substring(pagedata.search('<h1 class="blog-title"><a href="/">'),pagedata.search(' <h1 class="blog-title"><a href="/">')+ 100).split(">")[2].split("<")[0];

                avatar = pagedata.substring(pagedata.search('class="user-avatar"><img src="'),pagedata.search('class="user-avatar"><img src="')+100).split('"')[3];

                info = pagedata.substring(pagedata.search('<span class="description">'),pagedata.search('<span class="description">') + 200).split(">")[1].split("</")[0].trim();

                /* postinfo = pagedata.substring(pagedata.search('<article'),pagedata.search('</article>'));

                    if(postinfo.search('<div class="video-wrapper">') != -1) {
                        //console.log("found a video");
                        postimage="img/youtube.png";
                        post = postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"));
                    } else {
                        if(postinfo.search('<div class="post-content">') != -1) {
                            posttitle = postinfo.substring(postinfo.search('<h2 class="title">'),postinfo.search('</h2>')).split(">")[2].split("<")[0];
                            post = postinfo.substring(postinfo.search('<p>'),postinfo.search('</p>'));
                        } else {
                            if(postinfo.search('<div class="photo-wrapper">') != -1) {
                                postimage = postinfo.substring(postinfo.search('src="')+5,postinfo.search('" alt='));
                                post = postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"));
                            }
                        } */
                    }
            }

        }

    http.open('GET', url, true);
    http.send(null);

} break;

case "soundcloud": {
    var url = "https://soundcloud.com/"+account

    var profileavatar;
    var name;
http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;


            //console.log("From souncloud.js"+pagedata);

            name = pagedata.substring(pagedata.search("<title>")+7,pagedata.search("</title>")-8);
            name = name.split("|");
            profilename = name[0];

            profileavatar = pagedata.substring(pagedata.search("’s avatar")-200,pagedata.search("’s avatar"));

            profileavatar = profileavatar.split('<img');
            profileavatar = profileavatar[1].split('=');
            profileavatar = profileavatar[1].split(' ');

            avatar = profileavatar[0].substring(1,profileavatar[0].length-1);
            info = "";

           // stats = pagedata.substring(pagedata.search('<meta name="description" content=')+34,pagedata.search('><meta property="twitter:app:name:iphone"'));
           // var tracks = stats.substring(stats.search('Tracks')-4,stats.search('Tracks')+6).split(". ")[1];
            //console.log(tracks);
           // var followers = stats.substring(stats.search('Tracks')+6,stats.search('Followers')+9).split(". ")[1];
          //  stats = followers+"\n"+tracks;
           // thestats = stats;

        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

} break;

case "gravatar": {

    var url = "https://openseed.vagueentertainment.com:8675/corescripts/gravatar.php?email="+account

   // var profileavatar;
   // var name;
        http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;


            avatar = pagedata;



        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);



        }break;

case "blog": {

            var url = "";

            if(account.startsWith("http") == true) {
            url = account;
            } else {
                url = "http://"+account;
            }

         http.onreadystatechange = function() {
     if (http.readyState == 4) {

         pagedata = http.responseText;

         if(http.responseText == 100) {
             console.log(http.responseText);

         } else if(http.responseText == 101) {
             console.log(http.responseText);

         } else {

             pagedata = http.responseText;

             var rss = pagedata.search(/rss/i);
             var wordpress = pagedata.search(/wordpress/i);
             var medium = pagedata.search(/medium.com/i);


             if(medium !=-1 ) {
                    avatar = "./img/medium.png"

                    } else if (wordpress !=-1 ) {
                 avatar = "./img/wordpress.png"

             } else if (rss !=-1 ) {
                 avatar = "./img/RSS.png"

                 }


         }

     }

 }

 http.open('GET', url.trim(), true);
 http.send(null);



}break;

default: avatar = ""; break;





}

}


function socialaccounts() {

socialaccountslist.clear();


    for(var num =0;num < slist.length;num = num+1) {

socialaccountslist.append({
                          type:1,
                          service:slist[num].split("::")[3],
                          source:"Connect to "+slist[num].split("::")[0],
                          bgcolor:slist[num].split("::")[1],
                          serviceLogo:slist[num].split("::")[2],
                          });




}

}

function preview_card(id) {
  //  console.log("getting card "+id);

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/updatecard.php?id=" + userid+"&cid="+id+"&list=preview";
    //console.log(url);

    var formercard = currentcard_thecard;

    var carddata = "";
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            carddata = http.responseText;


            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

                carddata = http.responseText;
                //console.log(carddata);

                    var cardpos = carddata.split(";&;");
                    var ava = "";
                if(cardpos[12].length < 4) { ava = "img/default_avatar.png"} else {ava = cardpos[12]
                             if(ava.search("/9j/4A") != -1) { ava = "data:image/jpeg;base64, "+ava.replace(/ /g, "+");}

                }

                var spC;

                var dataStr = "SELECT id,name FROM SavedCards WHERE id ='"+cardpos[0]+"'";

                db.transaction(function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT,cardsop INT)');

                var pull =  tx.executeSql(dataStr);

                    if(pull.rows.length != 0) {
                        currentcard_saved = 1;
                    } else {
                        currentcard_saved = 0;
                    }

                });


                currentcard_thecard = cardpos[0];
                //currentcard_saved = 0;
                currentcard_username = cardpos[1];
                currentcard_userphone = cardpos[2];
                currentcard_useremail = cardpos[3];
                currentcard_cardposition = cardpos[5];
                currentcard_companyname = cardpos[4];
                currentcard_motto = cardpos[6];
                currentcard_mainsite = cardpos[7];
                currentcard_url1 = cardpos[8];
                currentcard_url2 = cardpos[9];
                currentcard_url3 = cardpos[10];
                currentcard_url4 = cardpos[11];
                currentcard_avatarimg = ava;
                currentcard_realcardback = cardpos[13];
                currentcard_cardcat = cardpos[14];
                currentcard_cardsop = cardpos[15];

              //  console.log(currentcard_thecard+" is Set");
             //   console.log(currentcard_username);
                readystate = "ready";
                card = cardpos[0];

            }


        }

    }
        http.open('GET', url.trim(), true);
        http.send(null);

    gc();

    if(formercard != currentcard_thecard) {
        return "ready";
    } else { return "not ready";}


    }


function connections(cardID) {

      var http = new XMLHttpRequest();
      var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId + "/scripts/connections.php";

      var carddata = "";
      http.onreadystatechange = function() {
          if (http.readyState == 4) {
              carddata = http.responseText;


              if(http.responseText == 100) {

                  console.log("Incorrect DevID");

              } else if(http.responseText == 101) {
                  console.log("Incorrect AppID");
              } else {

                  carddata = http.responseText;
                  //console.log(carddata);

                  connected = carddata;


                  //console.log("from connections "+connected);

              }


          }

      }

    http.open('POST', url.trim(), true);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("id="+ userid+ "&cardID="+cardID);

      gc();
      }


