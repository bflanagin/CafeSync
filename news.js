function get_news() {

    var http = new XMLHttpRequest();
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/news.php";
   // console.log(url)
    var seen = "";
    var news = "";

    var testStr = "SELECT  *  FROM NEWS WHERE 1";

     db.transaction(function(tx) {

    tx.executeSql('CREATE TABLE IF NOT EXISTS NEWS (date TEXT)');

         var pull = tx.executeSql(testStr);

         if(pull.rows.length == 1) {
             seen = pull.rows.item(0).date;
         } else {
             seen = "none";
         }

     });

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
                thenews = http.responseText.split("><")[0];
                date =  http.responseText.split("><")[1];
                    newscheck.stop();
                if(seen != date) {
                    thisWindow.visible = true;
                }

            }

        }



    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&userid="+ userid + "&lastseen" + seen);


}

function dismiss_news(date) {

    var testStr = "SELECT  *  FROM NEWS WHERE 1";

     var insert = "INSERT INTO NEWS VALUES(?)";
     var data = [date];

    var update = "UPDATE NEWS SET date='"+date+"' WHERE 1";

     db.transaction(function(tx) {

    tx.executeSql('CREATE TABLE IF NOT EXISTS NEWS (date TEXT)');

         var pull = tx.executeSql(testStr);

         if(pull.rows.length == 1) {
                tx.executeSql(update);
         } else {
                tx.executeSql(insert,data);
         }

     });
    thisWindow.visible = false;

}
