import QtQuick 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
import QtWebView 1.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
             //title: qsTr("Settings")
             //page: Page {
 id:settingsPage

 clip: true
// width:parent.width
// height:parent.height
// x:0
// y:0
 //title: qsTr("CafeSync - Settings")

 //Component.onCompleted: Scripts.load_Card();

 states: [
     State {
         name: "show"
         PropertyChanges {
             target:settingsPage
             width:parent.width
             height:parent.height
             x:0
             y:topBar.height

         }
     },
     State {
          name: "hide"
          PropertyChanges {
              target:settingsPage
              width:parent.width
              height:parent.height
              x:0
              y:parent.height

          }
     }



 ]


onStateChanged: if(settingsPage.state == "show") {topBar.state = "settings";listthing.state = "settings";} else {topBar.state = "standard";listthing.state = "cards";}

 state: "hide"


 Rectangle {
     color:"white"
     //y:listthing.height
     width:parent.width
     height:parent.height
     //border.width: 1
 }


 Flickable {
     clip:true
     contentHeight:parent.height * 2.0
    /* anchors {
         top: parent.top
         bottom:parent.bottom
         left:parent.left
         right:parent.right
     } */
     y: 0
     height: parent.height
     width: parent.width * 0.98
     anchors.horizontalCenter: parent.horizontalCenter

     Column {
         id:pageColumn

        /* anchors {
            top: parent.top
            bottom:parent.bottom
            left:parent.left
             right:parent.right
         } */
         width:parent.width
         height:parent.height

         //clip:true
Item {

     height:parent.height
     width:parent.width

     Image {
         id:cardsava
         width:parent.width * 0.35
         height: parent.width * 0.35
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.margins: 4
         visible: false
         source: if(cardindex == 0) {avimg} else {avimg1}

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

Rectangle {
    id:generalarea
    clip:true
    y:cardsava.y + cardsava.height + 10
    anchors.horizontalCenter: parent.horizontalCenter
    width:parent.width * 0.98
    height:parent.height * 0.13
    color:"white"


    Text {
        id:onlineLabel
        text: qsTr("Send Card")
        font.pointSize: 12
        anchors.top:parent.top
        anchors.topMargin: 10
        anchors.right:parent.right
        anchors.rightMargin: width * 0.6
        horizontalAlignment: Text.AlignLeft

        CheckBox {
           id:sendCard

            anchors.left: onlineLabel.right
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            //objectName: "switch_checked"

            checked: if(cardindex == 0) {if(stf == "true"){ return true } else {return false} } else { if(stf1 == "true"){ return true } else {return false} }
            onCheckedChanged: if(cardindex == 0) {stf = sendCard.checked }
        }
    }


  Text {
        id: nameLabel
       //  width:companyLabel.width
        anchors.top:onlineLabel.bottom
        anchors.left:parent.left
        //anchors.left:if(layouts.width > units.gu(mobile_vert)){ cardBacking.right} else {parent.left}
       // anchors.leftMargin: 3
        //anchors.top:if(layouts.width > units.gu(mobile_vert)){cardBacking.top} else {cardBacking.bottom}
       // anchors.topMargin:if(layouts.width > units.gu(mobile_vert)){return 0} else {units.gu(.5)}
       //anchors.top:cardBacking.bottom
        anchors.topMargin: 25
       //anchors.topMargin: 5

         text: qsTr("Name:")
         font.pixelSize:  24

      TextField {
         id: userName
         anchors.left: parent.right

         anchors.leftMargin: 4
         anchors.bottom: parent.bottom
         //anchors.top: parent.top
         text:if(cardindex == 0) {username } else {username1}
         //verticalAlignment: TextInput.AlignTop

         placeholderText: qsTr("User Name")
         font.pixelSize: 24
        // width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         width:(generalarea.width * 0.98) - nameLabel.width
         clip:true
         onTextChanged: if(cardindex == 0) {username = userName.text} else {username1 = userName.text}
     }
 }

  Text {
      id: companyLabel
      anchors.left:parent.left

    //  anchors.leftMargin: units.gu(.3)
      anchors.top:nameLabel.bottom
      anchors.topMargin: 25

      text: qsTr("Company:")
      font.pixelSize: 24

      TextField {
         id: userCompany

         anchors.left: parent.right
         anchors.leftMargin: 4
         anchors.bottom: parent.bottom
         //anchors.top: parent.top
         placeholderText: qsTr("Company Name")
         font.pixelSize: 24
         width:(generalarea.width * 0.98) - companyLabel.width


         //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {usercompany} else {usercompany1}
         onTextChanged: if(cardindex == 0) {usercompany = userCompany.text} else {usercompany1 = userCompany.text}
     }
}


  Text {
      id: aliasLabel


      anchors.left:companyLabel.left
    //  anchors.leftMargin: units.gu(.3)
      //anchors.bottom:avatarBacking.bottom
      anchors.top:companyLabel.bottom
      anchors.topMargin: 25
      //width:companyLabel.width
      text: qsTr("Position:")
      font.pixelSize: 24

      TextField {
         id: userAlias
         anchors.bottomMargin: 0
         anchors.topMargin: 0

         anchors.left: parent.right
         anchors.leftMargin: 4
         anchors.bottom: parent.bottom
         //anchors.top: parent.top
         placeholderText: qsTr("Job Title")
         font.pixelSize: 24
         width:(generalarea.width* 0.98) - aliasLabel.width
         //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {useralias} else {useralias1}
         onTextChanged: if(cardindex == 0) {useralias = userAlias.text} else {useralias1 = userAlias.text}
     }
}

}

DropShadow {

    anchors.fill: generalarea
    horizontalOffset: 0
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: generalarea
    z:1



}

Rectangle {
    id:contactarea
    clip:true
   // y:cardsava.y + cardsava.height + 10
    anchors.top:generalarea.bottom
    anchors.topMargin:20
    width:parent.width * 0.98
    height:parent.height * 0.1
    color:"white"
    anchors.horizontalCenter: parent.horizontalCenter


    Text {
        id:contactLabel
        text: qsTr("Send Contact Info")
        font.pointSize: 12
        //font.bold: true
        horizontalAlignment: Text.AlignLeft
        anchors.top:parent.top
        anchors.topMargin: 10
        anchors.right:parent.right
        anchors.rightMargin: width / 3

        CheckBox {
           id:sendContact

            anchors.left: contactLabel.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            objectName: "switch_checked"

            checked: if(cardindex == 0) { if(ctf == "true"){ return true } else { return false} } else { if(ctf1 == "true"){ return true } else { return false} }
            onCheckedChanged: if(cardindex == 0) {ctf = sendContact.checked } else {ctf1 = sendContact.checked}
        }
    }



  Text {
      id: phoneLabel


      anchors.left:parent.left
     // anchors.leftMargin: units.gu(.3)
      anchors.top:contactLabel.bottom
      anchors.topMargin: 25
      text: qsTr("Phone:")
      font.pixelSize: 24

      TextField {
         id: userPhone

         anchors.left: parent.right
         anchors.leftMargin: 4
         anchors.bottom: parent.bottom
         //anchors.top: parent.top
         placeholderText: qsTr("0 555-555-5555")
         font.pixelSize: 24
         width:(contactarea.width * 0.98) - phoneLabel.width
        // width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         inputMethodHints: Qt.ImhDialableCharactersOnly
         text:if(cardindex == 0) {userphone} else {userphone1}
          onTextChanged: if(cardindex == 0) {userphone = userPhone.text} else {userphone1 = userPhone.text}
     }
  }

  Text {
      id: emailLabel


      anchors.left:phoneLabel.left
     // anchors.leftMargin: units.gu(.3)
      anchors.top:phoneLabel.bottom
      anchors.topMargin: 25
      //width:phoneLabel.width

      text: qsTr("Email:")
      font.pixelSize: 24
      TextField {
         id: userEmail

         anchors.left: parent.right
         anchors.leftMargin: 4
         anchors.bottom: parent.bottom
         //anchors.top: parent.top
         placeholderText: qsTr("johndoe@example.com")
         font.pixelSize: 24
         width:(contactarea.width * 0.98) -emailLabel.width

       //  width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {useremail} else {useremail1}
         onTextChanged: if(cardindex == 0) {useremail = userEmail.text} else {useremail1 = userEmail.text}
     }

  }


}

DropShadow {

    anchors.fill: contactarea
    horizontalOffset: 0
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: contactarea
    z:1



}




Text {
 id: profileSettingLabel
 //x: units.gu(1)
// y: 208
 anchors.left:parent.left
 anchors.leftMargin: 2
 anchors.top:contactarea.bottom//avatarBacking.bottom
 anchors.topMargin: 10
 text: qsTr("Info")
 style: Text.Normal
 font.pixelSize: 24
}

Rectangle {
 id: rectangle1


 anchors.left:parent.left
 anchors.leftMargin:1
 anchors.top:profileSettingLabel.bottom
 anchors.topMargin:1

 //height: pageColumn.height / 4
 height: plinklist.y + plinklist.height + 40
 anchors.right:parent.right
 anchors.rightMargin:1



 clip:true
 color: "#ffffff"
 //radius: 6
 //z: -1
// border.width: 1


      Column {

          anchors.top:parent.top
          anchors.topMargin:10
          anchors.left:parent.left
          anchors.leftMargin: 10
          anchors.bottom: parent.bottom
          anchors.bottomMargin: 10
          anchors.right:parent.right
          anchors.rightMargin:10

          //clip: true
          spacing: parent.width * 0.1


          Text {
              font.pixelSize: 24
              text:"Category: "

             Rectangle {
                 width:if(cardindex == 0) {10*usercat.length + catText.width} else {10*usercat1.length + catText.width}
                 height:parent.height * 1.1
                 anchors.left:parent.right
                 anchors.verticalCenter: parent.verticalCenter
                 //border.color:"black"
                // radius: 3
                 clip:true
              Text {
                     id:catText
                  //anchors.left:parent.right
                     anchors.centerIn: parent
                  font.pixelSize:24
                 // anchors.verticalCenter: parent.verticalCenter
                  text:if(cardindex == 0) { if(usercat.length < 2) {qsTr("Select Category")} else {usercat}} else {if(usercat1.length < 2) {qsTr("Select Category")} else {usercat1}}
                 }
                  MouseArea {
                      anchors.fill:parent
                      onClicked: catmenu.state = "Active"
                  }
              }
          }

          Rectangle {
              //anchors.top:row0.bottom
              width:parent.width
              height:3
              color:"gray"


          }


          Text {
           id:mainadvert
           text: qsTr("URL:")
           font.pixelSize: 18
           TextField {
              id: userMain
              //anchors.bottomMargin: 0
              //anchors.topMargin: 0
              anchors.verticalCenter: parent.verticalCenter

              anchors.left: parent.right
              anchors.leftMargin: parent.width * 0.04
             // anchors.bottom: parent.bottom
             // anchors.top: parent.top
              placeholderText: qsTr("Main Site for Advertising")
              //font.pixelSize: units.gu(2.4)
              //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
              width:(rectangle1.width - parent.width) * 0.90
              text:if(cardindex == 0) {usermain} else {usermain1}
              onTextChanged: if(cardindex == 0) {usermain = userMain.text} else {usermain1 = userMain.text}
          }
          }

          Row {
              id:pmottoRow
              width: parent.width
              height: parent.height / 3

              Text {
                  text:qsTr("About:")


              TextArea {
                  anchors.top:parent.bottom
                  anchors.topMargin: .6
                  wrapMode: Text.WordWrap
                  id:personalMotto
                  width:pmottoRow.width
                  height:pmottoRow.height - 3
                  text:if(cardindex == 0) {usermotto} else {usermotto1}
                  onTextChanged: if(cardindex == 0) {usermotto = personalMotto.text} else {usermotto1 = personalMotto.text}
                 }
              }
          }



      Column {
          id:plinklist
          //x:0
          //anchors.top:pmottoRow.bottom
          width:parent.width
          //height:parent.height
          spacing: 25




              Text {
              id:websiteLabel

              text: "Twitter:"
              font.pixelSize:25
               TextField {
                   id:websiteVar

                   anchors.left: parent.right
                   anchors.leftMargin: .5
                   anchors.verticalCenter: parent.verticalCenter

                   width:plinklist.width - websiteLabel.width

                   placeholderText: qsTr("www.example.com")
                   //font.pixelSize: parent.height
                   text:if(cardindex == 0) {website1} else {website11}
                   onTextChanged: if(cardindex == 0) {website1 = websiteVar.text} else {website11 = websiteVar.text}

               }

           }


              Text {
              id:websiteLabel1

              text: "Tumblr:"
              font.pixelSize:25
               TextField {
                   id:websiteVar1

                   anchors.left: parent.right
                   anchors.leftMargin: .5
                   anchors.verticalCenter: parent.verticalCenter

                   width:plinklist.width - websiteLabel1.width

                   placeholderText: qsTr("www.example.com")
                   //font.pixelSize: parent.height
                   text:if(cardindex == 0) {website2} else {website21}
                   onTextChanged: if(cardindex == 0) {website2 = websiteVar1.text} else {website21 = websiteVar1.text}

               }

           }

              Text {
              id:websiteLabel2

              text: "SoundCloud:"
              font.pixelSize:25

               TextField {
                   id:websiteVar2

                   anchors.left: parent.right
                   anchors.leftMargin: .5
                   anchors.verticalCenter: parent.verticalCenter

                   width:plinklist.width - websiteLabel2.width

                   placeholderText: qsTr("www.example.com")
                   //font.pixelSize: parent.height
                   text:if(cardindex == 0) {website3} else {website31}
                   onTextChanged: if(cardindex == 0) {website3 = websiteVar2.text} else {website31 = websiteVar2.text}
               }

           }
              Text {
              id:websiteLabel3

              text: "Patreon:"
              font.pixelSize:25

               TextField {
                   id:websiteVar3

                   anchors.left: parent.right
                   anchors.leftMargin: .5
                   anchors.verticalCenter: parent.verticalCenter

                   width:plinklist.width - websiteLabel3.width

                   placeholderText: qsTr("www.example.com")
                   //font.pixelSize: parent.height
                   text:if(cardindex == 0) {website4} else {website41}
                   onTextChanged: if(cardindex == 0) {website4 = websiteVar3.text} else {website41 = websiteVar3.text}

               }

           }

        }
      }
}

DropShadow {

    anchors.fill: rectangle1
    horizontalOffset: 0
    verticalOffset: 3
    radius: 8.0
    samples: 17
    color: "#80000000"
    source: rectangle1
    z:1



}




 Text {
     anchors.left:parent.left
     anchors.leftMargin: 8
     anchors.top:rectangle1.bottom
     anchors.topMargin:8
     text: qsTr("Misc.")
     id:misc_title
 }

 Rectangle {
     anchors.horizontalCenter: parent.horizontalCenter
     anchors.top:misc_title.bottom
     anchors.topMargin:8
     width:parent.width * 0.99
     height: parent.height / 12
     radius:6
     border.width:1
     border.color:"black"

 Column {
     anchors.fill:parent
     anchors.margins: 10

     Item {
         id:about
         height:parent.height / 3
         width:parent.width
         Text {
             anchors.verticalCenter: parent.verticalCenter
             text: "About"
             font.pixelSize: parent.height * 0.4
         }
         /*  Flasher {
               id:conflash
           } */

         MouseArea {
             anchors.fill: parent
             onPressed:aboutflash.state = "Active"
             onReleased:aboutflash.state = "InActive"
             onClicked:aboutscreen.state = "Active"
         }

     }

     Item {
         id:credits
         height:parent.height / 3
         width:parent.width
         Text {
             anchors.verticalCenter: parent.verticalCenter
             text: "Credits"
             font.pixelSize: parent.height * 0.4
         }
         /*  Flasher {
               id:conflash
           } */

         MouseArea {
             anchors.fill: parent
             onPressed:creditsflash.state = "Active"
             onReleased:creditsflash.state = "InActive"
         }

     }

     Item {
         id:contribute
         height:parent.height / 3
         width:parent.width
         Text {
             anchors.verticalCenter: parent.verticalCenter
             text: "Contribute"
             font.pixelSize: parent.height * 0.4
         }
       /*  Flasher {
             id:conflash
         } */

         MouseArea {
             anchors.fill: parent
             onPressed:conflash.state = "Active"
             onReleased:conflash.state = "InActive"
         }

     }


 }

 }

     }
    }


 Menus {
     id:catmenu
     anchors.centerIn: parent

     state:"InActive"
     title:"Category Select"


 }

 SlideShow {
     id:aboutscreen

     width: parent.width
     height: parent.height
     state:"InActive"
     maintitle:"About"
     anchors.top: parent.top


 }

 }

