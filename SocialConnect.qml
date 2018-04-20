import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
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
    property string info: ""
    property string type: ""
    property string useraccount: ""

    property int po: 0

    property string currentservice:""

    property string theservice: ""
    property string theserviceLogo: ""
    property string theaccount: ""

    property bool preview: false

    MouseArea {
        anchors.fill:parent

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



    onStateChanged: if(thisWindow.state == "Active") {servicecheck.start();OpenSeed.socialaccounts();settingsPage.enabled = false;
                        if(type == "intergration") {
                            switch(po) {
                            case 0: useraccount = usermain;break;
                            case 1: useraccount = website1;break;
                            case 2: useraccount = website2;break;
                            case 3: useraccount = website3;break;
                            case 4: useraccount = website4;break;
                            }
                        }
                    } else {preview = false,currentservice ="",service="",useraccount="",avatar = "",profilename = "",info = "",servicecheck.stop();settingsPage.enabled = true;}

    Timer {
        id:servicecheck
        running:true
        repeat: false
        interval: 800
        onTriggered: if(account.text.length > 2 || account1.text.length > 2) {if(type == "avatar") {OpenSeed.serviceConnect(service,account.text);} else {
                             if(currentservice == "") {
                             OpenSeed.serviceConnect(useraccount.split("::")[0],account1.text);
                                 preview = true;
                             } else {
                                 OpenSeed.serviceConnect(currentservice,account1.text);
                                  preview = true;
                                 console.log(currentservice,account1.text);
                             }

                         }
                     }
    }


    Item {
        id:typeAvatar
        anchors.fill: parent
        visible: if(type == "avatar") {true} else {false}


    Rectangle {
        id:backing
       // y:parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:parent.height
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
                         case "gravatar":useraccount;break;
                         case "twitter": useraccount.split("::")[1];break;
                         case "tumblr": useraccount.split("::")[1];break;
                         case "soundcloud":useraccount.split("::")[1];break;
                         case "blog": useraccount;break;
                         default:"";
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
                        source:"./icons/find.svg"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: OpenSeed.serviceConnect(service,useraccount)
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
                source:"./icons/check.svg"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                            if (type == "avatar") {
                                    avimg = avatar;
                                }
                            if(type == "intergration") {
                                 switch(service) {
                                    case "twitter": if(account.text.length > 0 ) {website1 = "twitter::"+account.text} else {website1 =""};break;
                                    case "tumblr":if(account.text.length > 0 ) { website2 = "tumblr::"+account.text} else {website2 =""};break;
                                    //case "kickstarter": website3 = "kickstarter::"+account.text;break;
                                    case "soundcloud":if(account.text.length > 0 ) { website4 = "soundcloud::"+account.text} else {website4 =""};break;
                                    case "blog":usermain = account.text;break;
                                 }
                            }
                            servicecheck.stop()
                            thisWindow.state = "InActive";
                    }
            }
        }

        Text {
            text:switch(service) {
                 case "gravatar":"Gravatar";break;
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
                width:parent.width * 0.6
                height:parent.height * 0.6
                source:"./icons/close.svg"
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

    Item {
        id:typeIntergrate
        anchors.fill: parent
        visible: if(type == "intergration") {true} else {false}

        Rectangle {
            id:backing1
            //y:parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            height:parent.height
            color:cardcolor
            border.color: "black"
            border.width:1
            radius: 4


            Item {
                width:parent.width
                height:parent.height
              //  spacing:parent.height * 0.05

                ListView {
                    id:socialSelect
                    anchors.centerIn: parent
                    width:parent.width
                    height:parent.height * 0.98
                    layoutDirection: ListView.LeftToRight
                    orientation: Qt.Horizontal
                    snapMode:ListView.SnapOneItem
                    spacing:thisWindow.height * 0.01
                    clip:true
                    onContentXChanged: {theservice = ""; preview = false; useraccount = ""}
                    onMovingHorizontallyChanged: if(socialSelect.movingHorizontally == true) {currentservice = "";taptitle.visible = false;} else {taptitle.visible = true;}
                    model: socialaccountslist

                    delegate: SocialOptfull {
                                 width:thisWindow.width
                                 height:thisWindow.height * 0.98

                                 sourceselected:if(useraccount.length > 2) {useraccount.split("::")[0]} else  {currentservice}

                                 MouseArea {
                                     anchors.fill: parent
                                     onClicked: {theserviceLogo = serviceLogo; theservice = service; currentservice = service}
                                 }

                            }

                    Rectangle {
                        anchors.centerIn:pagedots
                        width:pagedots.width * 1.2
                        height:pagedots.height * 1.6
                        radius: parent.height * 0.1
                        color:Qt.rgba(0.4,0.4,0.4,0.4)
                    }

                    Row {
                        id:pagedots
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom:parent.bottom
                        anchors.bottomMargin: parent.height * 0.05
                        spacing: parent.width * 0.02
                    Repeater {
                            model:socialSelect.count
                            id:pageIndicator
                            Rectangle {
                                       width: mainView.height * 0.014
                                       height: mainView.height * 0.014
                                       border.width: 1
                                       border.color:barColor
                                       color: if(index == socialSelect.indexAt(socialSelect.contentX,0)) {highLightColor1} else {Qt.rgba(9,9,9,0);}
                                       radius:width /2




                                        MouseArea {
                                            anchors.fill:parent
                                            onClicked: socialSelect.positionViewAtIndex(index,ListView.Center)
                                        }
                                   }

                            }
                    }


                }

                /*Text {
                    text:account.text.length
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 32
                } */

                Text {
                    id:taptitle
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom:account1.bottom
                    text:qsTr("Tap to add Source")
                   ///color:if(bgcolor == cardcolor) {"black"} else {"white"}
                    color:"black"
                    width:parent.width
                    horizontalAlignment:Text.AlignHCenter
                    font.pixelSize: parent.width * 0.04
                    wrapMode: Text.WordWrap
                    visible: if(currentservice =="") {true} else {false}
                }

                TextField {
                        id:account1
                        text:if(useraccount.length > 2) {useraccount.split("::")[1]}else {""}
                        anchors.bottom:parent.bottom
                        anchors.bottomMargin: parent.height * 0.1
                        visible: if(currentservice == "") {false} else {true}
                       // enabled: if(visible == true) {true} else {false}
                        placeholderText: if(useraccount.length > 2){Scripts.socialsetup(useraccount.split("::")[0]).split("::")[4]} else if (currentservice.length > 2){Scripts.socialsetup(currentservice).split("::")[4]} else {""}
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 32
                        width:parent.width * 0.80
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
                            source:"./icons/find.svg"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: OpenSeed.serviceConnect(useraccount.split("::")[0],account1.text)
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
                    width:parent.width * 0.6
                    height:parent.height * 0.6
                    source:"./icons/check.svg"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                                if(type == "intergration") {

                                        if(currentservice == "") {
                                            switch(po) {
                                                case 0: usermain = useraccount.split("::")[0]+"::"+account1.text;break;
                                                case 1: website1 = useraccount.split("::")[0]+"::"+account1.text;break;
                                                case 2: website2 = useraccount.split("::")[0]+"::"+account1.text;break;
                                                case 3: website3 = useraccount.split("::")[0]+"::"+account1.text;break;
                                                case 4: website4 = useraccount.split("::")[0]+"::"+account1.text;break;
                                            }
                                        } else {
                                            switch(po) {
                                                case 0: usermain = currentservice+"::"+account1.text;break;
                                                case 1: website1 = currentservice+"::"+account1.text;break;
                                                case 2: website2 = currentservice+"::"+account1.text;break;
                                                case 3: website3 = currentservice+"::"+account1.text;break;
                                                case 4: website4 = currentservice+"::"+account1.text;break;
                                            }


                                        }


                                }
                                servicecheck.stop()
                                thisWindow.state = "InActive";
                        }
                }
            }

           /* Text {
                text:if(useraccount.length >2) {Scripts.socialsetup(useraccount.split("::")[0]).split("::")[0]} else {currentservice.toLocaleUpperCase()}


                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20

                font.pixelSize: 32
            } */



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
                    width:parent.width * 0.6
                    height:parent.height * 0.6
                    source:"./icons/close.svg"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: thisWindow.state = "InActive"
                }
            }







        }

        DropShadow {
            anchors.fill:backing1
            horizontalOffset: 2
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:backing1
            //z:1
        }



    }





    ListModel {
            id:socialaccountslist
                        }
}
