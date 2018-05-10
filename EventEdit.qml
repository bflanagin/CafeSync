import QtQuick 2.8
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.2
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.calendar 1.0
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0 as Sql


Item {
    id:thisWindow
    property bool edit:false
    property var d: new Date()

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

                            return themonth;
               }
               //onValueChanged: grid.month = value
           }

           Item {
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
                            color:model.day === d.getDay() ? highLightColor1 : cardcolor
                            opacity: model.month === monthselect.value ? 1 : 0
                   Text {
                       anchors.centerIn: parent
                   horizontalAlignment: Text.AlignHCenter
                   verticalAlignment: Text.AlignVCenter
                   text: model.day
                   //font: control.font
               }

               }


           }

           }

           Text {
               text:"Invites:"
               font.bold: true

           }

           Row {
               width:parent.width
               height:thisWindow.width * 0.2
               clip:true
               spacing: thisWindow.width * 0.02

               CirclePic {
                   height:parent.width * 0.20
                   width:parent.width * 0.20
                   anchors.verticalCenter: parent.verticalCenter

               }

               Item {
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

               }
           }

           Text {
               text:"About:"
               font.bold: true

           }
           TextArea {
               width:parent.width
               height:thisWindow.width * 0.5
               text:"We'll talk about things and stuff"
           }

       }



       }
   }



}
