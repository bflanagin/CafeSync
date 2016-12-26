import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
import Ubuntu.Components 1.2


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


    Rectangle {
        visible:if(type == "send") {true} else {false}
        anchors.fill:parent
        border.color:"black"

        Rectangle {
            color:"gray"
            width:parent.width
            height:parent.height * 0.20

        Text {
            anchors.centerIn: parent
            text:title
            font.pixelSize: parent.width* 0.1 - text.length
        }

        }
        Text {
            anchors.centerIn: parent
            text:message
            font.pixelSize: parent.width * 0.2 - text.length

            Text {
                anchors.top:parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text:i18n.tr("(Tap to close)")
            }

        }
        Text {
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin:10
            text:i18n.tr("Warning: Closing this window invalidates code")
        }
    }

    Rectangle {
        visible:if(type == "receive") {true} else {false}
        anchors.fill:parent
        border.color:"black"

        Rectangle {
            color:"gray"
            width:parent.width
            height:parent.height * 0.20

        Text {
            anchors.centerIn: parent
            text:title
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
        source:"/usr/share/icons/suru/actions/scalable/cancel.svg"
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
        source:"/usr/share/icons/suru/actions/scalable/ok.svg"
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

        color:Qt.rgba(0.5,0.5,0.5,0.60)
        width:0
        height:0

        states: [
            State {
                name:"start"
                PropertyChanges {
                    target:shade
                    width:0
                    height:0

                }
            },

                State {
                    name:"end"
                    when:shade.visible == true
                    PropertyChanges {
                        target:shade
                        width:parent.width
                        height:parent.height

                    }
                }

        ]
        transitions: Transition {
             PropertyAnimation {target: shade; property: "width,height"; duration: 300}
        }



    }

    Rectangle {
        id:simple
        visible:if(type == "simple") {true} else {false}

       // anchors.fill:parent
        height:parent.height
        width:parent.width
        border.color:"black"
        Image {
            id:logo
            anchors.left:parent.left
            height:parent.height * 0.80
            anchors.verticalCenter: parent.verticalCenter
            source:"img/overlay-dark.png"
            fillMode:Image.PreserveAspectFit

        }

        Text {
            anchors.left:logo.right
            anchors.verticalCenter: logo.verticalCenter
            font.pixelSize: parent.height * 0.15
            text:message
        }


    }



}




