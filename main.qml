import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "text.js" as Scrubber
import "requests.js" as Request
import "messages.js" as Message

Item {
//ApplicationWindow {

    id:mainView


    property int onsaved: 0

    property string backgrounds:""
    property string symbols:""

    property string text_Locations:""

    property string location_selected: "Passers By"
    property string listget: "temp"

    property string onetimecode:"Generating"

    property int cardindex: 0
    property string heart: "OffLine"
    property int updateinterval: 0



    //Theme settings //



 //   property string backgroundColor: "#DFDFD9"
    property string backgroundColor:Qt.rgba(0.98,0.98,0.98,1)

    property string highLightColor1: Qt.rgba(0.99,0.95,0.88,1)
    property string seperatorColor1: "#795548"
    property string barColor: Qt.rgba(0.98,0.98,0.96,1)
    property string bottombarColor: Qt.rgba(0.98,0.98,0.96,1)
    property string activeColor: "#6E4879"
    property string cardcolor: Qt.rgba(0.98,0.98,0.96,1)
    property string overlayColor: "#795548"
    property string fontColorTitle: "black"





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
    property string usercardNum: ""

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

   // property int uniquename: 8
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
    property string tempc: ""
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

    property string category_list: "All Cards::none,Art::yellow,Business::black,Construction::green,Education::red,Engineering::gold,Food::lightblue,
Government::brown,Law::maroon,Living::darkgreen,Lifestyle::pink,Music::darkblue,Non-Profit::merrygold,Personal::none,Repair::darkred,Science::blue,Software::orange,Technology::darkorange,Theatre::none,Writing::none,Wellness::lightpink"

    property int bgnum: 2
    property int symbolnum: 14

    property int selection: 0

    property int ctotal:0
    property int ptotal:0

    property int requests:0
    property int totalNewMessages:0

    property string connected:""
    property string accepted:""




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

   // "Facebook::"+"#3C5A8A"+"::./img/fb.png::facebook::pagename","Linkedin::"+"#6084C4"+"::./img/linkedin.png::linkedin::user-name",
    property var slist : ["Twitter::"+"lightblue"+"::./img/twitter.png::twitter::@username","Tumblr::"+"#343460"+"::./img/tumblr.png::tumblr::username/blogname",
    "Medium::"+cardcolor+"::./img/medium.png::medium::example.com","WordPress::"+"darkgray"+"::./img/wordpress.png::wordpress::example.com",
        "RSS::"+"lightgray"+"::./img/RSS.png::blog::example.com","SoundCloud::"+"orange"+"::./img/soundcloud.png::soundcloud::bandname","Etsy::"+"#F56400"+"::./img/etsy.png::etsy::store"];



    visible: true
    width: 720
    height: 1280
    //width:Screen.desktopAvailableWidth
    //height:Screen.desktopAvailableHeight
    //background: "black"

    //title: "CafeSync"

    property int closeit: 0

   /* onClosing: {
      /*  if(viewpic.state == "Show") {viewpic.state = "Hide"}
        if(settings.visible == true) {
            thefooter.state ="Show"
                    postslist.clear()
                stream_reload.running = true
                get_stream.running = true
            settings.visible = false
        }
        if(viewfinder.state == "Show") {viewfinder.state = "Hide"

        }


    if(closeit == 1) {
        close.accepted = true

    } else { closeit = closeit +1;
        close.accepted = false
        notification1.visible = true; notification1.themessage = "Tap again to exit";notificationFade.start();
    }

    } */

    Timer {
        id:notificationFade
        interval: 2000
        running:false
        onTriggered: {notification1.visible = false; closeit = 0;}
    }


    Timer {
        id:heartbeats
        interval: 8000
        running:false
        repeat:true
        onTriggered:if(firstrun.state == "InActive") {OpenSeed.heartbeat(),Request.check_requests();}
    }

    Timer {
        id:syncandsave
        interval:200
        running:false
        repeat:false
        onTriggered:Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                       useralias,usermotto,usermain,website1,website2,website3,website4,
                                       stf,atf,ctf,avimg,carddesign,usercat,usercardNum);
    }

    Timer {
        id:cardReload
        interval: 1000
        running:false
        repeat: false
        onTriggered: mainScreen.state = "Active"
    }


    Timer {
            id:startup
            interval:10; running:true; repeat: false
            onTriggered: {
            Scripts.load_Card();
                console.log("starting up");
                heartbeats.running = true;
                 notification.visible = true;




            }
    }

    Timer {
        id:connect
        interval: 10;running: false; repeat: false

        onTriggered: {OpenSeed.retrieve_data(userid);
                       OpenSeed.datasync(userid,0);
                        OpenSeed.get_list(userid,"temp");
                        OpenSeed.get_list(userid,"saved");
                     }
    }

    Timer {
        id:gpsupdate
        interval:100000
        running: true
        repeat: true
        onTriggered: {
          // notificationClient.notification = "Updating your location.";
            gpsupdate.interval = offset;
            if(userid != "" && cardloaded == 1) {
        if (positionSource.supportedPositioningMethods ===
                PositionSource.NoPositioningMethods) {
            positionSource.nmeaSource = "nmealog.txt";
            sourceText.text = "(filesource): " + printableMethod(positionSource.supportedPositioningMethods);
        }

        positionSource.update();
    }
        }
    }


    Timer {
        id:get_list_updater
        interval:5000; running: true; repeat: true
            onTriggered: {
                        if(firstrun.state == "InActive" && heart != "OffLine") {
                            //console.log("Updating List");
                        OpenSeed.retrieve_data(userid);
                        OpenSeed.get_list(userid,"temp");
                        OpenSeed.get_list(userid,"region");
                        OpenSeed.get_list(userid,"saved");



                         }
            }
        }


    Timer {
            id:cardload
            interval:800; running: true; repeat:false

                onTriggered: if(firstrun.state == "InActive") {
                          //  console.log("loading "+ listget);
                           // console.log("what the server has "+remotetemp);
                       // if (tempcheck != remotetemp) {


                     cardslist.clear();
                        Scripts.totals();

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
                                    currentcords = lat+","+log;
                                    //console.log(currentcords);
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
        //visible: false



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
                    font.pixelSize: parent.height * 0.4
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
                    font.pixelSize: parent.height * 0.4
                    color:fontColorTitle
                }
            }

            Item {
                id:cmainMenu
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter

                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4


                Image {
                    visible: false
                    id:cback_icon
                    anchors.fill: parent
                    source: "./img/back.svg"



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
                        themenu.state = "InActive",settingsPage.state = "InActive",mainMenu.rotation = 0,topBar.state = "standard"//,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.Show_sites("local",userid);

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
                    font.pixelSize: parent.height * 0.4
                    color:fontColorTitle
                }
            }

            Item {
                id:mmainMenu
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter

                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4


                Image {
                    visible: false
                    id:mback_icon
                    anchors.fill: parent
                    source: "./img/back.svg"



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
                        mainMenu.rotation = 0,
                        topBar.state = "standard"
                        //,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.Show_sites("local",userid);
                            } else if (messagePage.area == "Chat") {
                                messagePage.showroom  = false;
                                messagePage.area == "Conversations"
                                //themenu.state = "InActive",settingsPage.state = "InActive",mainMenu.rotation = 0,topBar.state = "standard"//,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.Show_sites("local",userid);
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

                width:parent.height * 0.4
                height:parent.height * 0.4


                Image {
                    visible: false
                    id:madd_icon
                    anchors.fill: parent
                    source: "./img/add.svg"



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
                    font.pixelSize: parent.height * 0.4
                    color:fontColorTitle
                }
            }

            Item {
                id:rmainMenu
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter

                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4


                Image {
                    visible: false
                    id:rback_icon
                    anchors.fill: parent
                    source: "./img/back.svg"



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
                        themenu.state = "InActive",settingsPage.state = "InActive",mainMenu.rotation = 0,topBar.state = "standard"//,mainScreen.state = "InActive",pagelist.clear(),Scripts.load_Card(),Scripts.Show_sites("local",userid);

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
                    font.pixelSize: parent.height * 0.4
                    color:fontColorTitle
                }
            }


            Item {
                id:emainMenu
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter

                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4


                Image {
                    visible: false
                    id:eback_icon
                    anchors.fill: parent
                    source: "./img/back.svg"



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
                        themenu.state = "InActive",settingsPage.state = "InActive",mainMenu.rotation = 0,topBar.state = "person",/*mainScreen.state = "InActive",*/pagelist.clear(),Scripts.load_Card(),Scripts.Show_sites("local",userid);
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


        anchors.leftMargin: parent.width * 0.03
        width:parent.height * 0.4
        height:parent.height * 0.4

        Image {
            anchors.fill: parent
            source: "./img/menu.svg"

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
                                    mainMenu.rotation = 90;
                       } else {
                           themenu.state = "InActive";
                            mainMenu.rotation = 0;
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

            width:parent.height * 0.4
          height:parent.height * 0.4
          anchors.right:parent.right
          anchors.rightMargin:parent.width * 0.03
          anchors.verticalCenter: parent.verticalCenter

            Image {
            source:"./img/find.svg"
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
                                             case 0:"img/location.svg";break;
                                             case 2:"img/language-chooser.svg";break;
                                          // case 2:"img/stock_website.svg";break;
                                              default:"img/location.svg";break;
                                            }
                                    }else {"img/overlay.svg"}



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

            Item {
                id:mainMenu1
                anchors.left:parent.left
                anchors.verticalCenter: parent.verticalCenter

                anchors.leftMargin: parent.width * 0.03

                width:parent.height * 0.4
                height:parent.height * 0.4


                Image {
                    visible: false
                    id:back_icon1
                    anchors.fill: parent
                    source: "./img/back.svg"



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
                        themenu.state = "InActive",settingsPage.state = "InActive",mainMenu.rotation = 0,topBar.state = "person",/*mainScreen.state = "InActive",*/pagelist.clear(),Scripts.load_Card(),Scripts.Show_sites("local",userid);
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
                width:parent.height * 0.4
                height:parent.height * 0.4



                Image {
                    id:save_icon
                    visible: false
                    anchors.fill: parent
                    source: "./img/save.svg"



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

                width:parent.height * 0.4
                height:parent.height * 0.4

                Image {
                    id:menu_icon2
                    visible: false
                    anchors.fill: parent
                    source: "./img/menu.svg"



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
                    onClicked: if(catmenu.state == "InActive") {catmenu.state = "Active",mainMenu2.rotation = 90} else {catmenu.state = "InActive",mainMenu2.rotation = 0}
                }
            }

            //}
            TextField {
                id:searchtextfield
                anchors.right:back.left
                anchors.rightMargin: parent.width * 0.02
                anchors.left:mainMenu2.right
                anchors.leftMargin: parent.width * 0.02
                anchors.verticalCenter: parent.verticalCenter
               // height:parent.height
                font.pixelSize: parent.width * 0.05
                text:searchtext
                placeholderText: qsTr(currentcat+":Search")

                onTextChanged: {cardslist.clear();
                    if(selection == 0) {Scripts.Temp_load(searchtextfield.text,listget)} else {Scripts.Cards_load(searchtextfield.text,listget) }
            }
            }



            Item {
                id:back
                anchors.right:parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width:parent.height * 0.4
                height:parent.height * 0.4



                Image {
                    id:back_icon2
                    visible: false
                    anchors.fill: parent
                    source: "./img/back.svg"


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


    Item {
        id:back2
        anchors.left:parent.left
        anchors.verticalCenter: parent.verticalCenter


        anchors.leftMargin: parent.width * 0.03
        width:parent.height * 0.4
        height:parent.height * 0.4

        Image {
            id:back_icon3
            visible: false
            anchors.fill: parent
            source: "./img/back.svg"



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
            onClicked: mainScreen.state = "InActive", topBar.state="standard", mainMenu.rotation = 0

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
            source: "./img/overlay.svg"



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

    Item {
        id:editdelete
        width:  parent.height  * 0.4
        height:  parent.height * 0.4
        anchors.right:parent.right
        anchors.rightMargin: parent.width * 0.03
        anchors.verticalCenter: parent.verticalCenter


        Image {
            id:eddel
            visible: false
            anchors.fill: parent
            source:if(currentcard_saved == 2) {"./img/edit.svg"} else {"./img/delete.svg"}


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

               /* Image {
                    source: "./img/overlay.svg"
                    anchors.centerIn: parent
                    fillMode:Image.PreserveAspectFit
                    width:parent.width /2
                    height:parent.height /2
                    opacity:0.1

                } */



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


                    onContentYChanged: if(contentY < (-1 *(parent.height * 0.3)) && draggingVertically == false) {
                                            cardload.running = true;
                                           notification.visible = false; notification.themessage = qsTr("No Cards found\n(Pull to Refresh, or hit the center button to try a larger search area)");

                                       } else if(contentY < (-1 *(parent.height * 0.3)) && draggingVertically == true) {
                                                notification.visible = true; notification.themessage = qsTr("Release to reload");
                                        }

                    onCountChanged: if(passerbyGrid.count == 0) {

                                        notification.visible = true;
                                        if(selection == 0) {
                                        notification.themessage = qsTr("No Cards found\n(Pull to Refresh, or hit the center button to try a larger search area)");
                                        } else {
                                            notification.themessage = qsTr("No Cards found\n(Pull to Refresh, or hit the center button to swap with another user)");
                                        }
                                    } else {
                                        notification.visible = false;
                                    }



                    Notification {
                        id:notification
                        anchors.fill: parent
                      themessage : qsTr("No Cards found\n(Pull to Refresh, or hit the center button to try a larger search area)");
                        visible: if(cardload.running == false && passerbyGrid.count == 0) {true} else {false}
                    }


                }




                Rectangle {
                    id:bottomBar
                    anchors.bottom:parent.bottom
                    width:parent.width
                    height:parent.height * 0.08
                    color:bottombarColor
                   //visible: false

                Item {
                    id:privimg
                    anchors.centerIn: parent
                    width:parent.height * 0.7
                    height: parent.height * 0.7

                    Image {
                        id:priv_icon
                        visible: false
                        anchors.fill: parent
                        source: if(stf == "true") {"./img/share.svg"} else {"./img/private-browsing.svg"}



                    }

                    ColorOverlay {
                        source:priv_icon
                        anchors.fill: priv_icon
                        color:overlayColor
                    }

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
                            Scripts.save_card(userid,Scrubber.replaceSpecials(username),userphone,useremail,usercompany,
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

      Requests {
          id:requestPage
          width:parent.width
          height:parent.height- topBar.height
             y:topBar.height
              state: "InActive"
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
     height:parent.height- topBar.height
        y:topBar.height
         state: "InActive"

 }

 /*Chat {
     id:chatPage
     width:parent.width
     height:parent.height - topBar.height
        y:topBar.height
         state: "InActive"
 } */

 Messages {
     id:messagePage
     width:parent.width
     height:parent.height- topBar.height
        y:topBar.height
         state: "InActive"
 }

 MessageContacts {
     id:messageContactsPage
     width:parent.width
     height:parent.height - topBar.height
     y:topBar.height
     state:"InActive"


 }



 Events {
     id:eventsPage
     width:parent.width
     height:parent.height- topBar.height
        y:topBar.height
         state: "InActive"
 }

Wizard {
    id:firstrun
    width: mainView.width
    height: mainView.height * 0.98
    //state: "InActive"
    state:"InActive"
   // onStateChanged: if(visible) {notificationClient.notification = "User is happy!"}
}




Notification {
    id:notification1
    pos:1
    width:parent.width
    height:parent.height * 0.20
    anchors.bottom: parent.bottom
  themessage : ""
    visible: false
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

SendRequest {
    id:sendrequest
    //y:topBar.height
    anchors.centerIn: parent
    width:parent.width * 0.98
    height:(parent.height - topBar.height) * 0.90
    state: "InActive"
}


SlideShow {
    id:slideshow

    width: parent.width
    height: parent.height
    state:"InActive"
    maintitle:"About"



}

SocialConnect {
    id:sConnect
    y:topBar.height
    width:parent.width
    height:parent.height - topBar.height
    state:"InActive"
}

MyIOout {
    id:fileio

        Component.onCompleted: {
         fileio.create = "makestuff"

            paths = fileio.create

        }

}


ListModel {
            id:requestlog

    }

Image {
    id:mask
    anchors.fill:parent
    source:"/graphics/CafeSync.png"
    visible: false

}


}

