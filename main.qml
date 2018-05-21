import QtQuick 2.8
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

//Item {
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
    property string heart: "OffLine"
    property int updateinterval: 0


    //Theme settings //



 //   property string backgroundColor: "#DFDFD9"
    property string backgroundColor:Qt.rgba(0.97,0.97,0.97,1)

    property string highLightColor1: Qt.rgba(0.99,0.95,0.88,1)
    property string seperatorColor1: "#795548"
    property string barColor: Qt.rgba(0.98,0.98,0.96,1)
    property string bottombarColor: Qt.rgba(0.98,0.98,0.96,1)
    property string activeColor: Qt.rgba(0.99,0.95,0.88,1)
    property string cardcolor: Qt.rgba(0.98,0.98,0.98,1)
    property string overlayColor: "#795548"
    property string fontColorTitle: "black"
    property string fontColor:"black"



    property string paths:""


    ////// Begin card info ///////

        //card one //
    property int sort: 1

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


    /// Settings ////

    property int cM: 1
    property int fM: 1
    property int mM: 1

    property int sD: 30
    property int sT: 3
    property int kT: 3

    property int theme: 0

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

    property var deletelist: []
    property var deletelistOld: []

    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

   // "Facebook::"+"#3C5A8A"+"::./img/fb.png::facebook::pagename","Linkedin::"+"#6084C4"+"::./img/linkedin.png::linkedin::user-name",
    property var slist : ["Twitter::"+"lightblue"+"::./img/twitter.png::twitter::@username","Tumblr::"+"#343460"+"::./img/tumblr.png::tumblr::username/blogname",
    "Medium::"+cardcolor+"::./img/medium.png::medium::example.com","WordPress::"+"darkgray"+"::./img/wordpress.png::wordpress::example.com",
        "RSS::"+"lightgray"+"::./img/RSS.png::blog::example.com","SoundCloud::"+"orange"+"::./img/soundcloud.png::soundcloud::bandname","Etsy::"+"#F56400"+"::./img/etsy.png::etsy::store",
        "Steemit::"+"lightgray"+"::./img/steemit-vector-logo.png::steemit::@username"];



    visible: false
    width: 720
    height: 1280
    //width:Screen.desktopAvailableWidth
    //height:Screen.desktopAvailableHeight
    //background: backgroundColor
    color: backgroundColor

    title: "CafeSync"

    property int closeit: 0

    onClosing: {
      /*  if(viewpic.state == "Show") {viewpic.state = "Hide"}
        if(settings.visible == true) {
            thefooter.state ="Show"
                    postslist.clear()
                stream_reload.running = true
                get_stream.running = true
            settings.visible = false
        }
        if(viewfinder.state == "Show") {viewfinder.state = "Hide"

        } */

        if(swapopt.state == "Active") {
            swapopt.state = "InActive";
            close.accepted = false;
        }else if(achievePage.state == "Active") {
                    achievePage.state = "InActive";
                    close.accepted = false;
        } else if(settingsPage.state == "Active") {
                        settingsPage.state = "InActive";
                        if(themenu.state != "Active") {
                        topBar.state="person";
                        } else {
                            topBar.state = "standard";
                        }

                        close.accepted = false;
        } else if(notes.state == "Active") {

            if(notes.editing == true) {
                notes.editing = false;
                close.accepted = false;
            } else {
                notes.state = "InActive";
                topBar.state="person";
                topBar.visible= true;
                close.accepted = false;
            }
        }else if(mainScreen.state == "Active") {
            mainScreen.state = "InActive";
            topBar.state="standard";
            close.accepted = false;

        } else if(messageContactsPage.state == "Active") {
            messageContactsPage.state = "InActive";
            topBar.state="chat";
            close.accepted = false;

        } else if(messagePage.state == "Active") {
            if(messagePage.showroom ==true) {
                messagePage.showroom = false;
            } else {
            messagePage.state = "InActive";
            topBar.state="standard";
            }
            close.accepted = false;
        } else if(requestPage.state == "Active") {
            requestPage.state = "InActive";
            topBar.state="standard";
            close.accepted = false;

        } else if(eventContactsPage.state == "Active") {
            eventContactsPage.state = "InActive";
            topBar.state="events";
            close.accepted = false;


        } else if(eventEdit.state == "Active") {
            eventEdit.state = "InActive";
            topBar.state="events";
            close.accepted = false;

        } else if(eventsPage.state == "Active") {
            eventsPage.state = "InActive";
            topBar.state="standard";
            close.accepted = false;


        }  else if(themenu.state == "Active") {
            themenu.state = "InActive";
            close.accepted = false;
         }


        else if(closeit == 1) {
                    close.accepted = true

                } else { closeit = closeit +1;
                            close.accepted = false;
                            notification1.visible = true; notification1.themessage = "Tap again to exit";notificationFade.start();
                    }

    }



    Timer {
        id:notificationFade
        interval: 3000
        running:false
        onTriggered: {notification1.visible = false; closeit = 0;}
    }


    Timer {
        id:heartbeats
        interval: 6000
        running:false
        repeat:true
        onTriggered:if(firstrun.state == "InActive") {OpenSeed.heartbeat();

                        OpenSeed.retrieve_data(userid);}
    }

