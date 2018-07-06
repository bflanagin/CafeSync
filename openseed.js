
function oseed_auth(name, email, passphrase) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authPOST.php"

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === 100) {
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {
                userid = http.responseText
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&username=" + name
              + "&email=" + email + "&passphrase=" + passphrase)
}

function heartbeat() {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/heartbeat.php"
    http.onreadystatechange = function () {

        if (http.readyState == 4) {
            if (http.responseText === "100") {
                console.log("Incorrect DevID")
            } else if (http.responseText === "101") {
                console.log("Incorrect AppID")
            } else {

                heart = http.responseText
                updateinterval = 5500

            }
        }

        if (heart == "OffLine") {
            updateinterval = 500 + updateinterval

        }
        heartbeats.interval = updateinterval
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&userid=" + userid)
}

function checkcreds(field, info) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/authCHECK.php"
    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === 100) {
                uniquemail = 100
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {

                uniquemail = 101
                console.log("Incorrect AppID")
            } else {

                if (field === "email") {
                    uniquemail = http.responseText
                }
                if (field === "username") {
                    uniquename = http.responseText
                }

                if (field === "account") {
                    uniqueaccount = http.responseText
                }

                if (field === "passphrase") {
                    uniqueid = http.responseText
                }
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&type=" + field + "&info=" + info)
}

function datasync(id, cnum) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/sync.php?id=" + id
    var carddata = ""

    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            carddata = http.responseText
            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {

                carddata = http.responseText

                var cid = carddata.substring(carddata.search("<id>") + 4,
                                             carddata.search("</id>"))
                var cardnum = carddata.substring(carddata.search(
                                                     "<cardid>") + 8,
                                                 carddata.search("</cardid>"))
                var name = carddata.substring(carddata.search("<name>") + 6,
                                              carddata.search("</name>"))
                var phone = carddata.substring(carddata.search("<phone>") + 7,
                                               carddata.search("</phone>"))

                var email = carddata.substring(carddata.search("<email>") + 7,
                                               carddata.search("</email>"))
                var company = carddata.substring(carddata.search(
                                                     "<company>") + 9,
                                                 carddata.search("</company>"))
                var alias = carddata.substring(carddata.search("<alias>") + 7,
                                               carddata.search("</alias>"))
                var motto = carddata.substring(carddata.search("<motto>") + 7,
                                               carddata.search("</motto>"))

                var send = carddata.substring(carddata.search("<send>") + 6,
                                              carddata.search("</send>"))
                var usealias = carddata.substring(
                            carddata.search("<usealias>") + 10,
                            carddata.search("</usealias>"))
                var contact = carddata.substring(carddata.search(
                                                     "<contact>") + 9,
                                                 carddata.search("</contact>"))

                var main = carddata.substring(carddata.search("<main>") + 6,
                                              carddata.search("</main>"))
                var link1 = carddata.substring(carddata.search("<link1>") + 7,
                                               carddata.search("</link1>"))
                var link2 = carddata.substring(carddata.search("<link2>") + 7,
                                               carddata.search("</link2>"))
                var link3 = carddata.substring(carddata.search("<link3>") + 7,
                                               carddata.search("</link3>"))
                var link4 = carddata.substring(carddata.search("<link4>") + 7,
                                               carddata.search("</link4>"))

                var avatar = carddata.substring(carddata.search(
                                                    "<avatar>") + 8,
                                                carddata.search("</avatar>"))
                var cardbk = carddata.substring(carddata.search(
                                                    "<cardbk>") + 8,
                                                carddata.search("</cardbk>"))
                var cardcat = carddata.substring(carddata.search(
                                                     "<cardcat>") + 9,
                                                 carddata.search("</cardcat>"))
                var cardsav = carddata.substring(carddata.search(
                                                     "<cardsav>") + 9,
                                                 carddata.search("</cardsav>"))
                var cardtem = carddata.substring(carddata.search(
                                                     "<cardtem>") + 9,
                                                 carddata.search("</cardtem>"))
                var cardsop = carddata.substring(carddata.search(
                                                     "<cardsop>") + 9,
                                                 carddata.search("</cardsop>"))

                if (cid.length > 4) {

                    if (cnum === 0) {
                        usercardNum = cardnum
                        username = name.replace(/&#x27;/g, "'")
                        userphone = phone
                        useremail = email
                        usercompany = company.replace(/&#x27;/g, "'")
                        usercat = cardcat
                        useralias = alias
                        usermotto = motto.replace(/&#x27;/g, "'")

                        usermain = main
                        website1 = link1
                        website2 = link2
                        website3 = link3
                        website4 = link4
                        avimg = avatar
                        carddesign = cardbk

                        stf = torf(send)
                        atf = torf(usealias)
                        ctf = torf(contact)

                        if (firstrun.state == "Active") {
                            firstrun.state = "InActive"
                        }
                        syncandsave.start()
                        connections(usercardNum)
                    }
                }

                if (cardsop === 2) {

                } else {

                }
            }
        }
    }
    http.open('GET', url.trim(), true)
    http.send(null)
}

function upload_data(Id, name, phone, email, company, ali, motto, send, ua, sc, main, l1, l2, l3, l4, av, cardback, cardcat, cardsav, cardtem, cardsop) {

    console.log("uploading data")

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/addcardPOST.php"

    if (av.split("/")[0] === "file:") {
        var test = av.split("/")
        var last = av.split("/")[test.length - 1]
        var dataStr = "SELECT * FROM `LIBRARY` WHERE file = '" + last + "'"

        db.transaction(function (tx) {
            var base64 = ""

            var pull = tx.executeSql(dataStr)

            if (pull.rows.length !== 0) {
                base64 = pull.rows.item(0).base64
                av = base64.toString().replace(/+/g, " ")
            }
        })
    }


    //console.log(send,ua,sc);
    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {
                console.log(http.responseText)
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("id=" + Id + "&name=" + name + "&phone=" + phone + "&email=" + email
              + "&company=" + company + "&alias=" + ali + "&motto=" + motto + "&send=" + send
              + "&ua=" + ua + "&sc=" + sc + "&main=" + main + "&l1=" + l1
              + "&l2=" + l2 + "&l3=" + l3 + "&l4=" + l4 + "&avatar=" + av
              + "&cardback=" + cardback + "&cardcat=" + cardcat
              + "&cardsav=" + cardsav + "&cardtem=" + cardtem + "&cardsop=" + cardsop)

    gc()
}

function retrieve_data(id) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/updateloc.php"
    var carddata = ""
    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            carddata = http.responseText

            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {
                if (tempc != http.responseText) {
                    tempc = http.responseText
                }
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&id=" + id + "&cords=" + currentcords)

    gc()
}

function torf(num) {
    if (num === 0) {
        return ("false")
    } else {
        return ("true")
    }
}

function sync_cards(id, opt) {
    var http = new XMLHttpRequest()
    var url
    var carddata = ""
    var dataStr = "SELECT * FROM SavedCards WHERE 1"

    db.transaction(function (tx) {

        var pull = tx.executeSql(dataStr)
        var record = 0
        while (pull.rows.length > record) {
            // console.log(pull.rows.item(record).id);
            if (cardsyncsaved.search(pull.rows.item(record).id) == -1) {
                cardsyncsaved = pull.rows.item(record).id + "," + cardsyncsaved
            }
            record = record + 1
        }
    })

    var dataStrt = "SELECT * FROM TempCards WHERE 1"
    db.transaction(function (tx) {

        var pull = tx.executeSql(dataStr)
        var record = 0
        while (pull.rows.length > record) {
            if (cardsynctemp.search(pull.rows.item(record).id) == -1) {
                cardsynctemp = pull.rows.item(record).id + "," + cardsynctemp
            }
            record = record + 1
        }
    })

    if (remotesaved.length < cardsyncsaved.length) {
        if (opt === 2) {

            url = "https://openseed.vagueentertainment.com:8675/devs/" + devId
                    + "/" + appId + "/scripts/updatecards.php?id=" + id
                    + "&cardsav=" + cardsyncsaved + "&cardtem=" + cardsynctemp
        } else {

            url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId
                    + "/scripts/updatecards.php?id=" + id + "&cardsav=" + cardsyncsaved
        }

        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {

                }
            }
        }
        http.open('GET', url, true)
        http.send(null)
    }

    if (cardsyncsaved.length < remotesaved.length) {

        //console.log("Syncing local saved cards");
        var cardlist = remotesaved.split(",")
        var num = 0

        while (cardlist[num].length > 0) {
            update_card(cardlist[num], "saved")
            num = num + 1
        }
    }

    if (opt === 3) {

        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/updatecards.php?id=" + id + "&cardsav=" + cardsyncsaved

        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {

                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
    }

    gc()
}

function get_list(id, list) {

    var http = new XMLHttpRequest()
    var url = ""
    var carddata = ""

    switch (list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/getlists.php?id=" + id + "&list=" + list
        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    remotesaved = carddata
                    sync_cards(userid, 0)
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    case "temp":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/getlists.php?id=" + id + "&list=" + list
        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    remotetemp = carddata
                    var tnum = 0
                    while (remotetemp.split(",")[tnum].length >= tnum) {
                        if (remotetemp.split(",")[tnum] !== "") {
                            check_for_update(remotetemp.split(",")[tnum], list)
                            justpulled = tnum
                        }
                        tnum = tnum + 1
                    }
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    case "region":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/getlists.php?id=" + id + "&list=" + list
        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    remotetemp = carddata
                    var tnum = 0
                    while (remotetemp.split(",")[tnum].length >= tnum) {
                        if (remotetemp.split(",")[tnum] !== "") {
                            check_for_update(remotetemp.split(",")[tnum], list)
                            justpulled = tnum
                        }
                        tnum = tnum + 1
                    }
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    case "global":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/getlists.php?id=" + id + "&list=" + list
        carddata = ""
        console.debug(url)
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText
                if (http.responseText == "100") {
                    console.log("Incorrect DevID")
                } else if (http.responseText == "101") {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    remotetemp = carddata
                    var tnum = 0
                    while (remotetemp.split(",")[tnum] !== null) {
                        if (remotetemp.split(",")[tnum] !== "") {
                           check_for_update(remotetemp.split(",")[tnum], list)
                            justpulled = tnum
                        }
                        tnum = tnum + 1
                    }
                    cardload.running = true
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    }
}

function check_for_update(id, list) {
    gc()

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/lastupdated.php?id=" + userid + "&cid=" + id

    var thelist = "TempCard"

    switch (list) {
    case "temp":
        thelist = "TempCards"
        break
    case "region":
        thelist = "RegCards"
        break
    case "global":
        thelist = "GlobCards"
        break
    case "saved":
        thelist = "SavedCards"
        break
    default:
        thelist = "TempCards"
        break
    }

    //console.log(url);
    var updateIt = 0
    if (id !== 'undefined') {

        var carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText

                    db.transaction(function (tx) {

                        var testStatupdated = "SELECT data FROM Stats WHERE id= '"
                                + id + "' AND name = 'updated'"
                        var testExist = "SELECT id FROM `" + thelist + "` WHERE id= '" + id + "'"

                        var pull = tx.executeSql(testStatupdated)
                        var epull = tx.executeSql(testExist)

                        if (epull.rows.length === 1) {
                            if (pull.rows.length === 1) {
                                if (pull.rows.item(0).data === carddata) {
                                    updateIt = 0
                                } else {
                                    updateIt = 1

                                    if (usercardNum !== id) {
                                        notification1.visible = true
                                        notification1.themessage = "Updating card!"
                                        update_card(id, list)
                                    }
                                }
                            } else {
                                updateIt = 2
                                if (usercardNum !== id) {

                                    update_card(id, list)
                                }
                            }
                        } else {
                            updateIt = 3

                            if (usercardNum !== id) {
                                update_card(id, list)
                            }
                        }
                    })
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
    }

    return updateIt
}

function update_card(id, list) {

    gc()
    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/updatecard.php?id=" + userid + "&cid=" + id + "&list=" + list
    var carddata = ""
    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            carddata = http.responseText

            if (http.responseText == "100") {

                console.log("Incorrect DevID")
            } else if (http.responseText == "101") {
                console.log("Incorrect AppID")
            } else {

                var cardpos = carddata.split(";&;")

                var cid = cardpos[0]
                var name = cardpos[1]
                var phone = cardpos[2]

                var email = cardpos[3]
                var company = cardpos[4]
                var calias = cardpos[5]
                var motto = cardpos[6]

                var main = cardpos[7]
                var link1 = cardpos[8]
                var link2 = cardpos[9]
                var link3 = cardpos[10]
                var link4 = cardpos[11]

                var avatar = cardpos[12]
                var cardbk = cardpos[13]
                var cardcat = cardpos[14]
                var cardsop = cardpos[15]
                var lastseen = cardpos[16]
                var updated = cardpos[17]

                var updata = ""
                var upfreq = 0
                var statname = ""

                var data = [cid, name, phone, email, company, calias, motto, main, link1, link2, link3, link4, avatar, cardbk, cardcat, cardsop]
                var dataT = [cid, name, phone, email, company, calias, motto, main, link1, link2, link3, link4, avatar, cardbk, lastseen, cardcat, cardsop]

                var dataLS = [cid, "lastseen", lastseen, 0]
                var dataLU = [cid, "updated", updated, 0]

                var dataStr = "INSERT INTO SavedCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
                var dataStrT = "INSERT INTO TempCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
                var dataStrR = "INSERT INTO RegCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
                var dataStrG = "INSERT INTO GlobCards VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

                var dataStats = "INSERT INTO Stats VALUES(?,?,?,?)"

                var update = "UPDATE SavedCards SET name='"
                        + name + "', email='" + email + "', phone='"
                        + phone + "', company='" + company + "', motto='"
                        + motto + "', main='" + main + "',website1='"
                        + link1 + "', website2='" + link2 + "', website3='"
                        + link3 + "', website4='" + link4 + "', avatar='"
                        + avatar + "', cardback='" + cardbk + "', cat='"
                        + cardcat + "'  WHERE id='" + id + "'"
                var updateT = "UPDATE TempCards SET name='"
                        + name + "', email='" + email + "', phone='"
                        + phone + "', company='" + company + "', motto='"
                        + motto + "', main='" + main + "',website1='"
                        + link1 + "', website2='" + link2 + "', website3='"
                        + link3 + "', website4='" + link4 + "', avatar='"
                        + avatar + "', cardback='" + cardbk + "', cat='"
                        + cardcat + "'  WHERE id='" + id + "'"
                var updateR = "UPDATE RegCards SET name='"
                        + name + "', email='" + email + "', phone='"
                        + phone + "', company='" + company + "', motto='"
                        + motto + "', main='" + main + "',website1='"
                        + link1 + "', website2='" + link2 + "', website3='"
                        + link3 + "', website4='" + link4 + "', avatar='"
                        + avatar + "', cardback='" + cardbk + "', cat='"
                        + cardcat + "'  WHERE id='" + id + "'"
                var updateG = "UPDATE GlobCards SET name='"
                        + name + "', email='" + email + "', phone='"
                        + phone + "', company='" + company + "', motto='"
                        + motto + "', main='" + main + "',website1='"
                        + link1 + "', website2='" + link2 + "', website3='"
                        + link3 + "', website4='" + link4 + "', avatar='"
                        + avatar + "', cardback='" + cardbk + "', cat='"
                        + cardcat + "'  WHERE id='" + id + "'"

                var updateLSStats = "UPDATE Stats SET data='" + lastseen + "',frequency='"
                        + upfreq + "' WHERE id='" + cid + "' AND name='lastseen'"
                var updateLUStats = "UPDATE Stats SET data='" + updated + "',frequency='"
                        + upfreq + "' WHERE id='" + cid + "' AND name='updated'"

                var testStr = "SELECT  name  FROM SavedCards WHERE id='" + cid + "'"
                var testStrT = ""
                var testStrR = ""
                var testStrG = ""

                var testStatlastseen = ""
                var testStatupdated = ""

                if (cid !== "") {
                    testStrT = "SELECT  name  FROM TempCards WHERE id='" + cid + "'"
                    testStrR = "SELECT  name  FROM RegCards WHERE id='" + cid + "'"
                    testStrG = "SELECT  name  FROM GlobCards WHERE id='" + cid + "'"

                    testStatlastseen = "SELECT name FROM Stats WHERE id='" + cid
                            + "' AND name = 'lastseen'"
                    testStatupdated = "SELECT name FROM Stats WHERE id='" + cid
                            + "' AND name = 'updated'"
                }

                db.transaction(function (tx) {

                    var duplicate
                    switch (list) {
                    case "saved":
                        if (testStr != "") {
                            duplicate = tx.executeSql(testStr)
                            if (duplicate.rows.length == 0) {
                                tx.executeSql(dataStr, data)
                            } else {
                                tx.executeSql(update)
                            }
                        }
                        ;
                        break
                    case "temp":
                        if (testStrT != "") {
                            duplicate = tx.executeSql(testStrT)
                            if (duplicate.rows.length == 0) {
                                if (name.length > 2 || company.length > 2) {
                                    tx.executeSql(dataStrT, dataT)
                                }
                            } else {
                                tx.executeSql(updateT)
                            }
                        }
                        ;
                        break
                    case "region":
                        if (testStrR != "") {
                            duplicate = tx.executeSql(testStrR)
                            if (duplicate.rows.length == 0) {
                                if (name.length > 2 || company.length > 2) {
                                    tx.executeSql(dataStrR, dataT)
                                }
                            } else {
                                tx.executeSql(updateR)
                            }
                        }
                        ;
                        break
                    case "global":
                        if (testStrG != "") {
                            duplicate = tx.executeSql(testStrG)
                            if (duplicate.rows.length == 0) {
                                if (name.length > 2 || company.length > 2) {
                                    tx.executeSql(dataStrG, dataT)
                                }
                            } else {
                                tx.executeSql(updateG)
                            }
                        }
                        ;
                        break
                    }

                    if (testStatlastseen != "") {
                        var statLSdup = tx.executeSql(testStatlastseen)
                        if (statLSdup.rows.length === 0) {
                            tx.executeSql(dataStats, dataLS)
                        } else {
                            upfreq = statLSdup.rows.frequency + 1
                            tx.executeSql(updateLSStats)
                        }
                    }
                    if (testStatupdated != "") {
                        var statLUdup = tx.executeSql(testStatupdated)
                        if (statLUdup.rows.length === 0) {
                            tx.executeSql(dataStats, dataLU)
                        } else {
                            upfreq = statLUdup.rows.frequency + 1
                            tx.executeSql(updateLUStats)
                        }
                    }
                })
            }
        }
    }
    http.open('GET', url.trim(), true)
    http.send(null)

    //}
    gc()
}

