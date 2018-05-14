import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "events.js" as Events

Item {
    id:thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    property string type:"chance"
    property var party: []
    property string who:""
    property string name: ""
    property string eventname:""
    property string about:""
    property string when: ""
    property string unique: ""

    states: [
        State {
            name: "Active"
            PropertyChanges {
                target:thisWindow
                anchors.verticalCenterOffset: 0

            }

            PropertyChanges {
                target:disappear
                running:if(type == "chance") {true} else {false}
            }

            PropertyChanges {
                target: you
                anchors.leftMargin: parent.width * 0.15
                opacity:1

            }

            PropertyChanges {
                target:o1
                anchors.rightMargin: parent.width * 0.15
                opacity: 1
            }

            PropertyChanges {
                target: o2
                 anchors.topMargin: parent.width * 0.02
                opacity:1

            }

            PropertyChanges {
                target:o3
                 anchors.bottomMargin: parent.width * 0.02
                opacity: 1
            }

            /* PropertyChanges {
                target:card

                flipped:true
            } */

            PropertyChanges {
                target:flipit
                 running: true

            }


        },
        State {
             name: "InActive"
             PropertyChanges {
                 target:thisWindow

                 anchors.verticalCenterOffset:mainView.height


             }

             PropertyChanges {
                 target: you
                 anchors.leftMargin: parent.width * -0.15
                 opacity: 0

             }

             PropertyChanges {
                 target:o1
                 anchors.rightMargin: parent.width * -0.15
                 opacity: 0
             }

             PropertyChanges {
                 target: o2
                  anchors.topMargin: parent.width * -0.12
                 opacity:0

             }

             PropertyChanges {
                 target:o3
                  anchors.bottomMargin: parent.width * -0.12
                 opacity: 0
             }

            /* PropertyChanges {
                 target:card

                 flipped:false
             } */


             PropertyChanges {
                 target:flipit
                  running: false
             }
        }





    ]

    Timer {
        id:disappear
        interval: 6000
        running: false
        repeat: false
        onTriggered: thisWindow.state = "InActive"
    }

    Timer {
        id:flipit
        interval: 2300
        running: false
        repeat: false
        onTriggered: card.flipped = false
    }



    transitions: [
        Transition {
            from: "InActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                targets: thisWindow
                properties: "anchors.verticalCenterOffset"
                duration: 200
                easing.type: Easing.InOutQuad
            }


            NumberAnimation {
                targets: [you,o1]
                properties: "anchors.leftMargin,anchors.rightMargin,opacity"
                duration: 600
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                targets: [o2,o3]
                properties: "anchors.topMargin,anchors.bottomMargin,opacity"
                duration: 700
                easing.type: Easing.InOutQuad
            }


        }


    ]



