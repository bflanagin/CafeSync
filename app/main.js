

function save_card(id,username,userphone,useremail,usercompany,useralias,usermotto,main,website1,website2,website3,website4,sendcard,usealias,contact,avatar,cardback,cardcat,id1,username1,userphone1,useremail1,usercompany1,
                   useralias1,usermotto1,main1,website11,website21,website31,website41,
                   sendcard1,usealias1,contact1,avatar1,cardback1,cardcat1,cardindex) {


    if(usercompany == "") {
        usercompany = " ";
    }

    if(main == "") {
        main = " ";
    }
    if(website1 == "") {
        website1 = " ";
    }
    if(website2 == "") {
        website2 = " ";
    }
    if(website3 == "") {
        website3 = " ";
    }
    if(website4 == "") {
        website4 = " ";
    }
    if(usermotto == "") {
        usermotto = " ";
    }
    if(useremail == "") {
        useremail = " ";
    }
    if(userphone == "") {
        userphone = " ";
    }
    if(useralias == "") {
        useralias = " ";
    }
    if(cardback == "") {
        cardback = "./img/default_card.png";

    }

    if(usercompany1 == "") {
        usercompany1 = " ";
    }

    if(main1 == "") {
        main1 = " ";
    }
    if(website11 == "") {
        website11 = " ";
    }
    if(website21 == "") {
        website21 = " ";
    }
    if(website31 == "") {
        website31 = " ";
    }
    if(website41 == "") {
        website41 = " ";
    }
    if(usermotto1 == "") {
        usermotto1 = " ";
    }
    if(useremail1 == "") {
        useremail1 = " ";
    }
    if(userphone1 == "") {
        userphone1 = " ";
    }
    if(useralias1 == "") {
        useralias1 = " ";
    }
    if(cardback1 == "") {
        cardback1 = "./img/default_card.png";

    }




    //if(cardindex == 0) {
      //  id = id;
    //} else {
      //  id = id+"-1";
    //}


    usermotto = usermotto.replace(/\'/g,"&#x27;");

    usermotto1 = usermotto1.replace(/\'/g,"&#x27;");

    username = username.replace(/\'/g,"&#x27;");
    username1 = username1.replace(/\'/g,"&#x27;");

    usercompany = usercompany.replace(/\'/g,"&#x27;");
    usercompany1 = usercompany1.replace(/\'/g,"&#x27;");

    useralias = useralias.replace(/\'/g,"&#x27;");
    useralias1 = useralias1.replace(/\'/g,"&#x27;");


    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var userStr = "INSERT INTO Card VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    var data = [id,username,userphone,useremail,usercompany,useralias,usermotto,main,website1,website2,website3,website4,avatar,cardback,cardcat];
    var data1 = [id+"-1",username1,userphone1,useremail1,usercompany1,useralias1,usermotto1,main1,website11,website21,website31,website41,avatar1,cardback1,cardcat1];

    var testStr = "SELECT  *  FROM Card WHERE id= '"+id+"'";
    var testStr1 = "SELECT  *  FROM Card WHERE id= '"+id+"-1'";

    var updateUser = "UPDATE Card SET name='"+username+"', email='"+useremail+"', phone='"+userphone+"', company='"+usercompany+"', alias='"+useralias+"', motto='"+usermotto+"', main='"+main+"',website1='"+website1+"', website2='"+website2+"', website3='"+website3+"', website4='"+website4+"', avatar='"+avatar+"', cardback='"+cardback+"', cat='"+cardcat+"'  WHERE id='"+id+"'";
    var updateUser1 = "UPDATE Card SET name='"+username1+"', email='"+useremail1+"', phone='"+userphone1+"', company='"+usercompany1+"', alias='"+useralias1+"', motto='"+usermotto1+"', main='"+main1+"',website1='"+website11+"', website2='"+website21+"', website3='"+website31+"', website4='"+website41+"', avatar='"+avatar1+"', cardback='"+cardback1+"', cat='"+cardcat1+"'  WHERE id='"+id+"-1'";

        db.transaction(function(tx) {
           //tx.executeSql("DROP TABLE Card");
            tx.executeSql('CREATE TABLE IF NOT EXISTS Card(id TEXT, name TEXT,phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT,cardback TEXT,cat TEXT)');


                        var test = tx.executeSql(testStr);


                            if(test.rows.length == 0) {

                                tx.executeSql(userStr, data);
                            } else {

                            tx.executeSql(updateUser);
                                }

                        var test1 = tx.executeSql(testStr1);


                            if(test1.rows.length == 0) {

                                tx.executeSql(userStr, data1);
                            } else {

                                tx.executeSql(updateUser1);
                            }


        });
     var settingStr = "INSERT INTO Options VALUES(?,?,?,?)";
    var settingdata = [id,sendcard,usealias,contact];
    var settingdata1 = [id+"-1",sendcard,usealias,contact];


     var OptStr = "SELECT  *  FROM Options WHERE id= '"+id+"'";
        var OptStr1 = "SELECT  *  FROM Options WHERE id= '"+id+"-1'";

    var updateOptions = "UPDATE Options SET sendcard ='"+sendcard+"',alias='"+usealias+"',contact='"+contact+"' WHERE id='"+id+"'";
    var updateOptions1 = "UPDATE Options SET sendcard ='"+sendcard1+"',alias='"+usealias1+"',contact='"+contact1+"' WHERE id='"+id+"-1'";

    db.transaction(function(tx) {
       //tx.executeSql("DROP TABLE Options");
        tx.executeSql('CREATE TABLE IF NOT EXISTS Options(id TEXT, sendcard TEXT, alias TEXT, contact TEXT)');

        var test = tx.executeSql(OptStr);
        if(test.rows.length == 0) {
        tx.executeSql(settingStr, settingdata);
        } else {
            tx.executeSql(updateOptions);
        }
        var test1 = tx.executeSql(OptStr1);
        if(test1.rows.length == 0) {
        tx.executeSql(settingStr, settingdata1);
        } else {
            tx.executeSql(updateOptions1);
        }


    });
        //getScript("openseed.js",upload_data());
        //console.log(data);
return 1;
}

function load_Card() {

    ///console.log(test[1]);

     var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
     var dataStr = "SELECT * FROM Card WHERE 1";

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Card(id TEXT, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT,cardback TEXT,cat TEXT)');

        var pull =  tx.executeSql(dataStr);
        //console.log("Item 1: "+ pull.rows.item(0).id);
       // console.log("Item 2: "+ pull.rows.item(1).id);

        if(pull.rows.length > 0) {

            //standard info card 1 //
            userid = pull.rows.item(0).id;
            username = pull.rows.item(0).name.replace(/&#x27;/g,"'");
            useremail = pull.rows.item(0).email;
            userphone = pull.rows.item(0).phone;
            usercompany = pull.rows.item(0).company.replace(/&#x27;/g,"'");
            useralias = pull.rows.item(0).alias.replace(/&#x27;/g,"'");
            usermotto = pull.rows.item(0).motto.replace(/&#x27;/g,"'");
            website1 = pull.rows.item(0).website1;
            website2 = pull.rows.item(0).website2;
            website3 = pull.rows.item(0).website3;

            avimg = pull.rows.item(0).avatar;
            cardbImg = pull.rows.item(0).cardback;


            if (cardbImg.search("internal:") ==  -1 ) {
                cardbImg = cardbImg;
            } else {
                carddesign = pull.rows.item(0).cardback;

                var sets  = cardbImg.slice(9,cardbImg.length);

                 fbgnum = sets.split(",")[0];
                 fsymbolnum = sets.split(",")[1];
                 ftextnum = sets.split(",")[2];
                cardbImg = Card_Set("background",fbgnum);
                cardsImg= Card_Set("symbol",fsymbolnum);
                cardtplace = Card_Set("text",ftextnum);
            }


            if(pull.rows.item(0).cat == null) {
                usercat = " ";
            } else {
                 usercat = pull.rows.item(0).cat;
        }
            if(pull.rows.item(0).website4 == null) {
                website4 = " ";
            } else {
                website4 = pull.rows.item(0).website4;
            }
            if(pull.rows.item(0).main == null) {
                usermain = " ";
            } else {
                usermain = pull.rows.item(0).main;
            }





            //standard info card 2 //

            if(pull.rows.item(1).id != "") {
            userid1 = pull.rows.item(1).id;
            username1 = pull.rows.item(1).name.replace(/&#x27;/g,"'");;
            useremail1 = pull.rows.item(1).email;
            userphone1 = pull.rows.item(1).phone;
            usercompany1 = pull.rows.item(1).company.replace(/&#x27;/g,"'");;
            useralias1 = pull.rows.item(1).alias.replace(/&#x27;/g,"'");;
            usermotto1 = pull.rows.item(1).motto.replace(/&#x27;/g,"'");
            website11 = pull.rows.item(1).website1;
            website21 = pull.rows.item(1).website2;
            website31 = pull.rows.item(1).website3;

                avimg1 = pull.rows.item(1).avatar;
                cardbImg1 = pull.rows.item(1).cardback;


                if (cardbImg1.search("internal:") ==  -1 ) {
                    cardbImg1 = cardbImg1;
                } else {
                    carddesign1 = pull.rows.item(0).cardback;

                    var sets  = cardbImg1.slice(9,cardbImg1.length);

                     fbgnum1 = sets.split(",")[0];
                     fsymbolnum1 = sets.split(",")[1];
                     ftextnum1 = sets.split(",")[2];
                    cardbImg1 = Card_Set("background",fbgnum1);
                    cardsImg1= Card_Set("symbol",fsymbolnum1);
                    cardtplace1 = Card_Set("text",ftextnum1);
                }


                if(pull.rows.item(1).cat == null) {
                    usercat1 = " ";
                } else {
                     usercat1 = pull.rows.item(1).cat;
            }
                if(pull.rows.item(1).website4 == null) {
                    website41 = " ";
                } else {
                    website41 = pull.rows.item(1).website4;
                }
                if(pull.rows.item(1).main == null) {
                    usermain1 = " ";
                } else {
                    usermain1 = pull.rows.item(1).main;
                }

            }

         //   console.log("User Cat = "+pull.rows.item(0).cat);
            return 1;

        } else {
            //console.log("No User found");
            return 0;
            }


    });
    if(userid.length < 3) {
            console.log("something is wrong launching firstrun");
            PopupUtils.open(firstrun);
    }

    var cardStr = "SELECT * FROM Options WHERE 1";
    var test = "";
    db.transaction(function(tx) {
       tx.executeSql('CREATE TABLE IF NOT EXISTS Options(id TEXT, sendcard INT, alias INT, contact INT)');
        var pull = tx.executeSql(cardStr);
        if(pull.rows.length > 0) {
            //id=pull.rows.item(0).id;

            stf = torf(pull.rows.item(0).sendcard);
            atf = torf(pull.rows.item(0).alias);
            ctf = torf(pull.rows.item(0).contact);

            if(pull.rows.item(1).sendcard != "") {
                stf1 = torf(pull.rows.item(1).sendcard);
                atf1 = torf(pull.rows.item(1).alias);
                ctf1 = torf(pull.rows.item(1).contact);
            }

            //console.log("send card set to "+stf+"");
            cardloaded = 1;

            //test = torf(pull.rows.item(0).sendcard);

        } else { //PopupUtils.open(firstrun);
            cardloaded = 0; }
    });



    if(username.length < 1) {
        if( username1.length < 1) {
            if(usercompany.length < 1) {
                if(usercompany1.length <1) {
                cardPage.head.sections.selectedIndex = 0;
                    cardPage.state = "settings";
                    mainScreen.state = "InActive";
                    infotab.state = "UnAvailable";
                settingsPage.state = "show";
        } } }

    }

    //console.log(sendCard.checked,test);

}


function Temp_load(search,locale) {

    //console.log(locale);

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var dbtable = "";
    switch(locale) {
    case "temp":dbtable="TempCards";break;
    case "region":dbtable="RegCards";break;
    case "global":dbtable="GlobCards";break;
    default:dbtable="TempCards";break;
    }



    if (search.length > 0) {

     var dataStr = "SELECT * FROM "+dbtable+" WHERE (name LIKE '%"+search+"%' OR company LIKE '%"+search+"%' OR motto LIKE '%#"+search+"%')";

        } else {
        var dataStr = "SELECT * FROM "+dbtable+" WHERE 1";
}



        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

            tx.executeSql('CREATE TABLE IF NOT EXISTS RegCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

            tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT,phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT)');

            tx.executeSql('CREATE TABLE IF NOT EXISTS GlobCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');


        var pull =  tx.executeSql(dataStr);
        numofcards = pull.rows.length;

        var record = 0;
    while (pull.rows.length > record) {
            var testStr = "SELECT  *  FROM SavedCards WHERE id= "+pull.rows.item(record).id;
            var duplicate = tx.executeSql(testStr);

           if(duplicate.rows.length == 0) {

                var w1;
                 var w2;
                 var w3;
                 var w4;
                 var main;

               var card;
               var symbol;
               var text;
               var design;


                var ava;

               cardsynctemp = pull.rows.item(record).id +","+cardsynctemp;

               switch(pull.rows.item(record).website1.substring(0,4)) {
               case "http":w1 = pull.rows.item(record).website1;break;
               case "HTTP":w1 = pull.rows.item(record).website1;break;
               case "Http":w1 = pull.rows.item(record).website1;break;
               default: w1 = "http://"+pull.rows.item(record).website1;break;
               }

                  //if(pull.rows.item(record).website1.substring(0,4) != "http") {w1 = "http://"+pull.rows.item(record).website1;}
                  //    else { w1 = pull.rows.item(record).website1; }
                  if(pull.rows.item(record).website2.substring(0,4) != "http") {w2 = "http://"+pull.rows.item(record).website2;}
                      else { w2 = pull.rows.item(record).website2; }
                  if(pull.rows.item(record).website3.substring(0,4) != "http") {w3 = "http://"+pull.rows.item(record).website3;}
                      else { w3 = pull.rows.item(record).website3; }
                  if(pull.rows.item(record).website4.substring(0,4) != "http") {w4 = "http://"+pull.rows.item(record).website4;}
                      else { w4 = pull.rows.item(record).website4; }
                  if(pull.rows.item(record).main.substring(0,4) != "http") {main = "http://"+pull.rows.item(record).main;}
                      else { main = pull.rows.item(record).main; }

                  if(pull.rows.item(record).cardback.search("internal:") == -1) {
                      if(pull.rows.item(record).cardback.length < 4) {

                          //card = "img/default_card.png";
                          card = Card_Set("background",1);

                          symbol = Card_Set("symbol",0);
                          text = Card_Set("text",12);

                            } else {card = pull.rows.item(record).cardback
                                    design = card;
                                symbol = Card_Set("symbol",0);
                                text = Card_Set("text",0);

                            }
                  } else {

                      var sets  = pull.rows.item(record).cardback.slice(9,pull.rows.item(record).cardback.length);
                      var fbnum = sets.split(",")[0];
                      var fsnum = sets.split(",")[1];
                      var ftnum = sets.split(",")[2];
                      design = pull.rows.item(record).cardback;
                     card = Card_Set("background",fbnum);
                     symbol= Card_Set("symbol",fsnum);
                     text = Card_Set("text",ftnum);

                  }

                   if(pull.rows.item(record).avatar.length < 4) { ava = "img/default_avatar.png"} else {ava = pull.rows.item(record).avatar}


        if (currentcat.length > 2 & currentcat != i18n.tr("All Cards") ) {

            if(currentcat == pull.rows.item(record).cat) {

               // console.log(currentlist.split(":"));
                if(currentlist != "") {
                        if(currentlist.search(":"+pull.rows.item(record).id) == -1) {
                           currentlist = currentlist+":"+pull.rows.item(record).id;
                        }
                                } else {
                                    currentlist =  ":"+pull.rows.item(record).id;
                                              }


                    cardslist.append({
            name: pull.rows.item(record).name.replace(/&#x27;/g,"'"),
            colorCode: "white",
            imagesource: "img/default_avatar.png",
            cardback:"img/default_card.png",

            company: pull.rows.item(record).company.replace(/&#x27;/g,"'"),
            phone:  pull.rows.item(record).phone,
            email:  pull.rows.item(record).email,
            motto:pull.rows.item(record).motto.replace(/&#x27;/g,"'"),
            card: pull.rows.item(record).id,

                             mainsite: main,
                             URL1: w1,
                             URL2: w2,
                             URL3: w3,
                             URL4: w4,

            cardback:card,
            cardsymbol:symbol,
            cardtext:text,
            cardcat:pull.rows.item(record).cat,
            imgsource:ava,
            thedesign:pull.rows.item(record).cardback,
            saved:0


        });} } else {



            if(currentlist != "") {
                if(currentlist.search(":"+pull.rows.item(record).id) == -1) {
                       currentlist = currentlist+":"+pull.rows.item(record).id;
                            }
                            } else {
                                currentlist = ":"+pull.rows.item(record).id;
                                          }

            cardslist.append({
                name: pull.rows.item(record).name.replace(/&#x27;/g,"'"),
                colorCode: "white",
                imagesource: "img/default_avatar.png",
                cardback:"img/default_card.png",

                company: pull.rows.item(record).company.replace(/&#x27;/g,"'"),
                phone:  pull.rows.item(record).phone,
                email:  pull.rows.item(record).email,
                motto:pull.rows.item(record).motto.replace(/&#x27;/g,"'"),
                card: pull.rows.item(record).id,

                mainsite: main,
                URL1: w1,
                URL2: w2,
                URL3: w3,
                URL4: w4,

                cardback:card,
                cardsymbol:symbol,
                cardtext:text,
                cardcat:pull.rows.item(record).cat,
                imgsource:ava,
                thedesign:pull.rows.item(record).cardback,
                saved:0
            });
             }

        //}

         //cavimg = ava;
         //cardback = card;
        }
        record = record + 1;
    }

    });

}

function Cards_save(id,username,userphone,useremail,usercompany,useralias,usermotto,main,website1,website2,website3,website4,avatar,cardback,cardcat) {
   var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var userStr = "INSERT INTO SavedCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    var data = [id,username,userphone,useremail,usercompany,useralias,usermotto,main,website1,website2,website3,website4,avatar,cardback,cardcat];

       // console.log(data);
        db.transaction(function(tx) {
           //tx.executeSql("DROP TABLE Card");
            tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT,phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT, website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT,cardback TEXT,cat TEXT)');

            if(id != 0) {
               // console.log("Saved card "+id);
            tx.executeSql(userStr, data);
            }



        });
    cardsyncsaved = id+","+cardsyncsaved

    //Delete_card(id,listget);
   //console.log("FUNCTION!!! SAVE CARDS!!!")

return 1;
}

function Cards_load(search) {
    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    cardsyncsaved = "";
    if (search.length > 0) {
     var dataStr = "SELECT * FROM SavedCards WHERE (name LIKE '%"+search+"%' OR company LIKE '%"+search+"%' OR motto LIKE '%#"+search+"%')";
    } else {
        var dataStr = "SELECT * FROM SavedCards WHERE 1";

}

       db.transaction(function(tx) {
       tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT, phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT, main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT)');

       var pull =  tx.executeSql(dataStr);


           var record = 0;
       while (pull.rows.length > record) {


           if(pull.rows.item(record).id > 1) {

           cardsyncsaved = pull.rows.item(record).id +","+cardsyncsaved;

          var w1;
           var w2;
           var w3;
           var w4;
           var main;
           var card;
           var ava;
           var symbol;
           var text;


                switch(pull.rows.item(record).website1.substring(0,4)) {
                case "http":w1 = pull.rows.item(record).website1;break;
                case "HTTP":w1 = pull.rows.item(record).website1;break;
                case "Http":w1 = pull.rows.item(record).website1;break;
                default: w1 = "http://"+pull.rows.item(record).website1;break;
                }

            //if(pull.rows.item(record).website1.substring(0,4) != "http") {w1 = "http://"+pull.rows.item(record).website1;}
             //   else { w1 = pull.rows.item(record).website1; }
            if(pull.rows.item(record).website2.substring(0,4) != "http") {w2 = "http://"+pull.rows.item(record).website2;}
                else { w2 = pull.rows.item(record).website2; }
            if(pull.rows.item(record).website3.substring(0,4) != "http") {w3 = "http://"+pull.rows.item(record).website3;}
                else { w3 = pull.rows.item(record).website3; }
            if(pull.rows.item(record).website4.substring(0,4) != "http") {w4 = "http://"+pull.rows.item(record).website4;}
                else { w4 = pull.rows.item(record).website4; }
            if(pull.rows.item(record).main.substring(0,4) != "http") {main = "http://"+pull.rows.item(record).main;}
                else { main = pull.rows.item(record).main; }





             //if(pull.rows.item(record).cardback.length < 4 ) { card = "img/default_card.png"} else {card = pull.rows.item(record).cardback}


             if(pull.rows.item(record).cardback.search("internal:") == -1) {
                 if(pull.rows.item(record).cardback.length < 4) {

                     //card = "img/default_card.png";
                     card = Card_Set("background",1);
                     symbol = Card_Set("symbol",0);
                     text = Card_Set("text",12);

                       } else {
                            card = pull.rows.item(record).cardback
                           symbol = Card_Set("symbol",0);
                           text = Card_Set("text",0);

                       }
             } else {

                 var sets  = pull.rows.item(record).cardback.slice(9,pull.rows.item(record).cardback.length);
                 var fbnum = sets.split(",")[0];
                 var fsnum = sets.split(",")[1];
                 var ftnum = sets.split(",")[2];
                card = Card_Set("background",fbnum);
                symbol= Card_Set("symbol",fsnum);
                text = Card_Set("text",ftnum);

             }






             if(pull.rows.item(record).avatar.length < 4) { ava = "img/default_avatar.png"} else {ava = pull.rows.item(record).avatar}

             if (currentcat.length > 2 & currentcat != i18n.tr("All Cards") ) {

                 if(currentcat == pull.rows.item(record).cat) {
             cardslist.append({ name: pull.rows.item(record).name.replace(/&#x27;/g,"'"),
                 colorCode: "white",
                 imagesource: "img/default_avatar.png",
                 cardback:"img/default_card.png",

                 company: pull.rows.item(record).company.replace(/&#x27;/g,"'"),
                 phone:  pull.rows.item(record).phone,
                 email:  pull.rows.item(record).email,
                 motto:pull.rows.item(record).motto.replace(/&#x27;/g,"'"),
                 card: pull.rows.item(record).id,

                 mainsite: main,
                 URL1: w1,
                 URL2: w2,
                 URL3: w3,
                 URL4: w4,

                                  cardback:card,
                                  cardsymbol:symbol,
                                  cardtext:text,
                 cardcat:pull.rows.item(record).cat,
                 imgsource:ava,
                 thedesign:pull.rows.item(record).cardback,
                 saved:1


             }); }} else {

                 cardslist.append({ name: pull.rows.item(record).name.replace(/&#x27;/g,"'"),
                     colorCode: "white",
                     imagesource: "img/default_avatar.png",
                     cardback:"img/default_card.png",

                     company: pull.rows.item(record).company.replace(/&#x27;/g,"'"),
                     phone:  pull.rows.item(record).phone,
                     email:  pull.rows.item(record).email,
                     motto:pull.rows.item(record).motto.replace(/&#x27;/g,"'"),
                     card: pull.rows.item(record).id,

                     mainsite: main,
                     URL1: w1,
                     URL2: w2,
                     URL3: w3,
                     URL4: w4,

                                      cardback:card,
                                      cardsymbol:symbol,
                                      cardtext:text,
                     cardcat:pull.rows.item(record).cat,
                     imgsource:ava,
                     thedesign:pull.rows.item(record).cardback,
                     saved:1
                 });

             }
             //cavimg = ava;
             //cardback = card;
            }



           record = record + 1;

}

       });
//console.log("From Load_cards "+cardsyncsaved);

return 1;
}

function torf (num) {

    /* Older versions of the Ubuntu SDK would return 1 if true and 0 if false, and then require the actual word
      true or false to be returned. This code is setup to return whatever is right whatever is set */

    switch(num) {

    case "true": return ("true"); break;
    case "false": return ("false");break;
    case 0: return ("false");break;
    default: return("true");break;
    }

}

function Show_sites(cid,list) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var dataStr;
    var issaved = 0;


    var dbtable = "";
    switch(list) {
    case "temp":dbtable="TempCards";break;
    case "region":dbtable="RegCards";break;
    case "global":dbtable="GlobCards";break;
    //default:dbtable="TempCards";break;
    }

    if(cid != "local") {
        if(list != "saved") {
     dataStr = "SELECT * FROM "+dbtable+" WHERE id ='"+cid+"'";
        } else {
            dataStr = "SELECT * FROM SavedCards WHERE id ='"+cid+"'";
            issaved = 1;
        }
} else {
        //console.log("showing info for "+list);
        dataStr = "SELECT * FROM Card WHERE id ='"+list+"'";
    }
        //console.log("showing sites for " + cid + " in "+dbtable);

        webview1 = "empty.html";
        webview2 = "empty.html";
        webview3 = "empty.html";
        webview4 = "empty.html";
        mainview = "empty.html";


        var cardbackis;


       db.transaction(function(tx) {

      //tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

       var pull =  tx.executeSql(dataStr);

           if (pull.rows.item(0).cardback.search("internal:") == -1) {
                    cardbackis = pull.rows.item(0).cardback;
                   } else {
                cardbackis = Card_Set("background",1);
           }
            var phonenumber;
            var emailaddress;

           if(pull.rows.item(0).phone == "Not Available") {
                    phonenumber = "*******"
           } else {
               phonenumber = pull.rows.item(0).phone
           }

           if(pull.rows.item(0).email == "Not Available") {
                    emailaddress = "*******"
           } else {
               emailaddress = pull.rows.item(0).email
           }

           pagelist.append({
                            webpage:"empty.html",
                            thestate:"Home",
                               pagewidth:mainScreen.width ,
                               pageheight:mainScreen.height,
                               motto:pull.rows.item(0).motto.replace(/&#x27;/g,"'"),
                               thecard:pull.rows.item(0).id.toString(),
                               avatarimg:pull.rows.item(0).avatar,
                               companyname:pull.rows.item(0).company.replace(/&#x27;/g,"'"),
                               cardusername:pull.rows.item(0).name.replace(/&#x27;/g,"'"),
                               carduserphone:phonenumber,
                               carduseremail:emailaddress,
                               cardbackimg:cardbackis,
                               //pageindex:pages,
                               cardcat:pull.rows.item(0).cat,
                               saved:issaved,
                               realcardback:pull.rows.item(0).cardback,

                               mainsite:pull.rows.item(0).main,
                               URL1:pull.rows.item(0).website1,
                               URL2:pull.rows.item(0).website2,
                               URL3:pull.rows.item(0).website3,
                               URL4:pull.rows.item(0).website4,




                           });


           if(pull.rows.item(0).main.length > 8) {
               pages = pages + 1;


               mainview = pull.rows.item(0).main;

                if(mainview.search("http") == -1) {
                    mainview = "http://" + mainview;
                }
                    if(mainview != "http://empty.html") {
                pagelist.append({
                                 webpage:mainview,
                                 thestate:"Active",
                                    pagewidth:mainScreen.width ,
                                    pageheight:mainScreen.height,
                                    thecard:pull.rows.item(0).id.toString(),

                                    avatarimg:"",
                                    companyname: "",
                                    cardusername:"",
                                    carduserphone:"",
                                    carduseremail:"",
                                    cardbackimg:"",
                                    motto:"",

                                    pageindex:pages
                                });


                    }

               //console.log(webview1);
           }

           if(pull.rows.item(0).website1.length > 8) {
               pages = pages + 1;
              // console.log(pull.rows.item(0).website1.length);
               webview1 = pull.rows.item(0).website1;
               if(webview1.search("http") == -1) {
                   webview1 = "http://" + webview1;
               }

                if(webview1 != "http://") {
               pagelist.append({
                                webpage:webview1,
                                thestate:"Active",
                                   pagewidth:mainScreen.width ,
                                   pageheight:mainScreen.height,
                                   thecard:pull.rows.item(0).id.toString(),

                                   avatarimg:"",
                                   companyname: "",
                                   cardusername:"",
                                   carduserphone:"",
                                   carduseremail:"",
                                   cardbackimg:"",
                                   motto:"",


                                   pageindex:pages
                               });

                        }
               //console.log(webview1);
           }

           if(pull.rows.item(0).website2.length > 8) {
               //  console.log(pull.rows.item(0).website2.length);

               pages = pages + 1;
               webview2 = pull.rows.item(0).website2;
               if(webview2.search("http") == -1) {
                   webview2 = "http://" + webview2;
               }

                 if(webview2 != "http://empty.html") {
               pagelist.append({
                         webpage:webview2,
                             thestate:"Active",
                                   pagewidth:mainScreen.width ,
                                   pageheight:mainScreen.height,
                                   thecard:pull.rows.item(0).id.toString(),

                                   avatarimg:"",
                                   companyname: "",
                                   cardusername:"",
                                   carduserphone:"",
                                   carduseremail:"",
                                   cardbackimg:"",
                                   motto:"",

                                   pageindex:pages
                               });
                 }

               //console.log(webview1);
           }

           if(pull.rows.item(0).website3.length > 8) {
                // console.log(pull.rows.item(0).website3.length);

               pages = pages + 1;
               webview3 = pull.rows.item(0).website3;
               if(webview3.search("http") == -1) {
                   webview3 = "http://" + webview3;
               }
                     if(webview3 != "http://empty.html") {
               pagelist.append({
                                webpage:webview3,
                                thestate:"Active",
                                   pagewidth:mainScreen.width ,
                                   pageheight:mainScreen.height,
                                   thecard:pull.rows.item(0).id.toString(),

                                   avatarimg:"",
                                   companyname: "",
                                   cardusername:"",
                                   carduserphone:"",
                                   carduseremail:"",
                                   cardbackimg:"",
                                   motto:"",


                                   pageindex:pages
                               });

                     }

               //console.log(webview1);
           }

           if(pull.rows.item(0).website4.length > 8) {
                // console.log(pull.rows.item(0).website4.length);

               pages = pages + 1;
               webview4 = pull.rows.item(0).website4;
               if(webview4.search("http") == -1) {
                   webview4 = "http://" + webview4;
               }
               //console.log(webview1);
                if(webview4 != "http://empty.html") {
               pagelist.append({
                                webpage:webview4,
                                thestate:"Active",
                                   pagewidth:mainScreen.width ,
                                   pageheight:mainScreen.height,
                                   thecard:pull.rows.item(0).id.toString(),

                                   avatarimg:"",
                                   companyname: "",
                                   cardusername:"",
                                   carduserphone:"",
                                   carduseremail:"",
                                   cardbackimg:"",
                                   motto:"",


                                   pageindex:pages
                               });
                }

           }



   });


}

function Temp_elapsed(cid) {
    var date = Date.now();

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var dataStr = "SELECT * FROM TempCards WHERE 1";
    var deleted = 0;

     db.transaction(function(tx) {

         tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT)');

        var pull = tx.executeSql(dataStr);

         var num = 0;
         //while(pull.rows.item(num).stamp != undefined) {
            var deletedate = pull.rows.item(num).stamp + (172800 * 1000)

         if(pull.rows.item(num).stamp != 999) {

             if(deletedate < date) {
                 //console.log("deleting "+cid);
                 Delete_card(cid,"temp");
                    deleted = 1;
                    get_list_updater.running = false;
                    cardload.running = false;

         }  else {
                 //console.log(cid+" has "+(deletedate - date) / 1000+ " seconds left");
                // deleted = 0;
                get_list_updater.running = true;
                cardload.running = true;
                }
         }
            num = num + 1;

         //}


     });

return deleted;
}

function Delete_card(cid,list) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

     if(list == "temp"){
         db.transaction(function(tx) {
    var tempDel = "DELETE FROM TempCards WHERE id ='"+cid+"'";
         tx.executeSql(tempDel);
        //console.log("deleted"+cid);
     });
     }
    if (list == "saved") {
    db.transaction(function(tx) {
    var saveDel = "DELETE FROM SavedCards WHERE id ='"+cid+"'";
        tx.executeSql(saveDel);

        //console.log("removed"+cid);
        //console.log("from delete command "+remotesaved+" <--from server, local --> "+cardsyncsaved);
    });
    }

    if(list == "region"){
        db.transaction(function(tx) {
   var tempDel = "DELETE FROM RegCards WHERE id ='"+cid+"'";
        tx.executeSql(tempDel);
       //console.log("deleted"+cid);
    });
    }

    if(list == "global"){
        db.transaction(function(tx) {
   var tempDel = "DELETE FROM GlobCards WHERE id ='"+cid+"'";
        tx.executeSql(tempDel);
       //console.log("deleted"+cid);
    });
    }



}

function Category_search() {
menuList.clear();

     var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var num = 0;
    while(category_list.split(",")[num].length > 0) {
            menuList.append({menuitem:category_list.split(",")[num]});
        num = num + 1;
    }


}

function Category_set() {
menuList.clear();

     var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var num = 0;
    while(category_list.split(",")[num].length > 0) {
            menuList.append({menuitem:category_list.split(",")[num]});
        num = num + 1;
    }

}


function updateDB() {
    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    db.transaction(function(tx) {
         tx.executeSql('DROP TABLE SavedCards');
        tx.executeSql('DROP TABLE TempCards');
        tx.executeSql('DROP TABLE Card');
        tx.executeSql('DROP TABLE Options');


});
    return 1;
}

function cardcreator() {
    var num = 0;
    fbackground_list.clear();
    fsymbol_list.clear();
    ftext_list.clear();
    while(num < bgnum) {


        fbackground_list.append({
                        index:num,

                        img:"img/card/background-f/"+num+".png"

                        });
            if(backgrounds.length < 2) {
                backgrounds = "img/card/background-f/"+num+".png";
            } else {
                backgrounds = backgrounds+","+"img/card/background-f/"+num+".png";
            }


            //console.log("creating background "+num);

            num = num + 1;
        }


        num = 0;
    fsymbol_list.append({
                            index:num,
                            img:"img/card/symbols/"+num+".png",
                            placement:-5
                    });
    //symbols = symbols+",img/card/symbols/"+num+".png:-5";

    num = 1;
     while(num < symbolnum) {

    fsymbol_list.append({
                            index:num,
                            img:"img/card/symbols/"+num+".png",
                            placement:-5
                    });
            symbols = symbols+",img/card/symbols/"+num+".png:-5";
         fsymbol_list.append({
                                 index:num,
                                 img:"img/card/symbols/"+num+".png",
                                 placement:55
                         });
            symbols = symbols+",img/card/symbols/"+num+".png:55";

         num = num + 1;
     }


     ftext_list.append({
             ftitle:"",
             ftitlesize:0,
             fHoffset:0,
             fVoffset:0,
             fsubtitle:"",
             fsubtitlesize:0,
             fsHoffset:0,
             fsVoffset:0
             });
     text_Locations = '0:0:0';
        var company = "";
        var name = "";

     if(cardindex == 0) {



     if(usercompany.length >1) {
         company = usercompany;
         name = username;
     } else {
         company = username;
         name = "";
     }

     } else {

         if(usercompany1.length >1) {
             company = usercompany1;
             name = username1;
         } else {
             company = username1;
             name = "";
         }


     }

    var snum = 18
     while (snum < 25) {
        num = -30;
        while ( num < 40 ) {
            var vnum = -30;
                while (vnum < 30) {
                        ftext_list.append({
                                ftitle:company,
                                ftitlesize:snum,
                                fHoffset:num,
                                fVoffset:vnum,
                                fsubtitle:name,
                                fsubtitlesize:30,
                                fsHoffset:35,
                                fsVoffset:70
                                });

                        if(text_Locations.length < 2) {
                            text_Locations = snum+':'+num+':'+vnum;
                        } else {
                            text_Locations = text_Locations+","+snum+':'+num+':'+vnum;
                        }

                        vnum = vnum + 30;
                    }
            num = num + 10;
            }
    snum = snum + 10;
     }

}

function Card_Set(location,num) {

    switch(location) {
    case "background":return backgrounds.split(",")[num];break;
    case "symbol":return symbols.split(",")[num];break;
    case "text":return text_Locations.split(",")[num];break;
    default:break;
    }

}
