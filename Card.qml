import QtQuick 2.2
import QtQml 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql

import "main.js" as Scripts
import "openseed.js" as OpenSeed


                        Item {


                                id: cards
                                anchors.horizontalCenter: parent.horizontalCenter

                                width: passerbyGrid.width * 0.96

                               // width: passerbyGrid.width * 0.90
                                height: if(cardsop == 1) {passerbyGrid.width * 0.46} else {passerbyGrid.width * 0.46}


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


                               // flickableDirection:Flickable.HorizontalFlick



                                    Component.onCompleted: if(name == 'undefined') {
                                                               OpenSeed.remote_delete(userid,listget,cardId);
                                                              cardslist.remove(index);
                                                           }



                                    Timer {id:selfdestruct;interval:3000; running: true; repeat: false
                                        onTriggered: {

                                                if(issaved !== 1) {
                                                    if(cardsop != 2) {
                                                        if(explodereset == 10000) {

                                                        if(Scripts.temp_Elapsed(cardId) === 1) {
                                                             OpenSeed.remote_delete(userid,listget,cardId);
                                                            cardslist.remove(index);

                                                            }
                                                        explodereset = 0;
                                                    } else {explodereset = explodereset + 1;}

                                                }

                                                }
                                                //Scripts.Temp_load(searchtext);
                                        }
                                    }


                                    Timer {
                                        id:updatecard
                                        interval: 20000+(index*100)
                                        running: true
                                        repeat: false

                                        onTriggered:OpenSeed.update_card(cardId,listget)//, notificationClient.notification = "Updating Card";


                                    }

                                   /* Timer {
                                        id:updateinfo
                                        interval: 15000
                                        running: true
                                        repeat: true

                                        //onTriggered:OpenSeed.update_card(cardId,listget)


                                    } */



                                Item {
                                    x: 0
                                    height: parent.height
                                    width: parent.width
                                    clip: true



                                        Rectangle {
                                            id:thecard
                                            width: parent.width
                                            height: parent.height * 0.98
                                            color: cardcolor
                                            radius: 2
                                            //border.color: "black"
                                           // border.width: 1
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            visible: false
                                            clip:true

                                            Item {
                                                width: parent.width
                                                height: parent.height * 0.90
                                                clip:true

                                                CirclePic {
                                                id:card_avatar_backing
                                                width: parent.height * 0.9
                                                height: parent.height * 0.9
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.left:parent.left
                                                thesource:imgsource
                                                }



                                        Text {
                                            //x: 5
                                            id:nametag
                                            visible:if(cardsop == 1) {true} else {false}
                                            text: "<div>"+name+"</div>"
                                            //width:thecard.width * 2
                                            //wrapMode: Text.WordWrap
                                            font.pixelSize:mainView.height * 0.034
                                            font.bold: true
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.left:card_avatar_backing.right
                                           anchors.leftMargin: parent.width * 0.008
                                            anchors.top: parent.top
                                            anchors.topMargin: parent.height * 0.07
                                           // wrapMode:Text.WordWrap

                                        }

                                        Rectangle {
                                            visible:if(cardsop == 1) {true} else {false}
                                            anchors.top:nametag.bottom
                                            anchors.topMargin: parent.height * 0.04
                                            anchors.left:card_avatar_backing.right
                                            width:parent.width * 0.57
                                            height:3
                                            color:spColor
                                        }

                                        Text {
                                            //x: 5
                                            id:position
                                            visible:if(cardsop == 1) {true} else {false}
                                            text: qsTr("Job Title: ")+cardposition
                                            font.pixelSize:  parent.width / 24 //units.gu(2.05)
                                            //font.bold: true
                                           // anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.left:card_avatar_backing.right
                                            anchors.leftMargin: parent.width * 0.03
                                            anchors.top: nametag.bottom
                                            anchors.topMargin: parent.height * 0.06
                                            wrapMode:Text.WordWrap
                                            width:parent.width * 0.55
                                        }



                                        Text {
                                            id:comp
                                            visible:if(cardsop == 1) {true} else {false}
                                            width:parent.width - card_avatar_backing
                                            anchors.right:parent.right
                                            anchors.bottom:parent.bottom
                                            anchors.rightMargin:parent.width * 0.02
                                           // anchors.top:nametag.bottom
                                            anchors.bottomMargin: parent.height * 0.02 //units.gu(2.4)
                                            //font.bold: true
                                            font.pixelSize: parent.width * 0.04 //units.gu(1.8)
                                           text: company
                                           wrapMode: Text.WordWrap
                                          /* Image {
                                               anchors.fill: parent
                                               source:compImg
                                               fillMode:Image.PreserveAspectFit
                                           } */
                                             }

                                        }

                                        Rectangle {
                                            anchors.left:parent.left
                                           anchors.bottom:parent.bottom
                                          //  anchors.bottomMargin: parent.height * 0.5
                                            width:parent.width
                                            height:parent.height * 0.1
                                            color:Qt.rgba(0.9,0.9,0.9,0.9)
                                        Text {
                                            anchors.leftMargin: parent.width * 0.03
                                            anchors.verticalCenter: parent.verticalCenter
                                            text:qsTr("Status:")+cardStatus
                                            color:"black"
                                        }

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

                                        /*Image {
                                            visible:if(cardsop == 2) {true} else {false}
                                            source:cardb
                                            anchors.fill:parent
                                            height:parent.height

                                            fillMode:Image.PreserveAspectFit
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

                                       // onClicked: mainScreen.state = "Active"
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
                                    width:if(cards.side === 1) {0} else {parent.width}
                                    height:if(cards.side === 1) {0} else {parent.height}
                                    //width:parent.width
                                    //height:parent.height
                                    //onClicked: {currentcard = index; cards.flipped = !cards.flipped; if(cards.side == 0) {if(layouts.width >= units.gu(mobile_vert)) {Scripts.show_Sites(card);} } else { /*pages = 0;*///}
                                        onClicked: {currentcard = index;
                                            //cards.flipped = !cards.flipped;
                                                    pagelist.clear();
                                                    gc();
                                              //  mainScreen.positionViewAtBeginning();
                                                mainScreen.fromRequest = false;
                                                mainScreen.state = "Active";
                                                topBar.state = "person";
                                                //topBar.saved = issaved;
                                            currentcard_thecard = cardId;
                                            currentcard_saved = issaved;
                                            currentcard_username = name;
                                            currentcard_userphone = phone;
                                            currentcard_useremail = email;
                                            currentcard_cardposition = cardposition;
                                            currentcard_companyname = company;
                                            currentcard_motto = motto;
                                            currentcard_mainsite = mainsite;
                                            currentcard_url1 = w1;
                                            currentcard_url2 = w2;
                                            currentcard_url3 = w3;
                                            currentcard_url4 = w4;
                                            currentcard_avatarimg = imgsource;
                                            currentcard_realcardback = cardback;
                                            currentcard_cardcat = cardcat;
                                            currentcard_cardsop = cardsop;

                                                  //  infotab.state = "Available";
                                           // pagelist.clear();
                                            if(issaved === 1) {
                                             Scripts.show_Sites(cardId,"saved");
                                            } else {
                                               Scripts.show_Sites(cardId,listget);
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



