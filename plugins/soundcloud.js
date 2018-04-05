function get_html(account) {

    var url = "http://www.souncloud.com/"+account.split("::")[1];

var http = new XMLHttpRequest();
    var profilename = "";
    var profilebanner = "";
    var profileavatar = "";
    var stats = "";
    var message = "";
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


            //console.log("From souncloud.js"+pagedata);

            profilename = pagedata.substring(pagedata.search("<title>")+7,pagedata.search("</title>")-8);
            profilename = profilename.split("|");
            name = profilename[0];

            profileavatar = pagedata.substring(pagedata.search("’s avatar")-200,pagedata.search("’s avatar"));

            profileavatar = profileavatar.split('<img');
            profileavatar = profileavatar[1].split('=');
            profileavatar = profileavatar[1].split(' ');

            avatar = profileavatar[0].substring(1,profileavatar[0].length-1);

            stats = pagedata.substring(pagedata.search('<meta name="description" content=')+34,pagedata.search('><meta property="twitter:app:name:iphone"'));
            var tracks = stats.substring(stats.search('Tracks')-4,stats.search('Tracks')+6).split(". ")[1];
            //console.log(tracks);
            var followers = stats.substring(stats.search('Tracks')+6,stats.search('Followers')+9).split(". ")[1];
            stats = followers+"\n"+tracks;
            thestats = stats;

        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}
