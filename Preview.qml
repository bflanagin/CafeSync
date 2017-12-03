import QtQuick 2.0

import QtGraphicalEffects 1.0

Item {
    property int effect:0

    Rectangle {

        anchors.fill:parent
        clip:true
        //color:"#9d9d9d"

        Image {
            id:baseImage
            //anchors.fill:parent
            anchors.centerIn: parent
            width:parent.width * 0.98
            height:parent.height * 0.98
            source:thesource
            fillMode:Image.PreserveAspectCrop

        }

     /*   Colorize {
               visible:if(effect == 1) {true} else {false}
               anchors.fill: baseImage
               source: baseImage
               hue: 0.0
               saturation: 0.0
               lightness: -0.1
           }

        Colorize {
               visible:if(effect == 2) {true} else {false}
               anchors.fill: baseImage
               source: baseImage
               hue: 0.15
               saturation: 0.7
               lightness: -0.4
           }


        Colorize {
               visible:if(effect == 3) {true} else {false}
               anchors.fill: baseImage
               source: baseImage
               hue: 0.15
               saturation: 0.7
               lightness: -0.4
           }

           RadialGradient {
                id:radialWashout
                anchors.fill: baseImage
                visible:if(effect == 3) {true} else {false}

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0) }
                    GradientStop { position: 0.7; color: Qt.rgba(0.9,0.9,0.9,0.8) }
                }
           }

           Desaturate {
                    visible:if(effect == 4) {true} else {false}
                  anchors.fill: baseImage
                  source:baseImage
                  desaturation: 0.7
              } */

    }

    /*Image {
        anchors.centerIn:parent
        width:parent.width * 1.03
        height:parent.height * 1.03
        source:"graphics/imageborder.png"
    } */


}
