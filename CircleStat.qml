import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "circlepic.js" as Scripts

Item {
        id:card_avatar_backing
        property string whichStat:""
        property string statNumber:""
        property int statRank:0
        opacity: if(statNumber == "0" ) {0.2} else {1}
       // visible: if(statNumber == "0") {false} else {true}
        clip:true




        Rectangle {
            //anchors.fill: statcircle
            anchors.centerIn: statcircle
            width:statcircle.width * 0.75
            height:statcircle.height * 0.75
            color:Qt.rgba(1,1,1,1)
            radius: width / 2
            border.width: 1
            border.color: if(statRank < 50 ) {"gray"} else {"goldenrod"}
        }

        Rectangle {
            id:statcircle
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.top:parent.top
            width:parent.height * 0.74
            height:parent.height * 0.74
            radius: width / 2
            color:if(statRank < 50 ) {"gray"} else {"goldenrod"}
            visible: false
        }

        OpacityMask {
             anchors.fill: statcircle
             source: statcircle
             maskSource: mask1

         }

        Text {
            id: stat
            text: statNumber
            anchors.centerIn:statcircle
            font.pixelSize: parent.height * 0.4
            width:statcircle.width
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            text:whichStat
            width:parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width * 0.15
        }

        Image {
            id:mask1
            anchors.fill:parent
            source:"./img/OpenCircle.png"
            visible: false
            fillMode: Image.PreserveAspectFit
        }

}