Flipable {
    id:card
    anchors.fill: parent
    property bool flipped: true


    transform: Rotation {
           id: rotation
           origin.x: card.width/2
           origin.y: card.height/2
           axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
           angle: 0    // the default angle
       }

       states: State {
           name: "front"
           PropertyChanges { target: rotation; angle: 180 }
           when: card.flipped !== true
       }

       transitions: Transition {
           NumberAnimation { target: rotation; property: "angle"; duration: 400 }
       }


  back: Item {
            anchors.fill: parent

        Rectangle {
        id: backing
        color:cardcolor
        radius:mainView.width * 0.02
        anchors.centerIn: parent
        width:parent.width * 0.98
        height:parent.height * 0.98
        visible: false

    }

    DropShadow {
           anchors.fill: backing
           horizontalOffset: 0
           verticalOffset: 10
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: backing
       }

    Image {
        anchors.centerIn:parent
        source:"./img/overlay.svg"
        width:parent.width * 0.80
        height:parent.width * 0.80
        fillMode:Image.PreserveAspectFit
        opacity: 0.1
    }

   /* Text {
        font.bold: true
        font.pixelSize: parent.width * 0.04
        horizontalAlignment: Text.AlignHCenter
        width:parent.width
        wrapMode: Text.WordWrap
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        //anchors.top: parent.top
        //anchors.topMargin: parent.width * 0.1
        opacity: 0.1

        text: switch(type) {

               case "chance": qsTr("Chance Meeting");break;
               case "invite": qsTr("Event Invite");break;
               case "decline": qsTr("Event Decline");break;
               case "arrived": qsTr("Arrived");break;
               case "canceled": qsTr("Canceled");break;
               case "forgot": qsTr("Forgot Event");break;

              }
    } */

    Item {
        anchors.fill: parent
        visible: if(type == "chance") {true} else {false}
        onVisibleChanged: if(visible == true) {party.push(usercardNum);}



    CirclePic {
        id:you
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:parent.left
        width: if(party.length <= 2) {parent.width * 0.35} else {parent.width * 0.2}
        height:width
        whichPic:party[0]
        where:if(whichPic === usercardNum) {"mycard"} else {"saved"}
    }

    CirclePic {
        id:o1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:parent.right
        width: if(party.length <= 2) {parent.width * 0.35} else {parent.width * 0.2}
        height:width
        whichPic:party[1]
        where:if(whichPic === usercardNum) {"mycard"} else {"saved"}
    }

    CirclePic {
        id:o2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        width: parent.width * 0.2
        height:width
        visible: if(party.length >= 3) {true} else {false}
        whichPic:party[2]
        where:if(whichPic === usercardNum) {"mycard"} else {"saved"}
    }

    CirclePic {
        id:o3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom:parent.bottom
        width: parent.width * 0.2
        height:width
        visible: if(party.length >= 4) {true} else {false}
        whichPic:party[3]
        where:if(whichPic === usercardNum) {"mycard"} else {"saved"}

    }


    }

    Item {

        anchors.fill: parent
        visible: if(type == "invite") {true} else {false}
       // onVisibleChanged: if(visible == true) {}

        Text {
            id:title
            anchors.top:parent.top
            anchors.topMargin: mainView.width * 0.01
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.right:parent.right
            anchors.rightMargin: mainView.width * 0.03
            font.pixelSize: mainView.width * 0.035
            font.italic: true
            horizontalAlignment: Text.AlignRight
            //text:"Invite"
            text:when
            width:parent.width * 0.4
            wrapMode: Text.WordWrap

        }

        CirclePic {
            id:inviter
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.left:parent.left
            anchors.leftMargin: parent.width * 0.01
            anchors.top:parent.top

            anchors.topMargin: mainView.width * 0.02
           // anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.10
            height:width
            whichPic:who.split(":")[0]
            where:if(whichPic === usercardNum) {"mycard"} else {"saved"}
        }



        Text {
            anchors.top:inviter.top
           anchors.left:inviter.right
            anchors.topMargin: mainView.width * 0.01
            font.pixelSize: mainView.width * 0.05
            font.bold: true
            width:parent.width * 0.55
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide:Text.ElideRight
            text:name

            Text {
                anchors.top:parent.bottom
                anchors.left:parent.left
                anchors.margins: parent.height * 0.1
                text:qsTr("Party of ")+party.length
                font.italic: true
                font.pixelSize: mainView.width * 0.03
            }
        }

        Text {

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: mainView.width * -0.04
            //anchors.bottomMargin: mainView.width * 0.04
            font.pixelSize: mainView.width * 0.07
             font.bold: true
            width:parent.width * 0.95
            wrapMode: Text.WordWrap
            text:eventname
            horizontalAlignment: Text.AlignHCenter

            Text {
                anchors.top:parent.bottom
                anchors.topMargin: mainView.width * 0.01
                width:parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                elide: Text.ElideRight
                text:about
            }
        }


        Button {
            anchors.left:parent.left
            anchors.bottom:parent.bottom
            anchors.margins: mainView.width * 0.02
            width:parent.width * 0.3
            text:"Decline"

            background: Rectangle {
                        color:highLightColor1
                        radius: mainView.width * 0.02
                        }

            onClicked: {Events.rsvp_event(unique,usercardNum,3)}
        }

        Button {
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.margins: mainView.width * 0.02
            width:parent.width * 0.3
            text:"Maybe"

            background: Rectangle {
                        color:highLightColor1
                        radius: mainView.width * 0.02
                        }

            onClicked: {Events.rsvp_event(unique,usercardNum,2)}
        }


        Button {
            anchors.right:parent.right
           anchors.bottom:parent.bottom
           anchors.margins: mainView.width * 0.02
            width:parent.width * 0.3
            text:"Accept"

            background: Rectangle {
                        color:highLightColor1
                        radius: mainView.width * 0.02
                        }
            onClicked: {Events.rsvp_event(unique,usercardNum,1)}
        }

    }

  }

    front: Item {
            anchors.fill: parent

            Rectangle {
            id: backbacking
            color:cardcolor
            radius:mainView.width * 0.02
            anchors.centerIn: parent
            width:parent.width * 0.98
            height:parent.height * 0.98
            visible: false

        }

        DropShadow {
               anchors.fill: backbacking
               horizontalOffset: 0
               verticalOffset: 10
               radius: 8.0
               samples: 17
               color: "#80000000"
               source: backbacking
           }

        Image {
            anchors.centerIn:parent
            source:"./img/overlay.svg"
            width:parent.width * 0.80
            height:parent.width * 0.80
            fillMode:Image.PreserveAspectFit
            opacity: 0.4
        }

        Text {
            font.bold: true
            font.pixelSize: parent.width * 0.07
            horizontalAlignment: Text.AlignHCenter
            width:parent.width
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            //anchors.top: parent.top
            //anchors.topMargin: parent.width * 0.1
            opacity: 0.4

            text: switch(type) {

                   case "chance": qsTr("Chance Meeting");break;
                   case "invite": qsTr("Event Invite");break;
                   case "decline": qsTr("Event Decline");break;
                   case "arrived": qsTr("Arrived");break;
                   case "canceled": qsTr("Canceled");break;
                   case "forgot": qsTr("Forgot Event");break;

                  }
        }


    }


}

}

