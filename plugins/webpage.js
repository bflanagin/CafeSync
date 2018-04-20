function get_html(account) {

    var url = "http://"+account.split("::")[1];

var http = new XMLHttpRequest();

    var pagedata = "";
//console.log("From webpage.js: "+url)
    var profilepic = "";
    var profilebanner = "";

    rssposts.clear();


http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;

            if(pagedata.length == 0) {

                theavatar = "../img/overlay-dark.png";
                thebanner = "../img/overlay-dark.png";
                banner = thebanner;

                rssposts.append({
                             thepostimage:"",
                             thepost:qsTr("Something is wrong with this site. Either the url is incorrect, or the host doesn't believe in the free exchange of information and is blocking CafeSync for some reason. It still may be possible to visit the site if you long press anywhere within this post.\
Please consider submitting a bug by long pressing the post below, if the url is indeed correct. "),
                             theposttitle:qsTr("Error connecting."),
                             thelink:url

                    });

                rssposts.append({
                             thepostimage:"",
                             thepost:qsTr("Long pressing on this post will send you to our github page. Please add url causing the issue to the bug. And thank you for making CafeSync better."),
                             theposttitle:qsTr("Bug Report for "+url+"."),
                             thelink:"https://github.com/OpenSeedINC/CafeSync/issues/new"

                    });
                rssposts.append({
                             thepostimage:"",
                             thepost:qsTr("Just encase I didn't say long press enough, I think you should try long pressing one of the posts above."),
                             theposttitle:qsTr("LONG PRESS "+url+"."),
                             thelink:""

                    });

            } else {

            var feed = pagedata.search(/feed/i);
            var rss = pagedata.search(/rss/i);
            var rssalt = pagedata.search('<rss xmlns');
            var medsearch = pagedata.search('medium.com');

            if(rss !=-1 || rssalt !=-1 || medsearch !=-1 || feed !=-1) {

                hasrss = 1;


                if(rss !=-1 || feed !=-1) {


                    var link = pagedata.substring(rss,rss+800).split('href="')[1].split('"')[0];

                    if(link.startsWith("/") == true) {

                     link =url.split("/")[0]+"//"+url.trim().split("/")[2]+link;
                    }
                        if(url.search("deviantart.com") != -1) {

                                     profilebanner = pagedata.substring(pagedata.search('<div id="site-header">'),pagedata.search('</div>'));
                                    thebanner = profilebanner.split('<img src="')[1].split('"')[0];
                                    theavatar = "../img/deviantart.png"
                                    rss_reader2(link);
                        } else if(url.search("medium.com") != -1){
                                theavatar = "../img/medium.png"
                                rss_medium(link);


                          } else {
                                   //  profilebanner = pagedata.substring(pagedata.search('<div id="site-header">'),pagedata.search('</div>'));
                                      //  if(profilebanner != 'undefined') {
                                       //         thebanner = profilebanner.split('<img src="')[1].split('"')[0];
                                      //  } else {
                                            thebanner = "../img/overlay-dark.png";
                                      //  }

                                    banner = thebanner;


                                theavatar = "../img/wordpress.png";

                                 avatar = theavatar;

                                theurl = link;
                                rss_reader1(link);
                            }
                }

                if(rssalt !=-1) {
                    rss_reader3(pagedata);

                }

                if(medsearch !=-1) {
                    var tomedium = pagedata.substring(pagedata.search('https://medium.com/'),pagedata.search('https://medium.com/')+100).split('"><')[0];
                        theavatar = "../img/medium.png"
                        get_html(tomedium);
                        //thebanner = tomedium;
                }

               /* if(feed !=-1) {

                } */


            } else { hasrss = 0;}
        }

        }

    }
}

http.open('GET', url.trim(), true);
http.send(null);

}


