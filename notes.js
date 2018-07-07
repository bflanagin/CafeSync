function get_notes(userid) {

    //gathers up notes about specific contact and displays them.
    notelist.clear()
    db.transaction(function (tx) {
        var pull = tx.executeSql(
                    "SELECT * FROM Notes WHERE contactid='" + userid + "'")

        if (pull.rows.length >= 1) {
            var num = 0
            while (num < pull.rows.length) {
                var d = new Date(pull.rows.item(num).date)
                notelist.append({
                                    notetitle: pull.rows.item(num).title,
                                    summary: pull.rows.item(num).information,
                                    date: d.toLocaleString(),
                                    origin: pull.rows.item(num).origin
                                })

                num = num + 1
            }
        }
    })

    remote_sync(userid)
}

function save_note(userid, notename, information, origin) {

    //saves and or updates note about contact
    var thedate = new Date().getTime()
    var insert = "INSERT INTO Notes VALUES(?,?,?,?,?)"
    var thedata = [userid, notename, information, thedate, thedate]
    var update = "UPDATE Notes SET title ='" + notename + "', information='"
            + information + "', date='" + thedate + "' WHERE origin=" + origin
            + " AND contactid='" + userid + "'"

    db.transaction(function (tx) {

        var pull = tx.executeSql("SELECT * FROM Notes WHERE 1")
        if (origin !== 0) {
            tx.executeSql(update)
            upload_note(userid, notename, information, thedate, origin)
        } else {
            tx.executeSql(insert, thedata)
            upload_note(userid, notename, information, thedate, thedate)
        }
    })
}

function get_note(userid, title) {

    //retrieves and single note displays it.
    db.transaction(function (tx) {

        var pull = tx.executeSql("SELECT * FROM Notes WHERE contactid='"
                                 + userid + "' AND title ='" + title + "'")

        if (pull.rows.length === 1) {

            nN.noteTile = pull.rows.item(0).title
            nN.noteBody = pull.rows.item(0).information
            nN.noteOrigin = pull.rows.item(0).origin
        }
    })
}

function delete_note(cid, origin) {

    //Deletes Note
    console.log("deleting")

    db.transaction(function (tx) {

        var pull = tx.executeSql(
                    "SELECT * FROM Notes WHERE contactid='" + cid + "' AND origin =" + origin)

        if (pull.rows.length === 1) {

            tx.executeSql(
                        "DELETE FROM Notes WHERE contactid='" + cid + "' AND origin =" + origin)

            var http = new XMLHttpRequest()
            var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php"

            http.onreadystatechange = function () {
                if (http.readyState == 4) {
                    if (http.responseText === 100) {
                        console.log("Incorrect DevID")
                    } else if (http.responseText === 101) {
                        console.log("Incorrect AppID")
                    } else {
                        console.log(http.responseText)
                        get_notes(cid)
                    }
                }
            }
            http.open('POST', url.trim(), true)
            http.setRequestHeader("Content-type",
                                  "application/x-www-form-urlencoded")
            http.send("&id=" + userid + "&devid=" + devId + "&appid=" + appId
                      + "&speaker=" + usercardNum + "::note::" + cid
                      + "&room=" + origin + "&type=delete")
        }
    })
}

//Open Seed functionality
function upload_note(cid, notename, information, date, origin) {

    var mesgdate = new Date()

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php"

    http.onreadystatechange = function () {
        if (http.readyState == 4) {
            if (http.responseText === 100) {
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("&id=" + userid + "&devid=" + devId + "&appid=" + appId + "&message=" + information
              + "&name=" + notename + "&speaker=" + usercardNum + "::note::" + cid
              + "&date=" + date + "&room=" + origin + "&type=sending")
}

function remote_sync(cid) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php"

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === 100) {
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {
                //console.log(http.responseText);
                var num = 1
                while (http.responseText.split("><").length > num) {

                    var note = http.responseText.split("><")[num]

                    db.transaction(function (tx) {

                        var search = tx.executeSql(
                                    "SELECT * FROM `Notes` WHERE origin=" + note.split(
                                        "::")[0] + " AND date=" + note.split(
                                        "::")[1])

                        if (search.rows.length === 0) {
                            remote_get(note.split("::")[0], note.split("::")[1])
                        }
                    })

                    num = num + 1
                }
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("&id=" + userid + "&devid=" + devId + "&appid=" + appId
              + "&speaker=" + usercardNum + "::note::" + cid + "&type=check")
}

function remote_get(origin, updated) {

    var http = new XMLHttpRequest()
    var url = "https://openseed.vagueentertainment.com:8675/corescripts/narrative.php"

    http.onreadystatechange = function () {
        if (http.readyState == 4) {

            if (http.responseText === 100) {
                console.log("Incorrect DevID")
            } else if (http.responseText === 101) {
                console.log("Incorrect AppID")
            } else {

                var num = 1
                while (http.responseText.split("><").length > num) {

                    var note = http.responseText.split("><")[num]
                    var noteinfo = note.split(":;:")
                    db.transaction(function (tx) {

                        var search = tx.executeSql(
                                    "SELECT * FROM `Notes` WHERE origin=" + noteinfo[0])

                        if (search.rows.length === 0) {
                            var insert = "INSERT INTO `Notes` VALUES(?,?,?,?,?)"
                            var thedata = [noteinfo[1].split(
                                               "::")[2], noteinfo[3], noteinfo[2], noteinfo[4], noteinfo[0]]
                            tx.executeSql(insert, thedata)

                            get_notes(noteinfo[1].split("::")[2])
                        } else {
                            var update = "UPDATE Notes SET title ='" + noteinfo[3]
                                    + "', information='" + noteinfo[2] + "', date='"
                                    + noteinfo[4] + "' WHERE origin=" + noteinfo[0]
                                    + " AND contactid='" + noteinfo[1].split(
                                        "::")[2] + "'"
                            get_notes(noteinfo[1].split("::")[2])
                        }
                    })

                    num = num + 1
                }
            }
        }
    }
    http.open('POST', url.trim(), true)
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.send("&id=" + userid + "&devid=" + devId + "&appid=" + appId + "&room="
              + origin + "&date=" + updated + "&type=pull")
}
