function get_html(account) {

    var url = "https://www.twitter.com/" + account.split("::")[1]

    var http = new XMLHttpRequest()

    var pagedata = ""

    var profilepic = ""
    var profilebanner = ""

    var tweet2 = ""
    var tweet3 = ""

    var mission = ""

    var posts = ""

    twitterposts.clear()

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            pagedata = http.responseText

            if (http.responseText == "100") {
                console.log(http.responseText)
            } else if (http.responseText == "101") {
                console.log(http.responseText)
            } else {

                pagedata = http.responseText

                profilepic = pagedata.substring(
                            pagedata.search(
                                "https://pbs.twimg.com/profile_images/"),
                            (pagedata.search(
                                 "https://pbs.twimg.com/profile_images/") + 150))
                profilepic = profilepic.split('"')

                if (pagedata.search(
                            "https://pbs.twimg.com/profile_banners/") != -1) {
                    profilebanner = pagedata.substring(
                                pagedata.search(
                                    "https://pbs.twimg.com/profile_banners/"),
                                (pagedata.search(
                                     "https://pbs.twimg.com/profile_banners/") + 150))
                    profilebanner = profilebanner.split(")")
                    banner = profilebanner[0]
                }
                mission = pagedata.substring(
                            pagedata.search(
                                '<p class="ProfileHeaderCard-bio u-dir" dir="ltr">'),
                            pagedata.search(
                                '<div class="ProfileHeaderCard-location ">'))

                profilename = profilepic[2]
                missionstatment = mission
                avatar = profilepic[0]

                posts = pagedata.split('<div class="js-tweet-text-container">')
                var num = 1

                while (num < posts.length && num <= 5) {
                    var quote = ""
                    var tweet1 = ""
                    var image = ""
                    var type = "Tweet"

                    tweet1 = pagedata.split(
                                '<div class="js-tweet-text-container">')[num].split(
                                '<div class="stream-item-footer">')[0]

                    if (tweet1.search(
                                '<div class="QuoteTweet-originalAuthor') != -1) {
                        type = "Quote"
                        quote = tweet1.split(
                                    '<div class="QuoteTweet-authorAndText u-alignTop">')[1].split(
                                    '<div class="stream-item-footer">')[0]

                        tweet1 = tweet1.split("<a")[0]
                    }

                    if (tweet1.search(
                                '<div class="AdaptiveMedia-photoContainer js-adaptive-photo "')
                            != -1) {
                        type = "Image"
                        image = tweet1.split(
                                    'data-image-url="')[1].split('"')[0]
                        tweet1 = tweet1.split("<a")[0]
                    }

                    twitterposts.append({
                                            posttitle: type,
                                            aquote: quote,
                                            postimg: image,
                                            message: tweet1
                                        })

                    num = num + 1
                }
            }
        }
    }

    http.open('GET', url, true)
    http.send(null)
}
