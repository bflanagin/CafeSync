function returnImage(who,locale) {


    var dbtable = "";
    switch(locale) {
    case "temp":dbtable="TempCards";break;
    case "region":dbtable="RegCards";break;
    case "global":dbtable="GlobCards";break;
    case "saved":dbtable="SavedCards";break;
    default:dbtable="TempCards";break;
    }

    var dataStr= "SELECT avatar FROM "+dbtable+" WHERE id ='"+who+"'";
    var ava = "";
    if(locale !== "mycard") {
    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS TempCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');

        tx.executeSql('CREATE TABLE IF NOT EXISTS RegCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');

        tx.executeSql('CREATE TABLE IF NOT EXISTS SavedCards(id INT UNIQUE, name TEXT,phone TEXT,email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,cat TEXT,cardsop INT)');

        tx.executeSql('CREATE TABLE IF NOT EXISTS GlobCards(id INT UNIQUE, name TEXT, phone TEXT, email TEXT,company TEXT,alias TEXT, motto TEXT,main TEXT,website1 TEXT,website2 TEXT,website3 TEXT,website4 TEXT,avatar TEXT, cardback TEXT,stamp INT,cat TEXT,cardsop INT)');


    var pull =  tx.executeSql(dataStr);
    //numofcards = pull.rows.length;



    if(pull.rows.item(0).avatar.length < 4) { ava = "img/default_avatar.png"} else {ava = pull.rows.item(0).avatar
                 if(ava.search("/9j/4A") != -1) { ava = "data:image/jpeg;base64, "+ava.replace(/ /g, "+");}

    }

    });
    } else {
        //console.log("from Circle Pic "+avimg);
       ava = avimg;
    }

    return ava;
}
