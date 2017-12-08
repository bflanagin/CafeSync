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
    property string type: ""

    MouseArea {
        anchors.fill:parent

    }

    Timer {
        id:servicecheck
        running:true
        repeat: false
        interval: 800
        onTriggered: if(account.text.length > 2) {OpenSeed.serviceConnect(service,account.text)}
    }

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

    onStateChanged: if(thisWindow.state == "Active") {servicecheck.start();
                        } else {avatar = "",profilename = "",servicecheck.stop();}

    Rectangle {
        id:backing
        y:parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.95
        height:parent.height * 0.80
        color:cardcolor
        border.color: "black"
        border.width:1
        radius: 4

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
                            source: if(avatar == "") {switch(service) {
                                    case "gravatar": "./img/gravatarlogo.jpg";break;
                                    case "twitter": "./img/twitter.png";break;
                                    case "tumblr": "./img/tumblr.png";break;
                                    case "soundcloud":"./img/soundcloud.png";break;
                                   // case "kickstarter":"./img/kickstarter.png";break;
                                    default: "./img/stock_website.svg";break;
                                    }
                                    } else {""}
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

                 }

                        Image {
                            width:32
                            height:32
                            anchors.right:parent.right
                            anchors.bottom:parent.bottom
                            //anchors.bottomMargin: parent.width * 0.2
                            source:if(avatar != ""){switch(service) {
                                       case "gravatar": "./img/gravatarlogo.jpg";break;
                                       case "twitter": "./img/twitter.png";break;
                                       case "tumblr": "./img/tumblr.png";break;
                                       case "soundcloud":"./img/soundcloud.png";break;
                                       case "kickstarter":"./img/kickstarter.png";break;
                                       default: "./img/stock_website.svg";break;
                                       }
                                   } else {""}
                        }

            }

            Text {
                text:profilename
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
            }

            TextField {
                    id:account
                    text:switch(service) {
                         case "gravatar":useremail;break;
                         case "twitter": website1.split("::")[1];break;
                         case "tumblr": website2.split("::")[1];break;
                         case "soundcloud":website4.split("::")[1];break;
                         //case "kickstarter":"./img/kickstarter.png";break;
                         default: usermain;break;
                         }
                    placeholderText: switch(service) {
                                     case "gravatar":"user@example.com";break;
                                     case "twitter":"@username";break;
                                     case "tumblr":"blogtitle";break;
                                     case "soundcloud":"bandname";break;
                                     //case "kickstarter":"./img/kickstarter.png";break;
                                     default:"www.blog.com";break;
                                     }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32
                width:parent.width * 0.98
                     onTextChanged: servicecheck.restart()

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
                        width:parent.width * 0.7
                        height:parent.height * 0.7
                        source:"./img/find.svg"
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
                width:parent.width * 0.7
                height:parent.height * 0.7
                source:"./img/check.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                            if (type == "avatar") {
                                    avimg = avatar;
                                }
                            if(type == "intergration") {
                                 switch(service) {
                                    case "twitter": website1 = "twitter::"+account.text;break;
                                    case "tumblr": website2 = "tumblr::"+account.text;break;
                                    //case "kickstarter": website3 = "kickstarter::"+account.text;break;
                                    case "soundcloud": website4 = "soundcloud::"+account.text;break;
                                    case "blog": usermain = account.text;break;
                                 }
                            }
                            servicecheck.stop()
                            thisWindow.state = "InActive";
                    }
            }
        }

        Text {
            text:switch(service) {
                 case "gravatar":"Gravtar";break;
                 case "soundcloud":"SoundCloud";break;
                 case "twitter":"Twitter";break;
                 case "tumblr":"Tumblr";break;
                 case "kickstarter":"KickStarter";break;
                 case "blog":"Website";break;
                 default:"";break;
                 }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            font.pixelSize: 32
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
                width:parent.width * 0.7
                height:parent.height * 0.7
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
