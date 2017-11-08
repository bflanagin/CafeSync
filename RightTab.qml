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

    //clip: true

    onStateChanged: Scripts.loadActions(list)
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                x:parent.width - width
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              x:parent.width + width
          }
        }
    ]

    Image {
        anchors.fill:parent
        source:"img/tabforward.png"

        Image {
            anchors.fill:parent
            source: "img/go-next.svg"
            fillMode: Image.PreserveAspectFit
        }

    }


}




