import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
    id:thisWindow


    property string name: ""
    property string email: ""
    property string phone: ""
    property string about: ""
    property string mainsite: ""

    states: [
        State {
            name: "InActive"
            PropertyChanges {
                target: thisWindow
                x:0
                y:parent.height
            }
        },
        State {
            name: "Active"
            PropertyChanges {
                target: thisWindow
                x:0
                y:parent.height * 0.02
            }
        }

    ]
    state: "InActive"

    Rectangle {
        anchors.fill: slideview
        color:backgroundColor
        //color:"green"
    }

    onStateChanged: if(thisWindow.state == "Active") {topBar.state = "Wizard"} else {topBar.state = "standard"}

    GridView {
            id:slideview
            width:parent.width
            height:parent.height
           // y:parent.height * 0.08
        snapMode: GridView.SnapOneRow
        //flow: GridView.FlowLeftToRight
        flow:GridView.FlowTopToBottom
        boundsBehavior: Flickable.DragAndOvershootBounds
        flickableDirection: Flickable.VerticalFlick
       // highlightFollowsCurrentItem: true
        focus:true
        visible: true
        //cellHeight: units.gu(26)
        clip:true
        cacheBuffer : 80
        cellHeight:parent.height //passerbyGrid.height
        cellWidth: thisWindow.width


        delegate: Item {
                    width:slideview.cellWidth
                     height:slideview.cellHeight
                     Rectangle {

                            anchors.centerIn: parent
                            width: parent.width * 0.95
                            height: parent.height * 0.8
                            id:dialogue1

                        color:cardcolor
                        clip: true

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: parent.height * 0.90
                            spacing: 20
                        Text {
                            text: thetitle
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 48

                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: 3
                            color: highLightColor1
                        }

                        Text {
                            width:parent.width * 0.9
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            text:message
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18

                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: 3
                            color: highLightColor1
                        }

                        Item {
                            visible: if(type == 3) {true} else {false}
                            width: parent.width
                            height: parent.height * 0.1

                        TextField{
                             id:osUsernameField
                             anchors.top:parent.top
                             anchors.topMargin:10
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.85
                             placeholderText: qsTr("User Name")
                             horizontalAlignment: Text.AlignHCenter
                             text:osUsername
                             onTextChanged: uniquename = 0, osUsername = text,OpenSeed.checkcreds(osUsername,osPassphrase);


                         }

                        TextField{
                            id:osEmailField
                            anchors.top:osUsernameField.bottom
                            anchors.topMargin:15
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.85
                            placeholderText: qsTr("Email")
                           horizontalAlignment: Text.AlignHCenter
                            text:osEmail
                            onTextChanged:uniquename = 0,osEmail = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                        }

                         TextField{
                             id:osPassField
                             anchors.top:osEmailField.bottom
                            anchors.topMargin:15
                              anchors.horizontalCenter: parent.horizontalCenter
                              width:parent.width * 0.85
                             placeholderText: qsTr("Passphrase")
                             horizontalAlignment: Text.AlignHCenter
                             echoMode: TextInput.Password
                             text:osPassphrase
                             onTextChanged:uniquename = 0,osPassphrase = text,OpenSeed.checkcreds(osUsername,osPassphrase);


                         }

                         Rectangle {
                             id:connectB
                             anchors.top: osPassField.bottom
                             anchors.horizontalCenter: parent.horizontalCenter
                             anchors.topMargin: 30
                             width: parent.width * 0.45
                             height: 60
                             color:highLightColor1
                             radius:4

                              Text {
                                  anchors.centerIn: parent
                                  text:qsTr("Connect")
                                  color:"black"
                                  font.pixelSize: 24
                              }

                              MouseArea {
                                  anchors.fill: parent

                              onClicked:
                                  { if(osEmail.length > 2) {
                                     if(osUsername.length > 2) {
                                        //  console.log("sending info to server");
                                          OpenSeed.oseed_auth(osUsernameField.text,osEmailField.text,osPassField.text);

                                                  //OpenSeed.datasync(userid);
                                                 //Scripts.load_Card();
                                                  //OpenSeed.retrieve_data(userid);
                                                //  settingsPage.state = "Active";
                                                //  slideshow.state = "Active";
                                               //  firstrun.state = "close";
                              }}}
                                }

                         }

                         DropShadow {
                             anchors.fill:connectB
                             horizontalOffset: 0
                             verticalOffset: 4
                             radius: 8.0
                             samples: 17
                             color: "#80000000"
                             source:connectB
                             z:1
                         }

                  }

            }

                        Image {
                            id: logo
                            source:image
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.margins: 10
                            width: 64
                            height: 64
                        }

            }

            DropShadow {
                anchors.fill:dialogue1
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: "#80000000"
                source:dialogue1
                z:1
            }

        }






        model: slides


    }




    ListModel {
            id:slides
        ListElement {
            thetitle: qsTr("Welcome")
            message:  qsTr("CafeSync is a location based card sharing service. That connects you to the world around you")
            type:1
            image:"./img/overlay-dark.png"
        }
        ListElement {
            thetitle: qsTr("EULA")
            message:qsTr("")
            type:2
            image:"./img/OpenSeed.png"
        }
        ListElement {
            thetitle: qsTr("OpenSeed Connect")
            message:qsTr("OpenSeed's network is used for app and user authentication as well as the background services that relies on.\n\n(Note: If you don't have an account the system will create one for you.) ")
            type:3
            image:"./img/OpenSeed.png"
        }
        ListElement {
            thetitle: qsTr("Your Card")
            message:  qsTr("Now that you're connected to OpenSeed's network we'll need to setup your CafeSync card.\n\n We'll get the easy stuff out of the way here, but it will be up to you to finish your profile.")
            type:1
            image:"./img/overlay-dark.png"
        }

        ListElement {
            thetitle: qsTr("Who?")
            message:qsTr("Who Are you?")
            type:4
            image:"./img/contact.svg"
        }

        ListElement {
            thetitle: qsTr("What?")
            message:qsTr("What do you do?")
            type:5
            image:"./img/overlay-dark.png"
        }

        ListElement {
            thetitle: qsTr("How?")
            message:qsTr("How Can others contact you?")
            type:6
            image:"./img/email.svg"
        }

        ListElement {
            thetitle: qsTr("Online")
            message:qsTr("To make your card shine consider connecting to one or more of these services")
            type:7
            image:"./img/stock_website.svg"
        }

        ListElement {
            thetitle: qsTr("Say Cheese!")
            message:qsTr("A picture is worth a thousand words. How do you want the world to know you.\n Take a picture or choose from a list of compatable services on the nex page!")
            type:1
            image:"./img/stock_website.svg"
        }

        ListElement {
            thetitle: qsTr("Show Time")
            message:""
            type:8
            image:"./img/camera-photo.svg"
        }
    }



