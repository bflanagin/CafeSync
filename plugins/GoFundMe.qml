import QtQuick 2.3
import QtQuick.Window 2.2


import "../main.js" as Scripts
import "gofundme.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"../img/gofundme.png"

    property string banner: ""
    property string title:""
    property string pitch:""
    property string ammount:""
    property string backers:""
    property string total:""
    property double percent: 0
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
        source:banner
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
    }


    Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.2,0.2,0.2,0.3)
        border.width:1
    }

    Image {
        anchors.centerIn: parent
        source:"../img/shade.png"
        anchors.fill:parent

    }

    Rectangle {
        id:titleback
        anchors.top:parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.95
        height:parent.height * 0.1
        border.width:2
        border.color:"gray"
        color:Qt.rgba(0.9,0.9,0.9,0.5)
        radius:5
        clip:true
        Text {
            text:title
            width:parent.width
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.width * 0.08 - title.length
            wrapMode: Text.WordWrap
            color:"white"
        }
    }

    Row {
        width:titleback.width
        anchors.top:titleback.bottom
        anchors.topMargin: 8
        height:(parent.height - titleback.height - titleback.y) * 0.90
        anchors.horizontalCenter: parent.horizontalCenter
        clip:true

        Rectangle {
            width:titleback.width * 0.80
            height:parent.height
            border.width:2
            border.color:"gray"
            color:Qt.rgba(0.5,0.5,0.5,0.5)
            radius:5
            id:infoback

            Column {

                width:parent.width
                height:parent.height
                spacing:10

                Text {
                    width:parent.width
                    text:ammount
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: parent.width / 5
                    color:"white"
                }
                Text {
                    width:parent.width
                    text:total
                     horizontalAlignment: Text.AlignHCenter
                     font.pixelSize: parent.width / 3
                     color:"white"
                }
                Text {
                    width:infoback.width
                    text:pitch
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: parent.width / 20 - pitch.length
                    wrapMode: Text.WordWrap
                    color:"white"
                }
            }

        }
        Rectangle {
            width:titleback.width * 0.20
            height:parent.height
            border.width:2
            border.color:"gray"
            color:Qt.rgba(0.5,0.5,0.5,0.5)
            radius:5

            Rectangle {
                anchors.centerIn: parent
                height:parent.height * 0.90
                width:parent.width * 0.80
                clip:true
                color:"black"
                border.color:"white"
                border.width: 2
                radius:10

                Rectangle {
                    anchors.bottom:parent.bottom
                    anchors.bottomMargin: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:parent.width * 0.96
                    color:"red"
                    height:parent.height * (percent / 100)
                    radius:10
                }
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
                    y:parent.height * 0.95
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

        Image {
            id:servicelogo
            source:pluginlogo
            width:parent.width * 0.05
            height:parent.height * 0.05
            fillMode:Image.PreserveAspectFit

        }
        Text {
            anchors.left:servicelogo.right
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:service

                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    /*onClicked: {
                        showurl = page
                        fullWeb.state = "show"
                        cardPage.header.hide()
                        onReleased:wrflasher.state = "InActive"
                } */
                    onClicked:Qt.openUrlExternally(page);



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


    MouseArea {
        anchors.fill:parent
        onPressed:wrflasher.state = "Active"
        /*onClicked: {
            showurl = page
            fullWeb.state = "show"
            cardPage.header.hide()
            onReleased:wrflasher.state = "InActive"
    }*/
        onClicked:Qt.openUrlExternally(page);
    }

}




