function get_html(account) {

    var url = "https://www.etsy.com/shop/"+account.split("::")[1];

var http = new XMLHttpRequest();

    var pagedata = "";
    var postinfo = "";

http.onreadystatechange = function() {
    if (http.readyState == 4) {

        //pagedata = http.responseText;

        if(http.responseText == 100) {
            console.log(http.responseText);

        } else if(http.responseText == 101) {
            console.log(http.responseText);

        } else {
          //  console.log(url);
            pagedata = http.responseText;
            //sitedata = pagedata;
          //  console.log(pagedata);

            //var shop = pagedata.split('<div class="shop-identity-section sis">')[1].split('<div class="button-fave-container">')[0];

            banner = pagedata.split('property="og:image"')[1].split('"')[1];
            //banner = "./img/overlay.svg";
            name = pagedata.split('property="og:title"')[1].split('"')[1].split("by")[1];

            message =pagedata.split('data-key="headline">')[1].split('</span>')[0].trim();



        }

    }

}

http.open('GET', url.trim(), true);
http.send(null);

return pagedata;
}

function storelist(account) {

    var url = "https://www.etsy.com/shop/"+account.split("::")[1];

    var http = new XMLHttpRequest();

        var pagedata = "";
        var postinfo = "";

    http.onreadystatechange = function() {
        if (http.readyState == 4) {

           // pagedata = http.responseText;

            if(http.responseText == 100) {
                console.log(http.responseText);

            } else if(http.responseText == 101) {
                console.log(http.responseText);

            } else {

                pagedata = http.responseText;
                //sitedata = pagedata;

                shoplist.clear();
    var items = pagedata.split('block-grid-item');
       // console.log(items.length);
            var listnum = 1;
                while (listnum < items.length && listnum < 10) {
                  // console.log(items[listnum].split('title="')[1].split('"')[0]);
                  // console.log(items[listnum].split('<img')[1].split('"')[1]);
                 //  console.log(items[listnum].split('href="')[1].split('"')[0]);
                  // console.log(items[listnum].split('<p class="n-listing-card__price text-gray  mt-xs-0 strong">')[1].split("</p>")[0].trim());

    shoplist.append({itemname:items[listnum].split('title="')[1].split('"')[0].substring(0,45),
                        itemimage:items[listnum].split('<img')[1].split('"')[1],
                        itemlink:items[listnum].split('href="')[1].split('"')[0],
                        itemprice:items[listnum].split("<span class='currency-value'>")[1].split("</span>")[0].trim()




                    });

                    listnum = listnum +1;
                }
            }

        }

    }

    http.open('GET', url.trim(), true);
    http.send(null);
}
