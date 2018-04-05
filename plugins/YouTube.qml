import QtQuick 2.3
import QtQuick.Window 2.2


import "../main.js" as Scripts
import "youtube.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    //property string sitedata:""
    property string pluginlogo:"img/youtube.png"

    property string avatar: ""
    property string banner: ""
    property string message: ""
    property string profilename: ""
    property string stats: ""

    property string posttitle:""
    property string post:""
    property string postimage:""
    property string link: ""


    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(service),Site.channelist(service);}


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                enabled:true
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              enabled:false

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
        color:Qt.rgba(0.5,0.5,0.5,0.7)
        border.width:1
    }

    Rectangle {
        id:bannerborder
        anchors.top:parent.top
        anchors.topMargin: 10

        width:parent.width * 0.98
        height:parent.width * 0.15
        color:"black"
        border.color:"white"
        border.width:2
        clip:true

        Image {
            source:banner
            anchors.top:parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin:2
            fillMode:Image.PreserveAspectFit
            width:parent.width * 0.99
            height:parent.height * 0.85

            Text {
                text:message
                color:"white"
                anchors.top:parent.bottom
                //anchors.right:parent.right
                font.pixelSize: (bannerborder.height - parent.height - message.length) * 0.80
            }
        }
        Rectangle {
            anchors.centerIn: adv
            border.width:2
            border.color:"black"
            color:"white"
            width:adv.width +4
            height:adv.height +4
        }

    Image {
        id:adv
        source:avatar
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 4
        height:parent.height * 0.5
        fillMode:Image.PreserveAspectFit
    }

    }

        GridView {
            id:itemgrid
            width:parent.width * 0.90
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:bannerborder.bottom
            //anchors.bottom:parent.bottom
            height:parent.height - bannerborder.height
            anchors.margins: 8
            cellWidth: parent.width * 0.90
            cellHeight: parent.height * 0.70
            clip:true




            model: ListModel { id:channellist }

            delegate:
                        Rectangle {
                            id:postbg
                            radius:10
                            //anchors.centerIn: parent
                            color:Qt.rgba(0.9,0.9,0.9,0.9)
                            border.color:"gray"
                            border.width:4
                            width: itemgrid.cellWidth
                            height:itemgrid.cellHeight
                            //height:postcontent.height + 10
                            //clip:true
                            //anchors.fill:parent
                            z:0

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
                                        text:itemname
                                        font.pixelSize: postbg.width * 0.07 - posttitle.length
                                        wrapMode:Text.WordWrap
                                        color:"black"
                                        }

                                    Text {
                                        id:added
                                        width:parent.width*0.98
                                        anchors.bottom:parent.bottom
                                        horizontalAlignment: Text.AlignRight
                                        visible:if(itemname.length > 2) {true} else {false}
                                        text:itemaddtion
                                        font.pixelSize: postbg.width * 0.06 - posttitle.length
                                        wrapMode:Text.WordWrap
                                        color:"darkgreen"
                                        }


                              }
                                Flasher {
                                    id:itemflash
                                }

                                MouseArea {
                                  anchors.fill:parent
                                     onClicked: showurl = itemlink,Qt.openUrlExternally(showurl);

                                                //fullWeb.state = "show"
                                     //,cardPage.header.hide()
                                     onPressed:itemflash.state = "Active"
                                     onReleased:itemflash.state = "InActive"

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
            width:parent.width * 0.06
            height:parent.height * 0.06
            fillMode:Image.PreserveAspectFit

        }
        Text {
            anchors.left:servicelogo.right
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:profilename
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

}




