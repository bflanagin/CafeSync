import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0


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
    property string pluginlogo:"./img/stock_website.svg"
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

    //onStateChanged: if(popup.state == "Active") {Site.get_html(service);}


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
        height:parent.width * 0.15
        color:Qt.rgba(0.5,0.5,0.5,0.8)
        radius:5
       // border.color: "white"
      //  border.width:1
        z:1
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
            font.pixelSize: avimage.height * 0.60
            color:"white"
        }
        Text {
            id:about
            anchors.left:avimage.right
            anchors.top:blogtitle.bottom
            text:message
            font.pixelSize: blogtitle.height * 0.30 - message.length
            color:"white"
        }

    }

    Rectangle {
        id:postbg
        radius:10
        anchors.centerIn: parent
        color:Qt.rgba(0.7,0.7,0.7,0.9)
        border.color:"gray"
        border.width:4
        width:parent.width * 0.98
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
                height:if(postimage.length > 2) {parent.height * 0.70} else {10}
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
                font.pixelSize: postbg.width * 0.04
                text:post
                wrapMode:Text.WordWrap
                color:"white"
            }
        }

        MouseArea {
          anchors.fill:parent
             //onClicked: showurl = link,fullWeb.state = "show"
            // ,cardPage.header.hide()
                onPressAndHold:Qt.openUrlExternally(link);


         }

    }

    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:backgroundColor
        //radius:10
        //border.color:highLightColor1
        z:2

        states: [
                State {
                     name:"loading"
                    PropertyChanges {
                     target:blinder
                        y:0
                        color:backgroundColor
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
                    y:parent.height

                    radius:0
                    color:barColor
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
                                      properties:"y,radius,color"; duration: 500 }
        }

    Item {
        id:links
        height:parent.height
        width:parent.width
        opacity:0

        Image {
            id:servicelogo
            source:pluginlogo
            width:parent.width * 0.07
            height:parent.height * 0.07
            fillMode:Image.PreserveAspectFit
            anchors.left:parent.left
            anchors.leftMargin: parent.width * 0.01

        }
       /* Text {
            anchors.left:servicelogo.right
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:service
            color:"black"
        } */
    }

    }


    DropShadow {
        anchors.fill:blinder
        horizontalOffset: 0
        verticalOffset: -4
        radius: 8.0
        samples: 17
        color: "#80000000"
        source:blinder
        z:1
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