function remote_delete(id, list, cid) {

    var http = new XMLHttpRequest()
    var url
    var carddata = ""

    //console.log("deleting");
    get_list_updater.stop()
    gpsupdate.stop()
    heartbeats.stop()

    switch (list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/deleteref.php?id=" + id + "&list=" + list + "&cid=" + cid
        carddata = ""
        // console.log("removing "+cid+" from server saved");
        //console.log(url);
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    var remotesaved = carddata
                    get_list_updater.restart()
                    gpsupdate.restart()
                    heartbeats.restart()
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    case "temp":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/deleteref.php?id=" + id + "&list=" + list + "&cid=" + cid
        carddata = ""
        console.log(url)
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    console.log(carddata)
                    remotetemp = carddata
                    var tnum = 0
                    while (remotetemp.split(",")[tnum] !== null) {
                        update_card(remotetemp.split(",")[tnum], "temp")
                        tnum = tnum + 1
                        get_list_updater.restart()
                    }
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    default:
        get_list_updater.restart()
        break
    }
}

function remote_delete_list(id, list, cid_list) {

    var http = new XMLHttpRequest()
    var url
    var carddata = ""
    get_list_updater.stop()

    switch (list) {
    case "saved":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/deleteref.php?id=" + id + "&list=" + list + "&cid=" + cid
        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    sync_cards(userid, 0)
                    get_list_updater.restart()
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    case "temp":
        url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
                + appId + "/scripts/deleteref.php?id=" + id + "&list=" + list + "&cid=" + cid_list
        carddata = ""
        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
        break
    default:
        get_list_updater.restart()
        break
    }
}

