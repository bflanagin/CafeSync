import QtQuick 2.0

Item {
    property string themessage : ""



    Text {
        id: notification
        //anchors.horizontalCenter: passerbyGrid.horizontalCenter
       // anchors.verticalCenter: passerbyGrid.verticalCenter
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        horizontalAlignment:Text.AlignHCenter
        width:parent.width * 0.5
        wrapMode: Text.WordWrap
        text: themessage
        color:"white"
        font.pointSize: mainView.height * 0.02
        Rectangle {
            anchors.centerIn: parent
            width:parent.width * 1.2
            height:parent.height * 1.8
            z:-1
            color:Qt.rgba(0.2,0.2,0.2,0.7)
            radius:width / 2
        }


    }


}
