import QtQuick 2.3
import QtQuick.Window 2.2


import "main.js" as Scripts


Item {
    id:popup
    property string number: "0"
    property string list:""

    //clip: true

    onStateChanged: Scripts.loadActions(list)
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                x:0
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              x:0 - width
          }
        }
    ]

    Image {
        anchors.fill:parent
        source:"img/tabback.png"

        Image {
            anchors.fill:parent
            source: "/usr/share/icons/suru/actions/scalable/go-previous.svg"
            fillMode: Image.PreserveAspectFit
        }

    }
    MouseArea {
        anchors.fill:parent
        onClicked: console.log("back");
    }

}





