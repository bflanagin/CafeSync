function get_html(url) {

var http = new XMLHttpRequest();
//var url = "http://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
//console.log(url)
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
            //datasync(http.responseText);
            return http.responseText;
        }

    }
}
http.open('GET', url, true);
http.send(null);

}
