function get_html(url) {

var http = new XMLHttpRequest();

    var pagedata = "";
//console.log("From gofundme.js: "+url)
http.onreadystatechange = function() {
    if (http.readyState == 4) {

        pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {

            pagedata = http.responseText;




            banner = pagedata.split('<meta property="og:image:secure_url" content="')[1].split('"')[0];
            title = pagedata.split('<title>')[1].split('</title>')[0].split('- GoFundMe')[0];
            pitch = pagedata.split('<meta property="og:description" content="')[1].split('"/>')[0];
            var numbers = pagedata.split('<div class="raised ">')[1].split("</div>")[0];
            //console.log("From gofundme.js"+numbers);
            ammount = pagedata.split('<span class="cur ">')[1].split('</span>')[0]+pagedata.split('</span>')[1].split('<span')[0];
            total = pagedata.split('<span class="goal">')[1].split('</span>')[0];

            percent = pagedata.split('<div class="bar">')[1].split('</div>')[0].split('style="width:')[1].split('%')[0];

        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}
