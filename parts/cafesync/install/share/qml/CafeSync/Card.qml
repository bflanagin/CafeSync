import QtQuick 2.2
import Ubuntu.Components 1.2

import QtQml 2.2
import QtGraphicalEffects 1.0

/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed


                        Flipable {
                            id: cards
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: passerbyGrid.width * 0.96
                            height: passerbyGrid.width / 1.8 //units.gu(26)
                            //clip: true
                            x:0
                            y:0
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

                            property bool flipped: false


                            Timer {id:selfdestruct;interval:300; running: true; repeat: true
                                onTriggered: {

                                        if(issaved != 1) {
                                            if(explodereset == 10000) {

                                                if(Scripts.Temp_elapsed(card) == 1) {
                                                     OpenSeed.remote_delete(userid,"temp",card);
                                                    cardslist.remove(index);

                                                    }
                                                explodereset = 0;
                                            } else {explodereset = explodereset + 1;}



                                        }
                                        //Scripts.Temp_load(searchtext);
                                }
                            }

                            back:  Item {
                                x: 0
                                height: parent.height
                                width: parent.width
                                clip: true


                                    Rectangle {

                                        width: parent.width
                                        height: parent.height
                                        color: colorCode
                                        radius: 0
                                        border.color: "black"
                                        border.width: 1
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Item {
                                            anchors.right:parent.right
                                            anchors.rightMargin:units.gu(1)
                                            anchors.top:parent.top
                                            anchors.topMargin:units.gu(1)
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

                                            Icon {
                                                width: /*units.gu(2) */ parent.width / 3.5
                                                height: /*units.gu(2) */ parent.width / 3.5
                                                name: if (saved == 0) {"add"} else {"starred"}
                                                //z: -8
                                                MouseArea {
                                                    anchors.fill: parent
                                                    preventStealing: true
                                                    onClicked: if (saved == 0){Scripts.Cards_save(card,name,phone,email,company,"",motto,mainsite,URL1,URL2,URL3,URL4,imgsource,thedesign,cardcat);
                                                                   cardslist.clear();
                                                                   OpenSeed.sync_cards(userid,3);
                                                                   OpenSeed.get_list(userid,"saved");
                                                                   Scripts.Temp_load(searchtext,listget);}
                                                }

                                            }

                                            Icon {
                                                width: parent.width / 3.5 //units.gu(2)
                                                height: parent.width / 3.5 //units.gu(2)
                                                name: "reload"
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                MouseArea {
                                                    anchors.fill:parent
                                                    onClicked:OpenSeed.update_card(card,listget),console.log("Updating Card")
                                                }

                                                }

                                            Icon {
                                                width: parent.width / 3.5 //units.gu(2)
                                                height: parent.width / 3.5 //units.gu(2)
                                                name: "delete"
                                                anchors.right:parent.right

                                                MouseArea {
                                                    anchors.fill: parent
                                                    preventStealing: true
                                                    onClicked: if (saved == 0){Scripts.Delete_card(card,listget);OpenSeed.remote_delete(userid,listget,card);cardslist.clear();Scripts.Temp_load(searchtext,listget);} else {
                                                                        Scripts.Delete_card(card,"saved");OpenSeed.remote_delete(userid,"saved",card);cardslist.clear();Scripts.Cards_load(searchtext); //OpenSeed.sync_cards(userid,3);
                                                               }
                                                }
                                            }


                                        }

                                        Rectangle {
                                            id:card_avatar_backing
                                            width: parent.width / 3.5 //units.gu(12)
                                            height: parent.width / 3.5 //units.gu(12)
                                            x:5
                                            y:5
                                            color:"white"
                                            border.color: "black"
                                            border.width: 0.5
                                            //radius: 10
                                            clip:true

                                            Image {
                                                id:cardsava
                                                anchors.fill:parent
                                                anchors.margins: units.gu(.2)

                                                source: imgsource
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
                                        anchors.leftMargin: units.gu(1.5)
                                        anchors.top: parent.top
                                        anchors.topMargin: units.gu(.5)
                                        wrapMode:Text.WordWrap

                                    }
                                    Text {
                                        id:comp
                                        anchors.left:card_avatar_backing.right
                                        anchors.leftMargin:units.gu(.3)
                                        anchors.top:nametag.bottom
                                        anchors.topMargin: parent.width / 25 //units.gu(2.4)

                                        font.pixelSize: parent.width / 25 //units.gu(1.8)
                                        text: i18n.tr("Company: ")

                                        Text {
                                            x:parent.width
                                            text: company
                                            anchors.top: parent.top
                                            font.pixelSize: parent.width / 4 //units.gu(1.8)

                                        }
                                    }
                                    Text {
                                        id:pho

                                        anchors.left:card_avatar_backing.right
                                        anchors.leftMargin:units.gu(.3)
                                        anchors.top:comp.bottom
                                        anchors.topMargin:units.gu(.3)

                                        font.pixelSize: parent.width / 25 //units.gu(1.8)
                                        text: if(phone == "Not Available") {i18n.tr("Phone: ")+"*******"} else {i18n.tr("Phone: ")+'<a href="tel:'+phone+'">'+phone+'</a>'}

                                    }
                                    Text {
                                        id:emai
                                        anchors.left:card_avatar_backing.right
                                        anchors.leftMargin:units.gu(.3)
                                        anchors.top:pho.bottom
                                        anchors.topMargin:units.gu(.3)

                                        font.pixelSize: parent.width / 25 //units.gu(1.8)
                                        text:if(email == "Not Available") {i18n.tr("Email: ")+"*******"} else {i18n.tr("Email: ")+'<a href="mailto:'+email+'">'+email+'</a>'}


                                    }

                                    Text {
                                        id:motd
                                        width:parent.width - units.gu(1)
                                        anchors.left:parent.left
                                        anchors.leftMargin: units.gu(.5)
                                        anchors.top:emai.bottom
                                        anchors.topMargin: units.gu(2)
                                        anchors.bottom:badge.top
                                        anchors.bottomMargin: units.gu(1)

                                        font.pixelSize: (parent.width / 23) //units.gu(2)
                                        maximumLineCount: 1
                                        text:if(motto.length > 45) {motto.slice(0,45)+"..."} else {motto}

                                        wrapMode: Text.WordWrap
                                        clip:true
                                    }





                                        Image {
                                            id:badge
                                            source:"./img/no-badge.png"
                                            anchors.right:parent.right
                                            anchors.bottom:parent.bottom
                                            width:parent.width * 0.12
                                            height:parent.width * 0.12
                                        Text {
                                            text: card
                                            font.pixelSize: units.gu(1.2)
                                            anchors.centerIn: parent
                                        //y:70
                                    }
                                        }



                                }

                                    MouseArea {
                                    anchors.centerIn: parent
                                    width:parent.width * 0.80
                                    height:parent.height * 0.80
                                    onPressed:shade.state = "Active",unshade.running = "true"
                                    onReleased:shade.state = "InActive"


                                    onPressAndHold: {if(infotab.state == "Available" || infotab.state == "Active") {
                                            mainScreen.state = "Active",infotab.state = "InActive",cardPage.header.hide()
                                        } else {
                                            mainScreen.state = "InActive",infotab.state = "UnAvailable",cardPage.header.show(),currentcard = -1
                                        }

                                    }

                                     }

                            }

                            front:
                                   Item {
                                        x:0
                                        //width: passerbyGrid.width
                                        //height: passerbyGrid.height
                                        clip: true
                                        anchors.fill:parent



                                Rectangle {

                                color: if (cardback.search("internal:") == -1) {colorCode} else {Qt.rgba(0,0,0,0)}
                                radius: 0
                                border.color: "black"
                                border.width: 1
                                anchors.fill:parent
                                }

                                Image { source: "img/connect.png" ; width:parent.width * 0.99;height:parent.height * 0.99;anchors.centerIn: parent}
                                //Image { id:cardbackImg; source: cardback ; width:parent.width * 0.99;height:parent.height * 0.99;anchors.centerIn: parent}


                                Image {
                                    id:cardbackImg
                                    anchors.fill:parent
                                    //source: if(cardbImg.search("internal:") == -1) {cardbImg} else {Scripts.Card_Set("background",fbgnum);}
                                     source:cardback
                                   //fillMode: Image.PreserveAspectFit
                                    Image {
                                        source:cardsymbol.split(":")[0]
                                        //anchors.fill:parent
                                        x:parent.width * (0.01*cardsymbol.split(":")[1])
                                        height:parent.height * 0.50
                                        width:parent.width * 0.50
                                        fillMode: Image.PreserveAspectFit
                                        anchors.verticalCenter: parent.verticalCenter
                                         }

                                    Item {

                                             anchors.fill:parent
                                                //width:basecard.width
                                                //height:basecard.height
                                                clip:true

                                             Text {
                                                 id:title
                                                 text:if (cardtext.split(":")[0] != 0) {if(company.length >1) {company
                                                          } else { name }
                                                      } else {""}
                                                 font.pixelSize: if(window_width > mobile_width) {parent.height * (0.01*cardtext.split(":")[0]) - text.length / 2.6 } else {parent.height * (0.01*cardtext.split(":")[0]) - text.length / 1.3}
                                                 anchors.horizontalCenter: parent.horizontalCenter
                                                 anchors.verticalCenter: parent.verticalCenter
                                                 anchors.horizontalCenterOffset: parent.width * (0.01*cardtext.split(":")[1])
                                                 anchors.verticalCenterOffset: parent.height * (0.01*cardtext.split(":")[2])

                                                 width:(parent.width * 0.95) - parent.width * (0.01*cardtext.split(":")[1])
                                                 wrapMode:Text.WordWrap

                                                 style: Text.Outline; styleColor: "#FFFFFF"

                                             Text {
                                                 id:subtitle
                                                 text:if (cardtext.split(":")[0] != 0) {if(company.length >1) {name
                                                          } else {""}} else {""}
                                                 font.pixelSize: parent.height * (0.01*30)
                                                 anchors.horizontalCenter: parent.horizontalCenter
                                                 anchors.verticalCenter: parent.verticalCenter
                                                 anchors.horizontalCenterOffset:title.text.length
                                                 anchors.verticalCenterOffset: parent.height * (0.01*70)

                                                 style: Text.Outline; styleColor: "#FFFFFF"
                                             }
                                             }
                                         }

                                }

                            }


                            transform: Rotation {
                                id: rotation
                                origin.x: cards.width/2
                                origin.y: cards.height/2
                                axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                                angle: 0    // the default angle
                            }

                            states: [ State {
                                name: "back"
                                PropertyChanges { target: rotation; angle: 180 }
                                when:  currentcard == index
                            },
                                State {
                                    name:"fade"
                                    PropertyChanges {target: rotation; angle:360}

                                }

                            ]

                            transitions: Transition {
                                NumberAnimation { target: rotation; property: "angle"; duration: 400 }
                            }

                            MouseArea {


                                x:0
                                y:0
                                width:if(cards.side == 1) {units.gu(2) } else {parent.width}
                                height:if(cards.side == 1) {parent.height - units.gu(3) } else {parent.height}
                                onClicked: {

                                    //if (socialLayout1.state == "hidden" || socialLayout2.state == "hidden") {

                                    currentcard = index;
                                    cards.flipped = !cards.flipped;
                                    if(cards.side == 0) {
                                             pagelist.clear();
                                            if(issaved == 1) {
                                             Scripts.Show_sites(card,"saved");
                                            } else {
                                               Scripts.Show_sites(card,listget);
                                            }

                                        if(window_width > units.gu(mobile_vert)) {
                                            mainScreen.state = "Active";
                                        }
                                            mainScreen.positionViewAtBeginning();

                                        if(window_width < units.gu(mobile_vert)) {

                                            infotab.state = "Available";

                                                }


                                        } else { /*pages = 0;*/}
                                        }



                                 }



                            //}

                            Info {
                                id:shade
                                anchors.fill:parent
                                state:"InActive"
                                type:"darken"
                            }
                            Timer {
                                id:unshade
                                interval:1000
                                running:false
                                onTriggered: {
                                    shade.state = "InActive"
                                }
                            }

                        }



