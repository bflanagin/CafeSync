

function oseed_auth(name,email) {

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com/corescripts/authPOST.php";
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
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email);
}




function heartbeat() {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com/corescripts/heartbeat.php";
   // console.log(url)

    http.onreadystatechange = function() {

       if(http.status == 200) {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

                heart = http.responseText;
                updateinterval = 2000;

              // console.log(heart);

            }

        }
            } else {
                    heart = "Offline";
                    updateinterval = 2000 + updateinterval;

        }
    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ id);

    heartbeats.interval = updateinterval;

}


function checkcreds(name,email) {

    var http = new XMLHttpRequest();
    //var url = "https://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "https://openseed.vagueentertainment.com/corescripts/authCHECK.php";
    console.log("sending "+name+" , "+email);
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
                //id = http.responseText;
                uniquename = http.responseText;

            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email);


}




function datasync (id,cnum) {
        console.log("datasync:" + id);
    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/sync.php?id=" + id;
    var carddata = "";

    console.log(url);

    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            carddata = http.responseText;
                console.log(carddata);
            if(http.responseText == 100) {

                console.log("Incorrect DevID");

            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {

            carddata = http.responseText;

    var cid = carddata.substring(carddata.search("<id>")+4,carddata.search("</id>"));
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
} else {


        username1 = name.replace(/&#x27;/g,"'");
        userphone1 = phone
        useremail1 = email;
        usercompany1 = company.replace(/&#x27;/g,"'");
        usercat1 = cardcat;
        useralias1 = alias;
        usermotto1 = motto.replace(/&#x27;/g,"'");

        usermain1 = main;
        website11 = link1;
        website21 = link2;
        website31 = link3;
        website41 = link4;
        avimg1 = avatar;
        carddesign1 = cardbk;

        stf1= torf(send);
        atf1= torf(usealias);
        ctf1= torf(contact);
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

    //motto = motto.replace(/\'/g,"&#x27;");
    var http = new XMLHttpRequest();
   /* var url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/addcard.php?id=" + Id + "&name=" + name + "&phone="+ phone + "&email=" + email +
                "&company=" + company + "&alias=" + ali + "&motto=" + motto + "&send=" + send + "&ua=" + ua + "&sc=" + sc +"&main=" + main + "&l1=" + l1 + "&l2=" + l2 + "&l3=" + l3
                + "&l4=" + l4 + "&avatar=" + av + "&cardback=" + cardback + "&cardcat=" + cardcat +"&cardsav=" + cardsav + "&cardtem="+cardtem+"&cardsop="+ cardsop; */
    var url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/addcardPOST.php";

    console.log(send,ua,sc);

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

}

function retrieve_data(id) {

    //console.log("collecting new info")



    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/updateloc.php";


    var carddata = "";
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
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&id=" + id + "&cords="+ currentcords);


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
        var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);


        //console.log("remotesaved = "+remotesaved.length+" and contains"+remotesaved);
        var dataStr = "SELECT * FROM SavedCards WHERE 1";
        db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT)');

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
    tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

    var pull =  tx.executeSql(dataStr);
            var record = 0;
        while (pull.rows.length > record) {
            if(cardsynctemp.search(pull.rows.item(record).id) == -1) {
            cardsynctemp = pull.rows.item(record).id +","+cardsynctemp;
            }
            record = record + 1;
        }

    });

        if (remotesaved.length < cardsyncsaved.length) {
                //console.log("Syncing Saved Remote Cards");
            if(opt == 2) {

                url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/updatecards.php?id=" + id+"&cardsav="+cardsyncsaved+"&cardtem="+cardsynctemp;
            } else {

                url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/updatecards.php?id=" + id+"&cardsav="+cardsyncsaved;
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
            console.log("Syncing local saved cards");

            var cardlist = remotesaved.split(",");
            var num = 0;


            while(cardlist[num].length > 0) {
                update_card(cardlist[num],"saved");
                num = num + 1;
            }
        }

        if (opt == 3) {

                url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/updatecards.php?id=" + id+"&cardsav="+cardsyncsaved;

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





}


function get_list(id,list) {

    var http = new XMLHttpRequest();
    var url;
     var carddata = "";



    switch(list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
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
        url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
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
                        remotetemp = carddata;
                        var tnum = 0;
                        while (remotetemp.split(",")[tnum] != null) {
                            if(remotetemp.split(",")[tnum] != "") {
                                    update_card(remotetemp.split(",")[tnum],"temp");
                                justpulled = tnum;
                            }
                            tnum = tnum + 1;
                        }

                        //console.log("updatig temp list");
                       // cardlist_update.running = true;
                        cardload.running = true;


                }
            }
        }
                http.open('GET', url.trim(), true);
                http.send(null);
        break;


    case "region":
        url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
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
                                    update_card(remotetemp.split(",")[tnum],"region");
                                justpulled = tnum;
                            }
                            tnum = tnum + 1;
                        }

                        //console.log("updatig region list");
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

    case "global":
        url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/getlists.php?id=" + id+"&list="+list;
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
                                    update_card(remotetemp.split(",")[tnum],"global");
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


