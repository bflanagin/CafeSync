import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4

import QtQuick.LocalStorage 2.0 as Sql

import "messages.js" as Message

Item {
id:thisWindow
//property int roomId: 0
//property string area: ""
//property bool contactlist: false
//property bool showroom: false


clip: true

states: [
    State {
        name: "Active"
        PropertyChanges {
            target:thisWindow

            x:0
        }

        PropertyChanges {
            target: messagePage
            area: "Contacts"
        }
    },
    State {
         name: "InActive"
         PropertyChanges {
             target:thisWindow

             x:width * -1


         }
    }



]

transitions: [
    Transition {
        from: "InActive"
        to: "Active"
        reversible: true


        NumberAnimation {
            target: thisWindow
            property: "x"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }


]

onStateChanged: if(state == "Active") {Message.contactlist()}

Rectangle {
anchors.fill: parent
color:backgroundColor
//color:"green"

}


ListView {
id:contacts
width:parent.width
height:parent.height
//verticalLayoutDirection: ListView.BottomToTop

spacing:thisWindow.height * 0.01
clip:true

model: ListModel {
        id:collectedContacts

}


delegate: Item {
    width:parent.width * 0.98
    height:conversecontent.height * 1.2
    anchors.horizontalCenter: parent.horizontalCenter
    clip:true
    Rectangle {
        anchors.centerIn: conversecontent
        width:conversecontent.width
        height:conversecontent.height
        color:"white"
        radius:5
    }
    Column {
        id:conversecontent
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        //spacing: thisWindow.height * 0.01

        Row {
            width:parent.width
            Item {
                width:parent.width * 0.30
                height:parent.width * 0.30
            Image {
                id:contactImg
                anchors.fill: parent
                source:avatar
                visible: false

                Image {

                    anchors.fill:parent
                    visible: true
                    source: "./img/default_avatar.png"
                    z:-1
                }

            }

            Image {
                id:mask
                anchors.fill:parent
                source:"/graphics/CafeSync.png"
                visible: false

            }

            OpacityMask {
                 anchors.fill: contactImg
                 source: contactImg
                 maskSource: mask
                //visible:if(cardsop == 1) {true} else {false}
             }
            }



            Column {
                width:parent.width * 0.70
                spacing: thisWindow.height * 0.01
                anchors.verticalCenter: parent.verticalCenter

            Text {
                text:speaker
                font.pixelSize: thisWindow.height * 0.045
                width:parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignLeft
                //anchors.left:parent.left

                Text {
                    text:timecode
                    width:parent.width * 0.5
                    horizontalAlignment: Text.AlignRight
                    anchors.right:parent.right
                    opacity: 0.2
                }
            }



        Rectangle {
            anchors.horizontalCenter:parent.horizontalCenter
            width:parent.width * 0.98
            height:thisWindow.height * 0.005
            color:seperatorColor1
        }

        Text {
            text:"<p>"+message+"</p>"
            font.pixelSize: thisWindow.height * 0.025
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
             horizontalAlignment: Text.LeftRight
            wrapMode: Text.WordWrap
                }
            }
        }

    }

    MouseArea {
        anchors.fill:parent
        onClicked: {thisWindow.state = "InActive",messagePage.roomId = usercardNum+","+who,Message.check_messages(usercardNum+","+who),messagePage.showroom = true }
    }
}


}


Rectangle {
id:conversationsbottomBar
anchors.bottom:parent.bottom
width:parent.width
height:parent.height * 0.08
color:bottombarColor

Image {
   id:newConversation
    anchors.verticalCenter: parent.verticalCenter
   // anchors.left:parent.left
   // anchors.leftMargin: thisWindow.height * 0.01
    anchors.horizontalCenter: parent.horizontalCenter
    height:parent.height * 0.6
    width:parent.height * 0.6
    source:"./icons/add.svg"
    Flasher {

    }
}

}

}
