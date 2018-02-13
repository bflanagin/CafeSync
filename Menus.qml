import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
//import Ubuntu.Components 1.2
import QtQuick.LocalStorage 2.0 as Sql
import QtGraphicalEffects 1.0

import "main.js" as Scripts


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string title:""

    clip: true

    onStateChanged: switch(title) {
                       case "Category": Scripts.Category_search();break;
                       case "Category Select": Scripts.Category_set();break;
                       default: Scripts.totals();break;
                    }

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                //visible:true
               // height:parent.height * 0.80
                //width:if(layouts.width > units.gu(mobile_vert)){parent.width * 0.40} else {parent.width * 0.90}
              //  width: parent.width * 0.90
                y:switch(title) {
                  case "Category": topBar.height;break;
                  case "Category Select": 0;break;
                  default: topBar.height;
               }

            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
             // visible:false
              y:height * - 1
          }
        }
    ]



    transitions: [
        Transition {
            from: "InActive"
            to: "Active"
            reversible: true


            NumberAnimation {
                target: popup
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }

        }
    ]

 Rectangle {
  width:parent.width
  height:parent.height
  color:backgroundColor
  //radius:8
 // border.color:"black"
 // border.width:1

  MouseArea {
      anchors.fill:parent

  }

}

    ListView {
        id:menulistview
       // anchors.top:parent.top
        anchors.verticalCenter: parent.verticalCenter
        //anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter

        //anchors.leftMargin: parent.width * 0.04
        clip:true
        width:parent.width * 0.98
        height:if(title != "Category") {parent.height * 0.98} else {parent.height * 0.98}
        flickableDirection: Flickable.VerticalFlick
        //contentHeight:notopdiscript.height
        spacing: height * 0.01

        delegate: Item {
                        id:listItem
                    states: [
                            State {
                                name:"Active"
                                PropertyChanges {
                                    target:bg
                                    color:highLightColor1
                                }
                        },
                        State {
                            name:"InActive"
                            PropertyChanges {
                                target:bg
                                color:cardcolor
                            }
                        }
                    ]
                    state:"InActive"

                    width:menulistview.width
                    height:menulistview.height *0.1
                    //anchors.horizontalCenter: parent.horizontalCenter
                    Item {
                        id:menuSeperator
                        visible: if(type==1) {false} else {true}
                        width:parent.width
                        height:parent.height



                        Column {
                            width:parent.width
                            height:parent.height * 0.8
                            anchors.bottom: parent.bottom
                            spacing: 10

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 5
                                font.pixelSize: parent.height * 0.35
                                text:switch(section) {
                                     case "1": qsTr("General");break;
                                     case "2": qsTr("Social");break;
                                     default: qsTr("Unknown Section ")+section;break;
                                     }
                            }

                        Rectangle {
                            color:seperatorColor1
                            width:parent.width
                            height:3
                        }
                        }
                    }

                    Item {
                        id:menuItem
                        visible: if(type==2) {false} else {true}
                        width:parent.width
                        height:parent.height
                    Rectangle {
                        id:bg
                        width:parent.width
                        height:parent.height
                        color:cardcolor
                        clip:true

                        radius: 1

                        Text {
                                //anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width:parent.width * 0.89
                                anchors.left:parent.left
                                anchors.leftMargin: 10
                                horizontalAlignment: Text.AlignLeft
                                //font.pixelSize: parent.width * 0.1 - text.length * 1.2

                                font.pixelSize: parent.height * 0.25
                               text: if(title != "Category") {switch(menuitem) {
                                     case "0": qsTr("Passersby");break;
                                     case "2": qsTr("Contacts");break;
                                    case "1": qsTr("Your Card");break;
                                     case "3": qsTr("Chat ");break;
                                     case "4": qsTr("Messages ");break;
                                     case "5": qsTr("Requests ");break;
                                     case "6": qsTr("Events ");break;

                                     default:menuitem;break;
                                     }
                                     } else {menuitem}

                        }

                        Text {
                            anchors.right:parent.right
                            anchors.rightMargin: 10
                            //width: parent.width * 0.10
                            font.pixelSize: parent.height * 0.25
                            horizontalAlignment: Text.AlignRight
                            anchors.verticalCenter: parent.verticalCenter
                            text: if(title != "Category") {switch(menuitem) {
                                  case "0":"("+ptotal+")";break;
                                  case "2":"("+ctotal+")";break;
                                 case "1":"";break;
                                  case "3": qsTr("(Coming Soon)");break;
                                  case "4": qsTr("("+totalNewMessages+")");break;
                                  case "5": qsTr("("+requests+")");break;
                                  case "6": qsTr("(Coming Soon)");break;

                                  default:"";break;
                                  }
                                  } else {""}

                            Rectangle {
                                anchors.right:parent.left
                                anchors.rightMargin: 10
                                width:1
                                height:parent.height * 1.4
                                anchors.verticalCenter: parent.verticalCenter
                                color:seperatorColor1
                                visible: if(parent.text !="") {true} else {false}

                            }

                        }
             }
                    DropShadow {
                        anchors.fill: bg
                        horizontalOffset: 1
                        verticalOffset: 2
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: bg
                       // z:1

                    }

            MouseArea {
                anchors.fill:parent
                onClicked:switch(menuitem) {
                          case "0": {
                                     requestPage.state = "InActive",
                                     messagePage.state = "InActive",
                                     settingsPage.state = "InActive",
                                     cardPage.state = "show",
                                     cardPage.state = "default";
                                     popup.state = "InActive";
                                     //saveded.state = "unselected";
                                    // passby.state = "selected";
                                     pages = 1,cardslist.clear(),currentcard = -1
                             ,mainMenu.rotation=0;
                                  selection = 0;
                                  listget = "temp"
                                  Scripts.Temp_load(searchtext,listget);

                          }break;
                          case "2":{
                                    requestPage.state = "InActive",
                                    messagePage.state = "InActive",
                                    settingsPage.state = "InActive",
                                    cardPage.state = "show",
                                    cardPage.state = "default";
                                    popup.state = "InActive";
                                    //saveded.state = "unselected";
                                   // passby.state = "selected";
                                    pages = 1,cardslist.clear(),currentcard = -1
                            ,mainMenu.rotation=0;
                              selection = 1;
                              listget = "saved";
                                  Scripts.Cards_load(searchtext);
                          }break;
                          //case "3": /*settingsPage.state = "Active",cardPage.state = "settings";popup.state = "InActive";cardindex = 0;*/break;
                          case "1":requestPage.state = "InActive",
                                   messagePage.state = "InActive",
                                    settingsPage.state = "InActive",cardPage.state = "show",cardPage.state = "default";currentcard = -1;cardindex = 0;
                                            pagelist.clear();Scripts.Show_sites("local",userid);mainScreen.state = "Active";mainScreen.fromRequest = false;popup.state = "InActive";mainScreen.positionViewAtBeginning();gc();
                                            currentcard_saved = 2;
                                            //if(layouts.width < units.gu(mobile_vert)) {
                                               // if(infotab.state == "Available" || infotab.state == "Active") {mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()} else {mainScreen.state = "InActive",infotab.state = "Active",cardPage.header.show()}
                                            //}
                                             mainScreen.state = "Active",topBar.state = "person"
                                            break;

                          case "3": /* chatPage.state = "Available",popup.state = "InActive";mainMenu.rotation=0;topBar.state = "chat";*/break;
                          case "4": messagePage.from =="Menu",messagePage.state = "Active",popup.state = "InActive";mainMenu.rotation=0;topBar.state = "messages";break;
                          case "5": messagePage.state = "InActive", requestPage.state = "Active",popup.state = "InActive";mainMenu.rotation=0;topBar.state = "requests";break;
                          case "6": /* eventsPage.state = "Available",popup.state = "InActive";mainMenu.rotation=0;topBar.state = "events"; */break;


                          default:if(title == "Category") {currentcat = menuitem;
                                                                    cardslist.clear();
                                                                       if (selection == 0) {
                                                                         Scripts.Temp_load(searchtextfield.text,listget);
                                                                       }else {
                                                                        Scripts.Cards_load(searchtextfield.text);}

                                                                        } else {usercat = menuitem;} popup.state = "InActive",mainMenu2.rotation = 0;break;
                          }
                onPressed:listItem.state = "Active"
                onReleased:listItem.state = "InActive"
            }

                    }
        }

        model:

               ListModel {
                                    id:menuList

                                    ListElement {
                                            section: "1"
                                            type:2
                                    }

                                    ListElement {
                                            menuitem: "0"
                                            type:1
                                    }

                                    ListElement {
                                            menuitem: "2"
                                            type:1
                                    }

                                    ListElement {
                                            menuitem: "1"
                                            type:1
                                    }

                                    ListElement {
                                            section: "2"
                                            type:2
                                    }

                                   /* ListElement {
                                            menuitem: "3"
                                            type:1
                                    } */

                                   ListElement {
                                           menuitem: "4"
                                            type:1
                                    }

                                    ListElement {
                                            menuitem: "5"
                                            type:1
                                    }

                                    ListElement {
                                            menuitem: "6"
                                            type:1
                                    }

                                }


}



}




