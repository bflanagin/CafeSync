function get_notes(userid) {
    //gathers up notes about specific contact and displays them.

    notelist.clear();
    db.transaction(function(tx) {
      //tx.executeSql('DROP TABLE Notes');

        tx.executeSql('CREATE TABLE IF NOT EXISTS Notes (contactid TEXT,title TEXT ,information MEDIUMTEXT,date MEDIUMINT,origin MEDIUMINT)');

        var pull = tx.executeSql("SELECT * FROM Notes WHERE contactid='"+userid+"'");

        if(pull.rows.length >= 1) {
            var num = 0;
            while(num < pull.rows.length) {
                //console.log(pull.rows.item(num).title);
                var d = new Date(pull.rows.item(num).date)
                notelist.append({
                                notetitle:pull.rows.item(num).title,
                                summary:pull.rows.item(num).information,
                                date:d.toLocaleString(),
                                origin:pull.rows.item(num).origin


                                });

                num = num + 1;
            }

        }


});

}


function save_note(userid,notename,information,origin) {
    //saves and or updates note about contact

    var thedate = new Date().getTime();
    var insert = "INSERT INTO Notes VALUES(?,?,?,?,?)";
    var thedata = [userid,notename,information,thedate,thedate];

   // console.log(thedata);

    var update = "UPDATE Notes SET title ='"+notename+"', information='"+information+"', date='"+thedate+"' WHERE origin="+origin+" AND contactid='"+userid+"'";

    db.transaction(function(tx) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS Notes (contactid TEXT,title TEXT,information MEDIUMTEXT,date MEDIUMINT,origin MEDIUMINT)');

        var pull = tx.executeSql("SELECT * FROM Notes WHERE 1");
        if(origin !== 0) {
        //if(pull.rows.length === 1) {
            //console.log("Updating "+parseInt(origin));
                tx.executeSql(update);
        } else {
           // console.log("creating "+parseInt(origin));
            tx.executeSql(insert,thedata);
        }

});

}


function get_note(userid,title) {
        //retrieves and single note displays it.
           // console.log(title);

    //if(title !== "NEW") {
        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS Notes (contactid TEXT,title TEXT,information MEDIUMTEXT,date MEDIUMINT,origin MEDIUMINT)');

            var pull = tx.executeSql("SELECT * FROM Notes WHERE contactid='"+userid+"' AND title ='"+title+"'");

            if(pull.rows.length === 1) {

                nN.noteTile = pull.rows.item(0).title;
               nN.noteBody = pull.rows.item(0).information;
               nN.noteOrigin = pull.rows.item(0).origin;

            }


});

   // } else {
   //     nN.noteTile = "New Note";
   //    nN.noteBody = " ";
   //    nN.noteOrigin = 0;
  //  }


    }


function delete_note(userid,origin) {
        //Checks to make sure note name is unique.

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS Notes (contactid TEXT,title TEXT,information MEDIUMTEXT,date MEDIUMINT,origin MEDIUMINT)');

            var pull = tx.executeSql("SELECT * FROM Notes WHERE contactid='"+userid+"' AND origin ="+origin);

            if(pull.rows.length === 1) {

                tx.executeSql("DELETE FROM Notes WHERE contactid='"+userid+"' AND origin ="+origin);
                get_notes(userid);
            }


});


}



