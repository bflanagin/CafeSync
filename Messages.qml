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
import "microblogger.js" as MicroBlog

Item {

    id:thisWindow

    property string area: ""
    property bool contactlist: false
    property bool showroom: false
    property int messagelist: 0
    property string from: "Menu"
    property string whowith: "Chat"
    property string roomId: "0"

    property string lastmessage: ""


    clip: true

    states: [
        State {
            name: "Active"
            PropertyChanges {
                target:thisWindow
                area: "Conversations"
                x:0


            }
        },
        State {
             name: "InActive"
             PropertyChanges {
                 target:thisWindow
                 area: "Conversations"
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

    onShowroomChanged: if(showroom == true) {conversations.state = "Inactive";room.state = "Active";Message.show_chat(roomId);checkchat.running = true}
                       else {conversations.state = "Active";room.state = "InActive";checkchat.running = false;Message.show_conversations(usercardNum)}

   // onAreaChanged: if(area == "Conversations") {Message.retrieve_conversations(usercardNum)}

    onStateChanged: if(thisWindow.state == "Active") {Message.show_conversations(usercardNum),Message.retrieve_conversations(usercardNum)}



    Timer {
        id:checkchat
        interval:2000
        running:false
        repeat:true
        onTriggered:Message.check_messages(roomId)
    }

    Timer {
        id:chatsanthings
        interval:2000
        running:true
        repeat:true
        onTriggered:if(usercardNum != "" && heart != "Offline") {Message.retrieve_conversations(usercardNum)}
    }



    Item {
        id:conversations
        width:parent.width
        height:parent.height


        states: [
            State {
                name: "Active"
                PropertyChanges {
                    target:conversations
                    x:0


                }
                PropertyChanges {
                    target:thisWindow
                    area: "Conversations"


                }
            },
            State {
                 name: "InActive"
                 PropertyChanges {
                     target:conversations

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
                    target: room
                    property: "x"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }


        ]

state:"Active"





Rectangle {
    anchors.fill: parent
    color:backgroundColor

}


ListView {
    id:conversationLog
    y:parent.width * 0.01
    width:parent.width
    height:(parent.height * 0.98) - bottomBar.height
    verticalLayoutDirection: ListView.TopToBottom

    spacing:thisWindow.height * 0.01
    clip:true

    model: ListModel {
            id:conversed

    }


    delegate: Item {
        width:parent.width * 0.98
        height:conversecontent.height * 1.2
        anchors.horizontalCenter: parent.horizontalCenter
        clip:true
         property string cardStatus:""
       // Component.onCompleted: MicroBlog.latest_log_remote("conversed",cardnum)

        Rectangle {
            id:converblock
            anchors.centerIn: conversecontent
           /* width:conversecontent.width
            height:conversecontent.height */
            width: parent.width * 0.97
            height: parent.height * 0.97
            color:"white"
            radius:mainView.width * 0.01
        }

        DropShadow {
            anchors.fill:converblock
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:converblock
            //z:1
        }
        Column {
            id:conversecontent
          //  anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            width:parent.width * 0.96
            //spacing: thisWindow.height * 0.01

            Row {
                width:parent.width
              /*  Item {
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
                } */

                CirclePic {
                    id:speaker1
                    width:parent.width * 0.30
                    height:parent.width * 0.30
                    thesource: avatar1

                    CirclePic {
                        id:speaker2
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        width:parent.width * 0.35
                        height:parent.width * 0.35
                        thesource: avatar2
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

            Text {
                text:timecode
                width:parent.width * 0.5
                font.pixelSize: thisWindow.height * 0.03
                horizontalAlignment: Text.AlignRight
                anchors.right:parent.right
                opacity: 0.2
            }



                }
            }
          /*  Rectangle {

                //visible: if(cardStatus.length != 0) {true} else {false}
                anchors.left:parent.left
               // anchors.bottom:parent.bottom
                //anchors.bottomMargin: parent.height * 0.05
                width:parent.width
                height:mainView.width * 0.04
                color:converblock.color


            } */


        }

        MouseArea {
            anchors.fill:parent
            onClicked: {thisWindow.area = "Chat",roomId = who,Message.check_messages(who),messagePage.showroom = true}//Message.show_chat(who)}
        }
    }


}


/*Rectangle {
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
        source:"./img/add.svg"
        Flasher {

        }
    }

}



DropShadow {
    anchors.fill:conversationsbottomBar
    horizontalOffset: 0
    verticalOffset: -4
    radius: 8.0
    samples: 17
    color: "#80000000"
    source:conversationsbottomBar
    z:1
} */


    }


    Item {
        id:room
        width:parent.width
        height:parent.height


        states: [
            State {
                name: "Active"
                PropertyChanges {
                    target:room
                    x:0
                }
                PropertyChanges {
                    target:thisWindow
                    area: "Chat"


                }
            },
            State {
                 name: "InActive"
                 PropertyChanges {
                     target:room

                     x:width * -1
                 }
                 PropertyChanges {
                     target:thisWindow
                     area: "Conversations"


                 }
            }



        ]

        transitions: [
            Transition {
                from: "InActive"
                to: "Active"
                reversible: true


                NumberAnimation {
                    target: room
                    property: "x"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }


        ]


state: "InActive"

Rectangle {
    anchors.fill: parent
    color:backgroundColor
}

ListView {
    id:chatLog
    y:parent.width * 0.01
    width:parent.width
    height:parent.height - bottomBar.height
    //verticalLayoutDirection: ListView.BottomToTop

    spacing:thisWindow.height * 0.01
    clip:true

    model: ListModel {
            id:chatlog

    }

    delegate: Item {
        width:parent.width
        height:content.height + mainView.width * 0.04
        clip:true

        CirclePic {
            id:card_avatar_backing
            width: parent.width * 0.2
            height: parent.width * 0.2
            anchors.verticalCenter: parent.verticalCenter
            anchors.right:if(who != usercardNum) {parent.right} else {""}
            anchors.margins: mainView.width * 0.01
            whichPic: who
            where: if(who != usercardNum){"saved"} else {"mycard"}

            clip:true
          }
        //anchors.left:if(who != usercardNum) {parent.left} else {""}

        Rectangle {
            id:messageblock
            anchors.centerIn: content
            width:content.width
            height:content.height
            visible: false
            color:"white"
            radius:mainView.width * 0.03
           // border.color:"black"
           // border.width: 1
        }

        DropShadow {
            anchors.fill:messageblock
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:messageblock
            //z:1
        }

        Column {
            id:content
            anchors.right:if(who == usercardNum) {parent.right} else {""}
            anchors.rightMargin: mainView.width * 0.02
            anchors.left:if(who != usercardNum) {parent.left} else {""}
            anchors.leftMargin: mainView.width * 0.02
            //anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.75
            spacing: thisWindow.height * 0.01

                Text {
                    text:if(who == usercardNum) {"You"} else {speaker}
                    font.pixelSize: thisWindow.width * 0.05
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignLeft
                    //anchors.left:parent.left

                    Text {
                        text:timecode
                        width:parent.width * 0.5
                        horizontalAlignment: Text.AlignRight
                        anchors.right:parent.right
                        font.pixelSize: thisWindow.width * 0.03
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
                text:"<p>"+message.replace(/&#x27;/g,"'")+"</p>"
                font.pixelSize: thisWindow.width * 0.045
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
    anchors.bottomMargin: mainView.width * 0.01
    width:parent.width
    height:(parent.height * 0.01) + messageField.height
    color:bottombarColor

   Image {
       id:addstuff
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:parent.left
        anchors.leftMargin: thisWindow.height * 0.01
        height:mainView.width * 0.06
        width:mainView.width * 0.06
        source:"./icons/add.svg"
        Flasher {

        }
    }
   TextArea {
       id:messageField
       focus: true
       anchors.bottom:parent.bottom
       anchors.horizontalCenter: parent.horizontalCenter
       verticalAlignment: Text.AlignVCenter
       wrapMode: Text.WordWrap
       leftPadding: width * 0.05
      // anchors.left:addstuff.right
      // anchors.leftMargin:addstuff.width * 0.4
       width:parent.width - addstuff.width * 1.8 - sendMsg.width * 1.5
       //height:parent.height * 0.7
       font.pixelSize: parent.width * 0.04
       //maximumLength: 144
        Keys.onPressed: { if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {Message.send_messages(roomId,messageField.text)} }

        /*background:Rectangle {
            border.color: borderColor
            border.width: 1
            radius: height / 2
                 } */
        background:InputBack{}
   }

   Image {
       id:sendMsg
       anchors.right:parent.right
       anchors.rightMargin: thisWindow.height * 0.01
       source:"./icons/message.svg"
       anchors.verticalCenter: parent.verticalCenter
       width:mainView.width * 0.06
       height:mainView.width * 0.06
       Flasher {

       }
        MouseArea {
            anchors.fill: parent
            onClicked: Message.send_messages(roomId,messageField.text)
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

}
