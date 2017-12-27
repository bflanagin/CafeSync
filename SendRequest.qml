import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4

import QtQuick.LocalStorage 2.0 as Sql

Item {
    id: thisWindow
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: thisWindow
                visible:true
                enabled:true

            }


        },
        State {
          name:"InActive"
          PropertyChanges {
              target:thisWindow
              visible:false
              enabled:false
          }

        }
    ]

    anchors.centerIn: parent


Item {
    id:sr
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        id:backing
        color:"white"
    }

    Column {
        width:parent.width
        height:parent.height
        spacing: thisWindow.height * 0.01

        Text {
            text:"Request"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: thisWindow.height * 0.1
        }

        Rectangle {
            color:seperatorColor1
            width:parent.width
            height:3
        }

        Text {
            text:"To: "+currentcard_username

            font.pixelSize: thisWindow.height * 0.07
        }

        TextArea {
            id:requestmessage
            width:parent.width
            height:thisWindow.height / 1.5
            placeholderText: "Why we should connect."
            wrapMode: Text.WordWrap

            Rectangle {
                anchors.centerIn: parent
                color:"white"
                width:parent.width * 1.01
                height:parent.height * 1.01
                border.color: "black"
                border.width: 1
                z:-1
            }
        }

    }



    Image {
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./img/close.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: thisWindow.state = "InActive"
        }
    }

    Image {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./img/check.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: thisWindow.state = "InActive"
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
