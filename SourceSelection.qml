import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property int selectedAsspect: 90
    id:thisWindow
    states: [

        State {
            name:"Active"

            PropertyChanges {
                target: thisWindow
                y:0
            }
    },

        State {
            name:"InActive"
            PropertyChanges {
                target: thisWindow
                y:height * -1
            }

    }

    ]


     transitions: [
         Transition {
             from: "InActive"
             to: "Active"
             reversible: true


             NumberAnimation {
                 target: thisWindow
                 property: "y"
                 duration: 200
                 easing.type: Easing.InOutQuad
             }
         }
     ]


     onStateChanged: if(thisWindow.state == "Active"){photo.state ="Show"} else {photo.state ="Hide"}


    Rectangle {
        anchors.fill: parent
        color:backgroundColor
    }


    Column {

            width:parent.width
            height:parent.height
            spacing:15

        GetPic {
               id:photo
               //anchors.centerIn: center
                width:parent.width
                height:parent.height * 0.5
               state:"Show"
            }

        Rectangle {
            width:parent.width
            height:4
            color:highLightColor1
        }
       /* Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Previous Photos")
            font.pixelSize: 18

        } */

        ListView {
            width:parent.width
            height: 64

        }

    Rectangle {
        width:parent.width
        height:4
        color:highLightColor1
    }

   /* Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Other Sources")
        font.pixelSize: 18

    } */


    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Item {
            id:gravatarButton
           // anchors.horizontalCenter: parent.horizontalCenter
           // anchors.top:tumblrButton.bottom
           // anchors.topMargin: 20
            width:parent.width * 0.49
            height:60

         Rectangle {
            id:ksb
            anchors.fill: parent
            color:"#0E75B8"
            radius:5
            border.color: "white"

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.98
                height:parent.height
                clip:true
                spacing: 10
                Image {
                    source:"./img/gravatarlogo.jpg"
                    height:parent.height * 0.9
                    width:parent.height * 0.9
                    anchors.verticalCenter: parent.verticalCenter

                }

                Rectangle {
                    height:parent.height * 0.9
                    color:"white"
                    width:3
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text:"Use Gravatar"
                    color:"white"
                    width:parent.width
                    font.pixelSize: parent.height * 0.3
                    wrapMode: Text.WordWrap
                }
            }
        }

         DropShadow {

            anchors.fill: ksb
            horizontalOffset: 0
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: ksb
            z:1



              }
          }

         Item {
             id:soundcloudButton
             //anchors.horizontalCenter: parent.horizontalCenter
             //anchors.top:kickstarterButton.bottom
            // anchors.topMargin: 20
             width:parent.width * 0.49
             height:60


        Rectangle {
            id:scb
            anchors.fill: parent
            color:"#FF3700"
            radius:5
            border.color: "white"

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.98
                height:parent.height
                clip:true
                spacing: 10
                Image {
                    source:"./img/soundcloud.png"
                    height:parent.height * 0.9
                    width:parent.height * 0.9
                    anchors.verticalCenter: parent.verticalCenter

                }

                Rectangle {
                    height:parent.height * 0.9
                    color:"white"
                    width:3
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text:"Use SoundCloud"
                    color:"white"
                    font.pixelSize: parent.height * 0.3
                    width:parent.width
                    wrapMode: Text.WordWrap
                }
            }
        }

        DropShadow {

           anchors.fill: scb
           horizontalOffset: 0
           verticalOffset: 3
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: scb
           z:1



             }
         }
    }

    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Item {
            id:twitterButton
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.top:tumblrButton.bottom
           // anchors.topMargin: 20
            width:parent.width * 0.49
            height:60

         Rectangle {
            id:twb
            anchors.fill: parent
            color:"lightblue"
            radius:5
            border.color: "white"

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.98
                height:parent.height
                clip:true
                spacing: 10
                Image {
                    source:"./img/twitter.png"
                    height:parent.height * 0.9
                    width:parent.height * 0.9
                    anchors.verticalCenter: parent.verticalCenter

                }

                Rectangle {
                    height:parent.height * 0.9
                    color:"white"
                    width:3
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text:"Use Twitter"
                    color:"white"
                    width:parent.width
                    font.pixelSize: parent.height * 0.3
                    wrapMode: Text.WordWrap
                }
            }
        }

         DropShadow {

            anchors.fill: twb
            horizontalOffset: 0
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: twb
            z:1



              }
          }

         Item {
             id:tumblrButton
             //anchors.horizontalCenter: parent.horizontalCenter
             //anchors.top:kickstarterButton.bottom
            // anchors.topMargin: 20
             width:parent.width * 0.49
             height:60


        Rectangle {
            id:trb
            anchors.fill: parent
            color:"#343460"
            radius:5
            border.color: "white"

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.98
                height:parent.height
                clip:true
                spacing: 10
                Image {
                    source:"./img/tumblr.png"
                    height:parent.height * 0.9
                    width:parent.height * 0.9
                    anchors.verticalCenter: parent.verticalCenter

                }

                Rectangle {
                    height:parent.height * 0.9
                    color:"white"
                    width:3
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text:"Use Tumblr"
                    color:"white"
                    font.pixelSize: parent.height * 0.3
                    width:parent.width
                    wrapMode: Text.WordWrap
                }
            }
        }

        DropShadow {

           anchors.fill: trb
           horizontalOffset: 0
           verticalOffset: 3
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: trb
           z:1



             }
         }
    }

}



    Rectangle {
        id:bottomBar
        anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height * 0.08
        color:bottombarColor

   /* Image {
        id:privimg
        anchors.centerIn: parent
        width:parent.height * 0.7
        height: parent.height * 0.7
        fillMode:Image.PreserveAspectFit
        source:if(stf == "true") {"./img/share.svg"} else {"./img/private-browsing.svg"}

        Flasher{
            id:privateb
           // state: if(stf =="true") {"InActive"} else {"Enabled"}
        }
        MouseArea {
            anchors.centerIn: parent
            width:parent.width * 1.2
            height:parent.height * 1.2
            //onPressed:privateb.state = "Active"
          //  onReleased:privateb.state = "InActive"

            preventStealing: true
            onClicked: { if(stf == "true") {stf = "false"; } else { stf = "true";}
                Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                          useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                          stf,atf,ctf,avimg,carddesign,usercat);
                                                        OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                             useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                             avimg,carddesign,usercat);

            }


        }
    } */

        Rectangle {
            color:highLightColor1
            width:parent.width * 0.36
            height:parent.height * 0.90
            anchors.centerIn: parent
            Text {
                anchors.centerIn: parent
                color:"black"
                text:qsTr("Cancel")
                font.pixelSize: 20
            }

            MouseArea {
                anchors.fill: parent
                onClicked: photo.state = "Hide", thisWindow.state = "InActive"
            }
        }


    }

    DropShadow {
        anchors.fill:bottomBar
        horizontalOffset: 0
        verticalOffset: -4
        radius: 8.0
        samples: 17
        color: "#80000000"
        source:bottomBar
        z:1
    }

}
