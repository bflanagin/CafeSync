import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

ApplicationWindow {

    id:mainView


    property int onsaved: 0

    property string backgrounds:""
    property string symbols:""

    property string text_Locations:""

    property string location_selected: "Passers By"
    property string listget: "temp"

    property string onetimecode:"Generating"

    property int cardindex: 0


    //Theme settings //
    property string backgroundColor: "#EFEFEF"
    property string highLightColor1: "#FFE082"
    property string barColor: "#795548"
    property string bottombarColor: "#795548"
    property string activeColor: "#6E4879"
    property string cardcolor: Qt.rgba(0.98,0.98,0.98,1)

    property string paths:""


    ////// Begin card info ///////

        //card one //

   property string username: ""
  property string userphone: ""
   property string useremail: ""
   property string usercompany: ""
   property string useralias: ""
   property string usermotto: ""
    property string userid: ""
    property string usercat: ""
    property string usercard: ""

    property string stf: "false"
    property string atf: "false"
    property string ctf: "false"
    property string wtf: "false"


    property string website1: ""
    property string website2: ""
    property string website3: ""
     property string website4: ""
     property string usermain: ""


    property string avimg: "img/default_avatar.png"
    property string cavimg: "img/default_avatar.png"
    property string cardback: "img/default_card.png"
    property string carddesign: ""
    property string cardtplace:""


    property string cardbImg: "img/default_card.png"
    property string cardsImg: ""
    property int fbgnum: 0
    property int fsymbolnum:0
    property int ftextnum:0
    property double lat:0
    property double log:0
    property string currentcords: ""

    property int uniquename: 8
        property int uniqueid: 8


    property int fbgnum1: 0
    property int fsymbolnum1:0
    property int ftextnum1:0

    property int offset: 60000



    ////// End card info ///////


    property string cardsyncsaved: ""
    property string cardsynctemp: ""
    property string remotesaved: ""
    property string remotetemp: ""

    property string tempcheck: ""
    property string savecheck: ""


   property string webview1: ""
    property string webview2: ""
    property string webview3: ""
    property string webview4: ""
    property string mainview: ""

    property string showurl: ""


    property string searchtext: ""


    property string devId: "Vag-01001011"
   property string appId: "vagCaf-01010"
    property string osUsername: ""
    property string osEmail: ""
    property string osPassphrase: ""
    property int cardloaded: 0
    property int numofcards: 0
    property int currentcard: -1
    property string currentlist: ""

    property int justpulled: 0

    property int pagenumber: 0



    property int window_height: Screen.desktopAvailableHeight
    property int window_width: Screen.desktopAvailableWidth

    //property list<ContentItem> importItems
    //property var activeTransfer

   property int pages: 0

    property int mobile_vert: 70
     property int mobile_width: 65

    property int menuLocx: 0
    property int menuLocy: 0

    property string currentcat: "All Cards"

    property string category_list: "All Cards,Art,Business,Construction,Education,Engineering,Food,Government,Law,Living,Lifestyle,Music,Non-Profit,Personal,Repair,Science,Software,Technology,Theatre,Writing,Wellness"

    property int bgnum: 2
    property int symbolnum: 14

    property int selection: 0



    // width: units.gu(175)
    //height: units.gu(100)


    property int currentcard_saved: 0
    property string currentcard_thecard: ""

    property string currentcard_username: ""
    property string currentcard_userphone: ""
    property string currentcard_useremail: ""
     property string currentcard_cardposition: ""
    property string currentcard_companyname: ""
    property string currentcard_motto: ""
    property string currentcard_mainsite: ""
    property string currentcard_url1: ""
    property string currentcard_url2: ""
    property string currentcard_url3: ""
    property string currentcard_url4: ""
    property string currentcard_avatarimg: ""
    property string currentcard_realcardback: ""
    property string currentcard_cardcat: ""
    property string currentcard_cardsop: ""

    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);





    visible: true
    width: 480
    height: 800
    //width:Screen.desktopAvailableWidth
    //height:Screen.desktopAvailableHeight
   // background: backgroundColor
    title: "CafeSync"




    Timer {
            id:startup
            interval:10; running:true; repeat: false
            onTriggered: {
            Scripts.load_Card();
            OpenSeed.retrieve_data(userid);
           // OpenSeed.retrieve_data(userid1);

                OpenSeed.datasync(userid,0);
               // OpenSeed.datasync(userid1,1);

            OpenSeed.get_list(userid,"temp");
            OpenSeed.get_list(userid,"saved");
            Scripts.Show_sites("local",userid);

            }
    }

    Timer {
        id:gpsupdate
        interval:1000000
        running: true
        repeat: true
        onTriggered:{
            gpsupdate.interval = offset;
        if (positionSource.supportedPositioningMethods ===
                PositionSource.NoPositioningMethods) {
            positionSource.nmeaSource = "nmealog.txt";
            sourceText.text = "(filesource): " + printableMethod(positionSource.supportedPositioningMethods);
        }

        positionSource.update();
    }
    }


    Timer {
        id:get_list_updater
        interval:80000; running: true; repeat: true
            onTriggered: {
                           // console.log("Updating List");
                        OpenSeed.retrieve_data(userid);
                        //OpenSeed.retrieve_data(userid1);
                   // if(listget == "temp") {

                    //cardslist.clear();
                        OpenSeed.get_list(userid,"temp");
                        OpenSeed.get_list(userid,"region");
                        OpenSeed.get_list(userid,"saved");
                    //}


          }
        }


    Timer {
            id:cardload
            interval:800; running: true; repeat:false

                onTriggered: {
                          //  console.log("loading "+ listget);
                           // console.log("what the server has "+remotetemp);
                       // if (tempcheck != remotetemp) {
                     cardslist.clear();
                   if(selection == 0)
                   {Scripts.Temp_load(searchtext,listget);}
                   else {Scripts.Cards_load(searchtext); }

                            tempcheck = remotetemp;
                          //console.log("what we have "+tempcheck);

                                //cardload.repeat = false
                        //} else {
                          // console.log("No change Detected");

                        //}

              }
            }


    PositionSource {
            id: positionSource
            onPositionChanged: {lat = positionSource.position.coordinate.latitude;
                                log = positionSource.position.coordinate.longitude;
                                // Scripts.gps_stats(lat,log);
                                 //   Scripts.upload_stats(lastName,firstName,userAge,homeTown,lat+","+log);

                                   lat = lat.toFixed(3);
                                    log = log.toFixed(3);
                                    currentcords = lat+","+log
                                    }

            onSourceErrorChanged: {
                if (sourceError == PositionSource.NoError)
                    return

                //console.log("Source error: " + sourceError)
                //activityText.fadeOut = true
                stop()
            }

            onUpdateTimeout: {
               }
        }



    Item {
        width:parent.width
        height:parent.height * 0.10
        id:topBar
        z:1
        clip:true



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
                }
                PropertyChanges {
                    target:personBar
                    visible:false
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
                }
                PropertyChanges {
                    target:personBar
                    visible:false
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
              }
              PropertyChanges {
                  target:personBar
                  visible:true
              }
          }

        ]
        state:"standard"


        Item {
            id:standardbuttons
            width:parent.width
            height:parent.height
            visible:false
            Rectangle {
                anchors.fill:parent
                color:barColor
            }


    Image {
        id:mainMenu
        anchors.left:parent.left
        anchors.verticalCenter: parent.verticalCenter

        source:"./img/menu.svg"
        anchors.leftMargin: parent.width * 0.03
        width:parent.height * 0.4
        height:parent.height * 0.4

        Flasher {
            id:menuflick
        }

        MouseArea {
            anchors.fill:parent
            //onClicked: standardMenu.popup()
            onClicked: {if(themenu.state == "InActive") {
                               themenu.state = "Active";
                                    mainMenu.rotation = 90;
                       } else {
                           themenu.state = "InActive";
                            mainMenu.rotation = 0;
                       }
            }
        }

        /*Text{
            anchors.left:parent.right
            text:numofcards

        } */


    }


        Image {
            id:search

            source:"./img/find.svg"
            anchors.right:parent.right
            anchors.rightMargin:parent.width * 0.03
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.4
          height:parent.height * 0.4

          Flasher {
              id:searchflick
          }

            MouseArea {
                anchors.fill:parent
            onClicked: topBar.state = "search"
               }
        }


        Image {
            id:location_switch
           // anchors.right:search.left
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            property int loc:if(listget == "temp") {0} else {2}
            source: if(selection != 1) { switch(loc) {
                                             case 0:"img/location.svg";break;
                                             case 2:"img/language-chooser.svg";break;
                                          // case 2:"img/stock_website.svg";break;
                                              default:"img/location.svg";break;
                                            }
                                    }else {"img/overlay-dark.png"}
            width:parent.height * 0.7
            height:parent.height * 0.7

            Flasher {
                id:locflick
            }

            MouseArea {
                anchors.fill:parent
            //onClicked: {menuLocx = parent.x;menuLocy = parent.height;if(themenu.state == "InActive") {themenu.state = "Active"} else {themenu.state = "InActive"}}
                onPressed: locflick.state = "Active"
                onReleased: locflick.state = "InActive"
                onClicked:if(selection != 1) {switch(location_switch.loc) {
                                                 case 0: currentcard = -1;/*location_switch.loc = 2;*/location_selected = "Region";cardslist.clear();listget = "region";OpenSeed.get_list(userid,listget);Scripts.Temp_load(searchtext,listget);break;
                                                 //case 1: currentcard = -1;location_switch.loc = 2;location_selected = "Global";cardslist.clear();listget = "global";OpenSeed.get_list(userid,listget);Scripts.Temp_load(searchtext,listget);break;
                                                 case 2: currentcard = -1;/*location_switch.loc = 0;*/location_selected = "Passers By";cardslist.clear();listget = "temp";OpenSeed.get_list(userid,listget);Scripts.Temp_load(searchtext,listget);break;
                                                 }
                            } else {
                                if(grabit.state == "InActive") {grabit.state = "Active"} else {grabit.state = "InActive"}
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

            Image {
                id:mainMenu1
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "./img/back.svg"
                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4

                Flasher {
                    id:setflick

                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: { Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                      useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                      stf,atf,ctf,avimg,carddesign,usercat);
                                                    OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                         useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                         avimg,carddesign,usercat);

                        themenu.state = "InActive",settingsPage.state = "InActive",mainMenu.rotation = 0,topBar.state = "person"
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
                color:"white"
                font.pixelSize: parent.height * 0.5
            }

            Image {
                id:saveme
                anchors.right:parent.right
                anchors.rightMargin:parent.width * 0.03
                anchors.verticalCenter: parent.verticalCenter
                width:parent.height * 0.4
                height:parent.height * 0.4
                source: "img/save.svg"

                Flasher {
                    id:savflick

                }

                MouseArea {
                    anchors.fill:parent
                onClicked: {Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                              useralias,usermotto,usermain,website1,website2,website3,website4,
                                              stf,atf,ctf,avimg,carddesign,usercat);
                            OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                 useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                 avimg,carddesign,usercat);


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

            Image {
                id:mainMenu2
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "./img/menu.svg"
                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4

                Flasher {
                   // id:setflick

                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: if(catmenu.state == "InActive") {catmenu.state = "Active",mainMenu2.rotation = 90} else {catmenu.state = "InActive",mainMenu2.rotation = 0}
                }
            }

            //}
            TextField {
                id:searchtextfield
                anchors.right:back.left
                anchors.rightMargin: parent.width * 0.01
                anchors.left:mainMenu2.right
                anchors.leftMargin: parent.width * 0.01
                anchors.verticalCenter: parent.verticalCenter


                text:searchtext
                placeholderText: qsTr(currentcat+":Search")

                onTextChanged: {cardslist.clear();
                    if(selection == 0) {Scripts.Temp_load(searchtextfield.text,listget)} else {Scripts.Cards_load(searchtextfield.text,listget) }
            }
            }



            Image {
                id:back
                anchors.right:parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width:parent.height * 0.4
                height:parent.height * 0.4
                source: "./img/back.svg"

                Flasher {
                    //id:setflick

                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: topBar.state = "standard", mainMenu.rotation = 0
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


    Image {
        id:back2
        anchors.left:parent.left
        anchors.verticalCenter: parent.verticalCenter

        source:"./img/back.svg"
        anchors.leftMargin: parent.width * 0.03
        width:parent.height * 0.4
        height:parent.height * 0.4

        Flasher {
           // id:setflick

        }

        MouseArea {
            anchors.fill:parent
            //onClicked: standardMenu.popup()
            onClicked: mainScreen.state = "InActive", topBar.state="standard", mainMenu.rotation = 0

        }


    }

    Image {
        id:saveState
        width:  parent.height * 0.7
        height: parent.height * 0.7
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        source:switch(currentcard_saved) {
               case 0: "./img/overlay-dark.png";break;
               case 1: "./img/overlay-dark.png";break;
               case 2: "./img/overlay-dark.png";break;
               default: "./img/overlay-dark.png";break;
               }

        //z: -8

        Flasher {
            id:sav1flick

        }

        MouseArea {
            anchors.fill:parent
            onClicked: switch (currentcard_saved){
                      /* case 0: Scripts.Cards_save(currentcard_thecard,currentcard_username,currentcard_userphone,currentcard_useremail,currentcard_companyname,currentcard_cardposition,currentcard_motto,
                                              currentcard_mainsite,currentcard_url1,currentcard_url2,currentcard_url3,currentcard_url4,currentcard_avatarimg,currentcard_realcardback,currentcard_cardcat,currentcard_cardsop);

                           //currentcard_saved;

                           cardslist.clear();
                           OpenSeed.sync_cards(userid,3);
                           OpenSeed.get_list(userid,"saved");
                           Scripts.Temp_load(searchtext,listget);

                            currentcard_saved = 1;
                           break; */
                       //case 2:settingsPage.state = "Active";mainScreen.state = "InActive";break;
                       case 2:swapopt.state ="Active";break;
                        case 1:swapopt.state ="Active";break;
                        case 0:swapopt.state ="Active";break;

                       }

        onPressed: sav1flick.state = "Active"
        onReleased: sav1flick.state = "InActive"

        }

    }

    Image {
        width:  parent.height  * 0.4
        height:  parent.height * 0.4
        anchors.right:parent.right
        anchors.rightMargin: parent.width * 0.03
        anchors.verticalCenter: parent.verticalCenter

        source:if(currentcard_saved == 2) {"./img/edit.svg"} else {"./img/delete.svg"}
        //z: -8

        Flasher {
            id:delflick


        }

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            onClicked: switch(currentcard_saved ) {

                       case 0: Scripts.Delete_card(currentcard_thecard,listget);OpenSeed.remote_delete(userid,listget,currentcard_thecard);cardslist.clear();Scripts.Temp_load(searchtext,listget);
                           mainScreen.state = "InActive";
                           topBar.state="standard";
                           mainMenu.rotation = 0; break;
                       case 1:
                                Scripts.Delete_card(currentcard_thecard,"saved");OpenSeed.remote_delete(userid,"saved",currentcard_thecard);cardslist.clear();Scripts.Cards_load(searchtext);
                                mainScreen.state = "InActive";
                                topBar.state="standard";
                                mainMenu.rotation = 0; break;

                       case 2: settingsPage.state = "Active";break;

                       default:Scripts.Delete_card(currentcard_thecard,listget);OpenSeed.remote_delete(userid,listget,currentcard_thecard);cardslist.clear();Scripts.Temp_load(searchtext,listget);
                           mainScreen.state = "InActive";
                           topBar.state="standard";
                           mainMenu.rotation = 0; break;
                       }
            onPressed: delflick.state = "Active"
            onReleased: delflick.state = "InActive"

        }

    }


}


}

    DropShadow {
           anchors.fill: topBar
           horizontalOffset: 0
           verticalOffset: 4
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: topBar
           z:1

       }


   /* Rectangle {
    id: listthing
    anchors.bottom: parent.bottom
    height:parent.height * 0.04
    width:parent.width
    color: "white"


    states: [
        State {
            name:"cards"
            PropertyChanges {
                target:divider
                text: "|"
            }
            PropertyChanges {
                target:passby
                text: location_selected
                //color:"black"
            }
            PropertyChanges {
                target:saveded
                text: "Saved"
                //color:"black"
            }
        },
        State {
            name:"settings"
            PropertyChanges {
                target:divider
                text: "|"
            }
            PropertyChanges {
                target:passby
                text: "Card 1"
            }
            PropertyChanges {
                target:saveded
                text: "Card 2"
            }

        }


    ]
    state: "cards"

    Text {
        id:divider
        text: "|"

        anchors.centerIn: parent
        color: "black"

    Text {
        id:passby
        text:location_selected
        anchors.right: parent.left
        anchors.rightMargin: 10
        color: "blue"
        states: [
            State {

                name:"selected"
                PropertyChanges {
                    target:passby
                    color:"purple"

                }

            },
            State {
                name:"unselected"
                PropertyChanges {
                    target:passby
                    color:"black"
                }
            }

        ]
        state: "selected"

        Flasher {
            id:tempflash
        }

        MouseArea {
            anchors.fill:parent
            onClicked: { if(settingsPage.state == "show") {cardindex = 0,passby.state = "selected",saveded.state = "unselected"} else { selection = 0,passby.state = "selected",saveded.state = "unselected",pages = 0,cardslist.clear(),currentcard = -1,Scripts.Temp_load(searchtext,listget)
            }}

            onPressed: tempflash.state = "Active"
            onReleased: tempflash.state = "InActive"
        }
    }
    Text {
        id:saveded
        text:"Saved"
        anchors.left: parent.right
        anchors.leftMargin: 10
        color: "black"
        states: [
            State {
                name:"selected"
                PropertyChanges {
                    target:saveded
                    color:"purple"
                }
                PropertyChanges {
                    target:title
                    text:"Saved ("+cardslist.count+")"
                }
            },
            State {
                name:"unselected"
                PropertyChanges {
                    target:saveded
                    color:"black"
                }
            }

        ]
        state: "unselected"
        Flasher {
            id:savedflash
        }

        MouseArea {
            anchors.fill:parent
            onClicked: { if(settingsPage.state == "show") {cardindex = 1,passby.state = "unselected",saveded.state = "selected"} else {selection = 1,passby.state = "unselected",saveded.state = "selected",pages =1,cardslist.clear(),currentcard = -1,Scripts.Cards_load(searchtext)
            }}
            onPressed: savedflash.state = "Active"
            onReleased: savedflash.state = "InActive"
        }
    }

    }


   } */




   /* Component.onCompleted: {

               console.log("Load card says: " + Scripts.load_Card());
                OpenSeed.retrieve_data(userid);

                console.log(cardloaded)
                if(cardloaded == 1) {
                    firstrun.state = "close"
                } else {
                    firstrun.state = "show"
                }
    } */

  /*  Timer {
        interval:20000; running: true; repeat: true
            onTriggered: {

                 OpenSeed.retrieve_data(userid);

                //Scripts.Temp_load();

                //Scripts.Cards_load();

          }
        } */


      Item {

            //anchors.top:listthing.bottom
            //title: qsTr("Cards")
            property int count: 2
            //anchors.fill:parent
            width:parent.width
            height:parent.height - topBar.height


            states: [
                State {
                    name: "hide"
                    PropertyChanges {
                        target: cardPage
                        x:0
                        y:parent.height

                    }
                },
                State {
                    name: "show"
                    PropertyChanges {
                        target:cardPage
                        x:0
                        anchors.top:topBar.bottom
                    }
                }

            ]
            state:"show"

                id:cardPage

                clip: true

              /*  Image {
                    source: "./img/Suru_Wallpaper_Desktop_4096x2304_Gray.png"
                    width:parent.width
                    height:parent.height

                } */

                  Rectangle {
                         width:parent.width
                         height:parent.height
                         color:backgroundColor

                  }

                Image {
                    source: "./img/overlay-dark.png"
                    anchors.centerIn: parent
                    fillMode:Image.PreserveAspectFit
                    width:parent.width /2
                    height:parent.height /2
                    opacity:0.4
                }



                GridView {
                    id: passerbyGrid

                    //z:-1
                    width: parent.width
                    height: parent.height * 0.95
                    topMargin:10
                    //anchors.verticalCenter: parent.verticalCenter
                    snapMode: GridView.SnapToRow
                    flow: GridView.FlowLeftToRight
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    flickableDirection: Flickable.VerticalFlick
                    visible: true

                    clip:true


                    delegate: Card {}




                    cellHeight: passerbyGrid.width / 2 //passerbyGrid.height
                    cellWidth: passerbyGrid.width

                    model: ListModel {
                            id: cardslist
                            //property int indexofcard: index

                    }

                    add: Transition {
                            NumberAnimation { properties: "y"; from: 0; duration: 200 }
                        }


                    onContentYChanged: if(contentY < -200 && draggingVertically == false) {
                                            cardload.running = true;
                                       }


                }


                Text {
                    id: notification
                    anchors.horizontalCenter: passerbyGrid.horizontalCenter
                    anchors.verticalCenter: passerbyGrid.verticalCenter
                    anchors.verticalCenterOffset: -40
                    horizontalAlignment:Text.AlignHCenter
                    text: qsTr("No Cards found.\n(Try tapping the center top button)")
                    color:"white"
                    font.pointSize: 20
                    Rectangle {
                        anchors.centerIn: parent
                        width:parent.width * 1.1
                        height:parent.height * 1.1
                        z:-1
                        color:Qt.rgba(0.2,0.2,0.2,0.4)
                        radius:5
                    }
                    visible: if(cardload.running == false && passerbyGrid.count == 0) {true} else {false}
                }


                Rectangle {
                    id:bottomBar
                    anchors.bottom:parent.bottom
                    width:parent.width
                    height:parent.height * 0.08
                    color:bottombarColor

                Image {
                    id:privimg
                    anchors.centerIn: parent
                    width:parent.height * 0.7
                    height: parent.height * 0.7
                    fillMode:Image.PreserveAspectFit
                    source:if(stf == "true") {"./img/share.svg"} else {"./img/private-browsing.svg"}

                    Flasher{
                        id:privateb
                       // state: if(stf =="true") {"InActive"} else {"Enabled"}
                    }
                    MouseArea {
                        anchors.centerIn: parent
                        width:parent.width * 1.2
                        height:parent.height * 1.2
                        //onPressed:privateb.state = "Active"
                      //  onReleased:privateb.state = "InActive"

                        preventStealing: true
                        onClicked: { if(stf == "true") {stf = "false"; } else { stf = "true";}
                            Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                                      useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                                      stf,atf,ctf,avimg,carddesign,usercat);
                                                                    OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                                         useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                                         avimg,carddesign,usercat);

                        }


                    }
                }


                }

                DropShadow {
                    anchors.fill:bottomBar
                    horizontalOffset: 0
                    verticalOffset: -4
                    radius: 8.0
                    samples: 17
                    color: "#80000000"
                    source:bottomBar
                    z:1
                }

        }




 MainScreen {
    id:mainScreen
    //anchors.fill:parent
   // x:passerbyGrid.x
     y:cardPage.y

     width:passerbyGrid.width
     // height:passerbyGrid.height
     height: parent.height - topBar.height

    //x:if(layouts.width > units.gu(mobile_vert)) {passerbyGrid.x + passerbyGrid.width} else {passerbyGrid.x} 
    //y:if(layouts.width > units.gu(mobile_vert)) {cardPage.y} else {passerbyGrid.y }
   // width:if(layouts.width > units.gu(mobile_vert)) {parent.width - passerbyGrid.width} else {passerbyGrid.width}
   // height:if(layouts.width > units.gu(mobile_vert)) {passerbyGrid.height} else {appWindow.height} //-10

    //state:if(layouts.width > units.gu(mobile_vert)) {"Active"} else {"InActive"}

    state:"InActive"

    model: ListModel {
            id: pagelist


    }



}

 Setup {
     id:settingsPage

     width:parent.width
     height:parent.height
        y:topBar.height
         state: "InActive"

 }


Wizard {
    id:firstrun
    width: parent.width
    height: parent.height * 0.98
    state: "InActive"
}




  /* ToggleUpDown {
       id:infotab
       x:passerbyGrid.width / 2 - width / 2
       //anchors.bottom:passerbyGrid.bottom
       width:passerbyGrid.width * 0.335
       height:passerbyGrid.height * 0.06
       state:"UnAvailable"

       MouseArea {
           anchors.fill:parent
           onClicked:{if(infotab.state == "Available" || infotab.state == "Active") {
                   mainScreen.state = "Active",infotab.state = "InActive"
               } else {
                   mainScreen.state = "InActive",infotab.state = "UnAvailable",currentcard = -1
               }
           }
       }
   } */


  /*CCreator {
       id:creator
       state:"InActive"
       //anchors.fill:parent
       //y:if(layouts.width > units.gu(mobile_vert)) {cardPage.header.height - settingsPage.y} else {0}
       y:0
       //height:if(layouts.width < units.gu(mobile_vert)) {parent.width} else {settingsPage.height}
       //width:if(layouts.width < units.gu(mobile_vert)) {parent.height} else {settingsPage.width}
       height:parent.width
       width:parent.height

       //onStateChanged: if(creator.state == "Active") {if(layouts.width < units.gu(mobile_vert)) {header.hide()}} else {header.show()}
       //rotation:if(layouts.width < units.gu(mobile_vert)) {90} else {0}
       rotation:90
   } */


CardBack {
    id:backingDialog
    anchors.centerIn:parent
    width:parent.width * 0.8
    height:parent.height * 0.6
}



Menus {
    id:themenu
    //anchors.centerIn: parent
    x:0
    width:parent.width
    y:topBar.height
    height:parent.height - topBar.height
    state:"InActive"
    title:"MainMenu"

}

Menus {
    id:catmenu
    x:0
    width:parent.width
    y:topBar.height
    height:parent.height - topBar.height
    state:"InActive"
    title:"Category"


}

Info {
    id:infoview
    width:parent.width * 0.50
    height:parent.height * 0.90
    anchors.centerIn: parent
    state:"InActive"
}


Info{
    id:grabit
    //width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
    width:parent.width * 0.95
    height:parent.height * 0.40
    state:"InActive"
    title:qsTr("Receive Card")
    type:"receive"
    message:""
}


Info {
    id:swapopt
    //width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
    width:parent.width * 0.95
    height:parent.height * 0.40
    state:"InActive"
    title:qsTr("Share Card")+"("+currentcard_thecard+")"
    type:"send"
    message:onetimecode
    onStateChanged:if(swapopt.state =="Active") {OpenSeed.onetime(currentcard_thecard,"1")}
    MouseArea {
        anchors.fill:parent
        onClicked:swapopt.state = "InActive",OpenSeed.onetime(currentcard_thecard,"0")
    }
}


SlideShow {
    id:slideshow

    width: parent.width
    height: parent.height
    state:"InActive"
    maintitle:"About"



}

MyIOout {
    id:fileio

        Component.onCompleted: {
         fileio.create = "makestuff"

            paths = fileio.create

        }

}




}

