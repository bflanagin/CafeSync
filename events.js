function load_current() {

    elCurrent.clear();

    var d = new Date();
     var previousdate;

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT, name TEXT,userID TEXT,party TEXT,location TEXT,about MEDIUMTEXT,date INT)');

        var test = "SELECT * FROM EVENTS WHERE `date` >"+d.getTime()+" ORDER by date";
        var pull = tx.executeSql(test);
           // console.log(pull.rows.length);
        eventsPage.counter = pull.rows.length;

        for(var num = 0;num < pull.rows.length;num = num + 1) {

            var dd = new Date(pull.rows.item(num).date);

            if(previousdate !== pull.rows.item(num).date) {
                                                //console.log('adding spacer')
                                                previousdate = pull.rows.item(num).date;
                                         elCurrent.append({
                                                       itemtype: 9,
                                                        date:dd.toLocaleString()
                                                    });
                                        }


            elCurrent.append({
                itemtype: 0,
                eventname: pull.rows.item(num).name,
                location: pull.rows.item(num).location,
                partymembers: pull.rows.item(num).party,
                date:dd.toLocaleDateString(),
                time:dd.toLocaleTimeString(),
            });


        }


});

}

function load_log() {

     elLog.clear();

    var d = new Date();
     var previousdate;

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT, name TEXT,userID TEXT,party TEXT,location TEXT,about MEDIUMTEXT,date INT)');

        var test = "SELECT * FROM EVENTS WHERE `date` <"+d.getTime()+" ORDER by date";
        var pull = tx.executeSql(test);
           // console.log(pull.rows.length);

        for(var num = 0;num < pull.rows.length;num = num + 1) {
                //console.log(pull.rows.item(num).name);
            var dd = new Date(pull.rows.item(num).date);

            if(previousdate !== pull.rows.item(num).date) {
                                                //console.log('adding spacer')
                                                previousdate = pull.rows.item(num).date;
                                          elLog.append({
                                                       itemtype: 9,
                                                        date:dd.toLocaleString()
                                                    });
                                        }

            elLog.append({
                itemtype:0,
                eventname: pull.rows.item(num).name,
                location: pull.rows.item(num).location,
                partymembers: pull.rows.item(num).party,
                date:dd.toLocaleDateString(),
                time:dd.toLocaleTimeString(),
            });
        }


});




}

function save_event(name,location,about,party,year,month,day,hour,minute) {

    var dd = new Date(year,month,day,hour,minute);
   // console.log(dd);



    db.transaction(function(tx) {

       // tx.executeSql('DROP TABLE EVENTS');

        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT, name TEXT,userID TEXT, party TEXT,location TEXT,about MEDIUMTEXT,date INT)');

        if(name.length > 1 && location.length > 1 && party.length > 1) {
            var insertStr = "INSERT INTO EVENTS VALUES(?,?,?,?,?,?,?)";
           var dataSTR = [usercardNum+""+dd.getTime()+""+name,name,usercardNum,party,location,about,dd.getTime()];
            var updateStr = "UPDATE EVENTS SET name='"+name+"' location='"+location+"' party='"+party+"' about='"+about+"' date="+dd.getTime()+" WHERE id ='"+dataSTR[0]+"'";

            var testStr = "SELECT * FROM EVENTS WHERE id='"+dataSTR[0]+"'";

            var text = tx.executeSql(testStr);

               // console.log(dataSTR[0]);

            if(text.rows.length === 0) {
                tx.executeSql(insertStr,dataSTR)
                notification1.themessage = qsTr("Added Event");
                notification1.delay = 4;
                notification1.visible = true;

                send_event(dataSTR[0]);
                eventsPage.updateevents = true;
                eventEdit.state = "InActive";
            } else {
                tx.executeSql(updateStr);
                notification1.themessage = qsTr("Updated Event");
                notification1.delay = 4;
                notification1.visible = true;

                send_event(dataSTR[0]);
                eventsPage.updateevents = true;
                eventEdit.state = "InActive";
            }


        } else {
            notification1.themessage = qsTr("Name and Location must be provided or you need to invite at least one other person.");
            notification1.delay = 4;
            notification1.visible = true;
        }


});

}

function send_event(event) {

   // console.log("from send event "+event);

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT, name TEXT,userID TEXT,party TEXT,location TEXT,about MEDIUMTEXT,date INT)');

         var test = "SELECT * FROM EVENTS WHERE id='"+event+"'";

            var pull = tx.executeSql(test);

        if(pull.rows.length === 1) {
           // console.log(pull.rows.item(0).date);

            var http = new XMLHttpRequest();
            var url = "https://openseed.vagueentertainment.com:8675/corescripts/events.php";
            //console.log("send message "+user+":"+message);
           // console.log(url)
            http.onreadystatechange = function() {
                if (http.readyState == 4) {
                    //console.log(http.responseText);
                    //userid = http.responseText;
                    if(http.responseText === 100) {
                        console.log("Incorrect DevID");
                    } else if(http.responseText === 101) {
                        console.log("Incorrect AppID");
                    } else {
                      // console.log(http.responseText);
                        gc();
                    }

                }
            }
            http.open('POST', url.trim(), true);
            //http.send(null);
            http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            http.send("&id="+ userid + "&devid=" +devId+ "&appid="+appId+"&eventUnique=" + pull.rows.item(0).id + "&title="+ pull.rows.item(0).name + "&userid="+usercardNum+"&party="+pull.rows.item(0).party+"&location="+pull.rows.item(0).location+"&about="+pull.rows.item(0).about+"&date="+pull.rows.item(0).date+"&type=sending");


        }



});



}

