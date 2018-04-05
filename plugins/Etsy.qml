import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0


import "../main.js" as Scripts
import "etsy.js" as Etsy

Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"../img/etsy.png"
    property string avatar: ""
    property string name: ""
    property string banner: ""
    property string stats: ""
    property string message: ""
    property string posttitle:""
    property string post:""
    property string postimage:""
    property string link: ""

    clip: true

    onStateChanged: if(popup.state == "Active") {Etsy.get_html(service),Etsy.storelist(service);}


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
        opacity: 0.1
    }

    Rectangle {
        anchors.fill:parent
        //radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.6)
        //border.width:1
    }

   /* Image {
        id:shade
        anchors.centerIn: parent
        source:"../img/shade.png"
        anchors.fill: parent
        //fillMode:Image.PreserveAspectCrop
    } */

    Rectangle {
        id:banborder
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        height:parent.width * 0.15
        color:Qt.rgba(0.2,0.2,0.2,0.8)
        //radius:10
        border.color: "white"
        border.width:2
        z:1
        Image {
            id:avimage
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.85
            height:parent.height * 0.85
            //anchors.fill:parent
            anchors.margins: 4
            //fillMode:Image.PreserveAspectFit
            source:banner

        }

        Text {
                id:blogtitle
                anchors.left:avimage.right

                text:"<div>"+name+"</div>"
                font.pixelSize: (banborder.height * 0.65) - name.length
                color:"white"
            }
            Text {
                id:about
                anchors.left:avimage.right
                anchors.top:blogtitle.bottom
                text:"<div>"+message+"</div>"
                font.pixelSize: blogtitle.height * 0.30 - message.length
                color:"white"
            }

    }

    GridView {
        id:itemgrid
        width:parent.width * 0.90
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:banborder.bottom
        //anchors.bottom:parent.bottom
        height:parent.height - banborder.height
        anchors.margins: 8
        cellWidth: parent.width * 0.90
        cellHeight: parent.height * 0.70
        clip:true




        model: ListModel { id:shoplist }

        delegate: Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: itemgrid.cellWidth * 0.99
                    height:itemgrid.cellHeight * 0.98

                    Rectangle {
                        id:postbg
                        radius:10

                        color:cardcolor
                        visible: false
                        anchors.fill:parent
                        //z:0

                            Item {
                                id:postcontent
                                width:parent.width * 0.98
                                height:parent.height * 0.95


                                Image {
                                    visible: if(itemimage.length > 2) {true} else {false}
                                    anchors.top:parent.top
                                    width:parent.width * 0.90
                                    height:if(itemimage.length > 2) {parent.height * 0.70} else {10}
                                    fillMode: Image.PreserveAspectFit
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    source:itemimage
                                    id:postimg
                                }

                                Rectangle {
                                    id:postsplitter
                                    color:"gray"
                                    anchors.top:postimg.bottom
                                    width:parent.width
                                    height:postbg.height * 0.01
                                    visible:if(itemname.length > 2) {true} else {false}
                                }

                                Text {
                                    id:titletext
                                    width:parent.width
                                    anchors.top:postsplitter.bottom
                                    horizontalAlignment: Text.AlignHCenter
                                    visible:if(itemname.length > 2) {true} else {false}
                                    text:"<div>"+itemname+"...</div>"
                                    font.pixelSize: postbg.width * 0.06 - posttitle.length
                                    wrapMode:Text.WordWrap
                                    color:"black"
                                    }

                                Text {
                                    id:price
                                    width:parent.width*0.98
                                    anchors.bottom:parent.bottom
                                    horizontalAlignment: Text.AlignRight
                                    visible:if(itemname.length > 2) {true} else {false}
                                    text:itemprice
                                    font.pixelSize: postbg.width * 0.08 - posttitle.length
                                    wrapMode:Text.WordWrap
                                    color:"darkgreen"
                                    }


                          }
                           /* Flasher {
                                id:itemflash
                            } */

                            MouseArea {
                              anchors.fill:parent
                                 //onClicked: showurl = itemlink,fullWeb.state = "show"
                                 //,cardPage.header.hide()
                                 onClicked:Qt.openUrlExternally(itemlink);
                                 //onPressed:itemflash.state = "Active"
                                 //onReleased:itemflash.state = "InActive"

                             }


                        }

                    DropShadow {
                        source:postbg
                        anchors.fill: postbg
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                    }

                 }

    }

    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:Qt.rgba(1,1,1,1)
        radius:10
        border.color:"black"
        z:2

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
                   color:Qt.rgba(0.9,0.9,0.9,0.4)
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
            id:servlogo
            source:pluginlogo
            anchors.left:parent.left
            width:parent.width * 0.08
            height:parent.width * 0.08
        }

            /*Text {
                    id:blogtitle
                    anchors.left:servlogo.right
                    text:name
                    font.pixelSize: servlogo.height * 0.56
                    color:"black"
                }
                Text {
                    id:about
                    anchors.left:servlogo.right
                    anchors.top:blogtitle.bottom
                    text:message
                    font.pixelSize: blogtitle.height * 0.30 - message.length
                    color:"black"
                } */


    }

    }

    Image {
        id:logo
        anchors.centerIn: parent
        source:pluginlogo
        height:parent.height /3
        fillMode:Image.PreserveAspectFit
        z:3

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




