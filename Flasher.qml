import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2

import "main.js" as Scripts

Rectangle {
//Item {
    id:popup
    property string number: "0"
    property string list:""
    radius: 5

    //clip: true

    //onStateChanged: Scripts.loadActions(list)
    state:"InActive"
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                //z: 3
                visible:true
                color: Qt.rgba(0.5,0.5,0.5,0.5)
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              //z: -2
              visible:false
          }
        },
        State {
          name:"Alert"
          PropertyChanges {
              target: popup
              //z: -2
              visible:true
              color:Qt.rgba(1.0,0.0,0.0,0.5)
          }
        }
    ]

    anchors.fill:parent


}




