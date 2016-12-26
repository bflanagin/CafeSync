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


                if(url.search("deviantart.com") != -1) {
                    theavatar = "img/deviantart.png"
                        hasrss = 2;
               rss_reader2(link);
                } else {
                    theavatar = "/usr/share/icons/suru/actions/scalable/stock_website.svg"
                        hasrss = 1;
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

   // console.log("From webpage.js[RRS reader 1]: "+url)

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



                if(post.search("<itunes:summary>") != -1) {

                    thepost = post.split("<itunes:summary><![CDATA[")[1].split("]]></itunes:summary>")[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                } else {

                if(post.search("<description>") != -1) {

                    thepost = post.split("<description><![CDATA[")[1].split("]]></description>")[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");

                }



                }

                thepostimage = post.split('<media:thumbnail url="')[1].split('" />')[0];


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

function all_posts(url) {

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

            var posts = pagedata.split('<article');
            var listnum = 1;


            while(listnum < posts.length) {

                var image = "";
                var tpost = "";
                var tposttitle = "";

           // postinfo = pagedata.substring(pagedata.search('<article'),pagedata.search('</article>'));

                if(posts[listnum].search('<div class="video-wrapper">') != -1) {
                    //console.log("found a video");
                   image="img/youtube.png";
                    tpost = posts[listnum].substring(posts[listnum].search("<p>")+3,posts[listnum].search("</p>"));

                } else {
                    if(posts[listnum].search('<div class="post-content">') != -1) {
                        //console.log("found a post");
                      tposttitle = posts[listnum].substring(posts[listnum].search('<h2 class="title">'),posts[listnum].search('</h2>')).split(">")[2].split("<")[0];
                        tpost = posts[listnum].substring(posts[listnum].search('<p>'),posts[listnum].search('</p>'));
                    } else {

                        if(posts[listnum].search('<div class="photo-wrapper">') != -1) {
                            //console.log("found a photo");

                          image = posts[listnum].substring(posts[listnum].search('src="')+5,posts[listnum].search('" alt='));
                            tpost = posts[listnum].substring(posts[listnum].search("<p>")+3,posts[listnum].search("</p>"));
                        }
                    }
                }

                channellist.append ({
                   itemimage:image,
                   itemname:tposttitle,
                   itemaddition:tpost

                 });

                listnum = listnum +1;

                }
        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

}
