function get_eula() {


    var seen = "";
    var news = "";

    var testStr = "SELECT  *  FROM EULA WHERE 1";

     db.transaction(function(tx) {

    tx.executeSql('CREATE TABLE IF NOT EXISTS EULA (date TEXT)');

         var pull = tx.executeSql(testStr);

         if(pull.rows.length == 1) {
             seen = pull.rows.item(0).date;
         } else {
             seen = "none";
         }

     });

    theeula = "\n## End User Agreement\\n All users of CafeSync must agree to continue using the software and its network. Please read the following carefully. \\n
<br> ### CafeSync and OpenSeed\\n
CafeSync is in large part a client of the OpenSeed API and as such both products will collect certain information about the user. The data collected will only go as far as what is required to render\
 the desired results of the application. Furthermore, your data is only accessible by those participating on the network and as long as that information isn't considered a part of securing an account or set private by the user or application.\
 Passwords, encryption keys, pin numbers, and passphrases are considered secure data. CafeSync offers businesses (not ad networks) the ability to gather data that is publicly accessible by those on the network for the\
  purpose of analytics and advertising. No data will be sold to third party ad networks by CafeSync or OpenSeed.\\n
<br> ### User expectations\\n
- Users will not assume another persons name or likeness for the purpose of defamation or personal gain.\\n
- Users will not harass or bully any other user on the system.\\n
- Users will not try to gain access to another persons account or ex-filtrate data from the servers.\\n
- Users will apply rules of common decency when selecting their profile image.\\n
- Users will use common sense when searching out other members.\\n
Users failing to adhere to a code of conduct may face up to and including the immediate deletion of the account with the possibility of public shaming in the form of updating your card to reflect the reason for dismissal.\\n
<br><br> Updated on April 24 2018\\n
";
    date = 'April 24 2018';

    if(seen != date) {
        thisWindow.visible = true;
    } else {
        eulacheck.stop();
    }



    //return eula;
}


function dismiss_eula(date) {

    var testStr = "SELECT  *  FROM EULA WHERE 1";

     var insert = "INSERT INTO EULA VALUES(?)";
     var data = [date];

    var update = "UPDATE EULA SET date='"+date+"' WHERE 1";

     db.transaction(function(tx) {

    tx.executeSql('CREATE TABLE IF NOT EXISTS EULA (date TEXT)');

         var pull = tx.executeSql(testStr);

         if(pull.rows.length == 1) {
                tx.executeSql(update);
         } else {
                tx.executeSql(insert,data);
         }

     });
    thisWindow.visible = false;

}
