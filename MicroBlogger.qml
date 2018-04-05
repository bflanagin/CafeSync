import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

Item {
 ListView {
     anchors.horizontalCenter: parent.horizontalCenter
     width:parent.width * 0.98
     height:parent.height

     model: 3

     delegate: Item {
            width:parent.width
            height:logContent.height

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.98
                height:logContent.height
            }
            Text {
                id:logContent
                width:parent.width * 0.98
                padding:5

                text:qsTr("Stuff about things")
            }
     }

 }
}
