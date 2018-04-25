import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "eula.js" as Eula
import "markdown.js" as MD

Item {
    id:thisWindow

    property string theeula: ""
     property string date: ""



     Timer {
         id:eulacheck
         interval: 1000
         running: true
         repeat: true
         onTriggered: {            
                 Eula.get_eula();
         }
     }

    Rectangle {
        id:internalArea
        anchors.fill: parent
        color: backgroundColor
        border.color: "black"
        border.width: 1
        //visible: false

    Text {
        id: title
        text: qsTr("Agreement")
        font.pixelSize: mainView.width * 0.1
        anchors.left: parent.left
        anchors.leftMargin:mainView.width * 0.03
        anchors.top:parent.top
        anchors.topMargin: mainView.width * 0.01
    }

    Text {
        id: thedate
        text:date
        font.pixelSize: mainView.width * 0.04
        anchors.right: parent.right
        anchors.rightMargin:mainView.width * 0.03
        anchors.bottom:title.bottom
        anchors.bottomMargin: mainView.width * 0.01
    }

    Rectangle {
        width: parent.width
        height: mainView.width * 0.01
        color: seperatorColor1
        anchors.top:title.bottom
    }


    Flickable {
        anchors.top:title.bottom
        anchors.topMargin: mainView.width * 0.01
        anchors.bottom:okay.top
        width: parent.width
        contentHeight: news.height
        clip:true
        Text {
            id: news
            text: "<p>"+MD.md2html(theeula)+"</p>"
            width: mainView.width * 0.93
            padding: mainView.width * 0.02
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignLeft
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Button {
        id:cancel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: mainView.width * 0.01
        anchors.left: parent.left
        anchors.leftMargin: mainView.width * 0.01
        width: parent.width * 0.30
        height: mainView.width * 0.1
        text:"Cancel"
        //onClicked: eula.dismiss_eula(date)
        onClicked:thisWindow.visible = false

        background: Rectangle {
                color:highLightColor1
                radius: mainView.width * 0.01
               // border.color: "black"
               // border.width: mainView.width * 0.001
        }
    }

    Button {
        id:okay
        anchors.bottom: parent.bottom
        anchors.bottomMargin: mainView.width * 0.01
        anchors.right: parent.right
        anchors.rightMargin: mainView.width * 0.01
        width: parent.width * 0.30
        height: mainView.width * 0.1
        text:"Okay"
        onClicked: Eula.dismiss_eula(date)

        background: Rectangle {
                color:highLightColor1
                radius: mainView.width * 0.01
              //  border.color: "black"
              //  border.width: mainView.width * 0.001
        }
    }

    }

    DropShadow {
           anchors.fill: internalArea
           horizontalOffset: 0
           verticalOffset: 4
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: internalArea
       }

}
