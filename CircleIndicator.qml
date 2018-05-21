import QtQuick 2.0
import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

Item {

    property string fillColor:"white"
    property string  icon: ""

    Rectangle {
        id:circle

        property string number: "0"
        property string list:""
        radius: width / 2
        visible: false
        //clip: true

        //onStateChanged: Scripts.loadActions(list)
        color:fillColor
        opacity: if(parent.enabled == true) {1} else {0.4}

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
            opacity: if(parent.enabled == true) {1} else {0.4}

       }

    Image {
        id:theicon
        anchors.centerIn: parent
        source:icon
        width:parent.width * 0.6
        height:parent.height * 0.6
        visible: false
        opacity: if(parent.enabled == true) {1} else {0.4}
    }


    ColorOverlay {
        source:theicon
        anchors.fill: theicon
        color:overlayColor
        opacity: if(parent.enabled == true) {1} else {0.4}
    }



    }