function website_snap(id, url, sitenum) {

    var http = new XMLHttpRequest()
    var carddata = ""

    url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/" + appId
            + "/scripts/snaps.php?id=" + id + "&url=" + url + "&sitenum=" + sitenum

    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            carddata = http.responseText

            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {
                carddata = http.responseText
                thesource = carddata
            }
        }
    }
    http.open('GET', url.trim(), true)
    http.send(null)

    return carddata
}

function onetime(id, action) {

    var http = new XMLHttpRequest()
    var carddata = ""
    var url = ""
    if (action < 3) {
        url = "https://openseed.vagueentertainment.com:8675/corescripts/onetime.php?devid="
                + devId + "&appid=" + appId + "&cardid=" + id + "&create=" + action

        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    onetimecode = carddata
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
    } else {
        url = "https://openseed.vagueentertainment.com:8675/corescripts/onetime.php?devid="
                + devId + "&appid=" + appId + "&cardid=" + id + "&create=" + action

        http.onreadystatechange = function () {
            if (http.readyState == 4) {
                carddata = http.responseText

                if (http.responseText === 100) {

                    console.log("Incorrect DevID")
                } else if (http.responseText === 101) {
                    console.log("Incorrect AppID")
                } else {
                    carddata = http.responseText
                    update_card(carddata, "saved")
                }
            }
        }
        http.open('GET', url.trim(), true)
        http.send(null)
    }
}


