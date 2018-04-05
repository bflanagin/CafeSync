import QtQuick 2.0
import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

Item {


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
           verticalOffset: 4
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: circle
           z:-1

       }

    }

