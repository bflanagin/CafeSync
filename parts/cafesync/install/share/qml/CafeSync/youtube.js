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



            banner = 'http://'+pagedata.split("#c4-header-bg-container {")[1].split("}")[0].split('background-image: url(//')[1].split(');')[0];
            avatar =  pagedata.split('<img class="channel-header-profile-image" src="')[1].split('"')[0];
            profilename = pagedata.split('<meta itemprop="name" content="')[1].split('">')[0];
            message = pagedata.split('<meta itemprop="description" content="')[1].split('">')[0];
        }

    }

}

http.open('GET', url, true);
http.send(null);

return pagedata;
}

function channelist(url) {

    var http = new XMLHttpRequest();

        var pagedata = "";
        var postinfo = "";

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

    var vidlist = pagedata.split('>Uploads</span>')[1].split('Created playlists</span>')[0];

    var items = vidlist.split('<li class="channels-content-item yt-shelf-grid-item yt-uix-shelfslider-item ">');
        //console.log(items.length);
            var listnum = 1;
                while (listnum < items.length) {

   channellist.append({itemname:items[listnum].split('dir="ltr" title="')[1].split('"')[0].substring(0,45),
                        itemimage:"http:"+items[listnum].split('data-thumb="')[1].split('"')[0],
                        itemlink:"https://youtube.com/"+items[listnum].split('<a href="')[1].split('"')[0],
                        itemaddtion:items[listnum].split('<ul class="yt-lockup-meta-info">')[1].split("</ul>")[0].trim()

                   });
                    listnum = listnum +1;
                }
            }

        }

    }

    http.open('GET', url.trim(), true);
    http.send(null);
}

