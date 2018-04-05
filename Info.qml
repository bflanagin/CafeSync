import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
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

    property string title:""
    property string message:""

    //clip: true

    Timer {
        id:reload
        running: false
        repeat: false
        interval: 800
        onTriggered:cardslist.clear(),Scripts.Cards_load("")
    }


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
                enabled:true

            }


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

    anchors.centerIn: parent


    //Sending code //

    Item {
        id:sr
        anchors.fill: parent

    Rectangle {
        visible:if(type == "send") {true} else {false}
        anchors.fill:parent
        border.color:seperatorColor1
        clip:true
        radius:5

        Rectangle {
            color:highLightColor1
            width:parent.width
            height:parent.height * 0.20
            anchors.horizontalCenter: parent.horizontalCenter

        Text {
            anchors.centerIn: parent
            text:title
            font.pixelSize: parent.width* 0.1 - text.length
            color:fontColorTitle

        }

        }
        Text {
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
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin:10
            text:qsTr("Warning: Closing this window invalidates code")
        }
    }

    //Recieving code //

    Rectangle {
        visible:if(type == "receive") {true} else {false}
        anchors.fill:parent
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
        TextField {

            id:codeentry
            width:parent.width * 0.90
            height:parent.height * 0.50

            anchors.centerIn: parent
            placeholderText:"000000"
            font.pixelSize: parent.width * 0.2 - text.length
            horizontalAlignment:TextInput.AlignHCenter
            maximumLength: 6
            text: text.toUpperCase()
        }

    Image {
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

    }

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
            onClicked:OpenSeed.onetime(codeentry.text,"3"),popup.state = "InActive",reload.start()
        }

    }

    }

    //Send Request

    Rectangle {
        visible:if(type == "request") {true} else {false}
        anchors.fill:parent
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
            onClicked:OpenSeed.onetime(codeentry.text,"3"),popup.state = "InActive",reload.start()
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




