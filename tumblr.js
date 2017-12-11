function get_html(account) {

    var url = "https://"+account.split("::")[1]+".tumblr.com/";

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

            banner = pagedata.substring(pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image='),pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image=') + 200).split('"')[5];

             name = pagedata.substring(pagedata.search('<h1 class="blog-title"><a href="/">'),pagedata.search(' <h1 class="blog-title"><a href="/">')+ 100).split(">")[2].split("<")[0];

            avatar = pagedata.substring(pagedata.search('class="user-avatar"><img src="'),pagedata.search('class="user-avatar"><img src="')+100).split('"')[3];

            message = pagedata.substring(pagedata.search('<span class="description">'),pagedata.search('<span class="description">') + 200).split(">")[1].split("</")[0].trim();

                var num = 1;
            while(pagedata.split('<article').length > num) {

         // postinfo = pagedata.substring(pagedata.search('<article'),pagedata.search('</article>'));
                postinfo = pagedata.split('<article')[num].split('</article>')[0];



                if(postinfo.search('<div class="video-wrapper">') != -1) {
                    //console.log("found a video");
                    tumblrposts.append({
                    posttitle:"",
                    postimage:"img/youtube.png",
                   post:postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"))
                    });

                } else {
                    if(postinfo.search('<div class="post-content">') != -1) {
                        tumblrposts.append({
                        posttitle:postinfo.substring(postinfo.search('<h2 class="title">'),postinfo.search('</h2>')).split(">")[2].split("<")[0],
                       post:postinfo.substring(postinfo.search('<p>'),postinfo.search('</p>'))
                                               });
                    } else {
                        if(postinfo.search('<div class="photo-wrapper">') != -1) {
                            tumblrposts.append({
                            posttitle:"",
                            //tmpostimage: postinfo.substring(postinfo.search('src="')+5,postinfo.search('" alt=')),
                             postimage: postinfo.split('<img src="')[1].split('" alt=')[0],
                           post:postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"))
                                        });
                        }
                    }
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