function delete_event() {

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT,name TEXT,userID TEXT,party TEXT,location TEXT,about MEDIUMTEXT,date INT)');
});

}


function rsvp_event(unique,usercardNum,answer) {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/events.php";
    //console.log("send message "+user+":"+message);
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText === 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText === 101) {
                console.log("Incorrect AppID");
            } else {
             //  console.log(http.responseText);

            eventInfo.state = "InActive";
            eventsPage.invitecheck = true;
            eventsPage.updatecheck = true;
                gc();
            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid + "&devid=" +devId+ "&appid="+appId+"&eventUnique=" + unique + "&userid="+usercardNum+"&rsvp="+answer+"&type=rsvp");



}

function get_events() {

    gc();

    var d = new Date();

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/events.php";
    //console.log("send message "+user+":"+message);
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            //console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText === 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText === 101) {
                console.log("Incorrect AppID");
            } else {


                var webinvites = http.responseText.split("><");
                var inum = 1;

              //  console.log("from get events "+webinvites.length);

                if(webinvites.length > 1) {
                   // eventsUpdate.stop();

                while(webinvites.length > inum) {

                   // console.log(webinvites[inum].split("::"));

                    db.transaction(function(tx) {
                        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT,name TEXT,userID TEXT,party TEXT,location TEXT,about MEDIUMTEXT,date INT)');

                        var test = "SELECT * FROM EVENTS WHERE id='"+webinvites[inum].split("::")[0]+"'";

                        var pull = tx.executeSql(test);

                        if(pull.rows.length === 0) {

                            var insertStr = "INSERT INTO EVENTS VALUES(?,?,?,?,?,?,?)";
                           var dataSTR = [webinvites[inum].split("::")[0],webinvites[inum].split("::")[1],webinvites[inum].split("::")[2],
                                          webinvites[inum].split("::")[3],webinvites[inum].split("::")[4],webinvites[inum].split("::")[5],webinvites[inum].split("::")[6]];

                            tx.executeSql(insertStr,dataSTR);

                          //  console.log("added event "+webinvites[inum].split("::")[1]);


                        } else {
                            //console.log(webinvites[inum].split("::")[1]);
                            var updateStr = "UPDATE EVENTS SET name='"+webinvites[inum].split("::")[1]+"', location='"+webinvites[inum].split("::")[4]+"', \
party='"+webinvites[inum].split("::")[3]+"', about='"+webinvites[inum].split("::")[5]+"', date="+webinvites[inum].split("::")[6]+" WHERE id ='"+webinvites[inum].split("::")[0]+"'";

                            tx.executeSql(updateStr);

                           // console.log("updated event "+webinvites[inum].split("::")[1]);
                        }

                    });

                    inum = inum +1;
                }

            } else {
                    eventsUpdate.interval = 60000;

                }

            }
        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("&id="+ userid + "&devid=" +devId+ "&appid="+appId+"&userid="+usercardNum+"&date="+d.getTime()+"&type=retrieve");


}


function check_invites() {

    var d = new Date();
     var previousdate;

  //  console.log("checking for invites");

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS EVENTS(id TEXT, name TEXT,userID TEXT,party TEXT,location TEXT,about MEDIUMTEXT,date INT)');

        var test = "SELECT * FROM EVENTS WHERE userID !="+usercardNum+" AND `date` >"+d.getTime()+" ORDER by date";
        var pull = tx.executeSql(test);
           // console.log(pull.rows.length);

        for(var num = 0;num < pull.rows.length;num = num + 1) {

            var dd = new Date(pull.rows.item(num).date);

              var party = pull.rows.item(num).party.split(",");
                    var pnum = 0;
                    while (pnum < party.length) {

                        if(party[pnum].split(":")[0] === usercardNum) {


                            if(party[pnum].split(":")[1] === "0") {

                                eventInfo.state = "Active";
                                     eventInfo.type = "invite";
                                     eventInfo.unique = pull.rows.item(num).id;
                                     eventInfo.who = pull.rows.item(num).userID;
                                     eventInfo.eventname = pull.rows.item(num).name;
                                     eventInfo.about = pull.rows.item(num).about;
                                     eventInfo.party = pull.rows.item(num).party.split(",");
                                     eventInfo.when = dd.toLocaleString();

                                         var test1 = "SELECT * FROM SavedCards WHERE id='"+pull.rows.item(num).userID+"'";

                                            var pull1 = tx.executeSql(test1);

                                        if(pull1.rows.length === 1) {

                                           eventInfo.name = pull1.rows.item(0).name;

                                        }
                                        eventsPage.invitecheck = false;
                                        eventsPage.updatecheck = false;
                                        break;
                            }

                        }

                    pnum = pnum + 1;
                }
        }

    });


}
