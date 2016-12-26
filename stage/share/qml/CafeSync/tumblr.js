function get_html(url) {

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

            console.log(pagedata);

            banner = pagedata.substring(pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image='),pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image=') + 200).split('"')[5];

             name = pagedata.substring(pagedata.search('<h1 class="blog-title"><a href="/">'),pagedata.search(' <h1 class="blog-title"><a href="/">')+ 100).split(">")[2].split("<")[0];

            avatar = pagedata.substring(pagedata.search('class="user-avatar"><img src="'),pagedata.search('class="user-avatar"><img src="')+100).split('"')[3];

            message = pagedata.substring(pagedata.search('<span class="description">'),pagedata.search('<span class="description">') + 200).split(">")[1].split("</")[0].trim();

            postinfo = pagedata.split('<article')[1].split('</article>')[0];

                if(postinfo.search('<div class="video-wrapper">') != -1) {
                    //console.log("found a video");
                    postimage="img/youtube.png";
                     post = postinfo.split("<p>")[1].split("</p>")[0];
                } else {
                    if(postinfo.search('<div class="post-content">') != -1) {
                        //console.log("found a post");
                        posttitle = postinfo.substring(postinfo.search('<h2 class="title">'),postinfo.search('</h2>')).split(">")[2].split("<")[0];

                         post = postinfo.split("<p>")[1].split("</p>")[0];
                    } else {

                        if(postinfo.search('<div class="photo-wrapper">') != -1) {
                            //console.log("found a photo");

                            postimage = postinfo.split('src="')[1].split('" alt=')[0];
                            post = postinfo.split("<p>")[1].split("</p>")[0];
                           // console.log(post);
                        }
                    }
                }
        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);


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
