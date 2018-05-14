import QtQuick 2.8
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0 as Sql

import "events.js" as Events
import "text.js" as Strings

Item {
    id:thisWindow
    property bool edit:false
    property bool update: false
    property var d: new Date()
    property int theday: d.getDate()
    property int selected_month: d.getMonth()
    property int selected_year: d.getFullYear()

    property int hour: 0
    property int minutes: 0
    property int amPm: 0

    property var party: []


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

    onStateChanged: if(thisWindow.state == "Active" && thisWindow.edit == false) {party.push(usercardNum+":1");
                    invites.append({
                                   member:party[0]
                                   });
                    } else {
                        eventName.text = "";
                        eventLocation.text = "";
                        invites.clear();
                        party.splice(0,party.length);

                    }

    onUpdateChanged: {
                    invites.clear();
                     for(var num =0;num<party.length;num = num + 1) {
                         invites.append({
                                        member:party[num]
                                      });
                     }
                     update = false;

    }


   Rectangle {
       anchors.fill:parent
           color:backgroundColor
   }

   Item {
       anchors.centerIn: parent
       width:parent.width * 0.98
       height:parent.height * 0.98

       Flickable {
           anchors.fill:parent
           contentWidth: parent.width
           contentHeight:form.height
           clip:true

       Column {
           id:form

           width:parent.width
           spacing: thisWindow.width * 0.02

           Text {
               text:if(edit == false) {qsTr("New Event")} else {qsTr("Edit Event")}
               font.bold:true
               font.pixelSize: thisWindow.width * 0.1
           }

           TextField {
               id:eventName
              width:parent.width
              placeholderText: qsTr("Event Name")

           }

           TextField {
               id:eventLocation
              width:parent.width
              placeholderText: qsTr("Location")

           }
           CheckBox {
               anchors.right: parent.right
               text:qsTr("Private Location")
           }

         //  GridLayout {
         //      width:parent.width
         //     columns:1

           SpinBox {
               id:monthselect
               from: 0
               to: 11
               value: d.getMonth()

               textFromValue: function(value) {
                                var themonth = "";
                            switch(value) {
                            case 0: themonth = "January";break;
                            case 1: themonth = "Febuary";break;
                            case 2: themonth = "March";break;
                            case 3: themonth = "April";break;
                            case 4: themonth = "May";break;
                            case 5: themonth = "Jun";break;
                            case 6: themonth = "July";break;
                            case 7: themonth = "August";break;
                            case 8: themonth = "September";break;
                            case 9: themonth = "October";break;
                            case 10: themonth = "November";break;
                            case 11: themonth = "December";break;
                            }
                            //selected_month = themonth+1;
                            return themonth;
               }
               //onValueChanged: grid.month = value
           }

           Item {
               id:dayselect
               width:parent.width
               height:grid.height + dow.height



                    DayOfWeekRow {
                                id:dow
                                locale: grid.locale
                                 width:grid.width
                                 anchors.bottom:grid.top

                            }
           MonthGrid {
                    id:grid
                    anchors.bottom:parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:parent.width * 0.98
                    month: monthselect.value

                    title:month


               locale: Qt.locale("en_US")

               delegate: Rectangle {
                           // anchors.fill: parent
                            width:20
                            height:20
                            radius: width /2
                            color:model.day === theday ? seperatorColor1 : cardcolor
                            opacity: model.month === monthselect.value ? 1 : 0
                   Text {
                       anchors.centerIn: parent
                   horizontalAlignment: Text.AlignHCenter
                   verticalAlignment: Text.AlignVCenter
                   text: model.day
                   color:model.day === theday ? "white" : "black"
                   //font: control.font


               }
                   MouseArea {
                       anchors.fill: parent
                       onClicked: {theday = model.day;}
                   }

               }


           }

           }

           Row {
               anchors.right:parent.right
               width:thisWindow.width * 0.98
               anchors.horizontalCenter: parent.horizontalCenter
               height:timeTime.height * 1.2
               //clip:true
               spacing: thisWindow.width * 0.01

               Text {
                   id:timeTime
                   text:"Time: "
                  // width:parent.width / 6
                   anchors.verticalCenter: parent.verticalCenter
                   horizontalAlignment: Text.AlignHCenter
                   font.pixelSize: thisWindow.width * 0.05
                   font.bold: true
               }

           SpinBox {
                           id: hoursSpin
                            width:thisWindow.width / 4
                            height:parent.height

                           //model: 12
                           from:1
                           to:12
                           value:if(d.getHours() > 12) {d.getHours() - 12}

                           textFromValue: function(value) {
                               if(value < 10) {return "0"+(value)} else {return value}
                              }


                             font.pixelSize: thisWindow.width * 0.04


                       }

           Text {
               text:":"
               //width:parent.width / 6
               horizontalAlignment: Text.AlignHCenter
               font.pixelSize: thisWindow.width * 0.05
           }

           SpinBox {
                           id: miniuteSpin
                                width:thisWindow.width / 4
                                 height:parent.height
                           from:0
                           to:59
                           value:d.getMinutes()
                           textFromValue: function(value) {
                               if(value < 10) {return "0"+(value)} else {return value}
                              }

                           font.pixelSize: thisWindow.width * 0.04


                       }

           SpinBox {
                           id: ampmSpin
                           width:thisWindow.width / 4
                           anchors.verticalCenter: parent.verticalCenter
                            height:parent.height

                           from: 0
                           to: 1
                           value:if(d.getHours() >= 12) {1} else {0}

                           textFromValue: function(value) {
                                     if(value === 0) {return "AM"} else {return "PM"}
                                    }

                           font.pixelSize: thisWindow.width * 0.04


                       }


           }


           Text {
               text:"Invites:"
               font.bold: true

           }

           Item {
               width:parent.width
               height:thisWindow.width * 0.2
               clip:true

           ListView {
               id:invitelistView
               width:contentWidth
               anchors.left: parent.left
               orientation: ListView.Horizontal
               height:thisWindow.width * 0.2
               clip:true
               spacing: thisWindow.width * 0.02

              model:invites

              delegate:  CirclePic {
                   height:thisWindow.width * 0.2
                   width:thisWindow.width * 0.2
                   anchors.verticalCenter: parent.verticalCenter
                   whichPic: member.split(":")[0]
                   where:if(whichPic === usercardNum) {"mycard"} else {"saved"}
                   badge:member.split(":")[1]

                   MouseArea {
                       anchors.fill:parent
                       onClicked: if(member.split(":")[0] !== usercardNum){removeDialog.who = index;
                                    removeDialog.visible = true;}
                   }
               }

                }

               Item {
                   anchors.left:invitelistView.right
                   anchors.leftMargin: thisWindow.width * 0.03
                   anchors.verticalCenter: parent.verticalCenter
                   //radius: width /2
                   height:parent.width * 0.10
                   width:parent.width * 0.10
                   //color:highLightColor1

                   Image {
                       anchors.centerIn: parent
                       width:parent.width * 0.45
                       height:parent.width * 0.45
                       source:"./icons/add.svg"
                   }

                   Flasher{}

                   MouseArea {
                       anchors.fill: parent
                       onClicked: {
                           eventContactsPage.type = "event";
                           eventContactsPage.state = "Active";
                       }
                   }

               }

           }

           Text {
               text:"About:"
               font.bold: true

           }
           TextArea {
               id:about
               width:parent.width
               height:thisWindow.width * 0.5
               text:"We'll talk about things and stuff"
           }

           Item {
               width:parent.width
               height:thisWindow.width * 0.15


           Button {
               width:parent.width * 0.48
               anchors.left: parent.left
               height:parent.height
               text:"Cancel"
               onClicked: {


                   eventEdit.state = "InActive";

                   eventsPage.updateevents = true;
               }
               background: Rectangle {
                           color:highLightColor1
                           }
           }
            Button {
                width:parent.width * 0.48
                 height:parent.height
                anchors.right: parent.right
                text:"Save"
                onClicked: {

                            if(ampmSpin.value === 1) {
                                hour = hoursSpin.value + 12;
                            } else {
                            hour = hoursSpin.value;
                                 }

                            if(hour == 24) { hour = 0}

                    Events.save_event(Strings.replaceSpecials(eventName.text),Strings.replaceSpecials(eventLocation.text),Strings.replaceSpecials(about.text),party.toString(),selected_year,monthselect.value,theday,hour,miniuteSpin.value)

                }
                background: Rectangle {
                            color:highLightColor1
                            }
            }

           }

       }


       }
   }

   ListModel {
       id:invites
   }

    Item {
   id:removeDialog
        anchors.centerIn: parent
        width:parent.width * 0.85
        height:parent.width * 0.55
        visible:false
        property int who: 0

        Rectangle {
            anchors.centerIn: parent
            width:parent.width * 0.98
            height:parent.height * 0.98
            color:cardcolor

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: thisWindow.width * 0.1
                text:qsTr("Remove Invite?")
            }

            Button {
                anchors.bottom:parent.bottom
                anchors.left:parent.left
                width:parent.width * 0.48
                height:parent.height * 0.2
                anchors.margins: thisWindow.width * 0.01
                text: qsTr("Cancel")
                onClicked: removeDialog.visible = false
                background: Rectangle {
                            color:highLightColor1
                            }
            }

            Button {
                anchors.bottom:parent.bottom
                anchors.right:parent.right
                width:parent.width * 0.48
                height:parent.height * 0.2
                anchors.margins: thisWindow.width * 0.01
                text: qsTr("Remove")
                onClicked: {
                        party.splice(removeDialog.who,1);
                        thisWindow.update = true;
                    removeDialog.visible = false

                    }
                background: Rectangle {
                            color:highLightColor1
                            }
            }


        }




    }


}