// Anouncement stuff //
function get_eula() {
    var http = new XMLHttpRequest()
    var url = "http://vagueentertainment.com/standard-license.html"

    http.onreadystatechange = function () {

        if (http.readyState == 4) {

            message = http.responseText.split(
                        '<body lang="en-US" dir="ltr">')[1].split("</body>")[0]
        }
    }

    http.open('GET', url.trim(), true)

    http.send(null)
}

function get_news(log) {
    var http = new XMLHttpRequest()
    var url = "http://vagueentertainment.com/" + log + ".html"

    http.onreadystatechange = function () {

        if (http.readyState == 4) {
            message = http.responseText.split(
                        '<body lang="en-US" dir="ltr">')[1].split("</body>")[0]
        }
    }

    http.open('GET', url.trim(), true)

    http.send(null)
}

function announcement_seen(type) {

    var data = [id, username, type, 1, 1]
    var insert = "INSERT INTO announcements VALUES(?,?,?,?,?)"
    db.transaction(function (tx) {
        tx.executeSql(insert, data)
    })
}

function sendimage(userid, file, private) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/profilePic.php"

    var retrieved

    var d = new Date()
    var thedate = d.getMonth() + 1 + "-" + d.getDate() + "-" + d.getFullYear()

    http.onreadystatechange = function () {

        if (http.readyState == 4) {

            if (http.responseText === 100) {
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {
                retrieved = http.responseText
                console.log(retrieved)
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("devid=" + devId + "&appid=" + appId + "&id=" + userid + "&file=" + file.trim(
                  ) + "&private=" + private + "&type=IMAGE&action=sending")
}

function update_index(file, retrieved) {

    var thefile = file.split(":;:")[1].trim() + ".jpg"

    var base64 = file.split(":;:")[0].replace(/ /g, "+")

    var insert = "UPDATE LIBRARY SET picture_index='" + retrieved
            + "' WHERE file='" + thefile + "' AND base64 = '" + base64 + "'"
    db.transaction(function (tx) {
        tx.executeSql(insert)
    })
}

function serviceConnect(service, account) {

    var http = new XMLHttpRequest()
    var retrieved
    var pagedata
    var profilepic
    var url = ""

    switch (service) {
    case "twitter":
        url = "https://www.twitter.com/" + account
        http.onreadystatechange = function () {
            if (http.readyState == 4) {

                pagedata = http.responseText

                if (http.responseText === 100) {
                    console.log(http.responseText)
                } else if (http.responseText === 101) {
                    console.log(http.responseText)
                } else {

                    pagedata = http.responseText

                    profilepic = pagedata.substring(
                                pagedata.search(
                                    "https://pbs.twimg.com/profile_images/"),
                                (pagedata.search(
                                     "https://pbs.twimg.com/profile_images/") + 150))
                    profilepic = profilepic.split('"')
                    var mission = pagedata.substring(
                                pagedata.search(
                                    '<p class="ProfileHeaderCard-bio u-dir" dir="ltr">'),
                                pagedata.search(
                                    '<div class="ProfileHeaderCard-location ">'))
                    avatar = profilepic[0]
                    profilename = profilepic[2]
                    info = mission
                }
            }
        }
        http.open('GET', url, true)
        http.send(null)

        break
    case "tumblr":
        url = "https://" + account + ".tumblr.com/"
        http.onreadystatechange = function () {
            if (http.readyState == 4) {

                pagedata = http.responseText

                if (http.responseText === 100) {
                    console.log(http.responseText)
                } else if (http.responseText === 101) {
                    console.log(http.responseText)
                } else {

                    pagedata = http.responseText

                    profilename = pagedata.substring(
                                pagedata.search(
                                    '<h1 class="blog-title"><a href="/">'),
                                pagedata.search(
                                    ' <h1 class="blog-title"><a href="/">') + 100).split(
                                ">")[2].split("<")[0]
                    avatar = pagedata.substring(
                                pagedata.search(
                                    'class="user-avatar"><img src="'),
                                pagedata.search(
                                    'class="user-avatar"><img src="') + 100).split(
                                '"')[3]
                    info = pagedata.substring(
                                pagedata.search('<span class="description">'),
                                pagedata.search(
                                    '<span class="description">') + 200).split(
                                ">")[1].split("</")[0].trim()
                }
            }
        }

        http.open('GET', url, true)
        http.send(null)

        break
    case "soundcloud":
        url = "https://soundcloud.com/" + account

        var profileavatar
        var name
        http.onreadystatechange = function () {
            if (http.readyState == 4) {

                pagedata = http.responseText

                if (http.responseText === 100) {
                    console.log(http.responseText)
                } else if (http.responseText === 101) {
                    console.log(http.responseText)
                } else {

                    pagedata = http.responseText

                    name = pagedata.substring(pagedata.search("<title>") + 7,
                                              pagedata.search("</title>") - 8)
                    name = name.split("|")
                    profilename = name[0]

                    profileavatar = pagedata.substring(
                                pagedata.search("’s avatar") - 200,
                                pagedata.search("’s avatar"))

                    profileavatar = profileavatar.split('<img')
                    profileavatar = profileavatar[1].split('=')
                    profileavatar = profileavatar[1].split(' ')

                    avatar = profileavatar[0].substring(
                                1, profileavatar[0].length - 1)
                    info = ""
                }
            }
        }

        http.open('GET', url.trim(), true)
        http.send(null)

        break
    case "gravatar":

        var url = "https://openseed.vagueentertainment.com:8675/corescripts/gravatar.php?email="
                + account

        http.onreadystatechange = function () {
            if (http.readyState == 4) {

                pagedata = http.responseText

                if (http.responseText === 100) {
                    console.log(http.responseText)
                } else if (http.responseText === 101) {
                    console.log(http.responseText)
                } else {

                    pagedata = http.responseText

                    avatar = pagedata
                }
            }
        }

        http.open('GET', url.trim(), true)
        http.send(null)

        break
    case "blog":

        url = ""

        if (account.startsWith("http") === true) {
            url = account
        } else {
            url = "http://" + account
        }

        http.onreadystatechange = function () {
            if (http.readyState == 4) {

                pagedata = http.responseText

                if (http.responseText === 100) {
                    console.log(http.responseText)
                } else if (http.responseText === 101) {
                    console.log(http.responseText)
                } else {

                    pagedata = http.responseText

                    var rss = pagedata.search(/rss/i)
                    var wordpress = pagedata.search(/wordpress/i)
                    var medium = pagedata.search(/medium.com/i)

                    if (medium !== -1) {
                        avatar = "./img/medium.png"
                    } else if (wordpress !== -1) {
                        avatar = "./img/wordpress.png"
                    } else if (rss !== -1) {
                        avatar = "./img/RSS.png"
                    }
                }
            }
        }

        http.open('GET', url.trim(), true)
        http.send(null)

        break
    default:
        avatar = ""
        break
    }
}

function socialaccounts() {

    socialaccountslist.clear()

    for (var num = 0; num < slist.length; num = num + 1) {

        socialaccountslist.append({
                                      type: 1,
                                      service: slist[num].split("::")[3],
                                      source: "Connect to " + slist[num].split(
                                          "::")[0],
                                      bgcolor: slist[num].split("::")[1],
                                      serviceLogo: slist[num].split("::")[2]
                                  })
    }
}

function preview_card(id) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/updatecard.php?id=" + userid + "&cid=" + id + "&list=preview"

    var formercard = currentcard_thecard

    var carddata = ""
    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            carddata = http.responseText

            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {

                carddata = http.responseText

                var cardpos = carddata.split(";&;")
                var ava = ""
                if (cardpos[12].length < 4) {
                    ava = "img/default_avatar.png"
                } else {
                    ava = cardpos[12]
                    if (ava.search("/9j/4A") != -1) {
                        ava = "data:image/jpeg;base64, " + ava.replace(/ /g,
                                                                       "+")
                    }
                }

                var spC

                var dataStr = "SELECT id,name FROM SavedCards WHERE id ='" + cardpos[0] + "'"

                db.transaction(function (tx) {

                    var pull = tx.executeSql(dataStr)

                    if (pull.rows.length !== 0) {
                        currentcard_saved = 1
                    } else {
                        currentcard_saved = 0
                    }
                })

                currentcard_thecard = cardpos[0]
                currentcard_username = cardpos[1]
                currentcard_userphone = cardpos[2]
                currentcard_useremail = cardpos[3]
                currentcard_cardposition = cardpos[5]
                currentcard_companyname = cardpos[4]
                currentcard_motto = cardpos[6]
                currentcard_mainsite = cardpos[7]
                currentcard_url1 = cardpos[8]
                currentcard_url2 = cardpos[9]
                currentcard_url3 = cardpos[10]
                currentcard_url4 = cardpos[11]
                currentcard_avatarimg = ava
                currentcard_realcardback = cardpos[13]
                currentcard_cardcat = cardpos[14]
                currentcard_cardsop = cardpos[15]
                readystate = "ready"
                card = cardpos[0]
            }
        }
    }
    http.open('GET', url.trim(), true)
    http.send(null)

    gc()

    if (formercard != currentcard_thecard) {
        return "ready"
    } else {
        return "not ready"
    }
}

function connections(cardID) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/devs/" + devId + "/"
            + appId + "/scripts/connections.php"

    var carddata = ""
    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            carddata = http.responseText

            if (http.responseText === 100) {

                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {

                carddata = http.responseText
                connected = carddata
            }
        }
    }

    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("id=" + userid + "&cardID=" + cardID)

    gc()
}
