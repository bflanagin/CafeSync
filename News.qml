import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

Item {
    id:thisWindow
    Rectangle {
        id:internalArea
        anchors.fill: parent
        color: backgroundColor
        border.color: "black"
        border.width: 1
        //visible: false

    Text {
        id: title
        text: qsTr("NEWS")
        font.pixelSize: mainView.width * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: mainView.width * 0.01
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
        Text {
            id: news
            text: "<p>"+"</p>"
            width: mainView.width * 0.96
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignJustify

        }

    }

    Button {
        id:okay
        anchors.bottom: parent.bottom
        anchors.bottomMargin: mainView.width * 0.01
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.60
        height: mainView.width * 0.1
        text:"Okay"
        onClicked: thisWindow.visible = false
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
