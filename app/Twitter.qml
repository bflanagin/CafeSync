import QtQuick 2.3
import QtQuick.Window 2.2


import "main.js" as Scripts
import "twitter.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string pluginlogo:"img/twitter.png"

    property string banner: ""
    property string avatar: ""
    property string profilename: ""
    property string message: ""

    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(service)}

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              visible:false
          }
        }
    ]

    anchors.centerIn: parent

    Image {
        id:bg
        anchors.centerIn: parent
        //source:pagesource
        source:banner
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop


        Rectangle {
           // anchors.centerIn: pic
            anchors.left:pic.left
            anchors.leftMargin: -8
            anchors.verticalCenter: pic.verticalCenter
           // width:pic.width + 8
            width:parent.width * 0.99
            height:pic.height + 8
            color:Qt.rgba(0.5,0.5,0.5,0.8)
            radius:10
            border.color:"white"
            z:0
            clip:true

        Rectangle {
            color:"white"
            border.color:"black"
            border.width:1
            radius:10
            anchors.centerIn: pic
            width:pic.width + 2
            height:pic.height + 2
        }

        Image {
            id:pic
            anchors.left:parent.left
            anchors.top:parent.top
            anchors.topMargin:4
            anchors.leftMargin:10
            //source:pagesource
            source:avatar
            fillMode:Image.PreserveAspectFit
            width:bg.height * 0.15
            height:bg.height * 0.15


        }
        Text {
            //anchors.verticalCenter: pic.verticalCenter
            anchors.top:pic.top
            anchors.left: pic.right
            anchors.leftMargin:5

            font.pixelSize: parent.height * 0.40 - text.length
            width:(parent.width - pic.width) * 0.98
            text:profilename
            wrapMode: Text.WordWrap
            //style: Text.Outline; styleColor: "#FFFFFF"
            color:"white"

            Text {
                anchors.top:parent.bottom
                text:"@"+service.split("/")[3]
                font.pixelSize: parent.height / 4
                //style: Text.Outline; styleColor: "#FFFFFF"
                color:"white"
            }

            MouseArea {
                anchors.fill:parent
                onClicked:{showurl = service,
                fullWeb.state = "show",
                cardPage.header.hide()}
            }
        }

        }

    }

    Rectangle {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 30
        color:Qt.rgba(1.0,1.0,1.0,0.8)

        radius:10
        width:parent.width * 0.89
        height:parent.height * 0.33
        clip:true

        Text {
            //anchors.centerIn: parent
            wrapMode: Text.WordWrap
            text:message
            anchors.fill:parent
            anchors.margins: 5
            font.pixelSize: parent.height * 0.12 - text.length


        }
    }

    /*Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.3)
        border.width:1
    } */

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
                    y:parent.height * 0.90
                    radius:0
                    }
                    PropertyChanges {
                        target:links
                        opacity:1
                    }
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
            z:1
            source:pluginlogo
            width:parent.width * 0.10
            height:parent.height * 0.10
            fillMode:Image.PreserveAspectFit
            anchors.right:parent.right

        }
       /* Text {
            id:accountname
            anchors.left:parent.left
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:"@"+service.split("/")[3]
        } */

        Row {
            width:parent.width
            //anchors.top:accountname.bottom
            anchors.left:parent.left
            anchors.verticalCenter: servicelogo.verticalCenter
            anchors.margins:20
            spacing:10


            Item {
                width:links.width * 0.30
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

               /* Image {
                     source:"/usr/share/icons/suru/actions/scalable/message-sent.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter */

                 Text {
                        anchors.centerIn: parent
                        //anchors.leftMargin: 10
                       // anchors.left:parent.right
                         text:i18n.tr("Tweets & Replies")
                         //anchors.verticalCenter: parent.verticalCenter
                         font.pixelSize: parent.height * 0.3

                     }
                // }
                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"with_replies"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    }
                    onReleased:wrflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.30
                 height:links.height * 0.08
                 Flasher {
                     //anchors.fill:parent
                     id:mediaflasher
                 }

               /* Image {
                     source:"/usr/share/icons/suru/actions/scalable/message.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter */

                 Text {
                        id:pav
                        //anchors.leftMargin: 10
                      //  anchors.left:parent.right
                         text:i18n.tr("Photos & Videos")
                         //anchors.verticalCenter: parent.verticalCenter
                         anchors.centerIn: parent
                         font.pixelSize: parent.height * 0.3

                     }
                // }
                MouseArea {
                    anchors.fill:parent
                    onPressed:mediaflasher.state = "Active"
                    onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"media"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    }
                    onReleased:mediaflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.30
                 height:links.height * 0.08

                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                     opacity:0.4
                 }

                 Flasher {
                     //anchors.fill:parent
                     id:followersflasher
                 }

                /*Image {
                     source:"/usr/share/icons/suru/actions/scalable/contact-group.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter */

                 Text {
                        //anchors.leftMargin: 10
                        //anchors.left:parent.right
                         text:i18n.tr("Followers")
                         //anchors.verticalCenter: parent.verticalCenter
                         anchors.centerIn: parent
                         font.pixelSize: parent.height * 0.30

                     }
                // }
                MouseArea {
                    anchors.fill:parent
                    onPressed:followersflasher.state = "Active"
                    onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"followers"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    }
                    onReleased:followersflasher.state = "InActive"
                }
            }


        }
    }

    }

    Image {
        id:logo
        anchors.centerIn: parent
        source:pluginlogo
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
                         PropertyChanges {
                            target:logo
                            opacity:0
                         }
                         PropertyChanges {
                             target:links
                             opacity:1
                         }

                         when:bg.status == Image.Ready
                     }

                 ]
                 state:"loading"

                 transitions: Transition {
                      PropertyAnimation { target: logo
                                                properties:"opacity"; duration: 300 }
                  }

    }

}




