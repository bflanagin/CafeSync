import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2
import QtGraphicalEffects 1.0

import "main.js" as Scripts


Item {
    id:popup
    property string number: "0"
    property string list:""

    //clip: true


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                //x:0
                y:parent.height - height
            }
            PropertyChanges {
                target:icon
                source: "img/go-up.svg"
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              //x:0 - width
              y:parent.height - height
          }
          PropertyChanges {
              target:icon
              source: "img/go-down.svg"
          }
        },
        State {
          name:"Available"
          PropertyChanges {
              target: popup
              //x:0 - width
              y:parent.height - height
          }
          PropertyChanges {
              target:icon
              source: "img/go-up.svg"
          }
        },
                State {
                  name:"UnAvailable"
                  PropertyChanges {
                      target: popup
                      //x:0 - width
                      y:parent.height + height

                  }
                  PropertyChanges {
                      target:icon
                      source: "img/go-up.svg"
                  }
                }
    ]

    Image {
        id:button
        anchors.fill:parent
        source:"img/tabdown.png"

        Image {
            id:icon
            anchors.fill:parent
            source: "img/go-down.svg"
            fillMode: Image.PreserveAspectFit
        }

        Glow {
               anchors.fill: icon
               radius: 8
               samples: 16
               color: "white"
               source: icon
           }

    }
    Glow {
           anchors.fill: button
           radius: 8
           samples: 16
           color: "white"
           source: button
       }


}





