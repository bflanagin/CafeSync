import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2
import QtGraphicalEffects 1.0


import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string type: ""
    property string where: ""
    property string title:""
    property string company:""
    property string message:""

    //clip: true

    Timer {
        id:reload
        running: false
        repeat: false
        interval: 800
        onTriggered:{cardslist.clear();
            Scripts.cards_Load("");}
    }


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
                enabled:true

            }
           // PropertyChanges {
               // target: speaker1
                //thesource: currentcard_avatarimg

            //}


        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              visible:false
              enabled:false
          }

        }
    ]

    //anchors.centerIn: parent



    Item {
        id:sr
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            radius:mainView.width * 0.01
            color:backgroundColor
        }

    Item {
        visible:if(type == "send") {true} else {false}
        anchors.bottom:parent.bottom
        width: parent.width
        height: parent.height * 0.90
        //border.color:seperatorColor1
        clip:true


        Rectangle {
            id:whocard
            color:cardcolor
            width:parent.width * 0.98
            height:parent.height * 0.25
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                width: parent.width

            CirclePic {
                id:speaker1
                width:parent.width * 0.30
                height:parent.width * 0.30
                whichPic:currentcard_thecard
                where:listget
               // thesource: if(where == "mycard") {avimg} else {currentcard_avatarimg}

            }
            Column {
                width: parent.width * 0.70
                anchors.verticalCenter: parent.verticalCenter
                spacing: mainView.width * 0.04
                Text {
                    text:title
                    font.pixelSize: parent.width* 0.10
                    font.bold: true
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color:fontColorTitle

                    }
                Text {
                    text:company
                    width: parent.width * 0.60
                    horizontalAlignment: Text.AlignRight
                    anchors.right: parent.right
                    wrapMode: Text.WordWrap
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    font.pixelSize: parent.width* 0.06
                    color:fontColorTitle

                    }

            }

            }

        }

        Rectangle {
            anchors.top:whocard.bottom
            anchors.bottomMargin: mainView.width * 0.01
            width: parent.width
            height: mainView.width * 0.01
            color: seperatorColor1
        }

        Column {
            id:shareoptions
            width: parent.width * 0.95
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: mainView.width * 0.02
            spacing: mainView.width * 0.03

            Rectangle {
                width: parent.width
                height: popup.height * 0.18
                radius: mainView.width * 0.01

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.96
                    height: parent.height
                     spacing: mainView.width * 0.03
                    Image {
                        source:"./icons/overlay.svg"
                        width: parent.width * 0.15
                        height: parent.width * 0.15
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text:"CafeSync Code"
                        font.pixelSize: mainView.width * 0.05
                    }


                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {OpenSeed.onetime(currentcard_thecard,"1");shareoptions.visible = false; cafecode.visible = true;}
                }
            }
            Rectangle {
                width: parent.width
                height: popup.height * 0.18
                radius: mainView.width * 0.01

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.96
                    height: parent.height
                     spacing: mainView.width * 0.03
                    Image {
                        source:"./icons/message.svg"
                        width: parent.width * 0.15
                        height: parent.width * 0.15
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text:"Text Message"
                        font.pixelSize: mainView.width * 0.05
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked:

                        if(username != currentcard_username) {
                            Qt.openUrlExternally('sms:?body='+username+' wants you to view '+currentcard_username+'\'s card on CafeSync.
\nNever heard of CafeSync?

Find out more by checking out the link below.

https://www.vagueentertainment.com/?page_id=434

Sent from CafeSync');
                        } else {
                        Qt.openUrlExternally('sms:?body=Connect with '+username+' on CafeSync
\nNever heard of CafeSync?

Find out more by checking out the link below.

https://www.vagueentertainment.com/?page_id=434

Sent from CafeSync
                            ');
                }

                }
            }
            Rectangle {
                width: parent.width
                height: popup.height * 0.18
                radius: mainView.width * 0.01

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.96
                    height: parent.height
                     spacing: mainView.width * 0.03
                    Image {
                        source:"./icons/email.svg"
                        width: parent.width * 0.15
                        height: parent.width * 0.15

                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text:"Email Message"
                        font.pixelSize: mainView.width * 0.05
                    }


                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(username != currentcard_username) {console.log(currentcard);
                            Qt.openUrlExternally('mailto:?subject=CafeSync%20Invite&body='+username+' wants you to view '+currentcard_username+'\'s card on CafeSync.
\nNever heard of CafeSync?

Find out more by checking out the link below.

https://www.vagueentertainment.com/?page_id=434

Sent from CafeSync
                                ');
                        } else {

                        Qt.openUrlExternally('mailto:?subject=CafeSync%20Invite&body=Connect with '+username+' on CafeSync
\nNever heard of CafeSync?

Find out more by checking out the link below.

https://www.vagueentertainment.com/?page_id=434

Sent from CafeSync
                            '); }
                        }
                    }
             }
        }

        Item {
            id:cafecode
            visible: false
            anchors.centerIn: parent
            height: shareoptions.height
            width: shareoptions.width

        Text {
           // visible: false
            anchors.centerIn: parent
            text:message
            font.pixelSize: parent.width * 0.2 - text.length

            Text {
                anchors.top:parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("(Tap to close)")
            }

        }
        Text {
           // visible: false
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin:10
            text:qsTr("Warning: Closing this window invalidates code")
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {OpenSeed.onetime(currentcard_thecard,"0");
                        cafecode.visible = false;
                            shareoptions.visible = true;}
             }
       }
    }

    //Recieving code //

    Item {
        visible:if(type == "receive") {true} else {false}
        anchors.bottom:parent.bottom
        width: parent.width
        height: parent.height * 0.90



        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: parent.height * 0.4

            CirclePic {
                anchors.centerIn: parent
                width: parent.width * 0.5
                height: parent.width * 0.5
            }
        }


        Rectangle {
            anchors.bottom: codeentry.top
            color:backgroundColor
            width:parent.width
            height:parent.height * 0.20

        Text {
            anchors.centerIn: parent
            text:"Enter Code"
            color:fontColorTitle
            font.pixelSize: parent.width* 0.1 - text.length
        }

        }

        TextField {

            id:codeentry
            width:parent.width * 0.90
            //height:parent.height * 0.50
            anchors.bottom:parent.bottom
            anchors.bottomMargin: mainView.width * 0.1
            anchors.horizontalCenter:parent.horizontalCenter
            placeholderText:"000000"
            font.pixelSize: parent.width * 0.1 - text.length
            horizontalAlignment:TextInput.AlignHCenter
            maximumLength: 6
            text: text.toUpperCase()
        }

   /* Image {
        id:cancel
        source:"./icons/close.svg"
        width:parent.width * 0.06
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        anchors.margins: 10
        fillMode: Image.PreserveAspectFit

        Flasher {
            id:cancelflash
        }

        MouseArea {
            anchors.fill: parent
            onPressed:cancelflash.state="Active"
            onReleased:cancelflash.state="InActive"
            onClicked:{popup.state ="InActive"

                        }
        }

    } */

    Image {
        id:okay
        source:"./icons/check.svg"
        width:parent.width * 0.06
        anchors.bottom: parent.bottom
        anchors.right:parent.right
        anchors.margins: 10
        fillMode: Image.PreserveAspectFit

        Flasher {
            id:goflash
        }

        MouseArea {
            anchors.fill: parent
            onPressed:goflash.state="Active"
            onReleased:goflash.state="InActive"
            onClicked:{OpenSeed.onetime(codeentry.text,"3");
                        popup.state = "InActive";
                        if(themenu.state == "Active") {
                            topBar.state = "standard";
                        } else {
                             topBar.state = "person";
                        }
                            reload.start();}
        }

    }

    }

    //Send Request

    Rectangle {
        visible:if(type == "request") {true} else {false}
        anchors.bottom:parent.bottom
        width: parent.width
        height: parent.height * 0.90
        border.color:highLightColor1

        Rectangle {
            color:highLightColor1
            width:parent.width
            height:parent.height * 0.20

        Text {
            anchors.centerIn: parent
            text:title
            color:fontColorTitle
            font.pixelSize: parent.width* 0.1 - text.length
        }

        }


    Image {
        id:rcancel
        source:"./icons/close.svg"
        width:parent.width * 0.06
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        anchors.margins: 10
        fillMode: Image.PreserveAspectFit

        Flasher {
            id:rcancelflash
        }

        MouseArea {
            anchors.fill: parent
            onPressed:rcancelflash.state="Active"
            onReleased:rcancelflash.state="InActive"
            onClicked:{popup.state ="InActive"

                        }
        }

    }

    Image {
        id:rokay
        source:"./icons/check.svg"
        width:parent.width * 0.06
        anchors.bottom: parent.bottom
        anchors.right:parent.right
        anchors.margins: 10
        fillMode: Image.PreserveAspectFit

        Flasher {
            id:rgoflash
        }

        MouseArea {
            anchors.fill: parent
            onPressed:rgoflash.state="Active"
            onReleased:rgoflash.state="InActive"
            onClicked:{OpenSeed.onetime(codeentry.text,"3");
                        popup.state = "InActive";
                        reload.start();
                    }
        }

    }

    }


    Rectangle {
        id:shade
        visible:if(type == "darken") {true} else {false}
        anchors.centerIn: parent

        color:Qt.rgba(0,0,0,0.60)

        states: [
            State {
                name:'start'
                PropertyChanges {
                    target:shade
                    width:0
                    height:0

                }
            },

                State {
                    name:'end'
                    when:info.state = "Active"
                    PropertyChanges {
                        target:shade
                        width:parent.width
                        height:parent.height

                    }
                }

        ]

    }

    Item {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height * 0.10
        clip: true

        Button {
            width:parent.width * 0.49
            height: parent.height * 0.80
            text: "Send"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            background: Rectangle {
                        color:if(type == "send") {highLightColor1} else {"white"}
                        }
            onClicked: type = "send"
        }

        Button {
            width:parent.width * 0.49
            height: parent.height * 0.80
            text: "Receive"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            background: Rectangle {
                        color:if(type == "receive") {highLightColor1} else {"white"}
                        }
            onClicked: type = "receive"
        }
    }

}

    DropShadow {
        anchors.fill:sr
        horizontalOffset: 0
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: "#80000000"
        source:sr
        z:1
    }



}




