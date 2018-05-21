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
    property string iswith: ""

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

    onStateChanged: if(thisWindow.state == "Active" && thisWindow.edit == false) {
                        party.push(usercardNum+":1");

                        invites.append({
                                       member:party[0]
                                       });

                        if(iswith != "") {
                           party.push(iswith+":0") ;

                            invites.append({
                                           member:party[1]
                                           });

                        }

                    } else {
                        eventName.text = "";
                        eventLocation.text = "";
                        iswith = "";
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
               font.pixelSize: thisWindow.width * 0.08
               color:fontColorTitle

               Text {
                   anchors.left:parent.right
                   anchors.bottom:parent.bottom
                   //anchors.verticalCenter: parent.verticalCenter
                   font.pixelSize: thisWindow.width * 0.08
                   text:if(iswith !="") {qsTr(" ( with ")+currentcard_username.split(" ")[0]+")"} else {""}
               }
           }

           TextField {
               id:eventName
              width:parent.width
              placeholderText: qsTr("Event Name")
              padding: 6
              color:fontColor
              background: InputBack{}

           }

           TextField {
               id:eventLocation
              width:parent.width
              padding: 6
              placeholderText: qsTr("Location")
              color:fontColor
              background: InputBack{}
           }
           CheckBox {
               anchors.right: parent.right
               width:thisWindow.width * 0.1
               text:qsTr("Private Location")
               contentItem: Text {
                   text:parent.text
                   anchors.right:parent.left
                   width:parent.width
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignRight
                   color:fontColor
                   font.pixelSize: mainView.width * 0.04
               }

           }

         //  GridLayout {
         //      width:parent.width
         //     columns:1

           SpinBox {
               id:monthselect
               from: 0
               to: 11
               value: d.getMonth()

               contentItem: Label {
                   text:switch(parent.value) {
                   case 0:"January";break;
                   case 1:"Febuary";break;
                   case 2:"March";break;
                   case 3:"April";break;
                   case 4:"May";break;
                   case 5:"Jun";break;
                   case 6:"July";break;
                   case 7:"August";break;
                   case 8:"September";break;
                   case 9:"October";break;
                   case 10:"November";break;
                   case 11:"December";break;
                   }

                   width:parent.width
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignHCenter
                   color:fontColor
                   font.pixelSize: mainView.width * 0.04
                   }


               down.indicator: Rectangle {
                                   width:parent.height /2
                                   height:parent.height /2
                                   radius: width /2
                                   anchors.left:parent.left
                                   anchors.verticalCenter: parent.verticalCenter
                                   color:activeColor

                                   Image {
                                       id:d1
                                       source:"./icons/minus.svg"
                                       anchors.centerIn: parent
                                       fillMode: Image.PreserveAspectFit
                                       width: parent.width * 0.65


                                   }

                                   ColorOverlay {
                                       source:d1
                                       color:fontColor
                                       anchors.fill:d1


                                   }

                                   }

               up.indicator: Rectangle {
                                   width:parent.height /2
                                   height:parent.height /2
                                   radius: width /2
                                   anchors.right:parent.right
                                   anchors.verticalCenter: parent.verticalCenter
                                   color:activeColor

                                   Image {
                                       id:u1
                                       source:"./icons/add.svg"
                                       anchors.centerIn: parent
                                       fillMode: Image.PreserveAspectFit
                                       width: parent.width * 0.65
                                   }

                                   ColorOverlay {
                                       source:u1
                                       color:fontColor
                                       anchors.fill:u1


                                   }

                                   }

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
                                 delegate: Text {

                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    font:parent.font
                                                    text: model.shortName
                                                    color:fontColorTitle
                                                }
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
                   color:model.day === theday ? highLightColor1 : fontColor
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
                   color:fontColor
               }

           SpinBox {
                           id: hoursSpin
                            width:thisWindow.width / 4
                            height:parent.height

                           //model: 12
                           from:1
                           to:12
                           value:if(d.getHours() > 12) {d.getHours() - 12}


                           contentItem: Label {
                               text:if(parent.value < 10) { "0"+(parent.value)} else {parent.value}
                               width:parent.width
                               verticalAlignment: Text.AlignVCenter
                               horizontalAlignment: Text.AlignHCenter
                               color:fontColor
                               font.pixelSize: mainView.width * 0.04
                               }


                           down.indicator: Rectangle {
                                               width:parent.height /2
                                               height:parent.height /2
                                               radius: width /2
                                               anchors.left:parent.left
                                               anchors.verticalCenter: parent.verticalCenter
                                               color:activeColor

                                               Image {
                                                   id:d2
                                                   source:"./icons/minus.svg"
                                                   anchors.centerIn: parent
                                                   fillMode: Image.PreserveAspectFit
                                                   width: parent.width * 0.65


                                               }

                                               ColorOverlay {
                                                   source:d2
                                                   color:fontColor
                                                   anchors.fill:d2


                                               }

                                               }

                           up.indicator: Rectangle {
                                               width:parent.height /2
                                               height:parent.height /2
                                               radius: width /2
                                               anchors.right:parent.right
                                               anchors.verticalCenter: parent.verticalCenter
                                               color:activeColor

                                               Image {
                                                   id:u2
                                                   source:"./icons/add.svg"
                                                   anchors.centerIn: parent
                                                   fillMode: Image.PreserveAspectFit
                                                   width: parent.width * 0.65
                                               }

                                               ColorOverlay {
                                                   source:u2
                                                   color:fontColor
                                                   anchors.fill:u2


                                               }

                                               }


                       }

           Text {
               text:":"
               //width:parent.width / 6
               horizontalAlignment: Text.AlignHCenter
               font.pixelSize: thisWindow.width * 0.05
               color:fontColor
           }

           SpinBox {
                           id: miniuteSpin
                                width:thisWindow.width / 4
                                 height:parent.height
                           from:0
                           to:59
                           value:d.getMinutes()


                           contentItem: Label {
                               text:if(parent.value < 10) {"0"+(parent.value)} else {parent.value}
                               width:parent.width
                               verticalAlignment: Text.AlignVCenter
                               horizontalAlignment: Text.AlignHCenter
                               color:fontColor
                               font.pixelSize: mainView.width * 0.04
                               }


                           down.indicator: Rectangle {
                                               width:parent.height /2
                                               height:parent.height /2
                                               radius: width /2
                                               anchors.left:parent.left
                                               anchors.verticalCenter: parent.verticalCenter
                                               color:activeColor

                                               Image {
                                                   id:d3
                                                   source:"./icons/minus.svg"
                                                   anchors.centerIn: parent
                                                   fillMode: Image.PreserveAspectFit
                                                   width: parent.width * 0.65


                                               }

                                               ColorOverlay {
                                                   source:d3
                                                   color:fontColor
                                                   anchors.fill:d3


                                               }

                                               }

                           up.indicator: Rectangle {
                                               width:parent.height /2
                                               height:parent.height /2
                                               radius: width /2
                                               anchors.right:parent.right
                                               anchors.verticalCenter: parent.verticalCenter
                                               color:activeColor

                                               Image {
                                                   id:u3
                                                   source:"./icons/add.svg"
                                                   anchors.centerIn: parent
                                                   fillMode: Image.PreserveAspectFit
                                                   width: parent.width * 0.65
                                               }

                                               ColorOverlay {
                                                   source:u3
                                                   color:fontColor
                                                   anchors.fill:u3


                                               }

                                               }


                       }

           SpinBox {
                           id: ampmSpin
                           width:thisWindow.width / 4
                           anchors.verticalCenter: parent.verticalCenter
                            height:parent.height

                           from: 0
                           to: 1
                           value:if(d.getHours() >= 12) {1} else {0}


                           contentItem: Label {
                               text:if(parent.value === 0) {return "AM"} else {return "PM"}
                               width:parent.width
                               verticalAlignment: Text.AlignVCenter
                               horizontalAlignment: Text.AlignHCenter
                               color:fontColor
                               font.pixelSize: mainView.width * 0.04
                               }


                           down.indicator: Rectangle {
                                               width:parent.height /2
                                               height:parent.height /2
                                               radius: width /2
                                               anchors.left:parent.left
                                               anchors.verticalCenter: parent.verticalCenter
                                               color:activeColor

                                               Image {
                                                   id:d4
                                                   source:"./icons/minus.svg"
                                                   anchors.centerIn: parent
                                                   fillMode: Image.PreserveAspectFit
                                                   width: parent.width * 0.65


                                               }

                                               ColorOverlay {
                                                   source:d4
                                                   color:fontColor
                                                   anchors.fill:d4


                                               }

                                               }

                           up.indicator: Rectangle {
                                               width:parent.height /2
                                               height:parent.height /2
                                               radius: width /2
                                               anchors.right:parent.right
                                               anchors.verticalCenter: parent.verticalCenter
                                               color:activeColor

                                               Image {
                                                   id:u4
                                                   source:"./icons/add.svg"
                                                   anchors.centerIn: parent
                                                   fillMode: Image.PreserveAspectFit
                                                   width: parent.width * 0.65
                                               }

                                               ColorOverlay {
                                                   source:u4
                                                   color:fontColor
                                                   anchors.fill:u4


                                               }

                                               }


                       }


           }


           Text {
               text:"Invites:"
               font.bold: true
               color:fontColor

           }

           Item {
               width:parent.width
               height:thisWindow.width * 0.2
               clip:true

           ListView {
               id:invitelistView
               width:if(contentWidth < (thisWindow.width * 0.89)) {contentWidth} else {thisWindow.width * 0.89}
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
                       id:addinviteimg
                       anchors.centerIn: parent
                       width:parent.width * 0.5
                       height:parent.width * 0.5
                       source:"./icons/add.svg"
                   }

                   ColorOverlay {
                       source:addinviteimg
                       anchors.fill:addinviteimg
                       color:fontColor
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
               text:qsTr("About:")
               font.bold: true
               color:fontColor

           }
           TextArea {
               id:about
               width:parent.width
               height:thisWindow.width * 0.5
               text:"We'll talk about things and stuff"
               color:fontColor
           }

           Item {
               width:parent.width
               height:thisWindow.width * 0.15


           Button {
               width:parent.width * 0.48
               anchors.left: parent.left
               height:parent.height
               text:qsTr("Cancel")
               onClicked: {


                   eventEdit.state = "InActive";

                   eventsPage.updateevents = true;
               }
               background: Rectangle {
                           color:highLightColor1
                           }

               contentItem: Text {
                                  width:parent.width
                                  horizontalAlignment: Text.AlignHCenter
                                  verticalAlignment: Text.AlignVCenter
                                  font:parent.font
                                  text:parent.text
                                  color:fontColorTitle
                              }
           }
            Button {
                width:parent.width * 0.48
                 height:parent.height
                anchors.right: parent.right
                text:qsTr("Save")
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

                contentItem: Text {
                                   width:parent.width
                                   horizontalAlignment: Text.AlignHCenter
                                   verticalAlignment: Text.AlignVCenter
                                   font:parent.font
                                   text:parent.text
                                   color:fontColorTitle
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
                color:fontColor
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
                contentItem: Text {
                                   width:parent.width
                                   horizontalAlignment: Text.AlignHCenter
                                   verticalAlignment: Text.AlignVCenter
                                   font:parent.font
                                   text:parent.text
                                   color:fontColorTitle
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
                contentItem: Text {
                                   width:parent.width
                                   horizontalAlignment: Text.AlignHCenter
                                   verticalAlignment: Text.AlignVCenter
                                   font:parent.font
                                   text:parent.text
                                   color:fontColorTitle
                               }
            }


        }




    }


}
