function get_html(account) {

   // var url = "https://www.linkedin.com/in/"+account.split("::")[1];

   var url = "https://api.linkedin.com/v1/people/~"+account.split("::")[1];

    //console.log(url);

var http = new XMLHttpRequest();

    var pagedata = "";

http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;

            console.log("From linkedin.js"+pagedata);

            //banner = pagedata.split('"og:image" content="')[1].split('"/>')[0].trim();
            banner = "./img/overlay.svg"
            //console.log(thebanner);
            name = pagedata.split('<meta name="og:title" content="')[1].split("|")[0];
            avatar = "./img/linkedin.png";
            stats = pagedata.split('<div class="member-connections">')[1].split("</div>")[0];
            var currentplacement = pagedata.split('<p class="headline title" data-section="headline">')[1].split("</p>")[0];
            var locale = pagedata.split('<span class="locality">')[1].split("</span></dd><dt>")[0];
            var vocation = pagedata.split('<dd class="descriptor">')[1].split("</dd>")[0];
            info1 = currentplacement+"\n"+locale+" | "+vocation;


            var positions1 = pagedata.split('<tr data-section="currentPositionsDetails">')[1].split("</tr>")[0];
            var positions2 = pagedata.split('<tr data-section="pastPositionsDetails">')[1].split("</tr>")[0];
            var prepositions = positions2.split('<li>');
            var pp;
            var prenum = 1;
            while(prepositions.length > prenum) {
                if(pp == undefined) {
                    pp = prepositions[prenum].split("</li>")[0];
                } else {
                    pp = pp+" "+prepositions[prenum].split("</li>")[0];
                }
                prenum = prenum + 1;
            }
            var education = pagedata.split('<tr data-section="educationsDetails">')[1].split("</tr>")[0];
            var theducation = education.split('<li>');


            var scnum = 0;
            var sc;
            while(theducation.length > scnum) {
                    sc = theducation[scnum];
                scnum = scnum + 1;
            }


            info2 = "Current: <b>"+positions1.split('<span class="org">')[1].split("</span>")[0]+", "+positions1.split("<span>")[1].split("</span>")[0]
            +"</b><br>Previous: <b>"+pp+"</b><br><br>Education: <b>"+sc+"</b>";

            console.log("Info2: "+theinfo2);

            var exp = pagedata.split('<section id="experience" class="profile-section">')[1].split("</section>")[0];
            info3 = exp;


            var volexp = pagedata.split('<section id="volunteering" data-section="volunteering" class="profile-section">')[1].split("</section>")[0];


            info4 = volexp;

            var skills = pagedata.split('<section id="skills" data-section="skills" class="profile-section">')[1].split("</section>")[0];

            info5 = skills;
        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);


}

function get_articles(url) {


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


                var article_section = pagedata.split('<section id="posts" data-section="posts" class="profile-section">')[1].split('</section>')[0];
                //console.log(article_section);


                var article = article_section.split('<li class="post">');
                var artnum = 1;

                while(article.length > artnum) {
                articlelist.append({

                                title:article[artnum].split('title="')[1].split('"')[0].replace(/&quot;/g,'"'),
                                articleimg:article[artnum].split('data-delayed-url="')[1].split('"')[0],
                                link:article[artnum].split('<a href="')[1].split('"')[0]



                                   });
                 artnum = artnum + 1;
                }


            }

      }

}

http.open('GET', url.trim(), true);
http.send(null);

}
