import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2


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

    clip: true


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


    //Sending code //

    Rectangle {
        visible:if(type == "send") {true} else {false}
        anchors.fill:parent
        border.color:highLightColor1

        Rectangle {
            color:barColor
            width:parent.width
            height:parent.height * 0.20

        Text {
            anchors.centerIn: parent
            text:title
            font.pixelSize: parent.width* 0.1 - text.length
            color:"white"

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
            color:barColor
            width:parent.width
            height:parent.height * 0.20

        Text {
            anchors.centerIn: parent
            text:title
            color:"white"
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
        source:"./img/cancel.svg"
        width:parent.width * 0.08
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
            onClicked:popup.state ="InActive"
        }

    }

    Image {
        id:okay
        source:"./img/ok.svg"
        width:parent.width * 0.08
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
            onClicked:OpenSeed.onetime(codeentry.text,"3"),popup.state = "InActive"
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




