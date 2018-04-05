import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2

import "../main.js" as Scripts
import "twitch.js" as Site

import "../"

Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""

    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(service);}


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                z: 3
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              z: -2
          }
        }
    ]

    anchors.centerIn: parent

    Image {
        id:bg
        anchors.centerIn: parent
        source:pagesource
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.3)
        border.width:1
    }

    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:"white"
        radius:10
        border.color:"black"

        states: [
                State {
                     name:"loading"
                    PropertyChanges {
                     target:blinder
                        y:0
                    }
                    PropertyChanges {
                        target:links
                        opacity:0
                    }
            },
                State {
                    name:"loaded"

                    PropertyChanges {
                   target:blinder
                    //y:parent.height * 0.90
                   opacity: 1
                    radius:0
                    }

                    /*PropertyChanges {
                        target:links
                        opacity:1
                    } */

                    when: bg.status == Image.Ready
            }

        ]
        state:"loading"

       transitions: Transition {
            PropertyAnimation { target: blinder
                                      properties:"y,radius"; duration: 500 }
        }

    Item {
        id:links
        height:parent.height
        width:parent.width
        opacity:0

        Image {
            id:servicelogo
            source:"img/twitch-tv.png"
            width:parent.width * 0.10
            height:parent.height * 0.10
            fillMode:Image.PreserveAspectFit

        }
        Text {
            anchors.left:servicelogo.right
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:service.split("/")[3]
        }

        Column {
            width:parent.width
            anchors.top:servicelogo.bottom
            anchors.left:servicelogo.right
            anchors.margins:20
            spacing:10


            Item {
                width:links.width * 0.98
                 height:links.height * 0.08
                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                     opacity:0.4
                 }

                 Flasher {
                     //anchors.fill:parent
                     id:wrflasher
                 }

                Image {
                     source:"../img/message-sent.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter

                 Text {

                        anchors.leftMargin: 10
                        anchors.left:parent.right
                         text:qsTr("Chat")
                         anchors.verticalCenter: parent.verticalCenter
                         font.pixelSize: parent.height * 0.60

                     }
                 }
                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                   /* onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    } */
                    onClicked:Qt.openUrlExternally(page);
                    onReleased:wrflasher.state = "InActive"
                }
            }




        }
    }

    }

    Image {
        id:logo
        anchors.centerIn: parent
        source:"img/twitch-tv.png"
        width:parent.width /3
        height:parent.height /3
        fillMode:Image.PreserveAspectFit

        states: [
                     State {  name:"Loading"
                         PropertyChanges {
                             target:logo
                             opacity:1

                     }
                         PropertyChanges {
                             target:links
                             opacity:0
                         }
                     },
                     State { name:"Loaded"
                        /* PropertyChanges {
                            target:logo
                            opacity:0
                         } */
                         /* PropertyChanges {
                             target:links
                             opacity:1
                         } */

                         when:bg.status == Image.Ready
                     }

                 ]
                 state:"loading"

                 transitions: Transition {
                      PropertyAnimation { target: logo
                                                properties:"opacity"; duration: 300 }
                  }

                 Text {
                     anchors.top:parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter
                     text:qsTr("Plugin Under Development")
                     font.pixelSize: (popup.width * 0.23) - text.length

                     Text {
                         anchors.top:parent.bottom
                         anchors.horizontalCenter: parent.horizontalCenter
                         text:qsTr("Tap to launch in external application")
                         font.pixelSize: (popup.width * 0.23) - text.length
                     }
                 }

    }

}




