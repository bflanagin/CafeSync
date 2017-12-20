function get_html(account) {

    var url = "https://www.twitter.com/"+account.split("::")[1];

var http = new XMLHttpRequest();

    var pagedata = "";
//console.log("From twitter.js: "+url);

    var profilepic = "";
    var profilebanner = "";
    var tweet1 = "";
    var tweet2 = "";
    var tweet3 = "";
    var mission = "";
    var quote = "";

http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;


           profilepic = pagedata.substring(pagedata.search("https://pbs.twimg.com/profile_images/"),(pagedata.search("https://pbs.twimg.com/profile_images/") + 150));
           profilepic = profilepic.split('"')

            profilebanner = pagedata.substring(pagedata.search("https://pbs.twimg.com/profile_banners/"),(pagedata.search("https://pbs.twimg.com/profile_banners/") + 150));
            profilebanner = profilebanner.split(")");

            //tweet1 = pagedata.substring(pagedata.search('<p class="TweetTextSize'),pagedata.search('<p class="TweetTextSize') + 844);
            //tweet1 = tweet1.split("/p>")[0]+"/p>";

            tweet1 = pagedata.split('<div class="js-tweet-text-container">')[1].split('<div class="stream-item-footer">')[0];

            if(tweet1.search('<div class="QuoteTweet-originalAuthor') != -1) {

                quote = tweet1.split('<div class="QuoteTweet-authorAndText u-alignTop">')[1].split('<div class="stream-item-footer">')[0];
                quote = "<u>"+quote.split('<div class="QuoteTweet-originalAuthor u-cf u-textTruncate stream-item-header account-group js-user-profile-link">')[1].split('<div class="QuoteTweet-text tweet-text u-dir js-ellipsis"')[0]+"</u>"+"<br><br>"+quote.split('&quot;')[1].split('&quot;')[0];
                tweet1 = tweet1.split("<a")[0];
            }

            mission = pagedata.substring(pagedata.search('<p class="ProfileHeaderCard-bio u-dir" dir="ltr">'),pagedata.search('<div class="ProfileHeaderCard-location ">'));


            profilename = profilepic[2];
            banner = profilebanner[0];
            avatar = profilepic[0];
            aquote = quote;
            missionstatment = mission;

            message = tweet1;



        }

    }
}

http.open('GET', url, true);
http.send(null);




}
