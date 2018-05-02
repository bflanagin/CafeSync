import QtQuick 2.0

Item {
    id:notify
    property string themessage : ""
    property int pos: 0;
    property int delay: 0


    Timer {
        id:notificationFade
        interval:if(delay != 0) {1000 * delay} else {2000}
        running:false
        onTriggered: {notify.visible = false;}
    }

    onVisibleChanged: if(notify.visible == true) {notificationFade.running = true}else {notificationFade.stop()}

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
        font.pixelSize: if(pos == 0) {mainView.width * 0.06} else {mainView.width * 0.04}
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
