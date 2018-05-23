function get_account(account) {
    var url = "https://api.steemit.com/";
    var tosend = '{"jsonrpc":"2.0", "method":"follow_api.get_blog", "params":{"account":"'+account.split("@")[1]+'","start_entry_id":0,"limit":3}, "id":1}'
   // console.log(url);
    var http = new XMLHttpRequest();

    var pagedata = "";

    steemitposts.clear();

    http.onreadystatechange = function() {
        //console.log(http.getAllResponseHeaders());
        if (http.readyState == 4) {
           // console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == "100") {
                console.log("Incorrect DevID");
            } else if(http.responseText == "101") {
                console.log("Incorrect AppID");
            } else {
                pagedata =http.responseText;

                var contents =pagedata.split('{"comment":');



                banner = "../img/steemit-vector-icon.png";
                var num = 1;
                while(num < contents.length) {
                    var permlink =contents[num].split('"permlink":"')[1].split('","category":"')[0];
                    var parent =contents[num].split('"parent_permlink":"')[1].split('","title":"')[0];

                steemitposts.append({
                    posttitle:contents[num].split('"title":"')[1].split('","body":"')[0],
                    //postimage:pluginlogo,
                    //post:contents[num].split('"body":"')[1].split('","json_metadata')[0]
                      post:contents[num].split('"body":"')[1].slice(0,1000)+"...",
                      thelink:"https://steemit.com/"+parent+"/@"+account.split("@")[1]+"/"+permlink
                });

                    num = num + 1;
               }


            }

        }
    }
    http.open('POST', url.trim(), true);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/json");
    http.send(tosend);

}
