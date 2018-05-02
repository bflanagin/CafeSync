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

import "requests.js" as Request
import "text.js" as Scrubber

Item {
    id: thisWindow
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: thisWindow
                //visible:true
                x:0
                enabled:true

            }


        },
        State {
          name:"InActive"
          PropertyChanges {
              target:thisWindow
              //visible:false
              x:width * -1
              enabled:false
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

  //  anchors.centerIn: parent


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
            text:"Connection Request"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: thisWindow.height * 0.05
            width:parent.width

            Rectangle {
                z:-1
                color:barColor
                anchors.fill: parent
            }

        }

        Rectangle {
            color:seperatorColor1
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:3
        }

        Text {
            text:"To: "+currentcard_username
            anchors.left:parent.left
            anchors.leftMargin: thisWindow.height * 0.01
            font.pixelSize: thisWindow.height * 0.04
        }

        TextArea {
            id:requestmessage
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:thisWindow.height / 1.5
            placeholderText: "To start messaging the user\n they must accept your request."
            wrapMode: Text.WordWrap
            font.pixelSize: parent.width * 0.06
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

Item {
    anchors.left:parent.left
    anchors.bottom:parent.bottom
    anchors.margins: mainView.width * 0.04
    width:parent.width * 0.08
    height:parent.width * 0.08
    Image {

        source:"./icons/close.svg"
        width:parent.height * 0.8
        height:parent.height * 0.8
        anchors.centerIn: parent
    }
    Flasher {

    }

    MouseArea {
        anchors.fill: parent
        onClicked: thisWindow.state = "InActive"
    }
}

    Item {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: mainView.width * 0.04
        width:parent.width * 0.08
        height:parent.width * 0.08
    Image {

        source:"./icons/check.svg"
        width:parent.height * 0.8
        height:parent.height * 0.8
        anchors.centerIn: parent

    }

    Flasher {

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Request.send_request(currentcard_thecard,requestmessage.text);

            thisWindow.state = "InActive"

        }
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
