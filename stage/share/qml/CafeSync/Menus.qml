import QtQuick 2.3
import QtQuick.Window 2.2

import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0 as Sql

import "main.js" as Scripts


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string title:""

    //clip: true

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
                z: 3
                height:parent.height * 0.60
                width:if(window_width > units.gu(mobile_vert)){parent.width * 0.30} else {parent.width * 0.80}
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              z: -4
          }
        }
    ]

    //anchors.centerIn: parent

 Rectangle {
  width:parent.width
  height:parent.height
  color:"white"
  radius:20
  border.color:"black"
  border.width:1

  MouseArea {
      anchors.fill:parent

  }

}
  Rectangle {
      clip:true
      id:titlebg
      width:parent.width
      height:parent.height * 0.12
      anchors.horizontalCenter: parent.horizontalCenter
      color:"gray"
      radius:20
      border.color:"darkgray"
      Rectangle {
          width:parent.width
          color:"gray"
          y:parent.height - 20
          height:parent.height - 35
      }

      Text {
          anchors.centerIn: parent
          text:title
          color:"white"
          font.pixelSize: parent.height /2
      }
  }
  Rectangle {
      anchors.top:titlebg.bottom
      width:parent.width
      height:3
      color:"black"


  }



    ListView {
        id:menulistview
        anchors.top:titlebg.bottom
        anchors.topMargin: 5
        //anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter

        //anchors.leftMargin: parent.width * 0.04
        clip:true
        width:parent.width * 0.98
        height:parent.height * 0.85
        flickableDirection: Flickable.VerticalFlick
        //contentHeight:notopdiscript.height
        spacing: units.gu(1)

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
                                color:"white"
                            }
                        }
                    ]
                    state:"InActive"

                    width:menulistview.width
                    height:menulistview.height / 8
                    Rectangle {
                        id:bg
                        width:parent.width
                        height:parent.height
                        color:"white"
                        border.color:"black"
                        border.width:1
                        radius: 10


            Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: parent.height * 0.85 - text.length / 2
                   text: if(title != "Category") {switch(menuitem) {
                         case "0": i18n.tr("Cards");break;
                         case "1": if(usercompany.length > 2) {usercompany} else {if(username.length >2) {username} else {i18n.tr("Card 1 not configured")}};break;
                         case "2": if(usercompany1.length > 2) {usercompany1} else {if(username1.length >2) {username1} else {i18n.tr("Card 2 not configured")}};break;
                         case "3": i18n.tr("Setup");break;

                         default:menuitem;break;
                         }
                         } else {menuitem}

            }
             }
            MouseArea {
                anchors.fill:parent
                onClicked:switch(menuitem) {
                          case "0": settingsPage.state = "hide",cardPage.head.sections.selectedIndex = 0,cardPage.state = "show",cardPage.state = "default";
                              if(window_width < units.gu(mobile_vert)) {
                              mainScreen.state = "InActive";
                              };popup.state = "InActive";break;
                          case "3":settingsPage.state = "show",cardPage.head.sections.selectedIndex = 0,cardindex= 0;cardPage.state = "settings";mainScreen.state = "InActive";popup.state = "InActive";infotab.state = "UnAvailable";break;
                          case "1":settingsPage.state = "hide",cardPage.state = "show",cardPage.state = "default";currentcard = -1;cardindex = 0;
                                            pagelist.clear();Scripts.Show_sites("local",userid);mainScreen.state = "Active";popup.state = "InActive";

                                            if(window_width <= units.gu(mobile_vert)) {

                                                        mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide();
                                            }
                                            break;

                          case "2":settingsPage.state = "hide",cardPage.state = "show",cardPage.state = "default";currentcard = -1;cardindex = 1;
                                            pagelist.clear();Scripts.Show_sites("local",userid1);mainScreen.state = "Active";popup.state = "InActive";

                                            if(window_width <= units.gu(mobile_vert)) {

                                                        mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide();
                                            }
                                            break;

                          default:if(title == "Category") {currentcat = menuitem;
                                                                    cardslist.clear();
                                                                       if (cardPage.head.sections.selectedIndex == 0) {
                                                                         Scripts.Temp_load(searchbox.text,listget);
                                                                       }else {
                                                                        Scripts.Cards_load(searchbox.text);}

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

                                        ListElement {
                                                menuitem: "2"
                                        }
                                        ListElement {
                                                menuitem: "3"
                                        }

                                }


}
    Image {
        visible:if(title !="Category") {true} else {false}
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: 10
        width:parent.width * 0.10
        fillMode:Image.PreserveAspectFit
        source:"/usr/share/icons/suru/actions/scalable/swap.svg"

        Flasher{
            id:reswap
        }
        MouseArea {
            anchors.fill:parent
            onPressed:reswap.state = "Active"
            onReleased:reswap.state = "InActive"
            onClicked:grabit.state = "Active",popup.state = "InActive"
        }
    }


}




