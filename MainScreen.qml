import QtQuick 2.9
import QtQml 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

ListView {
    id: ms
    property string number: "0"
    property string list: ""
    property bool fromRequest: false
    property string requestID: "0"

    z: 0
    snapMode: GridView.SnapOneRow
    boundsBehavior: Flickable.DragAndOvershootBounds
    orientation: Qt.Horizontal
    onDraggingVerticallyChanged: if (draggingVertically == true) {
                                     enabled = false
                                 }
    visible: true

    clip: true
    onStateChanged: if (state == "Active") {

                    } else {
                        gc()
                    }
    states: [
        State {
            name: "Active"
            PropertyChanges {
                target: ms
                //   visible:true
                x: 0
            }
        },
        State {
            name: "InActive"
            PropertyChanges {
                target: ms
                // visible:false
                x: -1 * width
            }
        }
    ]

    transitions: [
        Transition {
            from: "InActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: ms
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    delegate: Pages {
        pindex: index
    }

    Rectangle {
        anchors.centerIn: pagedots
        width: pagedots.width * 1.2
        height: pagedots.height * 1.6
        radius: parent.height * 0.1
        color: Qt.rgba(0.1, 0.1, 0.1, 0.4)
        visible: pagedots.visible
    }

    Row {
        id: pagedots
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.02
        spacing: parent.width * 0.02
        visible: if (ms.count > 1) {
                     true
                 } else {
                     false
                 }
        Repeater {
            model: ms.count
            id: pageIndicator
            Rectangle {
                width: mainView.width * 0.044
                height: mainView.width * 0.044
                border.width: 1
                border.color: barColor
                color: if (index === ms.indexAt(ms.contentX, 0)) {
                           highLightColor1
                       } else {
                           Qt.rgba(9, 9, 9, 0)
                       }
                radius: width / 2

                MouseArea {
                    anchors.fill: parent
                    onClicked: ms.positionViewAtIndex(index, GridView.Center)
                }
            }
        }
    }
}
