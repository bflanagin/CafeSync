import QtQuick 2.8
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

import "requests.js" as Request
import "openseed.js" as OpenSeed
import "main.js" as Scripts

Item {

    id:thisWindow
    property int roomId: 0
    property string type: "new"

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

    onStateChanged: if(thisWindow.state == "Active") {Request.check_requests("dialog")} else {}

    onTypeChanged: Request.check_requests("dialog")

    property string readystate: "Not Ready"
    property int card: 0


    onReadystateChanged: {if(readystate == "ready") {
            mainScreen.positionViewAtBeginning();
            mainScreen.fromRequest = true;
            mainScreen.state = "Active";
            topBar.state = "person";

            Scripts.Show_sites(card,"preview");
            }
    }


    Timer {
        id:requeststimer
        interval: 6000
        running:false
        repeat:true
        onTriggered:if(heartbeat != "Offline" && thisWindow.state != "Active") {
                                Request.check_requests("timer");
                        }
    }

Rectangle {
    anchors.fill: parent
    color:backgroundColor
}

Item {
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width
    height: parent.height * 0.10
    clip: true

    Button {
        width:parent.width * 0.32
        height: parent.height * 0.80
        text: "New"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
                    color:if(type == "new") {highLightColor1} else {"white"}
                    }
        onClicked: type = "new"
    }

    Button {
        width:parent.width * 0.32
        height: parent.height * 0.80
        text: "Accepted"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
                    color:if(type == "accepted") {highLightColor1} else {"white"}
                    }
        onClicked: type = "accepted"
    }
    Button {
        width:parent.width * 0.32
        height: parent.height * 0.80
        text: "Denied"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle {
                    color:if(type == "denied") {highLightColor1} else {"white"}
                    }
        onClicked: type = "denied"
    }
}

ListView {
    id:requestLog
    width:parent.width
    anchors.bottom: parent.bottom
    height:parent.height * 0.89


    spacing:thisWindow.height * 0.02
    clip:true

    model: requestlog

    delegate: Item {
        width:parent.width * 0.98
        height:content.height * 1.3
       // anchors.right:if(direction == 0) {parent.right} else {""}
        anchors.horizontalCenter: parent.horizontalCenter

        clip:true
        Rectangle {
            id:backing
            anchors.centerIn: content
            width:content.width
            height:content.height * 1.2
            color:"white"
            radius:mainView.width * 0.01
            visible: false
        }

        DropShadow {
            anchors.fill:backing
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:backing
            //z:-1
        }

        Column {
            id:content
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width:parent.width * 0.98
            spacing: thisWindow.height * 0.03

                Text {
                    text:if(direction == 0) {"To: "+speaker} else {"From: "+speaker}
                    font.pixelSize: thisWindow.height * 0.035
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignLeft
                    //anchors.left:parent.left

                    Text {
                        text:timecode
                        width:parent.width * 0.5
                        font.pixelSize: thisWindow.height * 0.015
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
                width:parent.width * 0.95
                anchors.horizontalCenter: parent.horizontalCenter
                 horizontalAlignment: Text.LeftRight
                wrapMode: Text.WordWrap
            }
            Text {
                anchors.right:parent.right
                anchors.rightMargin: thisWindow.height * 0.02
                text:status
            }

        }




        MouseArea {

            anchors.fill:parent

                onClicked: {
                            readystate = OpenSeed.preview_card(who);
                            pagelist.clear();
                            gc();
                            mainScreen.requestID = requestid;
                }


    }



    }
}

}
