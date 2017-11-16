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
                       default: break;
                    }

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
               // height:parent.height * 0.80
                //width:if(layouts.width > units.gu(mobile_vert)){parent.width * 0.40} else {parent.width * 0.90}
              //  width: parent.width * 0.90
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              visible:false
          }
        }
    ]

    //anchors.centerIn: parent

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
        height:parent.height * 0.88
        flickableDirection: Flickable.VerticalFlick
        //contentHeight:notopdiscript.height
        spacing: height / 9

        delegate: Item {
                        id:listItem
                    states: [
                            State {
                                name:"Active"
                                PropertyChanges {
                                    target:bg
                                    color:"gray"
                                }
                        },
                        State {
                            name:"InActive"
                            PropertyChanges {
                                target:bg
                                color:highLightColor1
                            }
                        }
                    ]
                    state:"InActive"

                    width:menulistview.width * 0.9
                    height:menulistview.height / 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        id:bg
                        width:parent.width
                        height:parent.height
                        color:highLightColor1
                        border.color:barColor
                        border.width:2
                        radius: 10


                        Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: parent.width * 0.1 - text.length * 1.2
                               text: if(title != "Category") {switch(menuitem) {
                                     case "0": qsTr("Contacts");break;
                                    // case "1": if(usercompany.length > 2) {usercompany} else {if(username.length >2) {username} else {qsTr("Card 1 not configured")}};break;
                                    case "1": qsTr("Your Card");break;
                                     case "3": qsTr("Settings");break;

                                     default:menuitem;break;
                                     }
                                     } else {menuitem}

                        }
             }
                    DropShadow {
                        anchors.fill: bg
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: bg
                        z:1

                    }

            MouseArea {
                anchors.fill:parent
                onClicked:switch(menuitem) {
                          case "0": settingsPage.state = "hide",cardPage.state = "show",cardPage.state = "default";popup.state = "InActive";saveded.state = "unselected";passby.state = "selected";selection=0;pages = 1,cardslist.clear(),currentcard = -1,pages = 1,cardslist.clear(),Scripts.Cards_load(searchtext);break;
                          case "3":settingsPage.state = "show",cardPage.state = "settings";popup.state = "InActive";saveded.state = "unselected";passby.state = "selected";cardindex = 0;break;
                          case "1":settingsPage.state = "hide",cardPage.state = "show",cardPage.state = "default";currentcard = -1;cardindex = 0;
                                            pagelist.clear();Scripts.Show_sites("local",userid);mainScreen.state = "Active";popup.state = "InActive";
                                            //if(layouts.width < units.gu(mobile_vert)) {
                                               // if(infotab.state == "Available" || infotab.state == "Active") {mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()} else {mainScreen.state = "InActive",infotab.state = "Active",cardPage.header.show()}
                                            //}
                                             mainScreen.state = "Active",topBar.state = "person"
                                            break;
                        /*  case "2":settingsPage.state = "hide",cardPage.state = "show",cardPage.state = "default";currentcard = -1;cardindex = 0;
                                            pagelist.clear();Scripts.Show_sites("local",userid1);mainScreen.state = "Active";popup.state = "InActive";
                                            //if(layouts.width < units.gu(mobile_vert)) {
                                               // if(infotab.state == "Available" || infotab.state == "Active") {mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()} else {mainScreen.state = "InActive",infotab.state = "Active",cardPage.header.show()}
                                            //}
                                             mainScreen.state = "Active",infotab.state = "InActive"
                                            break; */

                          default:if(title == "Category") {currentcat = menuitem;
                                                                    cardslist.clear();
                                                                       if (selection == 0) {
                                                                         Scripts.Temp_load(searchtextfield.text,listget);
                                                                       }else {
                                                                        Scripts.Cards_load(searchtextfield.text);}

                                                                        } else {if(cardindex == 0) {usercat = menuitem;} else {usercat1 = menuitem;}} popup.state = "InActive";break;
                          }
                onPressed:listItem.state = "Active"
                onReleased:listItem.state = "InActive"
            }
        }

        model:

               ListModel {
                                    id:menuList

                                    ListElement {
                                            menuitem: "0"
                                    }

                                    ListElement {
                                            menuitem: "1"
                                    }

                                  /*  ListElement {
                                            menuitem: "2"
                                    } */
                                    ListElement {
                                            menuitem: "3"
                                    }
                                }


}



}




