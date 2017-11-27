import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2
import QtQuick.Controls.Material 2.0

import "main.js" as Scripts

Rectangle {
//Item {
    id:popup
    property string number: "0"
    property string list:""
    radius: width / 2

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
              visible:true
              //color: Qt.rgba(0.5,0.5,0.5,0.5)
              color:highLightColor1
                z:-1
                opacity: 0.8
          }
        },
        State {
          name:"Alert"
          PropertyChanges {
              target: popup
              //z: -2
              visible:true
              color:Qt.rgba(1.0,0.0,0.0,0.5)
              z:-1
          }
        }
    ]

    anchors.centerIn: parent
    width:parent.width * 1.2
    height:parent.height * 1.2


}




