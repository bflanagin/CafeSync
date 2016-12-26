import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3
import Ubuntu.Components 1.2



import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed



Item {
    id:popup
    property string number: "0"
    property string list:""
    property string onetimecode:"Generating"

    clip: true

        anchors.fill:parent

        Image {
            //anchors.fill:parent
            anchors.centerIn: parent
            width:if(window_width <= units.gu(mobile_vert)) {parent.width} else {parent.width}
            height:if(window_width <= units.gu(mobile_vert)) {parent.height} else {parent.height}
            fillMode:Image.PreserveAspectCrop
            source:cardbackimg
            //scale: 3
            //rotation: if(window_width <= units.gu(mobile_vert)) {90} else {0}

           Rectangle {
               anchors.fill:parent
               color:Qt.rgba(0.2,0.2,0.2,.4)
           }
        }

    Rectangle {
        id:nameBack
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.margins:if(window_width > units.gu(mobile_vert)) {5} else {0}
        //color:"white"
        color:Qt.rgba(1,1,1,.9)
        border.color:"black"
        //radius: units.gu(1)
        //anchors.fill: parent
        width:if(window_width > units.gu(mobile_vert)) {parent.width * 0.49} else {parent.width}
        height:info.height + 10
        clip:true

        Row {
            x:5
            y:0
            width:parent.width
            height:parent.height
            Image {
                id:img
                anchors.verticalCenter: parent.verticalCenter
                width:if(avatarimg.length > 5) {nameBack.height * 0.90}
                height:if(avatarimg.length > 5) {nameBack.height * 0.90}
                source:avatarimg
                //anchors.fill:parent
                fillMode:Image.PreserveAspectFit
            }
            Column {
                  id:info
                  width:nameBack.width - (img.width +img.x) -20
                  //height:nameBack.height
                Text {
                    text:companyname
                    font.bold: true
                    font.pixelSize: (nameBack.width  - companyname.length * 1.5) * 0.068
                }
                Rectangle {
                    width:parent.width
                    height:3
                    color:"gray"
                }

                Text {
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.05
                    text:i18n.tr("Name: ")+cardusername
                }

                Item {
                    width:parent.width
                    height: (phone.height + email.height) * 2
                    //height:nameBack.height
                    //color:"gray"
                }
                Text {
                    id:phone
                    //x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.03
                    text:i18n.tr("Phone: ")+carduserphone
                    anchors.right:parent.right
                }
                Text {
                    id:email
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.03
                    text:i18n.tr("Email: ")+carduseremail
                    anchors.right:parent.right
                }
            }

        }


    }

Rectangle {
id:statsBack
anchors.top:nameBack.bottom
anchors.left:nameBack.left
anchors.right:nameBack.right
//anchors.bottom:parent.bottom
anchors.topMargin:10
height:statsContents.height * 1.02
//color:"white"
color:Qt.rgba(1,1,1,.9)
border.color:"black"
border.width:1
clip:true

Column {
  spacing:4
  id:statsContents
Text {
anchors.left:parent.left
anchors.leftMargin:10
width:parent.width - 10
wrapMode: Text.WordWrap
//text:if( cardusername == username) {"Stats:"} else {"Actions:"}
  text:"Actions:"
font.pixelSize: statsBack.width * 0.04
}
Rectangle {
width:statsBack.width
height:2
color:"black"
}
Row {
id:statRow1
width:statsBack.width
x:5
  //visible: if( cardusername == username) {true} else {false}
  visible: false
Text {
    width:statsBack.width /2
    text:i18n.tr("Category: "+cardcat)
}

Text {
    width:statsBack.width /2
    text:i18n.tr("Tagged On:") + "12/1/2015"
}

}
Row {
id:statRow2
width:statsBack.width
x:5
//visible: if( cardusername == username) {true} else {false}
      visible: false
Text {
    width:statsBack.width /2
    text:"Collected: 20"
}

Text {
    width:statsBack.width /2
    text:"Collected by: 5"
}

}

Row {
  height:80
  id:badges
  spacing:3
  visible: if( cardusername == username || cardusername == username1 ) {true} else {false}
}

Row {
  id:actions
  visible: if(cardusername == username || cardusername == username1 ) {false} else {true}
  spacing:width / 20
  //height:80
  width:parent.width
  //x:parent.width / 2 - width /2.3
  clip: true

  Icon {
      width: /*units.gu(2) */ parent.width / 8
      height: /*units.gu(2) */ parent.width / 8
      //name: if (saved == 0) {"add"} else {"starred"}
      name:"outgoing-call"
      //z: -8
      MouseArea {
          anchors.fill: parent
          preventStealing: true
          onClicked: Qt.openUrlExternally('tel:'+carduserphone)
      }

  }
  Icon {
      width: /*units.gu(2) */ parent.width / 9
      height: /*units.gu(2) */ parent.width / 9
      //name: if (saved == 0) {"add"} else {"starred"}
      name:"message"
      //z: -8
      MouseArea {
          anchors.fill: parent
          preventStealing: true
          onClicked: Qt.openUrlExternally('message:'+carduserphone)
      }

  }
  Icon {
      width: /*units.gu(2) */ parent.width / 9
      height: /*units.gu(2) */ parent.width / 9
      //name: if (saved == 0) {"add"} else {"starred"}
      name:"email"
      //z: -8
      MouseArea {
          anchors.fill: parent
          preventStealing: true
          onClicked: Qt.openUrlExternally('mailto:'+carduseremail)
      }

  }

      Icon {
          width: /*units.gu(2) */ parent.width / 9
          height: /*units.gu(2) */ parent.width / 9
          //name: if (saved == 0) {"add"} else {"starred"}
          name:"swap"
          //z: -8
          MouseArea {
              anchors.fill: parent
              preventStealing: true
              onClicked: swapopt.state ="Active"
          }

  }

     Rectangle {
         height:parent.height * 0.90
         anchors.verticalCenter: parent.verticalCenter
         width:parent.width * 0.005
         color:"gray"
     }

      Icon {
          width: /*units.gu(2) */ parent.width / 9
          height: /*units.gu(2) */ parent.width / 9
          name: if (saved == 0) {"add"} else {"starred"}
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
                             Scripts.Temp_load(searchtext,listget);
                                saveinfo.state = "Active";autoclose.running ="true";saveinfo.message = "Saved Card"}
          onPressed: savflick.state = "Active"
          onReleased: savflick.state = "InActive"

          }

  }
      Icon {
          width: /*units.gu(2) */ parent.width / 9
          height: /*units.gu(2) */ parent.width / 9
          //name: if (saved == 0) {"add"} else {"starred"}
          name:"delete"
          //z: -8

          Flasher {
              id:delflick

          }

          MouseArea {
              anchors.fill: parent
              preventStealing: true
              onClicked:  { if (saved == 0){Scripts.Delete_card(thecard,listget);OpenSeed.remote_delete(userid,listget,thecard);cardslist.clear();Scripts.Temp_load(searchtext,listget);} else {
                                  Scripts.Delete_card(thecard,"saved");OpenSeed.remote_delete(userid,"saved",thecard);cardslist.clear();Scripts.Cards_load(searchtext,"saved");}
                                     mainScreen.state = "InActive";
                                     infotab.state = "UnAvailable";
                                     cardPage.header.show(),currentcard = -1;
                            }
              onPressed: delflick.state = "Active"
              onReleased: delflick.state = "InActive"

          }

  }

}

Row {
  id:youractions
  visible: if(cardusername == username || cardusername == username1 ) {true} else {false}
  spacing:width / 18
  //height:80
  width:parent.width
  //x:parent.width / 2 - width /2.3
  clip: true

  Icon {
      width: /*units.gu(2) */ parent.width / 8
      height: /*units.gu(2) */ parent.width / 8
      //name: if (saved == 0) {"add"} else {"starred"}
      visible:false

      name:"account"
      //z: -8
      MouseArea {
          anchors.fill: parent
          preventStealing: true
          //onClicked: Qt.openUrlExternally('qr:')
      }

  }

  Icon {
      width: if(cardindex == 0) {if(stf == "true") {parent.width / 8} else {parent.width / 9} } else { if(stf1 == "true") {parent.width / 8} else {parent.width / 9} }
      height: if(cardindex == 0) {if(stf == "true") {parent.width / 8} else {parent.width / 9} } else { if(stf1 == "true") {parent.width / 8} else {parent.width / 9} }
      //name: if (saved == 0) {"add"} else {"starred"}
      name:"share"
      //z: -8

      Image {
          //anchors.fill:parent
          visible: if (cardindex == 0) { if ( stf == "true") {false} else {true} } else { if ( stf1 == "true") {false} else {true} }

          anchors.centerIn: parent
          width:parent.width * 1.17
          height:parent.height * 1.17
          source:"/usr/share/icons/suru/actions/scalable/cancel.svg"
      }

      MouseArea {
          anchors.fill: parent

          preventStealing: true
          onClicked: { if(cardindex == 0) {if(stf == "true") {stf = "false" } else { stf = "true" } } else {if(stf1 == "true") {stf1 = "false" } else { stf1 = "true" } }
              Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                        useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                        stf,atf,ctf,avimg,carddesign,usercat,userid1,username1,userphone1,useremail1,usercompany1,
                                                                        useralias1,usermotto1,usermain1,website11,website21,website31,website41,
                                                                        stf1,atf1,ctf1,avimg1,carddesign1,usercat1);
                                                      OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                           useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                           avimg,carddesign,usercat);
                                                      OpenSeed.upload_data(userid1,username1,userphone1,useremail1,usercompany1,
                                                                          useralias1,usermotto1,stf1,atf1,ctf1,usermain1,website11,website21,website31,website41,
                                                                          avimg1,carddesign1,usercat1);
          }
      }



  }


  Icon {
      width: /*units.gu(2) */  if(cardindex == 0) {if(atf == "true") {parent.width / 8} else {parent.width / 9} } else {if(atf1 == "true") {parent.width / 8} else {parent.width / 9} }
      height: /*units.gu(2) */  if(cardindex == 0) {if(atf == "true") {parent.width / 8} else {parent.width / 9} } else {if(atf1 == "true") {parent.width / 8} else {parent.width / 9} }
      //name: if (saved == 0) {"add"} else {"starred"}
      name:"private-browsing"
      //z: -8

      Image {
          //anchors.fill:parent
          visible: if (cardindex == 0) { if ( atf == "true") {false} else {true} } else { if ( atf1 == "true") {false} else {true} }

          anchors.centerIn: parent
          width:parent.width * 1.17
          height:parent.height * 1.17
          source:"/usr/share/icons/suru/actions/scalable/cancel.svg"
      }

      MouseArea {
          anchors.fill: parent
          preventStealing: true
          onClicked: { if(cardindex == 0) {if(atf == "true") {atf = "false" } else { atf = "true" } } else { if(atf1 == "true") {atf1 = "false" } else { atf1 = "true" } }
              Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                        useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                        stf,atf,ctf,avimg,carddesign,usercat,userid1,username1,userphone1,useremail1,usercompany1,
                                                                        useralias1,usermotto1,usermain1,website11,website21,website31,website41,
                                                                        stf1,atf1,ctf1,avimg1,carddesign1,usercat1);
                                                      OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                           useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                           avimg,carddesign,usercat);
                                                      OpenSeed.upload_data(userid1,username1,userphone1,useremail1,usercompany1,
                                                                          useralias1,usermotto1,stf1,atf1,ctf1,usermain1,website11,website21,website31,website41,
                                                                          avimg1,carddesign1,usercat1);
          }


      }

  }

  Icon {
      width: if(cardindex == 0) {if(ctf == "true") {parent.width / 8} else {parent.width / 9} } else {if(ctf1 == "true") {parent.width / 8} else {parent.width / 9}}
      height: if(cardindex == 0) {if(ctf == "true") {parent.width / 8} else {parent.width / 9} } else {if(ctf1 == "true") {parent.width / 8} else {parent.width / 9}}

      //name: if (saved == 0) {"add"} else {"starred"}
      name:"contact"
      //z: -8

      Image {
          //anchors.fill:parent
          visible:if(cardindex == 0) { if ( ctf == "true") {false} else {true} } else { if ( ctf1 == "true") {false} else {true} }

          anchors.centerIn: parent
          width:parent.width * 1.17
          height:parent.height * 1.17
          source:"/usr/share/icons/suru/actions/scalable/cancel.svg"
      }

      MouseArea {
          anchors.fill: parent

          preventStealing: true
          onClicked: {if(cardindex == 0) {if(ctf == "true") {ctf = "false" } else { ctf = "true" } } else {if(ctf1 == "true") {ctf1 = "false" } else { ctf1 = "true" } }

              Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                        useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                        stf,atf,ctf,avimg,carddesign,usercat,userid1,username1,userphone1,useremail1,usercompany1,
                                                                        useralias1,usermotto1,usermain1,website11,website21,website31,website41,
                                                                        stf1,atf1,ctf1,avimg1,carddesign1,usercat1);
                                                      OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                           useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                           avimg,carddesign,usercat);
                                                      OpenSeed.upload_data(userid1,username1,userphone1,useremail1,usercompany1,
                                                                          useralias1,usermotto1,stf1,atf1,ctf1,usermain1,website11,website21,website31,website41,
                                                                          avimg1,carddesign1,usercat1);
          }
      }



  }

  Rectangle {
      height:parent.height * 0.90
      anchors.verticalCenter: parent.verticalCenter
      width:parent.width * 0.005
      color:"gray"
  }


  Icon {
      width: /*units.gu(2) */ parent.width / 8
      height: /*units.gu(2) */ parent.width / 8
      //name: if (saved == 0) {"add"} else {"starred"}
      name:"swap"
      //z: -8
      MouseArea {
          anchors.fill: parent
          preventStealing: true
          onClicked: swapopt.state ="Active"
      }

}

}


}
}

    Rectangle {
        id:mottoBack
        x:if(window_width > units.gu(mobile_vert)){0} else {statsBack.width}
        y:0
        anchors.right:if(window_width > units.gu(mobile_vert)) {parent.right} else {statsBack.right}
        anchors.top:if(window_width > units.gu(mobile_vert)) {parent.top} else {statsBack.bottom}
        anchors.topMargin:5
        anchors.rightMargin: if(window_width > units.gu(mobile_vert)) {5} else {0}
        //color:"white"
        color:Qt.rgba(1,1,1,.9)
        border.color:"black"
        //radius: units.gu(1)
        //anchors.fill: parent
        width:if(window_width > units.gu(mobile_vert)) {parent.width * 0.49} else {statsBack.width}
        height:parent.height * 0.95
        clip:true
          Column {
              spacing:4
        Text {
            anchors.left:parent.left
            anchors.leftMargin:10
            width:parent.width - 10
            wrapMode: Text.WordWrap
            text:i18n.tr("About:")
            font.pixelSize: mottoBack.width * 0.04
        }
        Rectangle {
            width:mottoBack.width
            height:2
            color:"gray"
        }


        Text {
            anchors.left:parent.left
            anchors.leftMargin:10
            width:parent.width - 10
            wrapMode: Text.WordWrap
            text:motto
        }
          }


    }

    Info {
        id:swapopt
        width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
        height:parent.height * 0.40
        state:"InActive"
        title:i18n.tr("Share Card")
        type:"send"
        message:onetimecode
        onStateChanged:if(swapopt.state =="Active") {OpenSeed.onetime(thecard,"1")}
        MouseArea {
            anchors.fill:parent
            onClicked:swapopt.state = "InActive",OpenSeed.onetime(thecard,"0")
        }
    }
}





