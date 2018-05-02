import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0 as Sql
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "microblogger.js" as MBlog

import "main.js" as Scripts
import "text.js" as Scrubber

import "microblogger.js" as MicroBlog


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string title:""
    property string latestStatus:""

    clip: true



    onStateChanged: {switch(title) {
                       case "Category": Scripts.Category_search();break;
                       case "Category Select": Scripts.Category_set();break;
                       default: Scripts.totals();latestStatus = MicroBlog.latest_log("Menu",usercardNum);break;
                    }
            //console.log(username)
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

            PropertyChanges {
                target: quickactions
                menu: 1
                visible:if(title == "Category") {false} else {true}
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
             // visible:false
              y:height * - 1
          }

          PropertyChanges {
              target: quickactions
              menu: 0
              visible:false
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
        anchors.top:parent.top
        anchors.topMargin: mainView.width * 0.04
       // anchors.verticalCenter: parent.verticalCenter
        //anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter

        //anchors.leftMargin: parent.width * 0.04
        clip:true
        width:parent.width * 0.98
        height:if(title != "Category") {parent.height * 0.9} else {parent.height * 0.98}
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
                    height:if(menuitem == 1) {menulistview.height * 0.16} else {menulistview.height * 0.1}
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
                        color:backgroundColor
                        clip:true
                        visible: true
                        radius: 1
                        border.color: cardcolor
                        border.width:1

                        Item{
                            id:icon
                            anchors.left: parent.left
                            anchors.leftMargin: if(menuitem != "3") {mainView.width * 0.03} else {mainView.width * 0.70}
                            anchors.verticalCenter: parent.verticalCenter
                            width:if(menuitem == 1) {parent.height} else {parent.height * 0.6}
                            height:if(menuitem == 1) {parent.height} else {parent.height * 0.6}
                            Image {
                                anchors.fill: parent
                                visible: if(menuitem !=1) {true} else {false}
                            source: if(title != "Category") {switch(menuitem) {
                                       case "0": "./icons/gps.svg";break;
                                       case "2": "./icons/contact-group.svg";break;
                                      case "1": "./icons/contact.svg";break;
                                       case "3": "./icons/edit.svg";break;
                                       case "4": "./icons/message.svg";break;
                                       case "5": "./icons/swap.svg";break;
                                       case "6": "./icons/calendar.svg";break;

                                       default:"./icons/overlay.svg";break;
                                       } } else {""}
                            }
                            CirclePic {
                                id:menuPic
                                anchors.fill: parent
                                visible: if(menuitem == 1) {true} else {false}
                                //theImage:"./icons/contact.svg"
                                 whichPic:usercardNum
                                 where:"mycard"


                            }

                        }

                        Text {
                                //anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                width:parent.width * 0.89
                                anchors.left:icon.right
                                anchors.leftMargin: 10
                                horizontalAlignment: Text.AlignLeft
                                //font.pixelSize: parent.width * 0.1 - text.length * 1.2

                                font.pixelSize: if(menuitem == 1) {parent.height * 0.4} else {parent.height * 0.25}
                               text: if(title != "Category") {switch(menuitem) {
                                     case "0": qsTr("Collected");break;
                                     case "2": qsTr("Contacts");break;
                                    case "1": username;break;
                                     case "3": qsTr("");break;
                                     case "4": qsTr("Messages ");break;
                                     case "5": qsTr("Requests ");break;
                                     case "6": qsTr("Events ");break;
                                     //case "8":qsTr("");break;
                                     default:menuitem;break;
                                     }
                                     } else {menuitem}

                               Text {
                                     id:stext
                                     visible: if(menuitem == 1) {true} else {false}

                                        anchors.top:parent.bottom
                                         text:"<p>"+latestStatus+"</p>"
                                         verticalAlignment:Text.AlignVCenter
                                         //padding: width * 0.2
                                         anchors.left: parent.left
                                         anchors.leftMargin: parent.width * 0.04
                                         width:parent.width * 0.82
                                         wrapMode: Text.WordWrap
                                         //height:parent.height * 0.80
                                         font.pixelSize: parent.width * 0.04
                                          elide: Text.ElideRight
                                         maximumLineCount: 1
                                   }

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
                                  case "3": qsTr("Edit Profile");break;
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
                                visible: if(parent.text != "") {if(menuitem !="3") {true} else {false} } else {false}

                            }

                        }
             }
                   /* DropShadow {
                        anchors.fill: bg
                        horizontalOffset: 1
                        verticalOffset: 2
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: bg
                       // z:1

                    } */

            MouseArea {
                anchors.fill:parent
                onClicked:switch(menuitem) {
                          case "0": {
                                     requestPage.state = "InActive";
                                     messagePage.state = "InActive";
                                     settingsPage.state = "InActive";
                                     cardPage.state = "show";
                                     cardPage.state = "default";
                                     popup.state = "InActive";
                                     //saveded.state = "unselected";
                                    // passby.state = "selected";
                                     pages = 1;
                                        cardslist.clear();
                                        currentcard = -1;
                                        topBar.isActive = false;
                                             selection = 0;
                                            listget = "temp"
                                            Scripts.temp_Load(searchtext,listget);

                          }break;
                          case "2":{
                                    requestPage.state = "InActive";
                                    messagePage.state = "InActive";
                                    settingsPage.state = "InActive";
                                    cardPage.state = "show"
                                    cardPage.state = "default";
                                    popup.state = "InActive";
                                    //saveded.state = "unselected";
                                   // passby.state = "selected";
                                    pages = 1;
                              cardslist.clear();
                              currentcard = -1;
                              topBar.isActive = false;
                              selection = 1;
                              listget = "saved";
                                  Scripts.cards_Load(searchtext);
                          }break;

                          case "3": settingsPage.state = "Active";
                                    cardPage.state = "settings";
                                   // popup.state = "InActive";
                                    cardindex = 0;
                                    break;

                          case "1":requestPage.state = "InActive";
                                   messagePage.state = "InActive";
                                    settingsPage.state = "InActive";cardPage.state = "show";cardPage.state = "default";currentcard = -1;currentcard_username = username;
                                            currentcard_companyname = usercompany;
                                            currentcard_avatarimg = avimg;



                                            cardindex = 0;
                                            pagelist.clear();Scripts.show_Sites("local",userid);mainScreen.state = "Active";mainScreen.fromRequest = false;popup.state = "InActive";mainScreen.positionViewAtBeginning();gc();
                                            currentcard_saved = 2;
                                            //if(layouts.width < units.gu(mobile_vert)) {
                                               // if(infotab.state == "Available" || infotab.state == "Active") {mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()} else {mainScreen.state = "InActive",infotab.state = "Active",cardPage.header.show()}
                                            //}
                                             mainScreen.state = "Active";topBar.state = "person";
                                            break;

                          case "3": /* chatPage.state = "Available",popup.state = "InActive";topBar.isActive = false;topBar.state = "chat";*/break;
                          case "4": messagePage.from =="Menu",messagePage.state = "Active",popup.state = "InActive";topBar.isActive = false;topBar.state = "messages";break;
                          case "5": messagePage.state = "InActive", requestPage.state = "Active",popup.state = "InActive";topBar.isActive = false;topBar.state = "requests";break;
                          case "6": /* eventsPage.state = "Available",popup.state = "InActive";topBar.isActive = false;topBar.state = "events"; */break;


                          default:if(title == "Category") {currentcat = menuitem;
                                                                    cardslist.clear();
                                                                       if (selection == 0) {
                                                                         Scripts.temp_Load(searchtext,listget);
                                                                       }else {
                                                                        Scripts.cards_Load(searchtext);}

                                                                        } else {usercat = menuitem;} popup.state = "InActive",mainMenu2.rotation = 0;break;
                          }
                onPressed:listItem.state = "Active"
                onReleased:listItem.state = "InActive"
            }

                    }
                    Item {
                        id:statusInput
                        visible: if (type == 3) {true} else {false}
                        enabled: visible
                        width:parent.width
                        height:stext.height
                       /* Text {
                            id:stext
                           // anchors.right:back.left
                          //  anchors.rightMargin: parent.width * 0.02
                          //  anchors.left:mainMenu2.right
                          //  anchors.leftMargin: parent.width * 0.02
                            anchors.verticalCenter: parent.verticalCenter
                            text:MicroBlog.latest_log("Menu",usercardNum)
                            verticalAlignment:Text.AlignVCenter
                            //padding: width * 0.2
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.1
                            width:parent.width * 0.95
                            wrapMode: Text.WordWrap
                            //height:parent.height * 0.80
                            font.pixelSize: parent.width * 0.04
                           // elide: Text.ElideRight

                        } */

                    }


        }

        model:

               ListModel {
                                    id:menuList

                                    ListElement {
                                            menuitem: "1"
                                            type:1
                                    }

                                    ListElement {
                                            menuitem: "3"
                                            type:3
                                    }

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

                                   /* ListElement {
                                            menuitem: "6"
                                            type:1
                                    } */

                                }


}



    Actions {

        id:quickactions
        anchors.bottom:parent.bottom
        anchors.bottomMargin:mainView.width * 0.01
        width:parent.width
        height:mainView.width * 0.10
    }


}




