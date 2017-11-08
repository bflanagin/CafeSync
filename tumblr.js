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

            banner = pagedata.substring(pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image='),pagedata.search('<a href="/" class="header-image parallax cover " data-bg-image=') + 200).split('"')[5];

             name = pagedata.substring(pagedata.search('<h1 class="blog-title"><a href="/">'),pagedata.search(' <h1 class="blog-title"><a href="/">')+ 100).split(">")[2].split("<")[0];

            avatar = pagedata.substring(pagedata.search('class="user-avatar"><img src="'),pagedata.search('class="user-avatar"><img src="')+100).split('"')[3];

            message = pagedata.substring(pagedata.search('<span class="description">'),pagedata.search('<span class="description">') + 200).split(">")[1].split("</")[0].trim();

            postinfo = pagedata.substring(pagedata.search('<article'),pagedata.search('</article>'));

                if(postinfo.search('<div class="video-wrapper">') != -1) {
                    //console.log("found a video");
                    postimage="img/youtube.png";
                    post = postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"));
                } else {
                    if(postinfo.search('<div class="post-content">') != -1) {
                        posttitle = postinfo.substring(postinfo.search('<h2 class="title">'),postinfo.search('</h2>')).split(">")[2].split("<")[0];
                        post = postinfo.substring(postinfo.search('<p>'),postinfo.search('</p>'));
                    } else {
                        if(postinfo.search('<div class="photo-wrapper">') != -1) {
                            postimage = postinfo.substring(postinfo.search('src="')+5,postinfo.search('" alt='));
                            post = postinfo.substring(postinfo.search("<p>")+3,postinfo.search("</p>"));
                        }
                    }
                }
        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}
