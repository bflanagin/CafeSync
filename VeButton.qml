import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2

import "main.js" as Scripts


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string title:""
    property int enabled:1


    clip: true


    states: [
        State {
            name:"pressed"
            PropertyChanges {
                target: back
                color:"gray"

            }

        },
        State {
          name:"normal"
          PropertyChanges {
              target: back
              color:"white"

          }
        }
    ]

    state:"normal"

    Rectangle {
        id:back
        width:parent.width
        height:parent.height
        radius: 20
        border.width:0
        border.color:"black"
        color:"white"

        Text {
            anchors.centerIn: parent
            text:title
            font.pixelSize: parent.height * 0.35
        }
    }

    MouseArea {
        anchors.fill:parent
        onPressed:popup.state = "pressed"
        onReleased: popup.state = "normal"

    }

}