/*

Item {

                        width:parent.cellWidth
                        height:parent.cellHeight

                        id: slide

                     Rectangle {

                            anchors.centerIn: parent
                            width: parent.width * 0.95
                            height: parent.height * 0.8
                            id:dialogue1

                        color:cardcolor
                        clip: true

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: parent.height * 0.80
                            spacing: 20
                        Text {
                            text: thetitle
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 48

                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: 3
                            color: highLightColor1
                        }

                        Text {
                            width:parent.width * 0.9
                            wrapMode: Text.WordWrap
                            text: qsTr("CafeSync is a location based card sharing service. That connects you to the world around you")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18

                        }


                        }

                        Image {
                            id: logo
                            source: "./img/overlay-dark.png"
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.margins: 10
                            width: 64
                            height: 64
                        }

            }

            DropShadow {
                anchors.fill:dialogue1
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: "#80000000"
                source:dialogue1
                z:1
            }



}





    Item {
        x:0
       // y:0
        //anchors.fill:parent
        width:parent.width
        height:parent.height
       // anchors.top:topBar.bottom
        id: openseedLogin
       // anchors.margins: 50


        states: [
            State {
                name: "InActive"
                PropertyChanges {
                    target: openseedLogin
                    x:parent.width

                }
            },
            State {
                name: "Active"
                PropertyChanges {
                    target: openseedLogin
                    x:0

                }
            }

        ]
        state: "InActive"




        Rectangle {
                    //anchors.fill:parent
                    //anchors.margins: 100
                  //  x: parent.width * 0.1
                   // y: parent.height * 0.1
                    anchors.centerIn: parent
                    width: parent.width * 0.95
                    height: parent.height * 0.8
                   // radius: 6
                  //  border.width:1
                   // border.color:"black"
                    color:cardcolor
                    clip: true

                     id: dialogue2


                     Image {

                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.top:parent.top
                         anchors.topMargin: parent.height * 0.1
                         source:"img/OpenSeed.png"
                         fillMode: Image.PreserveAspectFit
                         //height:parent.height * 0.14
                         width:parent.width * 0.5
                     }

                     Text {
                     id:diaTitle
                     anchors.top:logo.bottom
                     anchors.horizontalCenter:parent.horizontalCenter
                     anchors.topMargin: 5
                     text: qsTr("Connect to OpenSeed")
                     horizontalAlignment: Text.AlignHCenter
                     color:"black"
                        }
                     Text {

                     id:diaSubTitle
                     anchors.top:diaTitle.bottom
                     anchors.topMargin: 5
                     anchors.horizontalCenter: parent.horizontalCenter
                     width:parent.width - 10
                     text: qsTr("CafeSync uses the Openseed network for app and user authentication.")
                     wrapMode:Text.Wrap
                     horizontalAlignment: Text.AlignHCenter
                     color:"black"
                        }


                    TextField{
                         id:osUsernameField
                         anchors.top:diaSubTitle.bottom
                         anchors.topMargin:10
                         anchors.horizontalCenter: parent.horizontalCenter
                         width:parent.width - 10
                         placeholderText: qsTr("User Name")
                         horizontalAlignment: Text.AlignHCenter
                         text:osUsername
                         onTextChanged: uniquename = 0, osUsername = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                     }

                    TextField{
                        id:osEmailField
                        anchors.top:osUsernameField.bottom
                        anchors.topMargin:10
                         anchors.horizontalCenter: parent.horizontalCenter
                         width:parent.width - 10
                        placeholderText: qsTr("Email")
                       horizontalAlignment: Text.AlignHCenter
                        text:osEmail
                        onTextChanged:uniquename = 0,osEmail = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                    }

                     TextField{
                         id:osPassField
                         anchors.top:osEmailField.bottom
                         anchors.topMargin:10
                          anchors.horizontalCenter: parent.horizontalCenter
                          width:parent.width - 10
                         placeholderText: qsTr("Passphrase")
                         horizontalAlignment: Text.AlignHCenter
                         echoMode: TextInput.Password
                         text:osPassphrase
                         onTextChanged:uniquename = 0,osPassphrase = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                     }



                    /* Text {
                                text:switch(uniquename) {
                                     case 0:qsTr("In Use");break;
                                     case 1:qsTr("Available");break;
                                     case 2:if(osUsername.length > 2) {qsTr("Welcome Back")} else {qsTr("No User Name")};break;
                                     default:qsTr("No User Name");break;
                                     }
                                color:switch(uniquename) {
                                      case 0:"Red";break;
                                      case 1:"Black";break;
                                      case 2:"Black";break;
                                      default:"white";break;
                                      }

                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 24
                                anchors.top:osPassField.bottom

                            }


                 }

        DropShadow {
            anchors.fill:dialogue2
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:dialogue2
            z:1
        }

    }*/




    Rectangle {
        id:bottomBar
        anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height * 0.08
        color:bottombarColor

    Row {
        spacing: 10
        anchors.bottom:parent.bottom
        anchors.bottomMargin:10
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            text: qsTr("Cancel")
            onClicked: firstrun.state = "close",Qt.quit();
        }

     Button {
         text: qsTr("Okay")
         //color: highLightColor1
         onClicked:
             { if(osEmail.length > 2) {
                if(osUsername.length > 2) {
                     console.log("sending info to server");
                     OpenSeed.oseed_auth(osUsernameField.text,osEmailField.text,osPassField.text);

                             //OpenSeed.datasync(userid);
                            //Scripts.load_Card();
                             //OpenSeed.retrieve_data(userid);
                             settingsPage.state = "Active";
                             slideshow.state = "Active";
                            firstrun.state = "close";
         }}}

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
