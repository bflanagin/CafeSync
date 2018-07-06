import QtQuick 2.10
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0 as Sql

import "events.js" as Events
import "text.js" as Strings

Item {
    id: thisWindow
    property string type: "current"
    property bool updateevents: false
    property bool invitecheck: true
    property bool updatecheck: true

    property int counter: 0

    states: [
        State {
            name: "Active"
            PropertyChanges {
                target: thisWindow
                x: 0
            }
        },
        State {
            name: "InActive"
            PropertyChanges {
                target: thisWindow

                x: width * -1
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

    Component.onCompleted: Events.load_current()

    onUpdateeventsChanged: {
        Events.load_current()
        Events.check_invites()
        updateevents = false
    }

    Timer {
        id: eventInvites
        interval: 5007
        running: invitecheck
        repeat: true
        onTriggered: {
            if (heart != "Offline" && firstrun.state == "InActive") {
                Events.check_invites()
            }
        }
    }

    Timer {
        id: eventsUpdate
        interval: 10000
        running: updatecheck
        repeat: true
        onTriggered: {
            if (heart != "Offline" && firstrun.state == "InActive") {

                Events.get_events()
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: backgroundColor
    }

    Item {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height * 0.10
        clip: true

        Button {
            width: parent.width * 0.49
            height: parent.height * 0.80
            text: "Scheduled"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            contentItem: Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: parent.font
                text: parent.text
                color: fontColorTitle
            }

            background: Rectangle {
                color: if (type == "current") {
                           highLightColor1
                       } else {
                           backgroundColor
                       }
            }
            onClicked: {
                type = "current"
                Events.load_current()
            }
        }

        Button {
            width: parent.width * 0.49
            height: parent.height * 0.80
            text: "Log"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            contentItem: Text {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: parent.font
                text: parent.text
                color: fontColorTitle
            }

            background: Rectangle {
                color: if (type == "log") {
                           highLightColor1
                       } else {
                           backgroundColor
                       }
            }
            onClicked: {
                type = "log"
                Events.load_log()
            }
        }
    }

    ListView {
        id: eventListLog
        visible: if (type == "log") {
                     true
                 } else {
                     false
                 }
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        height: parent.height * 0.90
        spacing: thisWindow.width * 0.02
        clip: true

        model: elLog

        delegate: Item {

            width: parent.width * 0.95
            anchors.horizontalCenter: parent.horizontalCenter
            height: if (itemtype != 9) {
                        logcard.height
                    } else {
                        logspacer.height
                    }

            Item {
                id: logspacer
                visible: if (itemtype == 9) {
                             true
                         } else {
                             false
                         }
                width: parent.width
                height: mainView.height * 0.04
                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: mainView.width * 0.01
                    horizontalAlignment: Text.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                    text: "" + date
                    color: fontColor
                }

                Rectangle {
                    color: seperatorColor1
                    width: parent.width
                    height: parent.height * 0.1
                    anchors.bottom: parent.bottom
                }
            }

            Item {
                id: logcard
                height: thisWindow.height * 0.30
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                visible: if (itemtype == 0) {
                             true
                         } else {
                             false
                         }

                Rectangle {
                    id: backfill
                    anchors.fill: parent
                    color: cardcolor

                }

                DropShadow {
                    anchors.fill: backfill
                    source: backfill
                    samples: 17
                    radius: 5.0
                    horizontalOffset: 0
                    verticalOffset: 0
                    color: "#80000000"
                }

                Text {
                    id: logTitle
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: thisWindow.width * 0.02
                    text: eventname
                    font.pixelSize: parent.width * 0.07
                    color: fontColor
                    Text {
                        anchors.top: parent.bottom
                        anchors.left: parent.left
                        anchors.margins: thisWindow.width * 0.01
                        text: location
                        font.pixelSize: parent.height * 0.4
                        color: fontColor
                    }
                }
                Rectangle {
                    anchors.centerIn: memberRow
                    width: memberRow.width * 1.1
                    height: memberRow.height * 1.1
                    border.color: seperatorColor1
                    border.width: 2
                    color: backfill.color
                }

                Row {
                    id: memberRow
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: logTitle.height / 2
                    width: parent.width * 0.98
                    height: parent.height * 0.40
                    spacing: parent.width * 0.01
                    clip: true

                    Repeater {
                        model: partymembers.split(",")

                        CirclePic {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.height * 0.9
                            height: parent.height * 0.9
                            whichPic: modelData.split(":")[0]
                            where: if (modelData.split(
                                               ":")[0] === usercardNum) {
                                       "mycard"
                                   } else {
                                       "saved"
                                   }
                            badge: modelData.split(":")[1]
                        }
                    }
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.margins: thisWindow.width * 0.02
                    text: date
                    font.pixelSize: parent.width * 0.04
                    color: fontColor
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.margins: thisWindow.width * 0.02
                    text: time
                    font.pixelSize: parent.width * 0.04
                    color: fontColor
                }
            }
        }
    }

    Item {
        visible: if (type == "current") {
                     true
                 } else {
                     false
                 }
        anchors.fill: parent

        ListView {
            id: eventListCurrent

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            height: parent.height * 0.90
            spacing: thisWindow.width * 0.02
            clip: true

            model: elCurrent

            delegate: Item {

                width: parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                height: if (itemtype != 9) {
                            thecard.height
                        } else {
                            spacer.height
                        }

                Item {
                    id: spacer
                    visible: if (itemtype == 9) {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width
                    height: mainView.height * 0.04
                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: mainView.width * 0.01
                        horizontalAlignment: Text.AlignRight
                        anchors.verticalCenter: parent.verticalCenter
                        text: "" + date
                        color: fontColor
                    }

                    Rectangle {
                        color: seperatorColor1
                        width: parent.width
                        height: parent.height * 0.1
                        anchors.bottom: parent.bottom
                    }
                }

                Item {
                    id: thecard

                    height: thisWindow.height * 0.30
                    width: parent.width

                    visible: if (itemtype == 0) {
                                 true
                             } else {
                                 false
                             }
                    clip: true
                    Rectangle {
                        id: backing
                        anchors.fill: parent
                        color: cardcolor
                        visible: false

                    }

                    DropShadow {
                        anchors.fill: backing
                        source: backing
                        samples: 17
                        radius: 5.0
                        horizontalOffset: 0
                        verticalOffset: 0
                        color: "#80000000"
                    }

                    Text {
                        id: eventTitle
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: thisWindow.width * 0.02
                        text: eventname
                        font.pixelSize: parent.width * 0.07
                        color: fontColor
                        Text {
                            anchors.top: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: thisWindow.width * 0.01
                            text: location
                            font.pixelSize: parent.height * 0.4
                            color: fontColor
                        }
                    }

                    Rectangle {
                        anchors.centerIn: partyRow
                        width: partyRow.width * 1.1
                        height: partyRow.height * 1.1
                        border.color: seperatorColor1
                        border.width: 2
                        color: backing.color
                    }

                    Row {
                        id: partyRow
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: eventTitle.height / 2
                        width: parent.width
                        height: parent.height * 0.40
                        spacing: parent.width * 0.01
                        Repeater {

                            model: partymembers.split(",")

                            CirclePic {
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.height * 0.9
                                height: parent.height * 0.9
                                whichPic: modelData.split(":")[0]
                                where: if (whichPic === usercardNum) {
                                           "mycard"
                                       } else {
                                           "saved"
                                       }
                                badge: modelData.split(":")[1]
                            }
                        }
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.margins: thisWindow.width * 0.02
                        text: date
                        font.pixelSize: parent.width * 0.04
                        color: fontColor
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.margins: thisWindow.width * 0.02
                        text: time
                        font.pixelSize: parent.width * 0.04
                        color: fontColor
                    }
                }
            }
        }

        Item {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: thisWindow.width * 0.04
            anchors.bottomMargin: thisWindow.width * 0.04
            width: thisWindow.width * 0.09
            height: thisWindow.width * 0.09
            z: 2

            Image {
                id: sicon
                visible: false
                anchors.centerIn: parent
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                source: "./icons/calendar-today.svg"
            }

            ColorOverlay {
                source: sicon
                anchors.fill: sicon
                color: overlayColor
            }

            Flasher {
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    eventEdit.edit = false
                    eventEdit.state = "Active"
                }
            }
        }
    }

    ListModel {
        id: elLog
    }

    ListModel {
        id: elCurrent
    }
}
