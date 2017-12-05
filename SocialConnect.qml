import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

Item {

    id:thisWindow
    property string service: ""
    property string avatar: ""
    property string profilename: "none"


    states: [

            State {
                name: "Active"

                PropertyChanges {
                    target: thisWindow
                    x:0
                }
        },

        State {
            name:"InActive"

            PropertyChanges {
                target: thisWindow
                x:width
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
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }

        }


    ]

    onStateChanged: if(thisWindow.state == "Active") {/*OpenSeed.serviceConnect(service,account.text) */} else {avatar = "",profilename = "",account.text = ""}

    Rectangle {
        id:backing
        y:parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.95
        height:parent.height * 0.80
        color:cardcolor

        Column {
            width:parent.width
            height:parent.height
            spacing:40

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.5
                height:parent.width * 0.5

                         Image {
                                 id:photo
                                 anchors.fill:parent

                             fillMode: Image.PreserveAspectFit
                            source: switch(service) {
                                    case "gravatar": "./img/gravatarlogo.jpg";break;
                                    case "twitter": "./img/twitter.png";break;
                                    case "tumblr": "./img/tumblr.png";break;
                                    case "soundcloud":"./img/soundcloud.png";break;
                                    default: "";break;
                                    }
                                visible: false

                                Image {
                                        id:av
                                        anchors.fill:parent

                                    fillMode: Image.PreserveAspectFit
                                   source:avatar
                                       //visible: false
                                   }
                            }



                     Image {
                         id:mask
                         anchors.fill:parent
                         source:"/graphics/CafeSync.png"
                        visible: false

                     }

                    OpacityMask {
                            id:opmask
                             anchors.fill: photo
                             source: photo
                             maskSource: mask

                         }

                        DropShadow {
                         anchors.fill:opmask
                         horizontalOffset: 2
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                     source:opmask
                     z:1
                 }

            }

            Text {
                text:switch(service) {
                     case "gravtar":"Connect to Gravtar";break;
                     case "soundcloud":"Connect to SoundCloud";break;
                     case "twitter":"Connect to Twitter";break;
                     case "tumblr":"Connect to Tumblr";break;
                     }

                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
            }

            Text {
                text:profilename
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
            }

            TextField {
                    id:account
                    text:""
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
                width:parent.width * 0.98

                Rectangle {
                    anchors.right:parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width:parent.height * 0.8
                    height:parent.height * 0.8
                    color:highLightColor1
                    radius: width /2

                    Image {
                        anchors.centerIn: parent
                        source:"./img/check.svg"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: OpenSeed.serviceConnect(service,account.text)
                    }
                }
            }


    }


        Rectangle {
            anchors.bottom:parent.bottom
            anchors.right:parent.right
            width:parent.width * 0.1
            height:parent.width *0.1
            anchors.margins: 20
            color:highLightColor1
            radius: width /2

            Image {
                anchors.centerIn: parent
                source:"./img/check.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: thisWindow.state = "InActive", avimg = avatar.source
            }
        }

        Rectangle {
            anchors.bottom:parent.bottom
            anchors.left:parent.left
            width:parent.width * 0.1
            height:parent.width *0.1
            anchors.margins: 20
            color:highLightColor1
            radius: width /2

            Image {
                anchors.centerIn: parent
                source:"./img/close.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: thisWindow.state = "InActive"
            }
        }

    }


    DropShadow {
        anchors.fill:backing
        horizontalOffset: 2
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: "#80000000"
        source:backing
        //z:1
    }

}
