import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "text.js" as Scrubber
import "requests.js" as Request
import "messages.js" as Message

Item {

    id:topBar

    clip:true
    //visible: false
    property string searchtextfieldText: ""
    property bool isActive: false


   // onIsActiveChanged: if( mainMenu.rotation == 0) { mainMenu.rotation = 90} else {mainMenu.rotation = 0}



    states: [
        State {
            name:"Wizard"
            PropertyChanges {
                target:standardbuttons
                visible:false
            }
            PropertyChanges {
                target:settingsbutton
                visible:false
            }
            PropertyChanges {
                target:searchBar
                visible:false
                enabled:false
            }
            PropertyChanges {
                target:personBar
                visible:false
            }

            PropertyChanges {
                target:wizardBar
                visible:true
            }
            PropertyChanges {
                target:eventsBar
                visible:false
            }
            PropertyChanges {
                target:topBar
                y:0
            }
        },


        State {
            name:"standard"
            PropertyChanges {
                target:standardbuttons
                visible:true
            }
            PropertyChanges {
                target:settingsbutton
                visible:false
            }
            PropertyChanges {
                target:searchBar
                visible:false
                enabled:false
            }
            PropertyChanges {
                target:personBar
                visible:false
            }
            PropertyChanges {
                target:wizardBar
                visible:false
            }
            PropertyChanges {
                target:eventsBar
                visible:false
            }
            PropertyChanges {
                target:topBar
                y:0
            }
        },
          State {
            name:"settings"
            PropertyChanges {
                target:standardbuttons
                visible:false
            }
            PropertyChanges {
                target:settingsbutton
                visible:true
            }
            PropertyChanges {
                target:personBar
                visible:false
            }
            PropertyChanges {
                target:searchBar
                visible:false
                enabled:false
            }
            PropertyChanges {
                target:wizardBar
                visible:false
            }
            PropertyChanges {
                target:eventsBar
                visible:false
            }
            PropertyChanges {
                target:topBar
                y:0
            }
        },
        State {
          name:"search"
          PropertyChanges {
              target:standardbuttons
              visible:false
          }
          PropertyChanges {
              target:settingsbutton
              visible:false
          }
          PropertyChanges {
              target:personBar
              visible:false
          }
          PropertyChanges {
              target:searchBar
              visible:true
              enabled:true
          }
          PropertyChanges {
              target:wizardBar
              visible:false
          }
          PropertyChanges {
              target:eventsBar
              visible:false
          }
          PropertyChanges {
              target:topBar
              y:0
          }
      },

        State {
          name:"person"
          PropertyChanges {
              target:standardbuttons
              visible:false
          }
          PropertyChanges {
              target:settingsbutton
              visible:false
          }
          PropertyChanges {
              target:searchBar
              visible:false
              enabled:false
          }
          PropertyChanges {
              target:personBar
              visible:true
          }
          PropertyChanges {
              target:wizardBar
              visible:false
          }
          PropertyChanges {
              target:eventsBar
              visible:false
          }
          PropertyChanges {
              target:topBar
              y:0
          }
      },

                    State {
                      name:"chat"
                      PropertyChanges {
                          target:standardbuttons
                          visible:false
                      }
                      PropertyChanges {
                          target:settingsbutton
                          visible:false
                      }
                      PropertyChanges {
                          target:searchBar
                          visible:false
                          enabled:false
                      }
                      PropertyChanges {
                          target:personBar
                          visible:false
                      }
                      PropertyChanges {
                          target:wizardBar
                          visible:false
                      }
            PropertyChanges {
                target:chatBar
                visible:true

            }
            PropertyChanges {
                target:messagesBar
                visible:false
            }
            PropertyChanges {
                target:requestsBar
                visible:false
            }
            PropertyChanges {
                target:eventsBar
                visible:false
            }
            PropertyChanges {
                target:topBar
                y:0
            }
                  },

        State {
          name:"messages"
          PropertyChanges {
              target:standardbuttons
              visible:false
          }
          PropertyChanges {
              target:settingsbutton
              visible:false
          }
          PropertyChanges {
              target:searchBar
              visible:false
              enabled:false
          }
          PropertyChanges {
              target:personBar
              visible:false
          }
          PropertyChanges {
              target:wizardBar
              visible:false
          }
          PropertyChanges {
              target:chatBar
              visible:false

          }
          PropertyChanges {
              target:messagesBar
              visible:true
          }
          PropertyChanges {
              target:requestsBar
              visible:false
          }
          PropertyChanges {
              target:eventsBar
              visible:false
          }
          PropertyChanges {
              target:topBar
              y:0
          }
      },

        State {
          name:"requests"
          PropertyChanges {
              target:standardbuttons
              visible:false
          }
          PropertyChanges {
              target:settingsbutton
              visible:false
          }
          PropertyChanges {
              target:searchBar
              visible:false
              enabled:false
          }
          PropertyChanges {
              target:personBar
              visible:false
          }
          PropertyChanges {
              target:wizardBar
              visible:false
          }
          PropertyChanges {
              target:chatBar
              visible:false

          }
          PropertyChanges {
              target:messagesBar
              visible:false
          }
          PropertyChanges {
              target:requestsBar
              visible:true
          }
          PropertyChanges {
              target:eventsBar
              visible:false
          }
          PropertyChanges {
              target:topBar
              y:0
          }
      },

        State {
          name:"events"
          PropertyChanges {
              target:standardbuttons
              visible:false
          }
          PropertyChanges {
              target:settingsbutton
              visible:false
          }
          PropertyChanges {
              target:searchBar
              visible:false
              enabled:false
          }
          PropertyChanges {
              target:personBar
              visible:false
          }
          PropertyChanges {
              target:wizardBar
              visible:false
          }
          PropertyChanges {
              target:chatBar
              visible:false

          }
          PropertyChanges {
              target:messagesBar
              visible:false
          }
          PropertyChanges {
              target:requestsBar
              visible:false
          }
          PropertyChanges {
              target:eventsBar
              visible:true
          }
          PropertyChanges {
              target:topBar
              y:0
          }
      },

        State {
          name:"hide"
           PropertyChanges {
               target:topBar
               y:-1*height
           }

      },
        State {
          name:"show"
           PropertyChanges {
               target:topBar
               y:0
           }

      }




    ]
    state:"standard"


    Item {
        id:wizardBar
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor

            Text {
                anchors.centerIn: parent
                text: qsTr("Wizard")
                font.pixelSize: parent.height * 0.5
                color:fontColorTitle
            }
        }

    }


    Item {
        id:chatBar
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor

            Text {
                anchors.centerIn: parent
                text: qsTr("Chat")
                font.pixelSize: parent.height * 0.5
                color:fontColorTitle
            }
        }

        Item {
            id:cmainMenu
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: parent.width * 0.03

            width:parent.height * 0.5
            height:parent.height * 0.5


            Image {
                visible: false
                id:cback_icon
                anchors.fill: parent
                source: "./icons/back.svg"



            }

            ColorOverlay {
                source:cback_icon
                anchors.fill: cback_icon
                color:overlayColor
            }

            Flasher {
                id:csetflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: { messagePage.state  = "InActive",
                    themenu.state = "InActive",settingsPage.state = "InActive",isActive = false, topBar.state = "standard"//,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.show_Sites("local",userid);

                        }

               // onPressed: setflick.state = "Active"
               // onReleased: setflick.state = "InActive"
            }
        }






    }


    Item {
        id:messagesBar
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor

            Text {
                anchors.centerIn: parent
                text: if(messagePage.area =="Chat") {messagePage.whowith} else {messagePage.area}
                font.pixelSize: parent.height * 0.5
                color:fontColorTitle
            }
        }

        Item {
            id:mmainMenu
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: parent.width * 0.03

            width:parent.height * 0.5
            height:parent.height * 0.5


            Image {
                visible: false
                id:mback_icon
                anchors.fill: parent
                source: "./icons/back.svg"



            }

            ColorOverlay {
                source:mback_icon
                anchors.fill: mback_icon
                color:overlayColor
            }

            Flasher {
                id:msetflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: { if(messagePage.from =="Menu") {
                        if(messagePage.area == "Conversations") {
                    messagePage.state  = "InActive",
                    themenu.state = "InActive",
                    settingsPage.state = "InActive",

                    topBar.isActive = false,
                    topBar.state = "standard"
                    //,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.show_Sites("local",userid);
                        } else if (messagePage.area == "Chat") {
                            messagePage.showroom  = false;
                            messagePage.area == "Conversations"
                            //themenu.state = "InActive",settingsPage.state = "InActive",topBar.state = "standard"//,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.show_Sites("local",userid);
                        } else {

                            messageContactsPage.state = "InActive"

                        }
                        } else {
                             messagePage.showroom  = false;
                            messagePage.state  = "InActive";
                            topBar.state = "person";
                            messagePage.from ="Menu";

                }

            }

               // onPressed: setflick.state = "Active"
               // onReleased: setflick.state = "InActive"
            }
        }

        Item {
            id:madd
            anchors.right:parent.right
            anchors.verticalCenter: parent.verticalCenter
            visible: if(messagePage.area == "Conversations") {true} else {false}
            anchors.rightMargin: parent.width * 0.03

            width:parent.height * 0.5
            height:parent.height * 0.5


            Image {
                visible: false
                id:madd_icon
                anchors.fill: parent
                source: "./icons/add.svg"



            }

            ColorOverlay {
                source:madd_icon
                anchors.fill: madd_icon
                color:overlayColor
            }

            Flasher {
                id:maddsetflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: {messageContactsPage.state = "Active"}

                onPressed: maddsetflick.state = "Active"
                onReleased: maddsetflick.state = "InActive"
            }
        }

    }


    Item {
        id:requestsBar
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor

            Text {
                anchors.centerIn: parent
                text: qsTr("Requests")
                font.pixelSize: parent.height * 0.5
                color:fontColorTitle
            }
        }

        Item {
            id:rmainMenu
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: parent.width * 0.03

            width:parent.height * 0.5
            height:parent.height * 0.5


            Image {
                visible: false
                id:rback_icon
                anchors.fill: parent
                source: "./icons/back.svg"



            }

            ColorOverlay {
                source:rback_icon
                anchors.fill: rback_icon
                color:overlayColor
            }

            Flasher {
                id:rsetflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: { requestPage.state  = "InActive",
                    themenu.state = "InActive",settingsPage.state = "InActive",topBar.isActive = false,topBar.state = "standard"//,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.show_Sites("local",userid);

                        }

               // onPressed: setflick.state = "Active"
               // onReleased: setflick.state = "InActive"
            }
        }


    }


    Item {
        id:eventsBar
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor

            Text {
                anchors.centerIn: parent
                text: qsTr("Events")
                font.pixelSize: parent.height * 0.5
                color:fontColorTitle
            }
        }


        Item {
            id:emainMenu
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: parent.width * 0.03

            width:parent.height * 0.5
            height:parent.height * 0.5


            Image {
                visible: false
                id:eback_icon
                anchors.fill: parent
                source: "./icons/back.svg"



            }

            ColorOverlay {
                source:eback_icon
                anchors.fill: eback_icon
                color:overlayColor
            }

            Flasher {
                id:esetflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: { if(settingsPage.sourceselect == true) { settingsPage.sourceselect = false} else {


                              /*  Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                  useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                  stf,atf,ctf,avimg,carddesign,usercat);
                                                OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                     useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                     avimg,carddesign,usercat); */
                        // settingsPage.saveit = true;
                    themenu.state = "InActive",settingsPage.state = "InActive",topBar.isActive = false,topBar.state = "person",/*mainScreen.state = "InActive",*/pagelist.clear(),Scripts.load_Card(),Scripts.show_Sites("local",userid);
                    }
                        }

               // onPressed: setflick.state = "Active"
               // onReleased: setflick.state = "InActive"
            }
        }

    }




    Item {
        id:standardbuttons
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor
        }


