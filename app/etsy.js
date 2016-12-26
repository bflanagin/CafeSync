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

            var shop = pagedata.split('<div class="shop-identity-section sis">')[1].split('<div class="button-fave-container">')[0];

            banner = shop.split("<img src='")[1].split("' width=")[0];
            name = shop.split('<span class="shopname wrap ">')[1].split("</span>")[0].trim();

            message =shop.split('<h2 class="shop-title">')[1].split('</h2>')[0].trim();



        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}

function storelist(url) {

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


    var items = pagedata.split('class="listing-card"');
        //console.log(items.length);
            var listnum = 1;
                while (listnum < items.length) {

    shoplist.append({itemname:items[listnum].split('title="')[1].split('"')[0].substring(0,45),
                        itemimage:items[listnum].split("<img src='")[1].split("'")[0],
                        itemlink:items[listnum].split('<a href="')[1].split('"')[0],
                        itemprice:items[listnum].split('<div class="listing-price">')[1].split("</div>")[0].trim()




                    });
                    listnum = listnum +1;
                }
            }

        }

    }

    http.open('GET', url.trim(), true);
    http.send(null);
}
