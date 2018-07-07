function get_html(url) {

    var http = new XMLHttpRequest()

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText == "100") {
                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {

                userid = http.responseText

                return http.responseText
            }
        }
    }
    http.open('GET', url, true)
    http.send(null)
}
