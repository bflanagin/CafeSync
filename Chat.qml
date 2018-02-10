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

Item {

    id:thisWindow
    property int roomId: 0

    clip: true

    states: [
        State {
            name: "Active"
            PropertyChanges {
                target:thisWindow

                x:0


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

Rectangle {
    anchors.fill: parent
    color:backgroundColor
}

ListView {
    id:chatLog
    width:parent.width
    height:parent.height - bottomBar.height
    verticalLayoutDirection: ListView.BottomToTop

    spacing:thisWindow.height * 0.01
    clip:true

    model: ListModel {
            id:chatlog




            ListElement {
                who:151
                speaker:"Someone Else"
                timecode:1231213914534
                message:"Talk later."
            }


            ListElement {
                who:151
                speaker: "Someone Else"
                timecode:1231213814534
                message:"Not bad, I've got lots to do though."
            }

            ListElement {
                who:150
                speaker: "Benjamin Flanagin"
                timecode:1231213414534
                message:"Hey, How's it going?"
            }

    }

    delegate: Item {
        width:parent.width * 0.60
        height:content.height * 1.2
        anchors.right:if(who == usercardNum) {parent.right} else {""}
        //anchors.left:if(who != usercardNum) {parent.left} else {""}
        clip:true
        Rectangle {anchors.centerIn: content
            width:content.width
            height:content.height
            color:"white"
            radius:5
        }
        Column {
            id:content
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            spacing: thisWindow.height * 0.01

                Text {
                    text:if(who == usercardNum) {"<h2>You</h2>"} else {"<h2>"+speaker+"</h2>"}
                   // font.pixelSize: thisWindow.width * 0.035
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignLeft
                    //anchors.left:parent.left

                    Text {
                        text:timecode
                        width:parent.width * 0.5
                       // font.pixelSize: thisWindow.width
                        horizontalAlignment: Text.AlignRight
                        anchors.right:parent.right
                        opacity: 0.1
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
               // font.pixelSize: thisWindow.width * 0.3
                width:parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                 horizontalAlignment: Text.LeftRight
                wrapMode: Text.WordWrap
            }
        }
    }
}

Rectangle {
    id:bottomBar
    anchors.bottom:parent.bottom
    width:parent.width
    height:parent.height * 0.08
    color:bottombarColor

   Image {
       id:addstuff
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:parent.left
        anchors.leftMargin: thisWindow.height * 0.01
        height:parent.height * 0.6
        width:parent.height * 0.6
        source:"./img/add.svg"
        Flasher {

        }
    }
   TextField {
       anchors.verticalCenter: parent.verticalCenter
       anchors.horizontalCenter: parent.horizontalCenter
      // anchors.left:addstuff.right
      // anchors.leftMargin:addstuff.width * 0.4
       width:parent.width - addstuff.width * 1.8 - sendMsg.width * 1.5
       height:parent.height * 0.6
       maximumLength: 144
   }

   Image {
       id:sendMsg
       anchors.right:parent.right
       anchors.rightMargin: thisWindow.height * 0.01
       source:"./img/message.svg"
       anchors.verticalCenter: parent.verticalCenter
       width:parent.height * 0.6
       height:parent.height * 0.6
       Flasher {

       }
   }


}

DropShadow {
    anchors.fill:bottomBar
    horizontalOffset: 0
    verticalOffset: -4
    radius: 8.0
    samples: 17
    color: "#80000000"
    source:bottomBar
    z:1
}


}
