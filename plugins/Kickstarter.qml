import QtQuick 2.3
import QtQuick.Window 2.2


import "../main.js" as Scripts
import "kickstarter.js" as Site
import "../openseed.js" as OpenSeed


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"../img/kickstarter.png"
    property string banner: ""
    property string pitch: ""
    property string title: ""

    property string total: " "
    property string backers: ""
    property int percent:0
    property string ammount: ""
    property string daysleft: ""


    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(service);}


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
        source:if(pagesource.length > 2) {pagesource} else {banner}
        anchors.fill: parent
        fillMode:Image.PreserveAspectFit
    }

    Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.1,0.1,0.1,0.7)
        border.width:1
    }

    Rectangle {
        id:titleback
        height:parent.height
        width:parent.width * 0.10
        color:"black"
        border.color: "white"
        border.width:1
        anchors.left:parent.left
        clip:true

        Text {
            anchors.centerIn: parent
            text:title
            rotation: -90
            color:"white"
            font.pixelSize: parent.width * 0.85
        }
    }

    Rectangle {
        anchors.left:titleback.right
        anchors.leftMargin:2
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 10
        width:parent.width - titleback.width -2
        color:Qt.rgba(0.1,0.1,0.1,0.3)
        border.width:1
        border.color:"white"
        height:messagetext.height +10
        Text {
            id:messagetext
            text:pitch
            anchors.centerIn: parent
            wrapMode:Text.WordWrap
            width:parent.width
            font.pixelSize: popup.width * 0.04
            color:"white"

        }
    }


    Rectangle {
        anchors.left:titleback.right
        anchors.leftMargin:2
        anchors.top:parent.top
        anchors.topMargin: 2
        width:(parent.width - titleback.width) * 0.99
        color:Qt.rgba(0.1,0.1,0.1,0.5)
        //border.width:1
        //border.color:"white"
        height:parent.height - messagetext.height - messagetext.x - 30
        id:numbersgame
            clip:true

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color:"white"
                font.pixelSize: parent.width * 0.50
                text:daysleft

                Text {
                    x:parent.x / 1.7
                    y:parent.height / 1.3
                    color:"white"
                    font.pixelSize: parent.height * 0.1
                    text:"days left"

                }
            }

        Column  {
            anchors.right:parent.right
            width:parent.width / 1.2
            height:parent.height

           Text {
               text:backers
               font.pixelSize:numbersgame.width * 0.2 - ammount.length
               color:"white"
               width:parent.width
               horizontalAlignment: Text.AlignRight

           }
           Text {
               text:"backers"

               color:"gray"
               font.pixelSize:numbersgame.width * 0.15 - ammount.length
               width:parent.width
               horizontalAlignment: Text.AlignRight
           }

           Text {
               text:total
               font.pixelSize: numbersgame.width * 0.2 - ammount.length
               color:"white"
               width:parent.width
               horizontalAlignment: Text.AlignRight
           }
           Text {
               text:"of "+ammount
               font.pixelSize:numbersgame.width * 0.15 - ammount.length
               color:"gray"
               width:parent.width
               horizontalAlignment: Text.AlignRight
           }
        }




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
                    y:parent.height * 0.99
                   opacity: 1
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

       /* Image {
            id:servicelogo
            source:pluginlogo
            width:parent.width * 0.10
            height:parent.height * 0.10
            fillMode:Image.PreserveAspectFit

        }
        Text {
            anchors.left:servicelogo.right
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:service
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
                     source:".../img/message-sent.svg"
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
                    /*onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    }

                    onClicked:Qt.openUrlExternally(page);

                    onReleased:wrflasher.state = "InActive"
                }
            }




        } */
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

                 /*Text {
                     anchors.top:parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter
                     text:qsTr("Plugin Under Development")
                     font.pixelSize: (popup.width * 0.10) - text.length

                     Text {
                         anchors.top:parent.bottom
                         width:parent.width
                         anchors.horizontalCenter: parent.horizontalCenter
                         text:qsTr("Tap to launch in external application")
                         wrapMode:Text.WordWrap
                         font.pixelSize: (popup.width * 0.09) - text.length
                     }
                 } */

    }

    MouseArea {
        anchors.fill:parent
        //onPressed:wrflasher.state = "Active"
        /*onClicked: {
            //console.log(page);
            showurl = page
            fullWeb.state = "show"
            cardPage.header.hide()
            onReleased:wrflasher.state = "InActive"
    } */
        onClicked:Qt.openUrlExternally(page);
    }

}




