import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0


import "../main.js" as Scripts
import "steemit.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"../img/steemit-vector-logo.png"
    property string avatar: ""
    property string name: ""
    property string banner: ""
    property string stats: ""
    property string message: ""
    property string posttitle:""
    property string post:""
    property string postimage:""
    property int postcount: 0

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
        opacity: 0.1
    }

   /* Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.6)
        border.width:1
    } */

    /*Image {
        id:shade
        anchors.centerIn: parent
        source:"../img/shade.png"
        anchors.fill: parent
        //fillMode:Image.PreserveAspectCrop
    } */

    Rectangle {
        anchors.top:parent.top
        anchors.topMargin:10
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        height:parent.height * 0.15
        color:Qt.rgba(0.5,0.5,0.5,0.8)
        radius:4
        clip:true
       // border.color: "white"
       // border.width:1
        z:1
        Image {
            id:avimage
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.80
            height:parent.height * 0.80
            fillMode:Image.PreserveAspectFit
            source:avatar

        }
        Text {
            id:blogtitle
            anchors.left:avimage.right
            text:name
            font.pixelSize: parent.height * 0.45 - text.length
            color:"white"
            minimumPixelSize: 20
        }
        Text {
            id:about
            anchors.left:avimage.right
            anchors.top:blogtitle.bottom
            anchors.topMargin: parent.height * 0.01
            text:message
            font.pixelSize: blogtitle.height * 0.25 - text.length
            color:"white"
            wrapMode: Text.WordWrap
            width:parent.width * 0.80
        }

    }

    ListView {
        width:parent.width * 0.98
        height:parent.height * 0.85
       // contentHeight: postbg.height * 1.2
       // contentWidth: width
        //anchors.centerIn: parent
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.height * 0.05
        cacheBuffer: 180
       clip:true

        delegate:Item {
                    width:parent.width * 0.98
                    height:postcontent.height
                    anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
        id:postbg
        radius:5
        //anchors.centerIn: parent
        color:cardcolor
        //border.color:"gray"
       // border.width:4
        width:parent.width
        height:parent.height

        anchors.horizontalCenter: parent.horizontalCenter
        //height:postcontent.height + 10
        clip:true
        z:0

        Item {
            id:postcontent
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            height:titletext.height+ postdata.height + postimg.height
            Text {
                id:titletext
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                visible:if(posttitle.length > 2) {true} else {false}
                text:"<b>"+posttitle+"</b>"
                font.pixelSize: postbg.width * 0.12 - posttitle.length
                wrapMode:Text.WordWrap
                color:"black"
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
                width:parent.width * 0.98
                //height:if(postimage.length > 2) {popup.height * 0.70} else {10}
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                source:postimage
                id:postimg
            }
            Text {
                id:postdata
                anchors.top:postimg.bottom
                anchors.topMargin:8
                //anchors.bottom:parent.bottom
                width:parent.width * 0.95
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: postbg.width * 0.04
                text:"<p>"+post+"</p>"
                wrapMode:Text.WordWrap
                color:"black"
            }
        }

    }

            DropShadow {
                anchors.fill:postbg
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: "#80000000"
                source:postbg
                z:1
            }
        }

        model:steemitposts


    }





    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:backgroundColor
        radius:10
       // border.color:"black"
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

                   opacity: 1
                    radius:0
                    color:bottombarColor
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
            width:parent.width * 0.07
            height:parent.height * 0.07
            fillMode:Image.PreserveAspectFit
            anchors.left:parent.left
            anchors.leftMargin: parent.width * 0.04

            Rectangle {
                anchors.centerIn: parent
                height:parent.height * 1.1
                width:parent.height * 1.1
                color:highLightColor1
                z:-1
                radius: width /2
            }

        }
        Text {
            id:totalPosts
            anchors.right:parent.right
            anchors.rightMargin: parent.width * 0.04
            anchors.verticalCenter:servicelogo.verticalCenter
            //font.underline: true
            font.pixelSize: servicelogo.height * 0.5
            text:postcount
            color:fontColorTitle
        }

        Rectangle {
            anchors.right:totalPosts.left
            anchors.rightMargin: parent.width * 0.05
            height:servicelogo.height * 0.80
            anchors.verticalCenter: servicelogo.verticalCenter
            color:seperatorColor1
            width:3
        }
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
        z:2

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
                 state:"Loading"

                 transitions: Transition {
                      PropertyAnimation { target: logo
                                                properties:"opacity"; duration: 300 }
                  }


    }

    Rectangle {anchors.centerIn: loading_info
                width:loading_info.width * 1.2
                height:loading_info.height *1.5
                color:Qt.rgba(0.4,0.4,0.4,0.5)
                radius: width /2
                opacity: logo.opacity
                z:2
    }
    Text {
        id:loading_info
        anchors.top:logo.bottom
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text:"The Service is:"+service
        width:parent.width * 0.6
        wrapMode: Text.WordWrap
        z:3
        color:"white"

        opacity:logo.opacity
    }


}




