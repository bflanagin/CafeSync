import QtQuick 2.3
import QtQuick.Window 2.2


import "../main.js" as Scripts
import "soundcloud.js" as Site
import "../"


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"../img/soundcloud.png"
    property string avatar: ""
    property string name: ""
    property string banner: ""
    property string thestats: ""

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
        source:avatar
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill:parent
        radius:10
        //color:Qt.rgba(0.1,0.1,0.1,0.8)
        color:"#FF5200"
        opacity: 0.7
        border.width:1
    }
    Image {
        id:shade
        anchors.centerIn: parent
        source:"../img/shade.png"
        anchors.fill: parent
        //fillMode:Image.PreserveAspectCrop
    }



    Rectangle {


        anchors.centerIn:parent
        clip:true
        width:parent.width * 0.80
        height:parent.width * 0.80
        color:Qt.rgba(0.8,0.8,0.8,0.9)
        radius:10

        Image {
            id:albumcover
            anchors.fill:parent
            source:avatar
            fillMode: Image.PreserveAspectFit
            anchors.margins: 8
        }
    }

    Rectangle {
        id:bottominfo
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        clip:true
        width:parent.width * 0.98
        height:parent.height * 0.10
        color:Qt.rgba(0.1,0.1,0.1,0.8)
        radius:10
        border.width:1
        border.color:"white"


    Text {
        id:statarea
        anchors.top:parent.top
        anchors.right:parent.right
        anchors.margins:6
        text:thestats
        color:"white"
        font.pixelSize: parent.height * 0.15
    }

    Image {
        id:logoin
        source:"../img/soundcloud.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:parent.left
        anchors.leftMargin: 8
        height:parent.width * 0.2
        width:parent.width * 0.2
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:logoin.right
        width:statarea.x
        wrapMode: Text.WordWrap
        text:name
        font.pixelSize: parent.height * 0.4 - name.length
        color:"white"
    }


    }


    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:backgroundColor
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
                     source:"../icons/message.svg"
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
    }*/

    onClicked:Qt.openUrlExternally(page);

    onReleased:wrflasher.state = "InActive"
}

}
