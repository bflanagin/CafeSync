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

    clip: true


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                z: 3
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              z: -2
          }
        },
        State {
          name:"need_rotate"
          PropertyChanges {
              target:popup
              z: 3
          }
          when:layouts.width < units.gu(mobile_vert) && popup.state == "Active"
      },
      State {
          name:"rotated"
          PropertyChanges {
              target:popup
              z: -2
          }
          when:layouts.width > units.gu(mobile_vert) && popup.state == "Active"
      }


    ]

    anchors.centerIn: parent
width:parent.width
height:parent.height

Rectangle {
    anchors.fill:parent
    color:Qt.rgba(0.1,0.1,0.1,0.8)
}

Text {
    text:"Rotate Screen"
    anchors.centerIn: parent
    color:"white"
}

MouseArea {
    anchors.fill:parent
}

}




