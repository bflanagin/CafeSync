import QtQuick 2.2
import Ubuntu.Components 1.2
import Ubuntu.Components.Pickers 0.1
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Content 1.1
import Ubuntu.Layouts 1.0
import Ubuntu.Web 0.2
import Ubuntu.Components.Popups 1.0
import QtQml 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "slides.js" as Slides

//import QtQuick.Controls 1.1

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    id:appWindow

    anchorToKeyboard: false

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "cafesync.vagueentertainment"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: false

    automaticOrientation: false

    // Removes the old toolbar and enables new features of the new header.
    //useDeprecatedToolbar: false



    property int onsaved: 0

    property string backgrounds:""
    property string symbols:""

    property string text_Locations:""
    property string text_Locations1:""


    property string location_selected: i18n.tr("Passers By")
    property string listget: "temp"


    property int cardindex: 0



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
    //property string cardback: "img/default_card.png"
    property string cardback: "internal:0,0,12"
    property string carddesign: ""
    property string cardtplace:""


    //property string cardbImg: "img/default_card.png"
    property string cardbImg: "internal:0,0,12"

    property string cardsImg: ""
    property int fbgnum: 0
    property int fsymbolnum:0
    property int ftextnum:0


        //card two //

    property string username1: ""
   property string userphone1: ""
    property string useremail1: ""
    property string usercompany1: ""
    property string useralias1: ""
    property string usermotto1: ""
     property string userid1: ""
     property string usercat1: ""

    property string stf1: "false"
    property string atf1: "false"
    property string ctf1: "false"
    property string wtf1: "false"

    property string website11: ""
    property string website21: ""
    property string website31: ""
     property string website41: ""
     property string usermain1: ""


    property string avimg1: "img/default_avatar.png"
    property string cavimg1: "img/default_avatar.png"
    //property string cardback1: "img/default_card.png"
    property string cardback1: "internal:0,0,12"
    property string carddesign1: ""
    property string cardtplace1:""


    //property string cardbImg1: "img/default_card.png"

    property string cardbImg1: "internal:0,0,12"

    property string cardsImg1: ""
    property int fbgnum1: 0
    property int fsymbolnum1:0
    property int ftextnum1:0



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
    property int cardloaded: 0
    property int numofcards: 0
    property int currentcard: -1
    property string currentlist: ""

    property int justpulled: 0

    property int pagenumber: 0


    property list<ContentItem> importItems
    property var activeTransfer

   property int pages: 0

    property int window_height: layouts.height
    property int window_width: layouts.width

    property int mobile_vert: 70
    property int mobile_width: units.gu(100)

    property int menuLocx: 0
    property int menuLocy: 0

    property string currentcat: i18n.tr("All Cards")


    property string category_list: i18n.tr("All Cards,Art,Business,Construction,Education,Engineering,Food,Government,Law,Living,Lifestyle,Music,Non-Profit,Personal,Repair,Science,Software,Technology,Theatre,Writing,Wellness")

    property int bgnum: 2
    property int symbolnum: 14



    width: units.gu(175)
   // width:units.gu(50)
    height: units.gu(100)



    Component {

        id: firstrun
        Dialog {
                     id: dialogue
                     title: i18n.tr("Connect to OpenSeed")
                     text: i18n.tr("CafeSync uses the Openseed network for App and User authentication.")


                     TextField{
                         id:osUsernameField
                         placeholderText: i18n.tr("User Name")
                        horizontalAlignment: parent.horizontalCenter
                         text:osUsername

                     }
                     TextField{
                         id:osEmailField
                         placeholderText: i18n.tr("example@email.com")
                         horizontalAlignment: parent.horizontalCenter
                         text:osEmail

                     }

                    Row {
                        spacing: units.gu(10)
                     Button {
                         text: i18n.tr("Okay")
                         onClicked: { if(osEmailField.length > 2) {

                                        if(osUsernameField.length > 2) {

                                            OpenSeed.oseed_auth(osUsernameField.text,osEmailField.text),slideshow.state = "Active",PopupUtils.close(dialogue)}
                             }
                         }

                     }
                     Button {
                         text: i18n.tr("Cancel")
                         onClicked: PopupUtils.close(dialogue), Qt.quit();
                     }
                    }

                 }

    }



    Component.onCompleted: {
            Theme.name = "Ubuntu.Components.Themes.Ambiance"

    }

    Timer {
            //id:get_list_updater
            interval:10; running:true; repeat: false
            onTriggered: {

                //infoview.state = "Active"
            Scripts.load_Card();
            OpenSeed.retrieve_data(userid);
            OpenSeed.retrieve_data(userid1);
                OpenSeed.datasync(userid,0);
                OpenSeed.datasync(userid1,1);
            OpenSeed.get_list(userid,"temp");
            OpenSeed.get_list(userid,"saved");
            Scripts.Show_sites("local",userid);
            //infoview.state = "InActive"
            }
    }


    Timer {
        id:get_list_updater
        interval:60000; running: true; repeat: true
            onTriggered: {

                        OpenSeed.retrieve_data(userid);
                        OpenSeed.retrieve_data(userid,1);
                   // if(listget == "temp") {

                    //cardslist.clear();
                        OpenSeed.get_list(userid,listget);
                        OpenSeed.get_list(userid,"saved");
                    //}


          }
        }


    Timer {
            id:cardload
            interval:1000; running: true; repeat:false

                onTriggered: {
                            //console.log("loading "+ listget);
                           // console.log("what the server has "+remotetemp);
                       // if (tempcheck != remotetemp) {
                   if(cardPage.head.sections.selectedIndex == 0)
                   { cardslist.clear();Scripts.Temp_load(searchtext,listget);}
                   else { cardslist.clear();Scripts.Cards_load(searchtext); }

                            tempcheck = remotetemp;
                          //console.log("what we have "+tempcheck);

                                //cardload.repeat = false
                        //} else {
                          // console.log("No change Detected");

                        //}

              }
            }




            Page {
                id:cardPage

                clip: true
                title: "CafeSync"
                x:0
                y:0

                head {


                        sections {
                                model: if(settingsPage.state != "show") {[location_selected, i18n.tr("Saved")]} else {[i18n.tr("Card")+"1",i18n.tr("Card")+"2"]}
                                onSelectedIndexChanged: {
                                    //console.log("head changed")
                                   if(settingsPage.state != "show") {
                                    if(cardPage.head.sections.selectedIndex == 0)
                                      { cardslist.clear();
                                        currentcard = -1;
                                        pages = 0;
                                          Scripts.Temp_load(searchtext,listget); }
                                      else { cardslist.clear();
                                            currentcard = -1;
                                            pages = 0;
                                              Scripts.Cards_load(searchtext);
                                            //cardload.running = true;
                                                //OpenSeed.get_list(userid,"saved");
                                    }
                                } else {if(cardPage.head.sections.selectedIndex == 0) {cardindex = 0} else {cardindex = 1} }

                                }
                        }


                                        }

                state: "default"

                states: [
                    State {
                        name:"hide"
                        PropertyChanges{
                            target:cardPage
                            visible:false
                        }
                    },
                    State {
                        name:"show"
                        PropertyChanges {
                            target:cardPage
                            visible:true
                        }
                    },
                    PageHeadState {
                        name: "default"
                        head: cardPage.head


                        contents: Item {
                                    width:parent.width
                                    height:parent.height
                                    //clip:true

                                    Rectangle {
                                        x:-100
                                        y:0
                                        width:parent.width + 100
                                        height:parent.height
                                        color:"white"
                                   }



                            Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    //text: "menu"
                                    source:"/usr/share/icons/suru/actions/scalable/navigation-menu.svg"
                                    width:parent.height /2
                                    height:parent.height /2

                                    Flasher {
                                        id:mmflick
                                    }

                                    MouseArea {
                                        anchors.fill:parent
                                    onClicked: {menuLocx = parent.x;menuLocy = parent.height;if(themenu.state == "InActive") {themenu.state = "Active"} else {themenu.state = "InActive"}}
                                    onPressed: mmflick.state = "Active"
                                    onReleased: mmflick.state = "InActive"
                                    }
                        Text {
                                anchors.left:parent.right
                                anchors.leftMargin:units.gu(1.5)
                                anchors.verticalCenter: parent.verticalCenter
                                text:if(cardPage.head.sections.selectedIndex == 0) {location_selected + " ("+cardslist.count+")"} else {i18n.tr("Saved")+ " ("+cardslist.count+")"}
                                font.pixelSize: (parent.height * 0.90) - location_selected.length / 1.5
                            }
                        }

                            Image {
                                id:findbutton
                                anchors.right:parent.right
                                 anchors.rightMargin:units.gu(1.5)
                                anchors.verticalCenter: parent.verticalCenter
                                source:"/usr/share/icons/suru/actions/scalable/find.svg"
                                width:parent.height /2
                                height:parent.height /2
                                Flasher {
                                    id:finflick

                                }

                                MouseArea {
                                    anchors.fill:parent
                                onClicked: {cardPage.state = "search"}
                                onPressed: finflick.state = "Active"
                                onReleased: finflick.state = "InActive"
                                }
                            }

                            Image {
                                id:location_switch
                                anchors.right:findbutton.left
                                anchors.rightMargin:units.gu(1.5)
                                anchors.verticalCenter: parent.verticalCenter
                                property int loc:0
                                source: {switch(loc) {
                                    case 0:"/usr/share/icons/suru/actions/scalable/location.svg";break;
                                    case 1:"/usr/share/icons/suru/actions/scalable/language-chooser.svg";break;
                                    case 2:"/usr/share/icons/suru/actions/scalable/stock_website.svg";break;
                                    default:"/usr/share/icons/suru/actions/scalable/location.svg";break;
                                    }
                                }
                                width:parent.height /2
                                height:parent.height /2

                                Flasher {
                                    id:locflick
                                }

                                MouseArea {
                                    anchors.fill:parent
                                //onClicked: {menuLocx = parent.x;menuLocy = parent.height;if(themenu.state == "InActive") {themenu.state = "Active"} else {themenu.state = "InActive"}}
                                    onPressed: locflick.state = "Active"
                                    onReleased: locflick.state = "InActive"
                                    onClicked:{switch(location_switch.loc) {
                                              case 0:currentcard = -1;cardPage.head.sections.selectedIndex =0; location_switch.loc = 1;location_selected = i18n.tr("Region");cardload.running = true;cardslist.clear();currentlist = "";listget = "region";OpenSeed.get_list(userid,listget);break;
                                              case 1:currentcard = -1;cardPage.head.sections.selectedIndex =0; location_switch.loc = 2;location_selected = i18n.tr("Global");cardload.running = true;cardslist.clear();currentlist = "";listget = "global";OpenSeed.get_list(userid,listget);break;
                                              case 2:currentcard = -1;cardPage.head.sections.selectedIndex =0; location_switch.loc = 0;location_selected = i18n.tr("Passers By");cardload.running = true;cardslist.clear();currentlist = "";listget = "temp";OpenSeed.get_list(userid,listget);break;

                                              } }

                                }
                            }
                        }
                    },
                    PageHeadState {
                        name: "search"
                        head: cardPage.head

                        contents: Item {
                                    width:parent.width
                                    height:parent.height
                                   // clip:true

                                    Rectangle {
                                        x:-100
                                        y:0
                                        width:parent.width + 100
                                        height:parent.height
                                        color:"white"
                                   }


                            Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    //text: "menu"
                                    source:"/usr/share/icons/suru/actions/scalable/navigation-menu.svg"
                                    width:parent.height /2
                                    height:parent.height /2

                                    Flasher {
                                        id:serflick
                                    }

                                    MouseArea {
                                        anchors.fill:parent
                                    onClicked: {menuLocx = parent.x;menuLocy = parent.height;if(catmenu.state == "InActive") {catmenu.state = "Active";currentcard = -1;mainScreen.state = "InActive";} else {catmenu.state = "InActive";currentcard = -1;mainScreen.state = "InActive";}}
                                    onPressed: serflick.state = "Active"
                                    onReleased: serflick.state = "InActive"
                                    }


                                TextField {
                            id:searchbox
                            width:actionReturn.x - parent.width
                            height:parent.height * 1.2
                            anchors.left:parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            //anchors.fill:parent
                            anchors.margins: units.gu(1)
                            placeholderText: currentcat+i18n.tr("::Search...")
                            text:searchtext
                            onTextChanged: {cardslist.clear();
                                if (cardPage.head.sections.selectedIndex == 0) {
                                  Scripts.Temp_load(searchbox.text,listget);
                                }else {
                                 Scripts.Cards_load(searchbox.text);}
                            }

                        }
                            }
                            Image {
                                id:actionReturn
                                anchors.right:parent.right
                                anchors.rightMargin: units.gu(1.5)
                                anchors.verticalCenter: parent.verticalCenter
                                source:"/usr/share/icons/suru/actions/scalable/back.svg"
                                width:parent.height /2
                                height:parent.height /2



                                MouseArea {
                                    anchors.fill:parent
                                onClicked: {cardPage.state = "default";currentcard = -1;mainScreen.state = "InActive";}

                                }

                            }

                      }

                    },

                    PageHeadState {
                        name: "settings"
                        head: cardPage.head

                        contents: Item {
                                        width:parent.width
                                        height:parent.height
                                        //clip:true

                                        Rectangle {
                                            x:-100
                                            y:0
                                            width:parent.width + 100
                                            height:parent.height
                                            color:"white"
                                       }

                               Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    source:"/usr/share/icons/suru/actions/scalable/navigation-menu.svg"
                                    width:parent.height /2
                                    height:parent.height /2

                                    Flasher {
                                        id:setflick

                                    }
                                    MouseArea {
                                        anchors.fill:parent
                                    onClicked: {menuLocx = parent.x;menuLocy = parent.height;if(themenu.state == "InActive") {themenu.state = "Active"} else {themenu.state = "InActive"} }

                                    onPressed: setflick.state = "Active"
                                    onReleased: setflick.state = "InActive"

                                    }
                        Text {
                                anchors.left:parent.right
                                anchors.leftMargin:units.gu(1.5)
                                anchors.verticalCenter: parent.verticalCenter
                                text:i18n.tr("Settings ")
                                font.pixelSize: parent.height
                            }
                        }

                        Image {
                            id:savebutton
                            anchors.right:parent.right
                            anchors.rightMargin:units.gu(1.5)
                            anchors.verticalCenter: parent.verticalCenter
                            source:"/usr/share/icons/suru/actions/scalable/save.svg"
                            width:parent.height /2
                            height:parent.height /2

                            Flasher {
                                id:savflick

                            }

                            MouseArea {
                                anchors.fill:parent
                            onClicked: {Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                          useralias,usermotto,usermain,website1,website2,website3,website4,
                                                          stf,atf,ctf,avimg,carddesign,usercat,userid1,username1,userphone1,useremail1,usercompany1,
                                                          useralias1,usermotto1,usermain1,website11,website21,website31,website41,
                                                          stf1,atf1,ctf1,avimg1,carddesign1,usercat1,cardindex);
                                        OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                             useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                             avimg,carddesign,usercat);

                                        OpenSeed.upload_data(userid1,username1,userphone1,useremail1,usercompany1,
                                                     useralias1,usermotto1,stf1,atf1,ctf1,usermain1,website11,website21,website31,website41,
                                                     avimg1,carddesign1,usercat1);

                                        saveinfo.state = "Active"
                                        autoclose.running = "true"
                                        }
                            onPressed: savflick.state = "Active"
                            onReleased: savflick.state = "InActive"

                            }
                        }

                        Image {
                            id:updatebutton
                            anchors.right:savebutton.left
                            anchors.rightMargin:20

                            anchors.verticalCenter: parent.verticalCenter
                            source:"/usr/share/icons/suru/actions/scalable/reset.svg"
                            width:parent.height /2
                            height:parent.height /2

                            Flasher {
                                id:updateflick

                            }

                            MouseArea {
                                anchors.fill:parent
                            onClicked: {OpenSeed.datasync(userid,0);
                                        OpenSeed.datasync(userid1,1);
                                        Scripts.save_card(userid,username,useremail,userphone,usercompany,
                                                        useralias,usermotto,usermain,website1,website2,website3,website4,
                                                        stf,atf,ctf,avimg,carddesign,usercat,userid1,username1,userphone1,useremail1,usercompany1,
                                                          useralias1,usermotto1,usermain1,website11,website21,website31,website41,
                                                          stf1,atf1,ctf1,avimg1,carddesign1,usercat1,cardindex);
                                        }
                            onPressed: updateflick.state = "Active"
                            onReleased: updateflick.state = "InActive"

                            }
                        }


                       /* Image {
                            anchors.right:updatebutton.left
                            anchors.rightMargin:20
                            anchors.verticalCenter: parent.verticalCenter
                            source:"/usr/share/icons/suru/actions/scalable/junk.svg"
                            width:parent.height /2
                            height:parent.height /2

                            Flasher {
                                id:clearflick

                            }

                            MouseArea {
                                anchors.fill:parent
                            onClicked: Scripts.updateDB(),Scripts.load_Card()
                                onPressed: clearflick.state = "Active"
                                onReleased: clearflick.state = "InActive"
                            }
                        } */

                        }
                    }

                    ]


                Layouts {
                     objectName: "layouts"
                    id:layouts

                    width:parent.width
                    height:parent.height

                  layouts: [
                        ConditionalLayout {
                          name: "phone"
                          when: window_width < units.gu(mobile_vert)

                          ItemLayout {
                              item: "pages"
                              visible: false
                          }

                         ItemLayout {
                              item: "bg"
                              y: -20
                              width: parent.width
                              height:parent.height + 20
                              visible:true

                          }

                          ItemLayout {
                              item: "cards"
                              width: parent.width
                              height:parent.height
                              visible:true

                          }


                      }

                  ]

                  Image {
                      //Layouts.item:"bg"
                      anchors.left:passerbyGrid.right
                      anchors.right:parent.right
                      anchors.top:parent.top
                      anchors.bottom:parent.bottom
                      source:"./img/Suru_Wallpaper_Desktop_4096x2304_Gray.png"
                      fillMode:Image.PreserveAspectCrop


                      Image {
                          id:overlay
                          anchors.centerIn: parent
                          width:parent.width * 0.80
                          height:parent.height * 0.80
                          source:"./img/overlay.png"
                          fillMode:Image.PreserveAspectFit
                          //visible: false
                            }




                  }

                GridView {
                    id: passerbyGrid
                    //x: units.gu(12)
                    //y: units.gu(4.5)
                    //anchors.top:pCount.bottom
                    Layouts.item: "cards"
                    z:0
                    width: parent.width * 0.25//- units.gu(.4)
                    height: parent.height //- units.gu(4.8)
                    snapMode: GridView.SnapToRow
                    flow: GridView.FlowLeftToRight
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    flickableDirection: Flickable.VerticalFlick
                    visible: true
                    //cellHeight: units.gu(26)
                    clip:true


                    delegate: Card {

                    }



                    cellHeight: passerbyGrid.width / 1.75 //passerbyGrid.height
                    cellWidth: passerbyGrid.width



                    model: ListModel {
                            id: cardslist
                            //property int indexofcard: index

                    }

                    Rectangle {
                       Layouts.item:"bg"
                        y: -20
                        width:passerbyGrid.width
                        height:parent.height + 20
                        color:Qt.rgba(0.1, 0.1, 0.1, .10)
                        border.color:"black"
                        border.width:1
                        z:-1

                        Image {
                            anchors.centerIn: parent
                            width:parent.width * 0.80
                            height:parent.height * 0.80
                            source:"./img/overlay.png"
                            fillMode:Image.PreserveAspectFit
                            visible:if(layouts.currentLayout == "phone") {return true} else {return false}
                        }


                        Text {
                            //Layouts.item: "cards"
                            //width:parent.width
                            anchors.centerIn: parent
                            wrapMode: Text.WordWrap
                            color: if(numofcards == 0) {return "black"} else {return "gray"}
                            text:if(numofcards == 0) {return i18n.tr("No cards yet")} else {return ""}

                            font.pixelSize: parent.width * 0.06
                        }
                    }

                }


                }



                Setup {
                    width:parent.width
                    height:parent.height
                    id:settingsPage
                    clip: true

                }

 }

            MainScreen {
                id:mainScreen
                x:if(window_width > units.gu(mobile_vert)) {passerbyGrid.x + passerbyGrid.width} else {passerbyGrid.x}
                y:if(window_width > units.gu(mobile_vert)) {cardPage.y} else {passerbyGrid.y }
                width:if(window_width > units.gu(mobile_vert)) {parent.width - passerbyGrid.width} else {passerbyGrid.width}
                height:if(window_width > units.gu(mobile_vert)) {passerbyGrid.height} else {appWindow.height} //-10
                state:if(window_width > units.gu(mobile_vert)) {"Active"} else {"InActive"}

                model: ListModel {
                        id: pagelist


                }

            }

            ToggleUpDown {
                id:infotab
                x:passerbyGrid.width / 2 - width / 2
                //anchors.bottom:passerbyGrid.bottom
                //anchors.horizontalCenter: passerbyGrid.horizontalCenter
                width:passerbyGrid.width * 0.335
                height:passerbyGrid.height * 0.06
                state:"UnAvailable"

                MouseArea {
                    anchors.fill:parent
                    onClicked:{if(infotab.state == "Available" || infotab.state == "Active") {
                            mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()
                        } else {
                            mainScreen.state = "InActive",infotab.state = "UnAvailable",cardPage.header.show(),currentcard = -1
                        }
                    }
                }
            }

        Item {

            states: [
                State {
                    name: "unavailable"
                    PropertyChanges {
                        target: fullWeb
                        y:parent.height + units.gu(3)

                    }
                    PropertyChanges {
                        target: fullWebview
                        url:"./empty.html"
                    }
                },
                State {
                    name: "available"
                    PropertyChanges {
                        target: fullWeb
                        y:parent.height
                    }
                    PropertyChanges {
                        target: fullWebview
                        url:"./empty.html"
                    }

                },
                State {
                    name: "show"
                    PropertyChanges {
                        target: fullWeb
                        y:units.gu(.5)

                    }
                    PropertyChanges {
                        target:fullWebtab
                        y:-units.gu(1)


                    }
                    PropertyChanges {
                        target: fullWebview
                        url:showurl.trim()
                    }
                }

            ]
            state:"unavailable"

            id:fullWeb
            width:parent.width
            height:parent.height
            x:0
            y:parent.height


            WebView {
                id:fullWebview
                anchors.fill:parent
                anchors.margins: units.gu(.2)

            }

            DownTab {
                id:fullWebtab
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.16
                height:parent.height * 0.04
                reverse:true

                MouseArea {
                    anchors.fill:parent
                    onClicked:{fullWeb.state = "available";if(window_width > units.gu(mobile_vert)) {cardPage.header.show()};}
                }

            }
        }

        CCreator {
            id:creator
            state:"InActive"
            //anchors.fill:parent
            y:if(window_width > units.gu(mobile_vert)) {cardPage.header.height - settingsPage.y} else {0}
            height:if(window_width < units.gu(mobile_vert)) {parent.width} else {settingsPage.height}
            width:if(window_width < units.gu(mobile_vert)) {parent.height} else {settingsPage.width}

            onStateChanged: if(creator.state == "Active") {if(window_width < units.gu(mobile_vert)) {header.hide()}} else {header.show()}
            rotation:if(window_width < units.gu(mobile_vert)) {90} else {0}
        }


        Menus {
            id:themenu
            anchors.centerIn: parent

            state:"InActive"
            title:i18n.tr("Main Menu")

        }

        Menus {
            id:catmenu
            anchors.centerIn: parent

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
            width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
            height:parent.height * 0.40
            state:"InActive"
            title:i18n.tr("Receive Card")
            type:"receive"
            message:""
        }



        SlideShow {
            id:slideshow

            width: if(window_width > mobile_width) {parent.width * 0.40} else {parent.width * 0.90}
            height: parent.height * 0.80
            state:"InActive"
            maintitle:"About"


        }

        Info {
            id:saveinfo
            width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
            height:parent.height * 0.30
            state:"InActive"
            type:"simple"
            message: "Saved Cards"
            z:1
        }

        Timer {
            id:autoclose
            running:false
            repeat:false
            interval:1000
            onTriggered: saveinfo.state = "InActive"
        }


}
