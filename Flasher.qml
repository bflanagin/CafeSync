import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0

import "main.js" as Scripts

Item {
    id:popup

    anchors.centerIn: parent
    width:parent.width * 1.2
    height:parent.height * 1.2
    z:-1

    Timer{
        id:pressed
        running:false
        repeat: false
        interval: 300
        onTriggered: popup.state = "InActive"
    }

    state:"InActive"
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: circle
                //z: 3
                //visible:true
                color: Qt.rgba(0.5,0.5,0.5,0.5)
            }
            PropertyChanges {
                target: thedrop
                //z: 3
                visible:true

            }

            PropertyChanges {
                target: pressed
                //z: 3
                running:true
            }



        },
        State {
          name:"InActive"
          PropertyChanges {
              target: circle
              //z: -2
              //visible:true
              //color: Qt.rgba(0.5,0.5,0.5,0.5)
              color:highLightColor1
              //  z:-1
                opacity: 0.9
          }
          PropertyChanges {
              target: thedrop
              //z: 3
              visible:true

          }

        },
        State {
          name:"Alert"
          PropertyChanges {
              target: circle
              //z: -2
             // visible:true
              color:Qt.rgba(1.0,0.0,0.0,0.5)
              //z:-1
          }

          PropertyChanges {
              target: thedrop
              //z: 3
              visible:true

          }

        },
                State {
                  name:"Enabled"
                  PropertyChanges {
                      target: circle
                      //z: -2
                      visible:true
                      color:activeColor
                     // z:-1
                  }
                }
    ]



Rectangle {
    id:circle

    property string number: "0"
    property string list:""
    radius: width / 2
    visible: false
    //clip: true

    //onStateChanged: Scripts.loadActions(list)


   anchors.fill: parent


}

DropShadow {
        id:thedrop
       anchors.fill: circle
       horizontalOffset: 0
       verticalOffset: 2
       radius: 5.0
       samples: 17
       color: "#80000000"
       source: circle
       z:-1

   }

}



