import QtQuick 2.3
import QtQuick.Window 2.2


import "main.js" as Scripts
import "webpage.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"img/overlay.png"
    property string avatar: ""
    property string name: ""
    property string banner: ""
    property string stats: ""
    property string message: ""
    property string posttitle:""
    property string post:""
    property string postimage:""
    property string link:""

    clip: true

    onStateChanged: if(popup.state == "Active") {Site.rss_reader1(service);}


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

    /*Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.6)
        border.width:1
    }*/

    Image {
        id:shade
        anchors.centerIn: parent
        source:"./img/shade.png"
        anchors.fill: parent
        //fillMode:Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        height:if(window_width > mobile_width) {parent.width * 0.10} else {parent.width * 0.15}
        color:Qt.rgba(0.2,0.2,0.2,0.5)
        radius:10
        border.color: "white"
        border.width:2
        z:1
        clip:true
        Image {
            id:avimage
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.85
            height:parent.height * 0.85
            fillMode:Image.PreserveAspectFit
            source:avatar

        }
        Text {
            id:blogtitle
            anchors.left:avimage.right
            text:name
            width:(parent.width - avimage.width) * 0.95
            wrapMode:Text.WordWrap
            font.pixelSize: if(window_width > mobile_width) {(parent.height - text.length) * 0.50 } else {(parent.height - text.length) * 0.60 }
            color:"white"
        }
        Text {
            id:about
            anchors.left:avimage.right
            anchors.top:blogtitle.bottom
            text:message
            width:(parent.width - avimage.width) * 0.95
            wrapMode:Text.WordWrap
            font.pixelSize: blogtitle.height * 0.30 - message.length
            color:"white"
        }

    }




    Rectangle {
        id:postbg
        radius:10
        anchors.centerIn: parent
        color:Qt.rgba(0.4,0.4,0.4,0.9)
        border.color:"gray"
        border.width:4
        width:if(window_width > mobile_width) {parent.width * 0.60} else {parent.width * 0.98}
        height:parent.height * 0.60
        //height:postcontent.height + 10
        clip:true
        z:0
        Item {
            id:postcontent
            width:parent.width * 0.98
            height:parent.height * 0.98
            Text {
                id:titletext
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                visible:if(posttitle.length > 2) {true} else {false}
                text:posttitle
                font.pixelSize: postbg.width * 0.12 - posttitle.length
                wrapMode:Text.WordWrap
                color:"white"
            }

            Rectangle {
                id:postsplitter
                color:"gray"
                anchors.top:titletext.bottom
                width:parent.width
                height:postbg.height * 0.01
                visible:if(posttitle.length > 2) {true} else {false}
            }

            Image {
                visible: if(postimage.length > 2) {true} else {false}
                anchors.top:postsplitter.bottom
                width:parent.width * 0.90
                height:if(postimage.length > 2) {parent.height * 0.65} else {10}
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                source:postimage
                id:postimg
            }
            Text {
                anchors.top:postimg.bottom
                //anchors.bottom:parent.bottom
                width:parent.width * 0.95
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize:if(postimage.length > 2) { postbg.width * 0.02 } else { postbg.width * 0.04 }
                text:post
                wrapMode:Text.WordWrap
                color:"white"
            }
        }

        MouseArea {
          anchors.fill:parent
             onClicked: showurl = link,fullWeb.state = "show"
             ,cardPage.header.hide()

               /*onPressAndHold:showurl = page,fullWeb.state = "show"
               ,cardPage.header.hide() */

         }

   // }

        }

    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:"white"
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
                    y:parent.height * 0.40
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
            font.pixelSize: servicelogo.height * 0.6
            text:service

            MouseArea {
              anchors.fill:parent
                 onClicked: showurl = service,fullWeb.state = "show"
                 ,cardPage.header.hide()

                   /*onPressAndHold:showurl = page,fullWeb.state = "show"
                   ,cardPage.header.hide() */

             }
        }


                 GridView {
                     id:itemgrid
                     width:if(window_width > mobile_width) {parent.width * 0.80} else {parent.width * 0.98}
                     anchors.horizontalCenter: parent.horizontalCenter
                     anchors.top:servicelogo.bottom
                     //anchors.bottom:parent.bottom
                     height:parent.height - servicelogo.height
                     anchors.margins: 8
                     cellWidth: if(window_width > mobile_width) {parent.width / 2.5} else {parent.width * 0.98}
                     cellHeight: if(window_width > mobile_width) {parent.height /1.8} else {parent.height * 0.70}
                     clip:true




                     model: ListModel { id:channellist }

                     delegate:
                                 Rectangle {
                                     id:list_postbg
                                     radius:10


                                     color:Qt.rgba(0.2,0.2,0.2,0.7)
                                     border.color:"gray"
                                     border.width:4

                                     width: itemgrid.cellWidth
                                     height:itemgrid.cellHeight * 0.94

                                     clip:true
                                     //anchors.fill:parent
                                     z:0

                                         Item {
                                             id:list_postcontent
                                             width:parent.width * 0.98
                                             height:parent.height * 0.95


                                             Image {
                                                 visible: if(itemimage.length > 2) {true} else {false}
                                                 anchors.top:parent.top
                                                 anchors.topMargin:20
                                                 width:parent.width * 0.90
                                                 height:if(itemimage.length > 2) {parent.height * 0.85} else {1}
                                                 fillMode: Image.PreserveAspectFit
                                                 anchors.horizontalCenter: parent.horizontalCenter
                                                 source:itemimage
                                                 id:list_postimg
                                             }

                                             Rectangle {
                                                 id:list_postsplitter
                                                 color:"gray"
                                                 anchors.top:list_postimg.bottom
                                                 width:parent.width
                                                 height:list_postbg.height * 0.01
                                                 visible:if(itemname.length > 2) {true} else {false}
                                             }

                                             Text {
                                                 id:list_titletext
                                                 width:parent.width
                                                 anchors.top:list_postsplitter.bottom
                                                 horizontalAlignment: Text.AlignHCenter
                                                 visible:if(itemname.length > 2) {true} else {false}
                                                 text:itemname
                                                 font.pixelSize: (list_postbg.width - posttitle.length ) * 0.07
                                                 wrapMode:Text.WordWrap
                                                 color:"White"
                                                 }

                                             Text {
                                                 id:list_added
                                                 width:parent.width*0.90
                                                 height:(parent.height - list_titletext.height) * 0.90
                                                 clip:true
                                                 anchors.top:list_titletext.bottom
                                                 anchors.horizontalCenter: parent.horizontalCenter
                                                 horizontalAlignment: Text.AlignLeft
                                                 visible:if(itemname.length > 2) {true} else {false}
                                                 text:itemaddition
                                                 font.pixelSize: (list_postbg.width - posttitle.length) * 0.06
                                                 wrapMode:Text.WordWrap
                                                 color:"white"
                                                 }


                                       }
                                         Flasher {
                                             id:itemflash
                                         }

                                         MouseArea {
                                           anchors.fill:parent
                                              onClicked: showurl = itemlink,fullWeb.state = "show"
                                              ,cardPage.header.hide()
                                              onPressed:itemflash.state = "Active"
                                              onReleased:itemflash.state = "InActive"

                                          }

                                 }


                               }


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




