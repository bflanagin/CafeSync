import QtQuick 2.0

import "openseed.js" as OpenSeed
import "main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql


Item {
    id:popup

    anchors.centerIn: parent

    clip: true

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
                height:parent.height * 0.70
                width:if(window_width > units.gu(mobile_vert)){parent.width * 0.50} else {parent.width * 0.80}
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

Image {
    id:samplecard
    anchors.horizontalCenter:parent.horizontalCenter
    anchors.top:parent.top
    anchors.topMargin:0
    source:"img/customcard.png"
    //fillMode:Image.PreserveAspectFit
    anchors.fill:parent
    width:parent.height * 0.8
    opacity: 0.06
    z:0
}


Text {
    //anchors.top:samplecard.bottom
    //anchors.topMargin:20
    anchors.centerIn: parent
    text: i18n.tr("You can upload custom card faces to our servers by hitting the check mark below.\n This will generate the request and send an email to the address on the card.\n (please check your Spam folder)");
    font.pixelSize: parent.height * 0.05
    wrapMode:Text.WordWrap
    width:parent.width * 0.80
    height:parent.height * 0.50
    horizontalAlignment: Text.AlignHCenter
    anchors.horizontalCenter: parent.horizontalCenter
    z:1
}



Image {
    anchors.bottom:parent.bottom
    anchors.left:parent.left
    anchors.margins: 10
    source:"/usr/share/icons/suru/actions/scalable/cancel.svg"
    fillMode: Image.PreserveAspectFit
    width:parent.height * 0.10
    height:parent.height * 0.10

    Flasher {
        id:cancelflash

    }

    MouseArea {
        anchors.fill:parent
        onPressed:cancelflash.state = "Active"
        onReleased: cancelflash.state = "InActive"
        onClicked:popup.state = "InActive"
    }

}

Text {
    text:i18n.tr("Custom Card Face = 1 USD")
    anchors.bottomMargin: 10
    anchors.bottom:parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter

}


Image {
    anchors.bottom:parent.bottom
    anchors.right:parent.right
     anchors.margins: 10
    source:"/usr/share/icons/suru/actions/scalable/ok.svg"
    fillMode: Image.PreserveAspectFit
    width:parent.height * 0.10
    height:parent.height * 0.10

    Flasher {
        id:okflash

    }

    MouseArea {
        anchors.fill:parent
        onPressed:okflash.state = "Active"
        onReleased: okflash.state = "InActive"
        onClicked: {if(cardindex == 0) {OpenSeed.cardface_gen(username,usercompany,userid,useremail)} else {OpenSeed.cardface_gen(username1,usercompany1,userid1,useremail1)}
                popup.state = "InActive",emailinfo.state = "Active",emailinfo.message = i18n.tr("Email Sent"),autoclose.running = "true"
                }
    }

}

}



}

