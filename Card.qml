import QtQuick 2.10
import QtQml 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Controls 1.3

/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql

import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "microblogger.js" as MicroBlogger

Item {

    id: cards
    anchors.horizontalCenter: parent.horizontalCenter

    width: passerbyGrid.width * 0.96
    height: if (cardsop == 1) {
                passerbyGrid.width * 0.46
            } else {
                passerbyGrid.width * 0.46
            }

    clip: true

    property string w1: "" + URL1
    property string w2: "" + URL2
    property string w3: "" + URL3
    property string w4: "" + URL4
    property string mainly: "" + mainsite
    property string issaved: saved
    property string cardStatus: ""

    property int explodereset: 0
    property int lister: 0

    property int deletetime: 9999999
    property int collecttime: 99999

    Component.onCompleted: if (name == 'undefined') {
                               cardslist.remove(index)
                           } else {
                               MicroBlogger.latest_log_remote(usercardNum,
                                                              cardId)
                           }

    Timer {
        id: selfdestruct
        interval: 800
        running: true
        repeat: false
        onTriggered: {

            if (listget == "temp") {
                if (type == 0) {
                    if (cardsop != 2) {
                        if (Scripts.temp_Elapsed(cardId) === 1) {
                            deletelist.push(cardId)
                            cardslist.remove(index)
                        } else {

                        }
                    }
                }
                if (deletelist.length > 0) {
                    listdeleter.start()
                }
            }
        }
    }

    Item {
        x: 0
        height: parent.height
        width: parent.width
        clip: true

        Rectangle {
            id: thecard
            width: parent.width * 0.98
            height: parent.height * 0.98
            color: cardcolor
            radius: 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            visible: false
            clip: true

            Item {
                width: parent.width
                height: parent.height * 0.90
                clip: true

                CirclePic {
                    id: card_avatar_backing
                    width: parent.height * 0.9
                    height: parent.height * 0.9
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    where: listget
                    whichPic: cardId
                }

                Text {

                    id: nametag
                    visible: if (cardsop == 1) {
                                 true
                             } else {
                                 false
                             }
                    text: "<div>" + name + "</div>"
                    wrapMode: Text.WordWrap
                    font.pixelSize: cards.width * 0.063
                    font.bold: true
                    anchors.left: card_avatar_backing.right
                    anchors.leftMargin: parent.width * 0.008
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.008
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.07
                    color: fontColor
                }

                Rectangle {
                    visible: if (cardsop == 1) {
                                 true
                             } else {
                                 false
                             }
                    anchors.top: nametag.bottom
                    anchors.topMargin: parent.height * 0.04
                    anchors.left: card_avatar_backing.right
                    width: parent.width * 0.57
                    height: 3
                    color: "" + spColor
                }

                Text {

                    id: position
                    visible: if (cardsop == 1) {
                                 true
                             } else {
                                 false
                             }
                    text: qsTr("Job Title: ") + cardposition
                    font.pixelSize: parent.width / 24
                    anchors.left: card_avatar_backing.right
                    anchors.leftMargin: parent.width * 0.03
                    anchors.top: nametag.bottom
                    anchors.topMargin: parent.height * 0.06
                    wrapMode: Text.WordWrap
                    width: parent.width * 0.55
                    color: fontColor
                }

                Text {
                    id: comp
                    visible: if (cardsop == 1) {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.70
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: parent.width * 0.02
                    anchors.bottomMargin: parent.height * 0.02
                    font.pixelSize: parent.width * 0.04
                    text: "" + company
                    wrapMode: Text.WordWrap
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignRight
                    color: fontColor
                }
            }

            Rectangle {

                anchors.left: parent.left
                anchors.bottom: parent.bottom

                width: parent.width
                height: parent.height * 0.1
                color: Qt.rgba(0.94, 0.94, 0.94, 0.1)
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.02
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: parent.height * 0.8
                    text: "<div>" + cardStatus + "</div>"
                    width: parent.width * 0.9
                    wrapMode: Text.WordWrap
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    color: fontColor
                }
            }
        }

        DropShadow {
            anchors.fill: thecard
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: thecard
        }

        MouseArea {
            anchors.centerIn: parent
            width: parent.width * 0.80
            height: parent.height * 0.80

            onPressed: shade.state === "Active"
            onReleased: shade.state === "InActive"
        }
    }

    MouseArea {

        x: 0
        y: 0
        width: if (cards.side === 1) {
                   0
               } else {
                   parent.width
               }
        height: if (cards.side === 1) {
                    0
                } else {
                    parent.height
                }

        onClicked: {
            currentcard = index

            pagelist.clear()
            gc()

            mainScreen.fromRequest = false
            mainScreen.state = "Active"
            topBar.state = "person"

            currentcard_thecard = cardId
            currentcard_saved = issaved
            currentcard_username = name
            currentcard_userphone = phone
            currentcard_useremail = email
            currentcard_cardposition = cardposition
            currentcard_companyname = company
            currentcard_motto = motto
            currentcard_mainsite = mainsite
            currentcard_url1 = w1
            currentcard_url2 = w2
            currentcard_url3 = w3
            currentcard_url4 = w4
            currentcard_avatarimg = imgsource
            currentcard_realcardback = cardback
            currentcard_cardcat = cardcat
            currentcard_cardsop = cardsop

            if (issaved === 1) {
                Scripts.show_Sites(cardId, "saved")
            } else {
                Scripts.show_Sites(cardId, listget)
            }

            mainScreen.positionViewAtBeginning()
        }
    }
}
