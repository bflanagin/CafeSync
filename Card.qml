import QtQuick 2.2
//import Ubuntu.Components 1.2
////import Ubuntu.Components.Pickers 0.1
////import Ubuntu.Components.ListItems 1.0 as ListItem
//import Ubuntu.Content 1.1
//import Ubuntu.Layouts 1.0
//import Ubuntu.Web 0.2
//import Ubuntu.Components.Popups 1.0
import QtQml 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed


                        Flickable {


                                id: cards
                                anchors.horizontalCenter: parent.horizontalCenter

                                width: passerbyGrid.width * 0.96

                               // width: passerbyGrid.width * 0.90
                                height: passerbyGrid.width * 0.3


                                 clip: true

                                    //enabled:false
                             //transformOrigin: Item.Center
                             // rotation:90

                            property string w1: URL1
                            property string w2: URL2
                            property string w3: URL3
                            property string w4: URL4
                            property string mainly: mainsite
                            property string issaved: saved

                                    property int explodereset: 0
                                    property int lister: 0

                                flickableDirection:Flickable.HorizontalFlick




                                    Timer {id:selfdestruct;interval:300; running: true; repeat: true
                                        onTriggered: {

                                                if(issaved != 1) {
                                                    if(explodereset == 10000) {

                                                        if(Scripts.Temp_elapsed(card) == 1) {
                                                             OpenSeed.remote_delete(userid,listget,card);
                                                            cardslist.remove(index);

                                                            }
                                                        explodereset = 0;
                                                    } else {explodereset = explodereset + 1;}



                                                }
                                                //Scripts.Temp_load(searchtext);
                                        }
                                    }





                                Item {
                                    x: 0
                                    height: parent.height
                                    width: parent.width
                                    clip: true



                                        Rectangle {
                                            id:thecard
                                            width: parent.width * 0.98
                                            height: parent.height * 0.98
                                            color: colorCode
                                            radius: 2
                                            //border.color: "black"
                                           // border.width: 1
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter

                                            clip:true



                                           /* Item {
                                                anchors.right:parent.right
                                                //anchors.rightMargin:units.gu(1)
                                                anchors.top:parent.top
                                                //anchors.topMargin:units.gu(1)
                                                width: parent.width / 5 // units.gu(8)
                                                height:parent.width / 12 //units.gu(4)

                                                Image {
                                                    //anchors.fill:parent
                                                    anchors.right:parent.right
                                                    anchors.rightMargin:-10
                                                    anchors.top:parent.top
                                                    anchors.topMargin:-10

                                                    width:parent.width + 30
                                                    height:parent.height + 10
                                                    source:"img/card/styles-b/card_opts.png"
                                                }

                                                Image {
                                                    width: parent.width / 3.5
                                                    height:  parent.width / 3.5
                                                    source: if (saved == 0) {"img/add.svg"} else {"img/starred.svg"}
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    //z: -8
                                                    MouseArea {
                                                        anchors.fill: parent
                                                        preventStealing: true
                                                         onClicked: if (saved == 0){Scripts.Cards_save(card,name,email,phone,company,"",motto,mainsite,URL1,URL2,URL3,URL4,imgsource,thedesign,cardcat);
                                                                        cardslist.clear();
                                                                        OpenSeed.sync_cards(userid,3);
                                                                        Scripts.Temp_load(searchtext);}
                                                    }

                                                }

                                                Image {
                                                    width: parent.width / 3.5 //units.gu(2)
                                                    height: parent.width / 3.5 //units.gu(2)
                                                    source: "img/reload.svg"
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    anchors.verticalCenter: parent.verticalCenter

                                                    MouseArea {
                                                        anchors.fill:parent
                                                        preventStealing:true
                                                        onClicked: OpenSeed.update_card(card,listget)
                                                    }
                                                }

                                                Image {
                                                    width: parent.width / 3.5 //units.gu(2)
                                                    height: parent.width / 3.5 //units.gu(2)
                                                    source: "img/delete.svg"
                                                    anchors.right:parent.right
                                                    anchors.verticalCenter: parent.verticalCenter

                                                    MouseArea {
                                                        anchors.fill: parent
                                                        preventStealing: true
                                                        onClicked:  if (saved == 0){Scripts.Delete_card(card,listget);OpenSeed.remote_delete(userid,listget,card);cardslist.clear();Scripts.Temp_load(searchtext,listget);} else {
                                                                            Scripts.Delete_card(card,"saved");OpenSeed.remote_delete(userid,"saved",card);cardslist.clear();Scripts.Cards_load(searchtext,listget); //OpenSeed.sync_cards(userid,3);
                                                                   }

                                                    }
                                                }


                                            } */



                                            Rectangle {
                                                id:card_avatar_backing
                                                width: parent.width / 4
                                                height: parent.width / 4
                                                x:10
                                                anchors.verticalCenter: parent.verticalCenter
                                                color:"white"
                                               // border.color: "white"
                                               // border.width: 0.5
                                               // radius: width / 2

                                                clip:true

                                                Image {
                                                    id:cardsava
                                                    anchors.fill:parent
                                                    anchors.margins: 4
                                                    visible: false
                                                    source: imgsource
                                                }

                                                Image {
                                                    id:mask
                                                    anchors.fill:parent
                                                    source:"/graphics/CafeSync.png"
                                                    visible: false

                                                }

                                                OpacityMask {
                                                     anchors.fill: cardsava
                                                     source: cardsava
                                                     maskSource: mask
                                                 }



                                              }

                                        Text {
                                            //x: 5
                                            id:nametag
                                            text: if(name.length > 2) {name} else {company}
                                            font.pixelSize:  parent.width / 20 //units.gu(2.05)
                                            font.bold: true
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.left:card_avatar_backing.right
                                           anchors.leftMargin: 4
                                            anchors.top: parent.top
                                            anchors.topMargin: 10
                                           // wrapMode:Text.WordWrap

                                        }
                                        Text {
                                            id:comp
                                            width:parent.width - card_avatar_backing
                                            anchors.right:parent.right
                                            anchors.bottom:parent.bottom
                                            anchors.rightMargin:parent.width / 25
                                           // anchors.top:nametag.bottom
                                            anchors.bottomMargin: parent.width / 25 //units.gu(2.4)
                                            //font.bold: true
                                            font.pixelSize: parent.width * 0.05 //units.gu(1.8)
                                           text: company
                                           wrapMode: Text.WordWrap
                                        }


                                       /* Text {
                                            id:indexcardnum
                                            anchors.bottom:parent.bottom
                                            anchors.right:parent.right
                                            anchors.rightMargin:4

                                            font.pixelSize:24
                                            text: "card: "

                                            Text {
                                                text: card
                                                font.pixelSize: 4
                                            x:parent.width
                                            //y:70
                                        }
                                        } */


                                    }

                                        DropShadow {
                                               anchors.fill: thecard
                                               horizontalOffset: 0
                                               verticalOffset: 4
                                               radius: 8.0
                                               samples: 17
                                               color: "#80000000"
                                               source: thecard

                                           }

                                        MouseArea {
                                        anchors.centerIn: parent
                                        width:parent.width * 0.80
                                        height:parent.height * 0.80

                                        onPressed:shade.state == "Active"
                                        onReleased: shade.state == "InActive"

                                        onClicked: mainScreen.state = "Active"
                                        /*onPressAndHold: {if(infotab.state == "Available" || infotab.state == "Active") {
                                                mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()
                                            } else {
                                                mainScreen.state = "InActive",infotab.state = "UnAvailable",cardPage.header.show(),currentcard = -1
                                            }
                                        } */

                                         }



                                }


                                MouseArea {

                                    //anchors.fill:parent
                                    x:0
                                    y:0
                                    width:if(cards.side == 1) {0} else {parent.width}
                                    height:if(cards.side == 1) {0} else {parent.height}
                                    //width:parent.width
                                    //height:parent.height
                                    //onClicked: {currentcard = index; cards.flipped = !cards.flipped; if(cards.side == 0) {if(layouts.width >= units.gu(mobile_vert)) {Scripts.Show_sites(card);} } else { /*pages = 0;*///}
                                        onClicked: {currentcard = index;
                                            //cards.flipped = !cards.flipped;

                                                mainScreen.state = "Active";
                                                topBar.state = "person";
                                                topBar.saved = issaved;
                                            topBar.cardusername = name;
                                            topBar.carduserphone = phone;
                                            topBar.carduseremail = email;
                                            topBar.companyname = company;
                                            topBar.motto = motto;
                                            topBar.mainsite = mainsite;
                                            topBar.url1 = w1;
                                            topBar.url2 = w2;
                                            topBar.url3 = w3;
                                            topBar.url4 = w4;
                                            topBar.avatarimg = imgsource;
                                            topBar.realcardback = cardback;
                                            topBar.cardcat = cardcat;

                                                  //  infotab.state = "Available";
                                            pagelist.clear();
                                            if(issaved == 1) {
                                             Scripts.Show_sites(card,"saved");
                                            } else {
                                               Scripts.Show_sites(card,listget);
                                            }
                                           // mainScreen.state = "Active";
                                            mainScreen.positionViewAtBeginning();
                                        }
                                    //}



                                //}


                            }

                                Info {
                                    id:shade
                                    anchors.fill:parent
                                    state:"InActive"
                                    type:"darken"
                                }
                        }



