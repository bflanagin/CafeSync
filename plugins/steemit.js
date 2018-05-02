function get_html(account) {

    var url = "https://steemit.com/"+account.split("::")[1];
    console.log(url);

    steemitposts.clear();

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
            console.log(pagedata);

            if(pagedata.search("header-image") != -1) {

            banner = pagedata.substring(pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image='),pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image=') + 200).split('"')[5];

            } else {banner = "../img/overlay-dark.png";}

            if(pagedata.search('{\"name\":\"') != -1) {
            name = pagedata.split('{\"name\":\"')[1].split('\",\"')[0];

            } else {
                name = pagedata.split('<meta name="description" content="')[1].split('.')[0];
            }

            if(pagedata.search('\"profile_image\":\"') != -1) {
            avatar = pagedata.split('\"profile_image\":\"')[1].split('\",\"')[0];
            } else {
            avatar = pagedata.split('property="og:image" content="')[1].split('" />')[0].trim();
            }
            if(pagedata.search('\"about\":\"') != -1) {
            message = "<p>"+pagedata.split('\"about\":\"')[1].split('\",\"')[0];
            } else {
             message = "<p>"+pagedata.split('<meta name="description" content="')[1].split('.')[2]+"</p>";
            }
                var num = 1;
                var posts;
            if(pagedata.search('<h2 class="articles__h2 entry-title"') != -1) {
                posts = pagedata.split('<h2 class="articles__h2 entry-title"');
            } else {
                posts = pagedata.split('<div class="post">');
            }

            postcount = posts.length;


            while(posts.length > num && num <= 5) {

         // postinfo = pagedata.substring(pagedata.search('<article'),pagedata.search('</article>'));
                 if(posts[num].search('</h2>') != -1) {
                        postinfo = posts[num].split('</h2')[0];
                    } else {
                     postinfo = posts[num].split('</div><!-- end .post -->')[0];
                 }


                if(postinfo.search('<div class="video-wrapper">') != -1) {
                    //console.log("found a video");
                    steemitposts.append({
                    posttitle:"",
                    postimage:"img/youtube.png",
                   post:postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"))
                    });

                } else if(postinfo.search('<div class="post-content">') != -1) {
                        steemitposts.append({
                        posttitle:postinfo.substring(postinfo.search('<h2 class="title">'),postinfo.search('</h2>')).split(">")[2].split("<")[0],
                       post:postinfo.substring(postinfo.search('<p>'),postinfo.search('</p>'))
                                               });
                    } else if(postinfo.search('<div class="photo-wrapper">') != -1) {
                            steemitposts.append({
                            posttitle:"",
                            //tmpostimage: postinfo.substring(postinfo.search('src="')+5,postinfo.search('" alt=')),
                             postimage: postinfo.split('<img src="')[1].split('" alt=')[0],
                           post:postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"))
                                        });
                        } else if (postinfo.search('<div class="media_post photo_post">') != -1) {

                            if(postinfo.search("photoset") == -1) {
                            steemitposts.append({
                                posttitle:"",
                                postimage:postinfo.split('<img src="')[1].split('"')[0],
                                post: postinfo.split('<div class="credit">')[1].split('</div><!-- end .credit -->')[0]

                                               });
                            } else {
                                steemitposts.append({
                                    posttitle:"Photo Set",
                                    postimage:pluginlogo,
                                    post: "Photo Sets aren't support...Yet"

                                                   });
                            }

                        } else if(postinfo.search('<div class="quote_post">') != -1) {

                                steemitposts.append({
                                        posttitle:"Quote",
                                        postimage:"",
                                        post:postinfo.split('<div class="quote_post"><span>&ldquo;</span>')[1].split('</div>')[0]+"<br><br>"+postinfo.split('<div class="body">')[1].split('</div>')[0],
                                            });

                            } else {

                                steemitposts.append({
                                    posttitle:"post "+num,
                                    postimage:pluginlogo,
                                    post:postinfo.split('<div class=')[1].split('>')[0]
                                });

                                }


                num = num +1;
            }
        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}
