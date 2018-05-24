import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "text.js" as Scrubber
import "requests.js" as Requests
import "messages.js" as Message

Item {
    z:1

    property int menu: 0
    property string carduserName: ""
    property string companyName: ""
    property string backingColor: cardcolor

    //onMenuChanged: console.log(menu,carduserName,companyName)

    Rectangle {
        id:bottomBar
        //anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height
        color:backingColor

        Row {
          id:actions
         // anchors.horizontalCenter:parent.horizontalCenter
          visible: if(carduserName != username && menu == 0) {true} else {false}
          spacing:width / 6
          height:parent.height
          x:parent.width * 0.09
          width:parent.width * 0.9
          //x:parent.width / 2 - width /2.3
          //clip: true


          CircleIndicator {
              width: parent.width / 9
              height: parent.width / 9
              anchors.verticalCenter: parent.verticalCenter
              enabled: if(carduserphone.length >= 7 && carduserphone != "*******") {true} else {false}

              icon :"./icons/outgoing-call.svg"
              fillColor: highLightColor1

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: if(carduserphone.length >= 7 && carduserphone != "*******") {Qt.openUrlExternally('tel:'+carduserphone)}
              }
          }


          CircleIndicator {
              width: parent.width / 9
              height: parent.width / 9
              anchors.verticalCenter: parent.verticalCenter
              icon :"./icons/message.svg"
              fillColor: highLightColor1

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                 // onClicked: Qt.openUrlExternally('sms:'+carduserphone)
                  onClicked: { if(accepted.search(cardId) != -1 && currentcard_saved == 1) {
                                  messagePage.state = "Active";
                               messagePage.roomId = usercardNum+','+cardId;
                               messagePage.showroom = true;
                               messagePage.from = "Card";
                               topBar.state = "messages";
                                } else if(currentcard_saved == 1) {
                                            sendrequest.state = "Active";
                                        } else {
                                            notification1.visible = true;notification1.themessage = "Card must be in your contacts";

                                }

              }

              }
          }

          CircleIndicator {
              width: parent.width / 9
              height: parent.width / 9
              anchors.verticalCenter: parent.verticalCenter
              enabled: if(carduseremail.length >= 5 && carduseremail != "*******") {true} else {false}

              icon :"./icons/email.svg"
              fillColor: highLightColor1

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: if(carduseremail.length >= 5 && carduseremail != "*******") {Qt.openUrlExternally('mailto:'+carduseremail)}
              }
          }

          CircleIndicator {
              width: parent.width / 9
              height: parent.width / 9
              anchors.verticalCenter: parent.verticalCenter
              enabled: if(carduseremail.length >= 5 && carduseremail != "*******") {true} else {false}

              icon :if(currentcard_saved == 0) {"./icons/contact-new.svg"} else {"./icons/contact.svg"}
              fillColor: highLightColor1

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                 // onClicked: swapopt.state ="Active"

                  onClicked: { if(currentcard_saved == 0) {Scripts.cards_Save(currentcard_thecard,currentcard_username,currentcard_userphone,currentcard_useremail,currentcard_companyname,currentcard_cardposition,currentcard_motto,
                                                                currentcard_mainsite,currentcard_url1,currentcard_url2,currentcard_url3,currentcard_url4,currentcard_avatarimg,currentcard_realcardback,currentcard_cardcat,currentcard_cardsop);

                                             //currentcard_saved;

                                             cardslist.clear();
                                             OpenSeed.sync_cards(userid,3);
                                             OpenSeed.get_list(userid,"saved");
                                             Scripts.temp_Load(searchtext,listget);

                                              currentcard_saved = 1;
                                            if(fromRequest == false) {
                                            notification1.visible = true;notification1.themessage = "Saved to Contacts";
                                            } else {
                                                Requests.accept_request(requestID);
                                                notification1.visible = true;notification1.themessage = "Request Accepted, Saved to Contacts";
                                                fromRequest = false;
                                            }
                                    } else {
                                            if(fromRequest == false) {
                                                    sendrequest.state = "Active";
                                                    //notification1.visible = true;notification1.themessage = "Saved to Contacts";
                                                } else {
                                                     Requests.accept_request(requestID);
                                                    notification1.visible = true;notification1.themessage = "Request Accepted";
                                                    fromRequest = false;
                                                }


                                        }
                                        }

              }
          }

    }




        Row {
          id:youractions
          visible: if(menu == 1) {true} else if(carduserName == username && companyName == usercompany) {true} else {false}
          spacing:width / 6
          height:parent.height
          x:parent.width * 0.24
          width:parent.width * 0.9
          onVisibleChanged: if(visible == true) {currentcard_thecard = usercard}
          //clip: true

        /*  CircleIndicator {
              width: parent.width / 9
              height: parent.width / 9
              anchors.verticalCenter: parent.verticalCenter


              icon :"./icons/contact.svg"
              fillColor: highLightColor1

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  //onClicked: Qt.openUrlExternally('qr:')
              }
          } */


          CircleIndicator {
              width: parent.width / 9
              height: parent.width / 9

              anchors.verticalCenter: parent.verticalCenter

              icon: if(stf == "true") {"./icons/share.svg"} else {"./icons/private-browsing.svg"}
              fillColor: highLightColor1


              MouseArea {
                  anchors.fill: parent

                  preventStealing: true
                  onClicked: { if(stf == "true") {stf = "false"; notification1.visible = true; notification1.themessage ="Collection Only"}
                                                                        else { stf = "true";notification1.visible = true; notification1.themessage ="Sharing Card"  }
                      Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                                useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                                stf,atf,ctf,avimg,carddesign,usercat);
                                                              OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                                   useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                                   avimg,carddesign,usercat);


                            }
                    }

              }



          CircleIndicator {
              width: if(cardindex == 0) {if(ctf == "true") {parent.width / 9} else {parent.width / 9} }
              height: if(cardindex == 0) {if(ctf == "true") {parent.width / 9} else {parent.width / 9} }
              anchors.verticalCenter: parent.verticalCenter

              icon:"./icons/contact.svg"
              fillColor: highLightColor1

              Image {
                  //anchors.fill:parent
                  visible: if (ctf == "true") {false} else {true}

                  anchors.centerIn: parent
                  width:parent.width * 0.9
                  height:parent.height * 0.9
                  source:"./icons/cancel.svg"
              }

              MouseArea {
                  anchors.fill: parent

                  preventStealing: true
                  onClicked: {if(cardindex == 0) {if(ctf == "true") {ctf = "false"; notification1.visible = true; notification1.themessage ="Contact info hidden" }
                                                                    else { ctf = "true";notification1.visible = true; notification1.themessage ="Contact info shared" }

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

          CircleIndicator {
              width:  parent.width / 9
              height:  parent.width / 9
              anchors.verticalCenter: parent.verticalCenter
              fillColor:highLightColor1
              icon: if(menu == 1) {"./icons/overlay.svg"} else {"./icons/stats.svg"}


              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: if(menu == 1) {swapopt.where ="mycard";swapopt.type = "send";swapopt.state = "Active";topBar.state="person" } else { achievePage.state = "Active";topBar.state="person"}
                 // onClicked: notification1.visible = true,notification1.themessage = "Coming Soon"
              }

          }

    }

        }

    Row {
      id:blogactions
      visible: if(menu == 2) {true} else {false}
      spacing:width / 6
      height:parent.height
     // x:parent.width * 0.24
      width:parent.width * 0.9
      onVisibleChanged: if(visible == true) {currentcard_thecard = usercard}
      anchors.horizontalCenter: parent.horizontalCenter
      //clip: true

      Item {
          width: /*units.gu(2) */ parent.width / 11
          height: /*units.gu(2) */ parent.width / 11
          anchors.verticalCenter: parent.verticalCenter


          Image {
              id:like_icon
              visible: false
              //anchors.fill: parent
              anchors.centerIn: parent
              width:parent.width * 0.8
              height:parent.height * 0.8
              source: "./icons/check.svg"



          }

          ColorOverlay {
              source:like_icon
              anchors.fill: like_icon
              color:overlayColor
          }


          Flasher {


          }

          MouseArea {
              anchors.fill: parent
              preventStealing: true
             // onClicked: swapopt.state = "Active"
              onClicked: notification1.visible = true,notification1.themessage = "Coming Soon"
          }

      }

      Item {
          width: /*units.gu(2) */ parent.width / 11
          height: /*units.gu(2) */ parent.width / 11
          anchors.verticalCenter: parent.verticalCenter


          Image {
              id:share_icon
              visible: false
              //anchors.fill: parent
              anchors.centerIn: parent
              width:parent.width * 0.8
              height:parent.height * 0.8
              source: "./icons/swap.svg"



          }

          ColorOverlay {
              source:share_icon
              anchors.fill: share_icon
              color:overlayColor
          }


          Flasher {


          }

          MouseArea {
              anchors.fill: parent
              preventStealing: true
             // onClicked: swapopt.state = "Active"
              onClicked: notification1.visible = true,notification1.themessage = "Coming Soon"
          }

      }

      Item {
          width: /*units.gu(2) */ parent.width / 11
          height: /*units.gu(2) */ parent.width / 11
          anchors.verticalCenter: parent.verticalCenter


          Image {
              id:reply_icon
              visible: false
              //anchors.fill: parent
              anchors.centerIn: parent
              width:parent.width * 0.8
              height:parent.height * 0.8
              source: "./icons/message-new.svg"



          }

          ColorOverlay {
              source:reply_icon
              anchors.fill: reply_icon
              color:overlayColor
          }


          Flasher {


          }

          MouseArea {
              anchors.fill: parent
              preventStealing: true
             // onClicked: swapopt.state = "Active"
              onClicked: notification1.visible = true,notification1.themessage = "Coming Soon"
          }

      }

      Item {
          width: /*units.gu(2) */ parent.width / 11
          height: /*units.gu(2) */ parent.width / 11
          anchors.verticalCenter: parent.verticalCenter


          Image {
              id:viewcard_icon
              visible: false
              //anchors.fill: parent
              anchors.centerIn: parent
              width:parent.width * 0.8
              height:parent.height * 0.8
              source: "./img/overlay.svg"



          }

          ColorOverlay {
              source:viewcard_icon
              anchors.fill: viewcard_icon
              color:overlayColor
          }


          Flasher {


          }

          MouseArea {
              anchors.fill: parent
              preventStealing: true
             // onClicked: swapopt.state = "Active"
              onClicked: notification1.visible = true,notification1.themessage = "Coming Soon"
          }

      }


    }




   /* DropShadow {
        anchors.fill:bottomBar
        horizontalOffset: 0
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: "#80000000"
        source:bottomBar
        z:1
    } */



}
