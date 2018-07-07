function get_html(account) {

    var url = "https://www.etsy.com/shop/" + account.split("::")[1]

    var http = new XMLHttpRequest()

    var pagedata = ""
    var postinfo = ""

    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            if (http.responseText == "100") {
                console.log(http.responseText)
            } else if (http.responseText == "101") {
                console.log(http.responseText)
            } else {

                pagedata = http.responseText

                banner = pagedata.split('property="og:image"')[1].split('"')[1]

                name = pagedata.split('property="og:title"')[1].split(
                            '"')[1].split("by")[1]

                message = pagedata.split('data-key="headline">')[1].split(
                            '</span>')[0].trim()
            }
        }
    }

    http.open('GET', url.trim(), true)
    http.send(null)

    return pagedata
}

function storelist(account) {

    var url = "https://www.etsy.com/shop/" + account.split("::")[1]

    var http = new XMLHttpRequest()

    var pagedata = ""
    var postinfo = ""

    http.onreadystatechange = function () {
        if (http.readyState == 4) {


            if (http.responseText == "100") {
                console.log(http.responseText)
            } else if (http.responseText == "101") {
                console.log(http.responseText)
            } else {

                pagedata = http.responseText

                shoplist.clear()
                var items = pagedata.split('block-grid-item')

                var listnum = 1
                while (listnum < items.length && listnum < 10) {

                    shoplist.append({
                                        itemname: items[listnum].split(
                                            'title="')[1].split(
                                            '"')[0].substring(0, 45),
                                        itemimage: items[listnum].split(
                                            '<img')[1].split('"')[1],
                                        itemlink: items[listnum].split(
                                            'href="')[1].split('"')[0],
                                        itemprice: items[listnum].split(
                                            "<span class='currency-value'>")[1].split(
                                            "</span>")[0].trim()
                                    })

                    listnum = listnum + 1
                }
            }
        }
    }

    http.open('GET', url.trim(), true)
    http.send(null)
}