Item {
    id:mainMenu
    anchors.left:parent.left
    anchors.verticalCenter: parent.verticalCenter
    rotation:if(themenu.state == "Active") {90} else {0}

    anchors.leftMargin: parent.width * 0.03
    width:parent.height * 0.5
    height:parent.height * 0.5

    Image {
        anchors.fill: parent
        source: "./icons/menu.svg"

    ColorOverlay {
        source:parent
        anchors.fill: parent
        color:overlayColor
    }

    }

    Flasher {
        id:menuflick
    }

    MouseArea {
        anchors.fill:parent
        //onClicked: standardMenu.popup()
        onClicked: {if(themenu.state == "InActive") {
                           themenu.state = "Active";
                                topBar.isActive = true;

                   } else {
                       themenu.state = "InActive";

                        topBar.isActive = false;
                   }
        }
    }

    Text{
        anchors.left:parent.right
        text:""

    }


}




    Item {
        id:search

        width:parent.height * 0.5
      height:parent.height * 0.5
      anchors.right:parent.right
      anchors.rightMargin:parent.width * 0.03
      anchors.verticalCenter: parent.verticalCenter

        Image {
        source:"./icons/find.svg"
        anchors.fill: parent

        ColorOverlay {
            source:parent
            anchors.fill: parent
            color:overlayColor
        }

        }

      Flasher {
          id:searchflick
      }

        MouseArea {
            anchors.fill:parent
        onClicked: topBar.state = "search"
           }
    }


    Item {
        id:location_switch
       // anchors.right:search.left
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        property int loc:if(listget == "temp") {0} else {2}
        width:parent.height * 0.7
        height:parent.height * 0.7

        Image {
             id:loc_icon
             visible: false
            anchors.fill: parent
        source: if(selection != 1) { switch(parent.loc) {
                                         case 0:"./icons/location.svg";break;
                                         case 2:"./icons/language-chooser.svg";break;
                                      // case 2:"./icons/stock_website.svg";break;
                                          default:"./icons/location.svg";break;
                                        }
                                }else {"./icons/overlay.svg"}



            }

        ColorOverlay {
            source:loc_icon
            anchors.fill: loc_icon
            color:overlayColor
        }


        Flasher {
            id:locflick
        }

        MouseArea {
            anchors.fill:parent
        //onClicked: {menuLocx = parent.x;menuLocy = parent.height;if(themenu.state == "InActive") {themenu.state = "Active"} else {themenu.state = "InActive"}}
            onPressed: locflick.state = "Active"
            onReleased: locflick.state = "InActive"
            onClicked:if(themenu.state != "Active") { if(selection != 1) {switch(location_switch.loc) {
                                             case 0: currentcard = -1;/*location_switch.loc = 2;*/location_selected = "Region";cardslist.clear();listget = "region";OpenSeed.get_list(userid,listget);Scripts.temp_Load(searchtext,listget);break;
                                             //case 1: currentcard = -1;location_switch.loc = 2;location_selected = "Global";cardslist.clear();listget = "global";OpenSeed.get_list(userid,listget);Scripts.temp_Load(searchtext,listget);break;
                                             case 2: currentcard = -1;/*location_switch.loc = 0;*/location_selected = "Passers By";cardslist.clear();listget = "temp";OpenSeed.get_list(userid,listget);Scripts.temp_Load(searchtext,listget);break;
                                             }
                        } else {
                            if(swapopt.state == "InActive") {swapopt.type ="receive";swapopt.state = "Active";} else {swapopt.type ="receive";swapopt.state = "InActive";}
                        }
                      }

        }
    }


}
    Item {
        id:settingsbutton
        width:parent.width
        height:parent.height
        visible:false
        Rectangle {
            anchors.fill:parent
            color:barColor
        }

        Item {
            id:mainMenu1
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: parent.width * 0.03

            width:parent.height * 0.5
            height:parent.height * 0.5


            Image {
                visible: false
                id:back_icon1
                anchors.fill: parent
                source: "./icons/back.svg"



            }

            ColorOverlay {
                source:back_icon1
                anchors.fill: back_icon1
                color:overlayColor
            }

            Flasher {
                id:setflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: { if(settingsPage.sourceselect == true) { settingsPage.sourceselect = false} else {


                              /*  Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                  useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                  stf,atf,ctf,avimg,carddesign,usercat);
                                                OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                     useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                     avimg,carddesign,usercat); */
                        // settingsPage.saveit = true;
                        if(themenu.state == "InActive") {
                                themenu.state = "InActive";
                                settingsPage.state = "InActive";
                                topBar.isActive = false;
                                mainMenu.rotation = 0;
                                topBar.state = "person";
                                /*mainScreen.state = "InActive";*/
                                pagelist.clear();
                                Scripts.load_Card();
                                Scripts.show_Sites("local",userid);
                    } else {
                            settingsPage.state = "InActive";
                            topBar.state = "standard";
                        }

                    }
                        }

               // onPressed: setflick.state = "Active"
               // onReleased: setflick.state = "InActive"
            }
        }

        //}
        Text {
            id:title1
            //anchors.left:mainMenu1.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text:qsTr("Setup")
            color:fontColorTitle
            font.pixelSize: parent.height * 0.5
        }

        Item {
            id:saveme
            anchors.right:parent.right
            anchors.rightMargin:parent.width * 0.03
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.5
            height:parent.height * 0.5



            Image {
                id:save_icon
                visible: false
                anchors.fill: parent
                source: "./icons/save.svg"



            }

            ColorOverlay {
                source:save_icon
                anchors.fill: save_icon
                color:overlayColor
            }


            Flasher {
                id:savflick

            }

            MouseArea {
                anchors.fill:parent
            onClicked: {/*Scripts.save_card(userid,username.replace(/'/g," "),userphone,useremail,usercompany,
                                          useralias,usermotto,usermain,website1,website2,website3,website4,
                                          stf,atf,ctf,avimg,carddesign,usercat);
                        OpenSeed.upload_data(userid,username.replace(/'/g," "),userphone,useremail,usercompany,
                                             useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                             avimg,carddesign,usercat);*/

                        settingsPage.saveit = true;


                        }

            onPressed: savflick.state = "Active"
            onReleased: savflick.state = "InActive"
            }
        }

        /*
            Image {
                id:updatebutton
                anchors.right:saveme.left
                anchors.rightMargin:20

                anchors.verticalCenter: parent.verticalCenter
                source:"img/reset.svg"
                width:parent.height * 0.3
                height:parent.height * 0.3

                Flasher {
                    id:updateflick

                }

                MouseArea {
                    anchors.fill:parent
                onClicked: {OpenSeed.datasync(userid,0);
                            Scripts.save_card(userid,username,useremail,userphone,usercompany,
                                    useralias,usermotto,usermain,website1,website2,website3,website4,
                                    stf,atf,ctf,avimg,carddesign,usercat,cardindex);
                            }
                onPressed: updateflick.state = "Active"
                onReleased: updateflick.state = "InActive"

                }
            } */

    }

    Item {
        id:searchBar
        width:parent.width
        height:parent.height
        visible:false

        Rectangle {
            width:parent.width
            height:parent.height
            color:barColor
        }

        Item {
            id:mainMenu2
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter

            anchors.leftMargin: parent.width * 0.03
            rotation:if(catmenu.state == "Active") {90} else {0}
            width:parent.height * 0.5
            height:parent.height * 0.5

            Image {
                id:menu_icon2
                visible: false
                anchors.fill: parent
                source: "./icons/menu.svg"



            }

            ColorOverlay {
                source:menu_icon2
                anchors.fill: menu_icon2
                color:overlayColor
            }



            Flasher {
               // id:setflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: if(catmenu.state == "InActive") {catmenu.state = "Active"} else {catmenu.state = "InActive"}
            }
        }

        //}
        TextField {
            id:searchtextfield
            anchors.right:back.left
            anchors.rightMargin: parent.width * 0.02
            anchors.left:mainMenu2.right
            anchors.leftMargin: parent.width * 0.02
            anchors.bottom: parent.bottom
          //  anchors.verticalCenter: parent.verticalCenter
            leftPadding: width * 0.05
            //height:parent.height * 0.4
            font.pixelSize: parent.width * 0.05
           // verticalAlignment: Text.AlignVCenter
            text:searchtext
            placeholderText: qsTr(currentcat+":Search")
             background:InputBack{}
            onTextChanged: {cardslist.clear();
                if(selection == 0) {searchtext = text; Scripts.temp_Load(searchtextfield.text,listget)} else {Scripts.cards_Load(searchtextfield.text,listget) }
        }
        }



        Item {
            id:back
            anchors.right:parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.5
            height:parent.height * 0.5



            Image {
                id:back_icon2
                visible: false
                anchors.fill: parent
                source: "./icons/back.svg"


            }


            ColorOverlay {
                source:back_icon2
                anchors.fill: back_icon2
                color:overlayColor
            }

            Flasher {
                //id:setflick

            }

            MouseArea {
                anchors.fill:parent
                onClicked: topBar.state = "standard"
            }
        }

    }

    Item {
        id:personBar
        width:parent.width
        height:parent.height
        //visible:false




        Rectangle {
            anchors.fill:parent
            color:barColor
        }


Item {
    id:back2
    anchors.left:parent.left
    anchors.verticalCenter: parent.verticalCenter


    anchors.leftMargin: parent.width * 0.03
    width:parent.height * 0.5
    height:parent.height * 0.5

    Image {
        id:back_icon3
        visible: false
        anchors.fill: parent
        source: "./icons/back.svg"



    }

    ColorOverlay {
        source:back_icon3
        anchors.fill: back_icon3
        color:overlayColor
    }


    Flasher {
       // id:setflick

    }

    MouseArea {
        anchors.fill:parent
        //onClicked: standardMenu.popup()
        onClicked: { if(achievePage.state == "Active")
                            {achievePage.state = "InActive" }
                              else if (swapopt.state == "Active") {swapopt.state = "InActive"}
                                else { mainScreen.state = "InActive"; topBar.state="standard" }

                        if(themenu.state == "Active") {
                                    topBar.state="standard";
                        }
        }
    }


}

Item {
    id:saveState
    width:  parent.height * 0.7
    height: parent.height * 0.7
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    //z: -8

    Image {
        id:save_icon1
        visible: false
        anchors.fill: parent
        source: "./icons/overlay.svg"



    }

    ColorOverlay {
        source:save_icon1
        anchors.fill: save_icon1
        color:overlayColor
    }

    Flasher {
        id:sav1flick

    }

    MouseArea {
        anchors.fill:parent
        onClicked: if(themenu.state != "Active") { switch (currentcard_saved){
                  /* case 0: Scripts.Cards_save(currentcard_thecard,currentcard_username,currentcard_userphone,currentcard_useremail,currentcard_companyname,currentcard_cardposition,currentcard_motto,
                                          currentcard_mainsite,currentcard_url1,currentcard_url2,currentcard_url3,currentcard_url4,currentcard_avatarimg,currentcard_realcardback,currentcard_cardcat,currentcard_cardsop);

                       //currentcard_saved;

                       cardslist.clear();
                       OpenSeed.sync_cards(userid,3);
                       OpenSeed.get_list(userid,"saved");
                       Scripts.temp_Load(searchtext,listget);

                        currentcard_saved = 1;
                       break; */
                   //case 2:settingsPage.state = "Active";mainScreen.state = "InActive";break;
                   case 2:swapopt.where = "";if(swapopt.state == "InActive") {swapopt.type = "send"; swapopt.state ="Active"} else {swapopt.state = "InActive"};break;
                    case 1:swapopt.where = "";if(swapopt.state == "InActive") {swapopt.type = "send"; swapopt.state ="Active"} else {swapopt.state = "InActive"};break;
                    case 0:swapopt.where = "";if(swapopt.state == "InActive") {swapopt.type = "send"; swapopt.state ="Active"} else {swapopt.state = "InActive"};break;

                   } }

    onPressed: sav1flick.state = "Active"
    onReleased: sav1flick.state = "InActive"

    }

}

Item {
    id:editdelete
    width:  parent.height  * 0.5
    height:  parent.height * 0.5
    anchors.right:parent.right
    anchors.rightMargin: parent.width * 0.03
    anchors.verticalCenter: parent.verticalCenter


    Image {
        id:eddel
        visible: false
        anchors.fill: parent
        source:if(currentcard_saved == 2) {"./icons/edit.svg"} else {"./icons/delete.svg"}


    }

    ColorOverlay {
        source:eddel
        anchors.fill: eddel
        color:overlayColor
    }


    Flasher {
        id:delflick


    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        onClicked: if(mainScreen.fromRequest == false) {

                    switch(currentcard_saved ) {

                   case 0: Scripts.delete_Card(currentcard_thecard,listget);OpenSeed.remote_delete(userid,listget,currentcard_thecard);cardslist.clear();Scripts.temp_Load(searchtext,listget);
                       mainScreen.state = "InActive";
                       topBar.state="standard";
                       break;
                   case 1:
                            Scripts.delete_Card(currentcard_thecard,"saved");OpenSeed.remote_delete(userid,"saved",currentcard_thecard);cardslist.clear();Scripts.cards_Load(searchtext);
                            mainScreen.state = "InActive";
                            topBar.state="standard";
                            break;

                   case 2: settingsPage.state = "Active";break;

                   default:Scripts.delete_Card(currentcard_thecard,listget);OpenSeed.remote_delete(userid,listget,currentcard_thecard);cardslist.clear();Scripts.temp_Load(searchtext,listget);
                       mainScreen.state = "InActive";
                       topBar.state="standard";
                       break;
                   }

                   } else {
                       Request.decline_request(mainScreen.requestID);
                       mainScreen.state = "InActive";
                       topBar.state="requests";
                       mainScreen.fromRequest = false;
                       notification1.visible = true;notification1.themessage = "Request Declined";
                   }

        onPressed: delflick.state = "Active"
        onReleased: delflick.state = "InActive"

    }

}


}


}