function rss_reader1(url) {

    var http = new XMLHttpRequest();

        var pagedata = "";
        var num = 1;

    loading_info.text ="From webpage.js[RRS reader 1]: "+url;

    http.onreadystatechange = function() {
        if (http.readyState == 4) {

            pagedata = http.responseText;

            if(http.responseText == 100) {
                console.log(http.responseText);

            } else if(http.responseText == 101) {
                console.log(http.responseText);

            } else {

                pagedata = http.responseText;

                var topblock = pagedata.substring(pagedata.search("<channel>"),pagedata.search("<item>"));

                thename = topblock.split("<title>")[1].split("</title>")[0].replace(/&#039;/g,"'").replace(/&#8217;/g,"'").replace(/&#38;/g,"&");

                name = thename;

                if(topblock.search("<description>") !=-1) {
                themessage = topblock.split("<description>")[1].split("</description>")[0].replace(/&#039;/g,"'").replace(/&#8217;/g,"'").replace(/&#38;/g,"&");
                }
                message = themessage;

                var allposts = pagedata.split("<item>");
                 postcount = allposts.length;

                loading_info.text = thename+"\n"+themessage+"\n"+postcount;

                while(allposts.length > num && num <= 5) {
                    var imagegetter = "";
                var post = allposts[num].substring(0,allposts[num].search("</item>"));




                //var post = pagedata.substring(pagedata.search("<item>"),pagedata.search("</item>"));
                    var mthelink = post.split('<link>')[1].split('</link>')[0];
                    var mtheposttitle = post.split("<title>")[1].split("</title>")[0];
                    var mthepost = "";
                    if(post.search("CDATA") != -1) {
                    mthepost = post.split("<description><![CDATA[")[1].split("]]></description>")[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                    } else {
                        mthepost = post.split("<description>")[1].split("</description>")[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                    }
                    if(post.search("<image>") !=-1) {
                        imagegetter = post.split("<image>")[1].split("</image>")[0].split("<url>")[1].split("</url>")[0];
                    } else {
                        imagegetter = findimage(mthelink);
                    }

                rssposts.append({
                             thepostimage:imagegetter,
                             thepost:mthepost,
                             theposttitle:mtheposttitle,
                             thelink:mthelink

                    });
    num = num + 1;
    }

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

    function rss_reader3(pagedata) {

                    thebanner = "../img/overlay-dark.png";
                    var topblock = pagedata.substring(pagedata.search("<channel>"),pagedata.search("<generator>"));

                    thename = topblock.split("<title><![CDATA[")[1].split("]]></title>")[0];
                    themessage = topblock.split("<description><![CDATA[")[1].split("]]></description>")[0];

                    var post = pagedata.substring(pagedata.search("<item>"),pagedata.search("</item>"));
                         thelink = post.split('<link>')[1].split('</link>')[0];
                        theposttitle = post.split("<title><![CDATA[")[1].split("]]></title>")[0];
                        thepost = post.split('<content:encoded><![CDATA[')[1].split(']]></content:encoded>')[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                    var imagegetter = post.split('<img alt="" src="')[1].split('" />')[0].trim();

                        thepostimage = imagegetter;
                }



function rss_medium(url) {

    var http = new XMLHttpRequest();

        var pagedata = "";

        var num = 1;

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

                thebanner = "../img/overlay-dark.png";
                var topblock = pagedata.substring(pagedata.search("<channel>"),pagedata.search("<generator>"));

                thename = topblock.split("<title><![CDATA[")[1].split("]]></title>")[0];
                themessage = topblock.split("<description><![CDATA[")[1].split("]]></description>")[0];

                var allposts = pagedata.split("<item>");

                postcount = allposts.length;
                while(allposts.length > num && num <= 5) {
                    var imagegetter = "";
                var post = allposts[num].substring(0,allposts[num].search("</item>"));
                     var mthelink = post.split('<link>')[1].split('</link>')[0];
                    var mtheposttitle = post.split("<title><![CDATA[")[1].split("]]></title>")[0];

                        var mthepost = post.search('<description>');
                        if (post.search('<content:encoded>') !=-1) {
                                imagegetter = post.split('<img alt="" src="')[1].split('"')[0].trim();
                                mthepost = post.split('<content:encoded><![CDATA[')[1].split(']]></content:encoded>')[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'");
                                mthepost = "<br>"+mthepost.replace(/&#x2014;/g,",").replace(/&#x2019;/g,"'").replace(/&#x2026;/g,"!").substring(imagegetter.length+29);


                   }else if (post.search('<description>') !=-1) {
                            var discript = post.split('<description><![CDATA[')[1].split(']]></description>')[0].replace(/&#8230;/g,"...").replace(/&#039;/g,"'").replace(/&#8217;/g,"'").replace(/&#x2014;/g,",").replace(/&#x2019;/g,"'");
                        mthepost = discript.split('</a></p><p class="medium-feed-snippet">')[1].split("</p>")[0].replace(/&#x2026;/g,"!");
                            imagegetter = post.split('<img src="')[1].split('"')[0].trim();
                    }



                   // thepostimage = imagegetter;

                        rssposts.append({
                                     thepostimage:imagegetter,
                                     thepost:mthepost,
                                     theposttitle:mtheposttitle,
                                     thelink:mthelink

                            });
            num = num + 1;
            }

            }

        }
    }

    http.open('GET', url.trim(), true);
    http.send(null);

    }







function findimage(url) {

    var http = new XMLHttpRequest();

        var pagedata = "";

        var num = 1;


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
               // console.log(pagedata);

                var getimage = pagedata.split('<img width="672" height="372" src="')[1].split('"')[0];

                return getimage;
            }
        }
       }

        http.open('GET', url.trim(), true);
        http.send(null);

        }