//Component.onCompleted: (console.log(Application.version));

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

    //onCurrentcard_thecardChanged: console.log("Card changed to "+currentcard_thecard);


    Timer {
            id:startup
            interval:1; running:true; repeat: false
            onTriggered: {
                // mainView.visible = true;
                Scripts.load_Card();
                //console.log("starting up");
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
        interval:3000
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
            gpsupdate.interval = 20000;
        }
    }


    Timer {
        id:get_list_updater
        interval:2400; running: true; repeat: true
            onTriggered: {
                        if(firstrun.state == "InActive" && heart != "OffLine") {
                            //console.log("Updating List");

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

                   if(selection == 0) {
                            Scripts.temp_Load(searchtext,listget,0);
                     } else {
                       Scripts.cards_Load(searchtext,0); }

                            tempcheck = remotetemp;
                          //console.log("what we have "+tempcheck);

                                //cardload.repeat = false
                        //} else {
                          // console.log("No change Detected");

                        //}

              }
            }

    Timer {
            id:listdeleter
            property int checkcount: 0
            interval:1000; running: false; repeat:true
            onTriggered:if(deletelist.length > deletelistOld) {
                            deletelistOld = deletelist;
                        } else {
                            checkcount = checkcount + 1;
                            if(checkcount == 3) {
                                OpenSeed.remote_delete_list(userid,listget,deletelist);
                                listdeleter.stop();
                                deletelistOld = [];
                                deletelist = [];
                                checkcount = 0;
                                cardload.running = true;
                            }
                        }


    }

    onConnectedChanged: Scripts.save_Stat(userid,"Impact",connected.split("><").length);
    onAcceptedChanged: Scripts.save_Stat(userid,"2-Way",accepted.split(",").length - 1);


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

                notification1.delay = 6;notification1.visible = true; notification1.themessage = "Location services are off. Card collection will be limited to Wifi"
               // console.log("Source error: " + sourceError)
                //activityText.fadeOut = true
                stop()
            }


            onUpdateTimeout: {
               }
        }

    TopBar {
        id:topBar
        width:parent.width
        height:parent.width * 0.12
        z:1


    }

    DropShadow {
           anchors.fill: topBar
           horizontalOffset: 0
           verticalOffset: 2
           radius: 5.0
           samples: 17
           color: "#80000000"
           source: topBar
           z:1
           visible: topBar.visible

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
            onClicked: { if(settingsPage.state == "show") {cardindex = 0,passby.state = "selected",saveded.state = "unselected"} else { selection = 0,passby.state = "selected",saveded.state = "unselected",pages = 0,cardslist.clear(),currentcard = -1,Scripts.temp_Load(searchtext,listget)
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
            onClicked: { if(settingsPage.state == "show") {cardindex = 1,passby.state = "unselected",saveded.state = "selected"} else {selection = 1,passby.state = "unselected",saveded.state = "selected",pages =1,cardslist.clear(),currentcard = -1,Scripts.cards_Load(searchtext)
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

                //Scripts.temp_Load();

                //Scripts.cards_Load();

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



                ListView {
                    id: passerbyGrid

                    //z:-1
                    width: parent.width
                    height: parent.height
                    topMargin:10
                    //anchors.verticalCenter: parent.verticalCenter
                   // snapMode: ListView.SnapToRow
                   // flow: GridView.FlowLeftToRight
                    boundsBehavior: Flickable.DragAndOvershootBounds
                   // flickableDirection: Flickable.VerticalFlick
                    visible: true
                    spacing: mainView.width * 0.05

                    clip:true


                    delegate: Item {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: passerbyGrid.width * 0.98
                                height: if(type != 9) {thecard.height} else {spacer.height}
                                Item {
                                    id:spacer
                                    visible: if(type == 9) {true} else {false}
                                    width: parent.width
                                    height: mainView.height * 0.04
                                    Text {
                                        anchors.right: parent.right
                                        anchors.rightMargin: mainView.width * 0.01
                                        horizontalAlignment: Text.AlignRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: ""+date
                                        color:fontColorTitle
                                    }

                                    Rectangle {
                                        color:seperatorColor1
                                        width: parent.width
                                        height: parent.height * 0.1
                                        anchors.bottom: parent.bottom

                                    }
                                }

                        Card {
                               id:thecard
                                visible: if(type != 9) {true} else {false}
                                enabled: if(type != 9) {true} else {false}
                                            }

                    }


                    //cellHeight: passerbyGrid.width / 2 //passerbyGrid.height
                   // cellWidth: passerbyGrid.width

                    model: ListModel {
                            id: cardslist
                            //property int indexofcard: index

                    }

                   /* remove: Transition {
                            NumberAnimation { properties: "x"; from: 0; duration: 400 }
                        } */


                    onContentYChanged: if(contentY < (-1 *(parent.height * 0.3)) && draggingVertically == false) {
                                            cardload.running = true;
                                           notification.visible = false; notification.themessage = qsTr("No Cards found\n(Pull to Refresh, or hit the center button to try a larger search area)");

                                       } else if(contentY < (-1 *(parent.height * 0.3)) && draggingVertically == true) {
                                                notification.visible = true; notification.themessage = qsTr("Release to reload");
                                        }

                    onCountChanged: if(passerbyGrid.count == 1) {

                                        notification.visible = true;
                                        if(selection == 0) {
                                            notification.delay = 9999;
                                        notification.themessage = qsTr("No Cards found\n(Pull to Refresh, or hit the center button to try a larger search area)");
                                        } else {
                                            notification.delay = 9999;
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

                Item {
                    anchors.bottom:parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: mainView.width * 0.03
                    anchors.bottomMargin: mainView.width * 0.03
                    width: mainView.width * 0.07
                    height:mainView.width * 0.07
                    z:2

                    Image {
                        id:sicon
                        visible: false
                        anchors.centerIn: parent
                        width: parent.width * 0.8
                        fillMode: Image.PreserveAspectFit
                        source:switch(sort) {
                                case 2: "./icons/view-sort-alpha-descending.svg";break;
                                case 3: "./icons/view-sort-company-decending.svg";break;
                               default:"./icons/view-sort-descending.svg";break;
                               }


                    }

                    ColorOverlay {
                        source:sicon
                        anchors.fill: sicon
                        color:overlayColor
                    }

                     Flasher {}

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {    switch(sort) {
                                            case 1:  notification1.themessage ="Sort by Name";
                                                        notification1.visible = true;
                                                        cardslist.clear();
                                                        if(selection == 0) {
                                                        Scripts.temp_Load(searchtext,listget,1);
                                                        } else {
                                                           Scripts.cards_Load(searchtext,1);
                                                        }

                                                        sort = 2
                                                     break;
                                            case 2:  notification1.themessage ="Sort by Company";
                                                    notification1.visible = true;
                                                    cardslist.clear();
                                                    if(selection == 0) {
                                                    Scripts.temp_Load(searchtext,listget,2);
                                                    } else {
                                                        Scripts.cards_Load(searchtext,2);
                                                    }

                                                    sort = 3;
                                                         break;
                                            case 3:  notification1.themessage ="Sort by Category";
                                                    notification1.visible = true;
                                                    cardslist.clear();
                                                    if(selection == 0) {
                                                    Scripts.temp_Load(searchtext,listget,3);
                                                    }else {
                                                        Scripts.cards_Load(searchtext,3);
                                                    }

                                                    sort = 0;
                                                         break;
                                            default:
                                                cardslist.clear();
                                                if(selection == 0) {
                                                    notification1.themessage ="Sort by Date";
                                                    notification1.visible = true;
                                                Scripts.temp_Load(searchtext,listget,0);
                                                }else {
                                                    notification1.themessage ="Sort by Name";
                                                    notification1.visible = true;
                                                    Scripts.cards_Load(searchtext,0);
                                                }

                                                sort = 1;
                                             break;

                                            }
                                    }
                    }


                }




                 /* Rectangle {
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
                } */

        }

      Requests {
          id:requestPage
          width:parent.width
          height:parent.height - topBar.height
             y:topBar.height
              state: "InActive"
              //onStateChanged: if(state == "Active") {topBar.visible = false} else {topBar.visible = true}
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
     type:"messages"

 }




 Events {
     id:eventsPage
     width:parent.width
     height:parent.height- topBar.height
    y:topBar.height
         state: "InActive"
 }

 EventEdit {
     id:eventEdit
     width:parent.width
     height:parent.height- topBar.height
      y:topBar.height
     state: "InActive"
 }

 MessageContacts {
     id:eventContactsPage
     width:parent.width
     height:parent.height - topBar.height
     y:topBar.height
     state:"InActive"
     type:"event"

 }

Wizard {
    id:firstrun
    width: mainView.width
    height: mainView.height * 0.98
    //state: "InActive"
    state:"InActive"
   // onStateChanged: if(visible) {notificationClient.notification = "User is happy!"}
    onStateChanged: if(state == "Active") {topBar.visible = false} else {topBar.visible = true}
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
    id:catmenu
    x:0
    width:parent.width
    y:topBar.height
    height:parent.height - topBar.height
    state:"InActive"
    title:"Category"


}

AchievmentsPage {
    id:achievePage
    width: parent.width
    height: parent.height - topBar.height
    anchors.bottom: parent.bottom
    state:"InActive"
}

Share {
    id:infoview
    width:parent.width * 0.95
    height:parent.height * 0.90
    anchors.centerIn: parent
    state:"InActive"
}


Share {
    id:grabit
    //width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
    width:parent.width * 0.95
    height:parent.height * 0.90
    state:"InActive"
    title:qsTr("Receive Card")
    type:"receive"
    message:""
}


Share {
    id:swapopt
    //width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
    width:parent.width
    height:parent.height - topBar.height
    anchors.bottom:parent.bottom
    state:"InActive"
    title:if(where == "mycard") {username.trim();} else {currentcard_username.trim();}
    company:if(where == "mycard") {usercompany.trim();} else {currentcard_companyname.trim();}
    type:"send"
    message:onetimecode
    onStateChanged:if(swapopt.state =="Active") {OpenSeed.onetime(currentcard_thecard,"1")}
  /*  MouseArea {
        anchors.fill:parent
        onClicked:swapopt.state = "InActive",OpenSeed.onetime(currentcard_thecard,"0")
    } */
}

SendRequest {
    id:sendrequest
    //y:topBar.height
   // anchors.centerIn: parent
  //  width:parent.width * 0.98
   // height:(parent.height - topBar.height) * 0.90
    width:parent.width
    height:parent.height
    state: "InActive"
    onStateChanged: if(state == "Active") {topBar.visible = false} else {topBar.visible = true}
}

Notes {
    id:notes
    width:parent.width
    height:parent.height
    state:"InActive"
    onStateChanged: if(state == "Active") {topBar.visible = false} else {topBar.visible = true}
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

News {
    id:newsRelease
    anchors.top:topBar.bottom
    anchors.topMargin: mainView.width * 0.02
    anchors.horizontalCenter: parent.horizontalCenter
    width: mainView.width * 0.95
    height: (mainView.height* 0.98)- topBar.height
    visible:false
}

EULA {
    id: latestEULA
    anchors.top:topBar.bottom
    anchors.topMargin: mainView.width * 0.02
    anchors.horizontalCenter: parent.horizontalCenter
    width: mainView.width * 0.95
    height: (mainView.height* 0.98)- topBar.height
    visible:false
}

EventInfo {
    id:eventInfo
    width:parent.width * 0.98
    height:parent.width * 0.60
    state: "InActive"
}

Notification {
    id:notification1
    pos:1
    width:parent.width
    height:parent.height * 0.20
    anchors.bottom: parent.bottom
  themessage : ""
    visible: false
    //z:5
}


ListModel {
            id:requestlog

    }

/*Image {
    id:mask
    anchors.fill:parent
    source:"/graphics/newicon1.png"
    visible: false

} */

Rectangle {
    id:mask
    radius: width /2
    width: parent.width * 0.94
    height: parent.width * 0.94
    visible: false

}


}

