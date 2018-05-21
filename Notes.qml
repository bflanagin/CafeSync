import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4

import QtQuick.LocalStorage 2.0 as Sql


import "text.js" as Scrubber
import "notes.js" as Notes
import "encryption.js" as Secret

Item {
    id: thisWindow

    property string key:""
    property bool editing: false




    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: thisWindow
                x:0
                enabled:true

            }


        },
        State {
          name:"InActive"
          PropertyChanges {
              target:thisWindow 
              x:width * -1
              enabled:false
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

  onStateChanged: if(state == "Active") {key = Secret.genkey(devId,"note",currentcard_thecard); Notes.get_notes(currentcard_thecard);}

    Item {
        id:thenotes
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent

            color:backgroundColor

        }


        Rectangle {
            id:back
            anchors.fill: titlecolumn
            color:cardcolor
        }

        DropShadow {
            anchors.fill:back
            horizontalOffset: 0
            verticalOffset: 2
            radius: 5.0
            samples: 17
            color: "#80000000"
            source:back

        }

        Item {
            id:titlecolumn
            width:parent.width
            height:topBar.height
            clip:true
            //spacing: thisWindow.width * 0.02

            CircleIndicator {
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: mainView.width * 0.01
                height:parent.height * 0.7
                width:parent.height * 0.7

                icon: "./icons/back.svg"
                fillColor: highLightColor1

                MouseArea {
                    anchors.fill: parent
                    onClicked: thisWindow.state = "InActive"
                }
            }

            Text {
                text:"Notes"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: thisWindow.width * 0.08
                font.bold: true
                width:parent.width
                color:fontColor
            }

            Text {
                text:currentcard_username
                anchors.bottom: parent.bottom
                anchors.right:parent.right
                anchors.rightMargin: thisWindow.width * 0.03
                font.pixelSize: thisWindow.width * 0.03
                color:fontColor
            }


        }


            ListView {
                //height:400
                anchors.bottom: addbutton.top
                anchors.top: titlecolumn.bottom
                anchors.topMargin: thisWindow.width * 0.02
                width:parent.width
                clip:true
                spacing: mainView.width * 0.1

                model: notelist

                delegate: Item {
                        width:parent.width
                        height:thisWindow.width * 0.4

                        Rectangle {
                            id:itemback
                            color:cardcolor

                            anchors.centerIn: parent
                            width:parent.width * 0.98
                            height:parent.height * 0.98
                            visible: false
                        }
                        DropShadow {
                            anchors.fill:itemback
                            horizontalOffset: 0
                            verticalOffset: 1
                            radius: 2.0
                            samples: 17
                            color: "#80000000"
                            source:itemback

                        }

                        Column {
                            anchors.centerIn: parent
                            width:parent.width * 0.97
                            height:parent.height * 0.97
                            spacing: thisWindow.width * 0.04
                            clip:true
                            Text {
                                anchors.left: parent.left
                                font.bold: true
                                text: Secret.decrypt(key,notetitle)
                                font.pixelSize: parent.width * 0.07
                                color:fontColorTitle
                            }

                            Rectangle {
                                color:seperatorColor1
                                width:parent.width * 0.98
                                anchors.horizontalCenter: parent.horizontalCenter
                                height:3
                            }

                            Text {
                                anchors.left: parent.left
                                wrapMode: Text.WordWrap
                                maximumLineCount: 2
                                width:parent.width
                                elide: Text.ElideRight
                                text: Secret.decrypt(key,summary)
                                color:fontColor
                                height:parent.height * 0.33
                            }

                            Text {
                                anchors.right: parent.right
                                text: date
                                color:fontColor

                            }

                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {editing = true
                                        nN.noteSelected = notetitle;
                                            }
                            onPressAndHold: {Notes.delete_note(currentcard_thecard,origin);}
                        }



                }

            }




     Button {
         id:addbutton
         anchors.bottom:parent.bottom
         anchors.horizontalCenter:parent.horizontalCenter
         anchors.bottomMargin: mainView.width * 0.03
         width:parent.width * 0.50
         height:mainView.width * 0.15
         text: qsTr("Add Note")
         onClicked: {editing = true; nN.noteSelected = ""; nN.noteOrigin = 0; }
         //enabled: if(key === "0") {false} else {true}

         contentItem: Text {
                            //width:parent.width
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font:parent.font
                            text:parent.text
                            color:fontColorTitle

                        }

         background: Rectangle {
                     color:highLightColor1
                     radius:4
                     }
     }

    }


Item {
    id:nN
    width:parent.width
    height:parent.height
    visible: editing

    property string noteSelected: ""
    property string noteBody:""
    property string noteTile:""
    property real noteOrigin: 0


    onVisibleChanged: if(editing == false) {Notes.get_notes(currentcard_thecard); }
    onNoteSelectedChanged: if(nN.noteSelected != "") {Notes.get_note(currentcard_thecard,noteSelected)} //else {noteTitleField.text = qsTr("New Note"); notebody.text = qsTr("Note area"); }

    Rectangle {
        anchors.fill: parent
        id:backing
        color:cardcolor
        visible: false
    }

    DropShadow {
        anchors.fill:backing
        horizontalOffset: 0
        verticalOffset: 2
        radius: 5.0
        samples: 17
        color: "#80000000"
        source:backing

    }

    Column {
        width:parent.width
        height:parent.height
        spacing: thisWindow.height * 0.01


        Text {
            text:"Note"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: thisWindow.width * 0.08
            font.bold: true
            width:parent.width
            color:fontColor

        }

        Text {
            text:currentcard_username
            anchors.right:parent.right
            anchors.rightMargin: thisWindow.width * 0.03
            font.pixelSize: thisWindow.height * 0.03
            color:fontColor
        }


        Rectangle {
            color:seperatorColor1
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:3
        }

        TextField {
            id:noteTitleField
            text: if(nN.noteSelected == "") {qsTr("New Note")} else {Secret.decrypt(key,nN.noteTile)}
            anchors.left:parent.left
            width:parent.width
            anchors.leftMargin: thisWindow.height * 0.01
            font.pixelSize: thisWindow.height * 0.04
            color:fontColor
            enabled:editing
        }

        TextArea {
            id:notebody
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:thisWindow.height / 1.5
           // placeholderText: "Just let it flow"
            text:if(nN.noteSelected == "") {qsTr("Note area")} else {Secret.decrypt(key,nN.noteBody)}
            wrapMode: Text.WordWrap
            font.pixelSize: parent.width * 0.06
            color:fontColor
            enabled:editing
            Rectangle {
                anchors.centerIn: parent
                color:backgroundColor
                width:parent.width * 1.01
                height:parent.height * 1.01

                z:-1
            }
        }

        Rectangle {
            color:seperatorColor1
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:3
        }
    }

CircleIndicator {
    anchors.left:parent.left
    anchors.bottom:parent.bottom
    anchors.margins: mainView.width * 0.04
    width:parent.width * 0.08
    height:parent.width * 0.08
    icon :"./icons/close.svg"
    fillColor: highLightColor1

    MouseArea {
        anchors.fill: parent

        onClicked: { nN.noteOrigin = 0;
            nN.noteSelected = "";
            editing = false;
        }
    }
}

CircleIndicator {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: mainView.width * 0.04
        width:parent.width * 0.08
        height:parent.width * 0.08
        icon:"./icons/check.svg"
        fillColor: highLightColor1

    MouseArea {
        anchors.fill: parent
        onClicked: {

                Notes.save_note(currentcard_thecard,Secret.encrypt(key,noteTitleField.text),Secret.encrypt(key,notebody.text),nN.noteOrigin);
            nN.noteSelected = "";
            //notebody.focus = false;
            editing = false;


        }
    }

    }

}


ListModel {
         id:notelist
       }

}