function update_card(id,list) {
  //  console.log("getting card "+id);

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/updatecard.php?id=" + userid+"&cid="+id;
    //console.log(url);

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


                //console.log(cardpos);
                var data = [cid,name,phone,email,company,calias,motto,main,link1,link2,link3,link4,avatar,cardbk,cardcat];
                var dataT = [cid,name,phone,email,company,calias,motto,main,link1,link2,link3,link4,avatar,cardbk,Date.now(),cardcat];


                var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

                var dataStr = "INSERT INTO SavedCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                var dataStrT = "INSERT INTO TempCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                var dataStrR = "INSERT INTO RegCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                var dataStrG = "INSERT INTO GlobCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";


                var update = "UPDATE SavedCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
                var updateT = "UPDATE TempCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
                var updateR = "UPDATE RegCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
                var updateG = "UPDATE GlobCards SET name='"+name+"', email='"+email+"', phone='"+phone+"', company='"+company+"', motto='"+motto+"', main='"+main+"',website1='"+link1+"', website2='"+link2+"', website3='"+link3+"', website4='"+link4+"', avatar='"+avatar+"', cardback='"+cardbk+"', cat='"+cardcat+"'  WHERE id='"+id+"'";



                var testStr = "SELECT  *  FROM SavedCards WHERE id='"+cid+"'";
                var testStrT = "";
                var testStrR = "";
                var testStrG = "";

                    if(cid != "") {
                        testStrT = "SELECT  *  FROM TempCards WHERE id='"+cid+"'";
                        testStrR = "SELECT  *  FROM RegCards WHERE id='"+cid+"'";
                        testStrG = "SELECT  *  FROM GlobCards WHERE id='"+cid+"'";
                    }

                db.transaction(function(tx) {

                    tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

                    tx.executeSql('CREATE TABLE IF NOT EXISTS GlobCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS RegCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

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


                   });

            }

        }
    }
    http.open('GET', url.trim(), true);
    http.send(null);



}

function remote_delete(id,list,cid) {

    var http = new XMLHttpRequest();
    var url;
     var carddata = "";


    switch(list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/deleteref.php?id=" + id+"&list="+list+"&cid="+cid;
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
        url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/deleteref.php?id=" + id+"&list="+list+"&cid="+cid;
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
                        remotetemp = carddata;
                        var tnum = 0;
                        while (remotetemp.split(",")[tnum] != null) {
                            update_card(remotetemp.split(",")[tnum],"temp");
                            tnum = tnum + 1;
                        }

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

function website_snap(id,url,sitenum) {

    var http = new XMLHttpRequest();
    var url;
     var carddata = "";

    url = "https://openseed.vagueentertainment.com/devs/" + devId + "/" + appId + "/scripts/snaps.php?id="+id+"&url="+url+"&sitenum="+sitenum;
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
     url = "https://openseed.vagueentertainment.com/corescripts/onetime.php?devid=" + devId + "&appid=" + appId + "&cardid="+ id+"&create="+action;
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
        url = "https://openseed.vagueentertainment.com/corescripts/onetime.php?devid=" + devId + "&appid=" + appId + "&cardid="+ id+"&create="+action;
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

