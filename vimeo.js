function get_html(url) {

var http = new XMLHttpRequest();

    var pagedata = "";
//console.log("From twitch.js: "+url)
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

            //console.log("From twitch.js"+pagedata);

        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}
