function get_html(url) {

var http = new XMLHttpRequest();

    var pagedata = "";
//console.log("From webpage.js: "+url)
    var profilepic = "";
    var profilebanner = "";


http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;

            //console.log(pagedata);
            var rss = pagedata.search('<link rel="alternate"');

            if(rss !=-1) {
                profilebanner = pagedata.substring(pagedata.search('<div id="site-header">'),pagedata.search('</div>'));
                thebanner = profilebanner.split('<img src="')[1].split('"')[0];

                var link = pagedata.substring(rss,rss+800).split('href=')[1].split('"')[1];
                hasrss = 1;

                if(url.search("deviantart.com") != -1) {
                    theavatar = "img/deviantart.png"
                 rss_reader2(link);
                } else {
                    theavatar = "img/wordpress.png"
                rss_reader1(link);
                }

            } else { hasrss = 0;}
        }

    }
}

http.open('GET', url.trim(), true);
http.send(null);

}

function rss_reader1(url) {

    var http = new XMLHttpRequest();

        var pagedata = "";

    //console.log("From webpage.js[RRS reader 1]: "+url)

    http.onreadystatechange = function() {
        if (http.readyState == 4) {

            pagedata = http.responseText;

            if(http.responseText == 100) {
                console.log(http.responseText);

            } else if(http.responseText == 101) {
                console.log(http.responseText);

            } else {

                pagedata = http.responseText;



                var topblock = pagedata.substring(pagedata.search("<channel>"),pagedata.search("<generator>"));

                thename = topblock.split("<title>")[1].split("</title>")[0];
                themessage = topblock.split("<description>")[1].split("</description>")[0].replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                var post = pagedata.substring(pagedata.search("<item>"),pagedata.search("</item>"));
                    thelink = post.split('<link>')[1].split('</link>')[0];
                    theposttitle = post.split("<title>")[1].split("</title>")[0];
                    thepost = post.split("<description><![CDATA[")[1].split("]]></description>")[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");

            }

        }
    }

    http.open('GET', url.trim(), true);
    http.send(null);

    }


function rss_reader2(url) {

    var http = new XMLHttpRequest();

        var pagedata = "";

    //console.log("From webpage.js[RRS reader 2]: "+url)

    http.onreadystatechange = function() {
        if (http.readyState == 4) {

            pagedata = http.responseText;

            if(http.responseText == 100) {
                console.log(http.responseText);

            } else if(http.responseText == 101) {
                console.log(http.responseText);

            } else {

                pagedata = http.responseText;



                var topblock = pagedata.substring(pagedata.search("<channel>"),pagedata.search("<generator>"));

                thename = topblock.split("<title>")[1].split("</title>")[0].split("/")[0].split(":")[1];
                themessage = topblock.split("<description>")[1].split("</description>")[0].replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                var post = pagedata.substring(pagedata.search("<item>"),pagedata.search("</item>"));
                     thelink = post.split('<link>')[1].split('</link>')[0];
                    theposttitle = post.split("<title>")[1].split("</title>")[0];
                    thepost = post.split('<media:description type="html">')[1].split('</media:description>')[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                var imagegetter = post.substring(post.search("300x200")-200,post.search("300x200")+200).split('<media:thumbnail url="')[1].split('" height')[0];

                    thepostimage = imagegetter;
            }

        }
    }

    http.open('GET', url.trim(), true);
    http.send(null);

    }

function findimage(url) {


}
