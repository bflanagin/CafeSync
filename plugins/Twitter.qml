import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0


import "../main.js" as Scripts
import "twitter.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string pluginlogo:"../img/twitter.png"

    property string banner: ""
    property string avatar: ""
    property string profilename: ""
    property string missionstatment:""
    property bool showing: false
 //   property string message: ""

  //  property string aquote:""
   // property string postimg:""

    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(service)}

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
                showing:true
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              visible:false
              showing:false


          }
          PropertyChanges {
              target: blinder
              //visible:false
              state:"loading"


          }

        }
    ]

    transitions: [

        Transition {
            from: "Active"
            to: "InActive"
               reversible: true

               NumberAnimation {
                   target: popup
                   property: "opacity"
                   duration: 100
                   easing.type: Easing.InOutQuad
               }

        }

    ]

    anchors.centerIn: parent

    Item {

            anchors.fill: parent
            anchors.centerIn: parent
        Image {
            id:bg
        anchors.centerIn: parent
        //source:pagesource
        source:banner
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
        opacity: 0.1
        }

        Rectangle {
           // anchors.centerIn: pic
           // anchors.left:pic.left
           // anchors.leftMargin: -8
           // anchors.verticalCenter: pic.verticalCenter
           // width:pic.width + 8
            anchors.top:parent.top
            anchors.topMargin: parent.height * 0.01
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.99
            height:parent.height * 0.15
            color:Qt.rgba(0.5,0.5,0.5,0.8)
            radius:5
            z:1

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
           // anchors.top:parent.top
            //anchors.topMargin:4
            anchors.leftMargin:parent.width * 0.01
            //source:pagesource
            anchors.verticalCenter: parent.verticalCenter
            source:avatar
            fillMode:Image.PreserveAspectFit
            width:parent.height *0.90
            height:parent.height *0.90


        }
        Text {
            id:profiletitle
            //anchors.verticalCenter: pic.verticalCenter
            anchors.top:pic.top
            anchors.left: pic.right
            anchors.leftMargin:5
            minimumPixelSize: 20
            font.pixelSize: parent.height * 0.45 - text.length
            width:parent.width * 0.98 - pic.width
            text:profilename
            wrapMode: Text.WordWrap
            //style: Text.Outline; styleColor: "#FFFFFF"
            color:"white"



            MouseArea {
                anchors.fill:parent
                /*onClicked:{showurl = service,
                fullWeb.state = "show",
                cardPage.header.hide()} */
                onClicked:Qt.openUrlExternally(service);
            }


            }

        Text {
            anchors.top:profiletitle.bottom
            anchors.topMargin: parent.height * 0.01
            anchors.left:pic.right
            anchors.leftMargin: parent.height * 0.01
            text:missionstatment
            height: pic.height * 0.80
            clip:true
            font.pixelSize: (parent.height * 0.13) - missionstatment.length
            width:(parent.width - pic.width) * 0.98
            wrapMode: Text.WordWrap
            //style: Text.Outline; styleColor: "#FFFFFF"
            color:"white"
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

        spacing: parent.width * 0.01
        cacheBuffer: 180
       clip:true

       model: twitterposts


   delegate: Item {
                width:parent.width
                height:messageblock.height * 1.2

       Rectangle {
        id:messageblock
        anchors.centerIn: parent

        color:cardcolor
       // anchors.horizontalCenter: parent.horizontalCenter

        radius:5
        width:parent.width * 0.98
        height:themessage.height+(quotebox.height*1.4)+ titletext.height+ postImage.height+popup.height * 0.06
        clip:true
        visible: false


        Text {
            id:titletext
            width:parent.width* 0.95
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:parent.top
            anchors.topMargin: parent.width * 0.04
           // horizontalAlignment: Text.AlignHCenter
            visible:if(posttitle.length > 2) {true} else {false}
            text:"<h2>"+posttitle+"</h2>"
           // font.pixelSize: messageblock.width * 0.08 - posttitle.length
            wrapMode:Text.WordWrap
            color:"black"
        }

        Rectangle {
            id:postsplitter
            color:"gray"
            anchors.top:titletext.bottom
            anchors.topMargin: -popup.width *0.02
            width:parent.width
            height:messageblock.height * 0.01
            visible:if(posttitle.length > 2) {true} else {false}
        }


        Text {
            id:themessage
            //anchors.centerIn: parent
            anchors.left: parent.left
            anchors.top: titletext.bottom
            anchors.topMargin: popup.height *0.06
            anchors.leftMargin: popup.height *0.01
            wrapMode: Text.WordWrap
            width:parent.width* 0.98
            text:message

            anchors.margins: 5
            font.pixelSize: popup.height * 0.03 - text.length


        }
        Rectangle {
            id:quotebox
           // visible: if(aquote != "") {true} else {false}
            visible: false

            color:cardcolor
            radius:5
            anchors.top:themessage.bottom
            anchors.topMargin:messageblock.height * 0.03
            width:parent.width * 0.92
            height:thequote.height+10
            clip:true

            anchors.right:parent.right
            anchors.rightMargin: popup.height * 0.01
            Text {
                id:thequote
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
                width:parent.width* 0.98
                text:aquote
                //horizontalAlignment: Text.AlignHCenter
               // anchors.fill:parent
                anchors.margins: 5
                font.pixelSize: popup.height * 0.02 - text.length
            }
        }
        DropShadow {
                visible: if(aquote != "") {true} else {false}
               anchors.fill: quotebox
               horizontalOffset: 0
               verticalOffset: 4
               radius: 6.0
               samples: 17
               color: "#80000000"
               source: quotebox
               z:1
        }

        Image {
            id:postImage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:themessage.bottom
            anchors.topMargin:messageblock.height * 0.01
            width:parent.width * 0.98
            fillMode: Image.PreserveAspectFit
            source:postimg
            visible: if(postimg != "") {true} else {false}

        }
    }

    DropShadow {
           anchors.fill: messageblock
           horizontalOffset: 0
           verticalOffset: 2
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: messageblock
           z:1
            }
         }

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
        color:backgroundColor
        radius:10
       // border.color:"black"

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
                        reversible:true
            PropertyAnimation { target: blinder
                                      properties:"y,radius,color"; duration: 500 }
        }

    Item {
        id:links
        height:parent.height * 0.80
        width:parent.width
        opacity:0
        clip:true

        Image {
            id:servicelogo
            z:1
            source:pluginlogo
            width:parent.width * 0.10
            height:parent.height * 0.10
            fillMode:Image.PreserveAspectFit
            anchors.left:parent.left




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
            width:parent.width * 0.90
            //anchors.top:accountname.bottom
            anchors.right:parent.right
            anchors.verticalCenter: servicelogo.verticalCenter
            anchors.margins:12
            spacing:10


            Item {
                width:links.width * 0.30
                 height:links.height * 0.08
                 Rectangle {
                     anchors.fill:parent
                     color:highLightColor1
                     opacity:0.9
                 }

                 /*Flasher {
                     //anchors.fill:parent
                     id:wrflasher
                 } */

               /* Image {
                     source:"../img/message-sent.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter */

                 Text {
                        anchors.centerIn: parent
                        //anchors.leftMargin: 10
                       // anchors.left:parent.right
                         text:qsTr("Tweets & Replies")
                         //anchors.verticalCenter: parent.verticalCenter
                         font.pixelSize: parent.height * 0.3

                     }
                // }
                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = "https://twitter.com/"+page.split("::")[1]+extrathing+"with_replies"
                        Qt.openUrlExternally(showurl);
                       // fullWeb.state = "show"
                       // cardPage.header.hide()
                    }

                    //onClicked:Qt.openUrlExternally(showurl);

                    onReleased:wrflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.30
                 height:links.height * 0.08
              /*   Flasher {
                     //anchors.fill:parent
                     id:mediaflasher
                 } */

               /* Image {
                     source:"../img/message.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter */

                 Rectangle {
                     anchors.fill:parent
                     color:highLightColor1
                     opacity:0.9
                 }

                 Text {
                        id:pav
                        //anchors.leftMargin: 10
                      //  anchors.left:parent.right
                         text:qsTr("Photos & Videos")
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
                        showurl = "https://twitter.com/"+page.split("::")[1]+extrathing+"media"
                        Qt.openUrlExternally(showurl);
                        //fullWeb.state = "show"
                        //cardPage.header.hide()
                    }
                    onReleased:mediaflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.30
                 height:links.height * 0.08

                 Rectangle {
                     anchors.fill:parent
                     color:highLightColor1
                     opacity:0.9
                 }

               /*  Flasher {
                     //anchors.fill:parent
                     id:followersflasher
                 } */

                /*Image {
                     source:"../img/contact-group.svg"
                         width:parent.height * 0.80
                         height:parent.height * 0.80
                         anchors.verticalCenter: parent.verticalCenter */

                 Text {
                        //anchors.leftMargin: 10
                        //anchors.left:parent.right
                         text:qsTr("Followers")
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
                        showurl = "https://twitter.com/"+page.split("::")[1]+extrathing+"followers"
                        Qt.openUrlExternally(showurl);
                        //fullWeb.state = "show"
                        //cardPage.header.hide()
                    }
                    onReleased:followersflasher.state = "InActive"
                }
            }


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
                 state:"Loading"

                 transitions: Transition {
                                reversible: true
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




