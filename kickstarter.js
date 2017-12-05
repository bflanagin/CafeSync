function get_html(account) {

    var url = "http://www.kickstarter.com/"+account.split("::")[1];

var http = new XMLHttpRequest();

    var pagedata = "";
//console.log("From Kickstarter.js: "+url)
http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;


            //console.log("From kickstarter.js "+pagedata);
            banner = "./img/shade.png"
            //thebanner = pagedata.split('<div class="video-player" data-dimensions="{&quot;width&quot;:640,&quot;height&quot;:480}" data-image="')[1].split('"')[0];
            title =pagedata.split('<meta property="og:title" content="')[1].split('"/>')[0];
            pitch =pagedata.split('<meta property="og:description" content="')[1].split('"/>')[0];
            backers = pagedata.split('data-backers-count="')[1].split('"')[0];
            total = pagedata.split('data-pledged="')[1].split('"')[0];
            ammount = pagedata.split('data-goal="')[1].split('"')[0]+" "+pagedata.split('data-currency="')[1].split('"')[0];
            percent = pagedata.split('data-percent-raised="')[1].split('"')[0];
            daysleft = (pagedata.split('data-hours-remaining="')[1].split('"')[0] / 24);


        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}
