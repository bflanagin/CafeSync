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
            color:Qt.rgba(1,1,1,1)
        }


    Rectangle {
        id:nameBack
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.02
        //color:"white"
        color:Qt.rgba(1,1,1,1)
        //border.color:"black"
        //radius: units.gu(1)
        //anchors.fill: parent
        width:parent.width
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
                visible: false
            }

            Image {
                id:mask
                anchors.fill:parent
                source:"/graphics/CafeSync.png"
                visible: false

            }

            OpacityMask {
                id:optmask
                 anchors.fill: img
                 source: img
                 maskSource: mask
             }


            Column {
                  id:info
                  width:nameBack.width - (img.width +img.x) - 10
                  anchors.left: img.right
                  clip:true
                Text {
                    text:companyname
                    font.bold: true
                    font.pixelSize: (nameBack.width  - companyname.length * 1.5) * 0.064
                }
                Rectangle {
                    width:parent.width
                    height:3
                    color:"gray"
                }

                Text {
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.04
                    text:qsTr("Name: ")+cardusername
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
                    text:qsTr("Phone: ")+carduserphone
                    anchors.right:parent.right
                }
                Text {
                    id:email
                    x:10
                    font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.03
                    text:qsTr("Email: ")+carduseremail
                    anchors.right:parent.right
                }
            }

        }


    }

/* Rectangle {
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
    text:qsTr("Category: "+cardcat)
}

Text {
    width:statsBack.width /2
    text:qsTr("Tagged On:") + "12/1/2015"
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






}
} */

    Rectangle {
        id:mottoBack
        //x:statsBack.width
        //y:0
        //anchors.right:statsBack.right
        anchors.top:nameBack.bottom
        //anchors.top:statsBack.bottom
        anchors.topMargin:5
       // anchors.rightMargin: 0
        //color:"white"
        color:Qt.rgba(1,1,1,1)
       // border.color:"black"
        //radius: units.gu(1)
        //anchors.fill: parent
        width:parent.width
        height:parent.height * 0.95
        clip:true
          Column {
              spacing:4
        Text {
            anchors.left:parent.left
            anchors.leftMargin:10
            width:parent.width - 10
            wrapMode: Text.WordWrap
            text:qsTr("About:")
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
        //width:if(window_width > mobile_width) {parent.width * 0.50} else {parent.width * 0.95}
        width:parent.width * 0.95
        height:parent.height * 0.40
        state:"InActive"
        title:qsTr("Share Card")
        type:"send"
        message:onetimecode
        onStateChanged:if(swapopt.state =="Active") {OpenSeed.onetime(thecard,"1")}
        MouseArea {
            anchors.fill:parent
            onClicked:swapopt.state = "InActive",OpenSeed.onetime(thecard,"0")
        }
    }


    Rectangle {
        id:bottomBar
        anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height * 0.1
        color:"white"

        Row {
          id:actions
         // anchors.horizontalCenter:parent.horizontalCenter
          visible: if(cardusername == username) {false} else {true}
          spacing:width / 6
          height:parent.height
          x:parent.width * 0.09
          width:parent.width * 0.9
          //x:parent.width / 2 - width /2.3
          clip: true

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
                  onClicked: Qt.openUrlExternally('message:'+carduserphone)
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

              source:"./img/share.svg"
              //z: -8

              Flasher {
                  //id:locflick
              }
              MouseArea {
                  anchors.fill: parent
                  preventStealing: true
                  onClicked: swapopt.state ="Active"
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





