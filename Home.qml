import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed



Item {
    id:popup
    property string number: "0"
    property string list:""
    property string backgroundColor:Qt.rgba(0.98,0.98,0.98,1)

    clip: true

        anchors.fill:parent

      /*  Image {
            //anchors.fill:parent
            anchors.centerIn: parent
            width:parent.width
            height:parent.height
            fillMode:Image.PreserveAspectCrop
            source:cardbackimg
            //scale: 3
            //rotation: if(layouts.width <= units.gu(mobile_vert)) {90} else {0}


        } */

        Rectangle {
            anchors.fill:parent
            color:backgroundColor
        }




    Rectangle {
        id:nameBack
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.02
        //color:"white"
        color:cardcolor
        //border.color:"black"
        //radius: units.gu(1)
        //anchors.fill: parent
        //anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:info.height + 40
        clip:true

        Row {
            x:5
            y:0
            width:parent.width
            height:parent.height

            Item {
                width:if(avatarimg.length > 5 && cardsop == 1) {nameBack.height * 0.96} else {nameBack.height * 0.01}
                height:if(avatarimg.length > 5 && cardsop == 1) {nameBack.height * 0.96} else {nameBack.height * 0.01}
            Image {
                id:img
               // anchors.verticalCenter: parent.verticalCenter
                anchors.fill: parent
                source:avatarimg
                //anchors.fill:parent
                fillMode:Image.PreserveAspectCrop
                visible: false
            }

            Image {
                id:mask
                anchors.fill:img
                source:"/graphics/CafeSync.png"
                visible: false

            }

            OpacityMask {
                id:optmask
                 anchors.fill: img
                 source: img
                 maskSource: mask
                 visible: if(cardsop == 1) {true} else {false}
             }

             }

            Column {
                  id:info
                  width:nameBack.width - (img.width +img.x) - 10
                  //anchors.left: img.right
                  spacing: 5
                  clip:true
                Text {
                    text:if(cardsop == 1) {cardusername} else {companyname}
                    font.bold: true
                    font.pixelSize: (nameBack.width  - companyname.length * 1.5) * 0.064
                }
                Rectangle {
                    width:parent.width
                    height:3
                    color:highLightColor1
                }

                Text {
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.04
                    text:if(cardsop == 1) {qsTr("Job Title: ")+cardposition} else {qsTr("Category: ")+cardcat}
                    width:parent.width
                    wrapMode: Text.WordWrap

                }
                Text {
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.04
                    text:if(cardsop == 1) {qsTr("Company: ")+companyname} else {""}
                    width:parent.width
                    wrapMode: Text.WordWrap

                }


                Item {
                    width:parent.width
                    height:phone.height
                    //height:nameBack.height
                    //color:"gray"
                }
                Text {
                    id:phone
                    //x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.03
                    text:carduserphone
                    anchors.right:parent.right
                }
                Text {
                    id:email
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.03
                    text:carduseremail
                    anchors.right:parent.right
                }
            }

        }


    }

    DropShadow {
           anchors.fill: nameBack
           horizontalOffset: 0
           verticalOffset: 4
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: nameBack

       }

    Flickable {
        id:infoFlick
        anchors.top:nameBack.bottom
        flickableDirection:Flickable.VerticalFlick
        anchors.topMargin:10
        width:parent.width * 0.98
        height:parent.height - nameBack.height
        contentWidth: parent.width
        contentHeight: parent.height * 1.2
        clip:true

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width:popup.width * 0.98
            height:parent.height * 1.2
            spacing:20

            Item {
                width:parent.width
                height:20
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:aboutcontent.height + aboutcontent.y
                visible: if(motto.length > 2) {true} else {false}

                 Rectangle {
                     id:aboutbox
                     width:parent.width * 0.98
                     height:parent.height * 0.98
                     anchors.centerIn: parent
                     color:cardcolor

                 Column {
                     anchors.top:parent.top
                     width:parent.width
                     height:parent.height *0.98
                     spacing:10

                        Text {

                             anchors.left:parent.left
                             anchors.margins:10
                             width:parent.width - 10
                             wrapMode: Text.WordWrap
                             text:qsTr("About:")
                             font.pixelSize: 24
                        }

                       Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.98
                                height:3
                                color:highLightColor1
                            }

                    Text {
                            id:aboutcontent
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:parent.width - 10
                            wrapMode: Text.WordWrap
                             text:motto
                        }

                    }

                 }

                 DropShadow {
                        anchors.fill: aboutbox
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: aboutbox

                    }
            }

    }



    }




    Info {
        id:swapopt
        //width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
        width:parent.width * 0.95
        height:parent.height * 0.40
        state:"InActive"
        title:qsTr("Share Card")+" ("+cardId+")"
        type:"send"
        message:onetimecode
        onStateChanged:if(swapopt.state =="Active") {OpenSeed.onetime(cardId,"1")}
        MouseArea {
            anchors.fill:parent
            onClicked:swapopt.state = "InActive",OpenSeed.onetime(cardId,"0")
        }
    }


    Rectangle {
        id:bottomBar
        anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height * 0.08
        color:bottombarColor

        Row {
          id:actions
         // anchors.horizontalCenter:parent.horizontalCenter
          visible: if(cardusername == username) {false} else {true}
          spacing:width / 6
          height:parent.height
          x:parent.width * 0.09
          width:parent.width * 0.9
          //x:parent.width / 2 - width /2.3
          //clip: true

          Image {
              width: /*units.gu(2) */ parent.width / 10
              height: /*units.gu(2) */ parent.width / 10
              anchors.verticalCenter: parent.verticalCenter

              //name:"outgoing-call"
              source:"./img/outgoing-call.svg"
              //z: -8


              Flasher {
                  //id:locflick
              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: Qt.openUrlExternally('tel:'+carduserphone)
              }

          }
          Image {
              width: /*units.gu(2) */ parent.width / 10
              height: /*units.gu(2) */ parent.width / 10
              anchors.verticalCenter: parent.verticalCenter
              //name:"message"
              source:"./img/message.svg"
              //z: -8


              Flasher {
                  //id:locflick
              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: Qt.openUrlExternally('sms:'+carduserphone)
              }

          }
          Image {

              width: /*units.gu(2) */ parent.width / 10
              height: /*units.gu(2) */ parent.width / 10
              anchors.verticalCenter: parent.verticalCenter

              source:"./img/email.svg"
              //z: -8

              Flasher {
                  //id:locflick
              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: Qt.openUrlExternally('mailto:'+carduseremail)
              }

          }

          Image {
              width: /*units.gu(2) */ parent.width / 10
              height: /*units.gu(2) */ parent.width / 10
              anchors.verticalCenter: parent.verticalCenter

              source:if(currentcard_saved ==0) {"./img/add.svg"} else {"./img/contact.svg"}
              //z: -8

              Flasher {
                  //id:locflick
              }
              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                 // onClicked: swapopt.state ="Active"

                  onClicked: {Scripts.Cards_save(currentcard_thecard,currentcard_username,currentcard_userphone,currentcard_useremail,currentcard_companyname,currentcard_cardposition,currentcard_motto,
                                                                currentcard_mainsite,currentcard_url1,currentcard_url2,currentcard_url3,currentcard_url4,currentcard_avatarimg,currentcard_realcardback,currentcard_cardcat,currentcard_cardsop);

                                             //currentcard_saved;

                                             cardslist.clear();
                                             OpenSeed.sync_cards(userid,3);
                                             OpenSeed.get_list(userid,"saved");
                                             Scripts.Temp_load(searchtext,listget);

                                              currentcard_saved = 1;
                                        }

              }

          }

       /*   Rectangle {
              height:parent.height * 0.90
              anchors.verticalCenter: parent.verticalCenter
              width:parent.width * 0.005
              color:"gray"
          }

          Image {
              width:  parent.width / 9
              height: parent.width / 9
              //name: if (saved == 0) {"add"} else {"starred"}
              //name:"email"
              source:if (saved == 0) {"./img/add.svg"} else {"./img/starred.svg"}
              //z: -8

              Flasher {
                  id:savflick

              }

              MouseArea {
                  anchors.fill:parent
                  onClicked: if (saved == 0){Scripts.Cards_save(thecard,cardusername,carduserphone,carduseremail,companyname,"",motto,mainsite,URL1,URL2,URL3,URL4,avatarimg,realcardback,cardcat);
                                 cardslist.clear();
                                 OpenSeed.sync_cards(userid,3);
                                 OpenSeed.get_list(userid,"saved");
                                 Scripts.Temp_load(searchtext,listget);}
              onPressed: savflick.state = "Active"
              onReleased: savflick.state = "InActive"

              }

          }

          Image {
              width:  parent.width / 9
              height:  parent.width / 9
              //name: if (saved == 0) {"add"} else {"starred"}
              //name:"email"
              source:"./img/delete.svg"
              //z: -8

              Flasher {
                  id:delflick

              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: if (saved == 0){Scripts.Delete_card(thecard,listget);OpenSeed.remote_delete(userid,listget,thecard);cardslist.clear();Scripts.Temp_load(searchtext,listget);} else {
                                      Scripts.Delete_card(thecard,"saved");OpenSeed.remote_delete(userid,"saved",thecard);cardslist.clear();Scripts.Cards_load(searchtext); //OpenSeed.sync_cards(userid,3);
                             }
                  onPressed: delflick.state = "Active"
                  onReleased: delflick.state = "InActive"

              }

          } */
    }




        Row {
          id:youractions
          visible: if(cardusername == username && companyname == usercompany) {true} else {false}
          spacing:width / 6
          height:parent.height
          x:parent.width * 0.24
          width:parent.width * 0.9
          onVisibleChanged: if(visible == true) {currentcard_thecard = usercard}
          //clip: true

          Image {
              width: /*units.gu(2) */ parent.width / 10
              height: /*units.gu(2) */ parent.width / 10
              //name: if (saved == 0) {"add"} else {"starred"}
              visible:false
              anchors.verticalCenter: parent.verticalCenter

              //name:"account"
              source:"./img/contact.svg"
              //z: -8

              Flasher {


              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  //onClicked: Qt.openUrlExternally('qr:')
              }

          }

          Image {
              width: parent.width / 11
              height: parent.width / 11
              //name: if (saved == 0) {"add"} else {"starred"}
              //name:"share"
              source: if(stf == "true") {"./img/share.svg"} else {"./img/private-browsing.svg"}
              //z: -8
              anchors.verticalCenter: parent.verticalCenter

              Flasher {
                id:privateb
               // state: if(stf =="true") {"InActive"} else {"Enabled"}
              }





              MouseArea {
                  anchors.fill: parent

                  preventStealing: true
                  onClicked: { if(cardindex == 0) {if(stf == "true") {stf = "false";} else { stf = "true";  } }
                      Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                                useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                                stf,atf,ctf,avimg,carddesign,usercat);
                                                              OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                                   useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                                   avimg,carddesign,usercat);

                  }
              }



          }


        /*  Image {
              width:   if(cardindex == 0) {if(atf == "true") {parent.width / 10} else {parent.width / 11} }
              height:  if(cardindex == 0) {if(atf == "true") {parent.width / 10} else {parent.width / 11} }
              //name: if (saved == 0) {"add"} else {"starred"}
              //name:"private-browsing"
              source:"./img/private-browsing.svg"
              //z: -8
              anchors.verticalCenter: parent.verticalCenter

              Image {
                  //anchors.fill:parent
                  visible: if (cardindex == 0) { if ( atf == "true") {false} else {true} }

                  anchors.centerIn: parent
                  width:parent.width * 1.17
                  height:parent.height * 1.17
                  source:"./img/cancel.svg"
              }

              Flasher {


              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: { if(cardindex == 0) {if(atf == "true") {atf = "false" } else { atf = "true" } }
                      Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                                useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                                stf,atf,ctf,avimg,carddesign,usercat);
                                                              OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                                   useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                                   avimg,carddesign,usercat);

                  }


              }

          } */

          Image {
              width: if(cardindex == 0) {if(ctf == "true") {parent.width / 11} else {parent.width / 11} }
              height: if(cardindex == 0) {if(ctf == "true") {parent.width / 11} else {parent.width / 11} }
              anchors.verticalCenter: parent.verticalCenter

              //name: if (saved == 0) {"add"} else {"starred"}
              //name:"contact"
              source:"./img/contact.svg"
              //z: -8

              Image {
                  //anchors.fill:parent
                  visible:if(cardindex == 0) { if ( ctf == "true") {false} else {true} }

                  anchors.centerIn: parent
                  width:parent.width * 1.17
                  height:parent.height * 1.17
                  source:"./img/cancel.svg"
              }

              Flasher {


              }

              MouseArea {
                  anchors.fill: parent

                  preventStealing: true
                  onClicked: {if(cardindex == 0) {if(ctf == "true") {ctf = "false" } else { ctf = "true" }

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

          Image {
              width: /*units.gu(2) */ parent.width / 11
              height: /*units.gu(2) */ parent.width / 11
              anchors.verticalCenter: parent.verticalCenter

              source:"./img/reload.svg"
              //z: -8

              Flasher {


              }

              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                 // onClicked: swapopt.state = "Active"
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





