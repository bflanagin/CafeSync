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
    property bool reverse:false

    //clip: true

    onStateChanged: Scripts.loadActions(list)
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                //x:0
                y:parent.height - height
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              //x:0 - width
              y:parent.height
          }
        }
    ]

    Image {
        anchors.fill:parent
        source:"img/tabdown.png"
        rotation:if(reverse == true) {180} else {0}
        fillMode: Image.PreserveAspectFit

        Image {
            anchors.fill:parent
            source: "img/go-down.svg"
            fillMode: Image.PreserveAspectFit
            rotation:if(reverse == true) {180} else {0}
        }

    }
    MouseArea {
        anchors.fill:parent
        onClicked: console.log("back");
    }

}





