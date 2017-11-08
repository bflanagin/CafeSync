import QtQuick 2.0

Item {
    id:popup

    anchors.centerIn: parent

    //clip: true

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
                height:parent.height * 0.70
                width:parent.width * 0.6
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              visible:false
          }
        }
    ]

Rectangle {
anchors.fill:parent
color:"white"
border.color:"black"
border.width:2
radius:10

}

Rectangle {
    color:"gray"
    width:parent.width
    height:title.height * 1.5
    anchors.verticalCenter: title.verticalCenter
    radius:10
    border.color:"black"
    border.width:1
}

Text {
    id:title
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top:parent.top
    anchors.topMargin:10
    text:qsTr("Payment Options")
    font.pixelSize:parent.width * 0.06
}


Column {
    id:paymentopts
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top:title.bottom
    anchors.topMargin:8
    clip:true
    spacing:10
    width:parent.width
    //height:parent.height


Rectangle {
    width:popup.width
    height:popup.height / 4
    //border.color:"black"
    border.width:2
    radius:5
Image {
    source:"img/paypal.png"
    fillMode:Image.PreserveAspectFit
    anchors.fill:parent

}
MouseArea {
    anchors.fill:parent
    //onClicked:Qt.openUrlExternally("http://openseed.vagueentertainment.com/core/paypal.php?id="+userid)
    onClicked: Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=GB7XMSJJYU7RG")

}


}
Rectangle {
    width:popup.width
    height:popup.height / 4
    //border.color:"black"
    border.width:2
    radius:5
Image {
    source:"img/bitcoin.png"
    fillMode:Image.PreserveAspectFit
    width:popup.width
    height:popup.height / 4
}

MouseArea {
    anchors.fill:parent
    //onClicked:Qt.openUrlExternally("http://openseed.vagueentertainment.com/core/coinbase.php?id="+userid)
    onClicked:Qt.openUrlExternally("https://www.coinbase.com/checkouts/ea8d22e7ae085ac72051227e5cada2d0")

}
}

}

Text {
    anchors.top:paymentopts.bottom
    anchors.topMargin:10
    anchors.horizontalCenter: popup.horizontalCenter
    text:"Card Images are 1 USD"
}


VeButton {
    height:parent.height * 0.10
    width:parent.width * 0.98
    anchors.bottom:parent.bottom
    anchors.bottomMargin:10
    anchors.horizontalCenter: parent.horizontalCenter
    title:"Cancel"
    Flasher {
        id:cancel
    }

    MouseArea {
        anchors.fill:parent
        onPressed:cancel.state = "Active"
        onReleased:cancel.state = "InActive"
        onClicked:popup.state = "InActive"
        propagateComposedEvents: true
    }
}


}

