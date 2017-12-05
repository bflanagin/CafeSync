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
         name: "Active"
         PropertyChanges {
             target:settingsPage

             x:0


         }
     },
     State {
          name: "InActive"
          PropertyChanges {
              target:settingsPage

              x:width * -1


          }
     }



 ]

 transitions: [
     Transition {
         from: "InActive"
         to: "Active"
         reversible: true


         NumberAnimation {
             target: settingsPage
             property: "x"
             duration: 200
             easing.type: Easing.InOutQuad
         }
     }


 ]


onStateChanged: if(settingsPage.state == "Active") {topBar.state = "settings";} else {topBar.state = "standard";}




 Rectangle {
     color:backgroundColor
    // color: "white"
     //y:listthing.height
     width:parent.width
     height:parent.height
     //border.width: 1
 }


 Flickable {
     clip:true
     contentHeight:parent.height * 2.9
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
         spacing:20

         //clip:true

         Item {
             width:parent.width
             height:parent.height * 0.01

        }

         Text {
             text: qsTr("General Settings")
             anchors.left:parent.left
             font.pixelSize: 24
             anchors.leftMargin: 4
             //anchors.verticalCenter: parent.verticalCenter
         }
         Rectangle {
             width: parent.width * 0.98
             height:3
             anchors.horizontalCenter: parent.horizontalCenter

             color:highLightColor1

         }



Item {
    width:parent.width
    height:parent.height * 0.12



 Rectangle {
    id:generalarea
    clip:true
   // y:cardsava.y + cardsava.height + 10
    anchors.horizontalCenter: parent.horizontalCenter
    width:parent.width * 0.98
    height:parent.height
    color:"white"

   Column {
       y:10
       width:parent.width
       height:parent.height
       spacing:20



    Row {
        width:parent.width
        height: parent.height * 0.65
        clip:true

    Item {
           id:imagearea
     height:parent.width * 0.4
     width:parent.width * 0.4

     Image {
         id:cardsava
         width:parent.width
         height: parent.width
         anchors.verticalCenter: parent.verticalCenter
         anchors.horizontalCenter: parent.horizontalCenter
         //anchors.margins: 4
         visible: false
         source: if(cardindex == 0) {avimg}

     }

     Image {
         id:mask
         anchors.fill:parent
         source:"/graphics/CafeSync.png"
         visible: false

     }

     OpacityMask {
         id:opmask
          anchors.fill: cardsava
          source: cardsava
          maskSource: mask


      }
    DropShadow {
            anchors.fill: opmask
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: opmask
            z:1

        }

    MouseArea {
        anchors.fill: parent
        onClicked:sourceSelector.state = "Active"
    }



}
    Column {
        y:20
        width:parent.width * 0.6
        height:parent.height * 0.9
        spacing:15
        anchors.verticalCenter: parent.verticalCenter

  Text {
        id: nameLabel
       //  width:companyLabel.width
       //anchors.top:onlineLabel.bottom
        anchors.left:parent.left
        //anchors.left:if(layouts.width > units.gu(mobile_vert)){ cardBacking.right} else {parent.left}
       // anchors.leftMargin: 3
        //anchors.top:if(layouts.width > units.gu(mobile_vert)){cardBacking.top} else {cardBacking.bottom}
       // anchors.topMargin:if(layouts.width > units.gu(mobile_vert)){return 0} else {units.gu(.5)}
       //anchors.top:cardBacking.bottom
       // anchors.topMargin: 25
       //anchors.topMargin: 5
        width:parent.width * 0.98
        // text: qsTr("Name:")
        text:username
         font.pixelSize:  26

         MouseArea {
             anchors.fill: parent
             onClicked: userName.visible = true
         }

      TextField {
         id: userName
         anchors.left: parent.left
        visible: false
        // anchors.leftMargin: 4
         anchors.verticalCenter: parent.verticalCenter
         //anchors.top: parent.top
         text:if(cardindex == 0) {username }
         //verticalAlignment: TextInput.AlignTop
           onVisibleChanged: if(visible == true) {focus = true}
            onFocusChanged: if(focus == false) {visible = false}
         placeholderText: qsTr("User Name")
         font.pixelSize: 20
        // width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         width:parent.width
         clip:true
         onTextChanged: if(cardindex == 0) {username = userName.text}
     }
 }

  Text {
      id: aliasLabel


      anchors.left:parent.left
      anchors.leftMargin: parent.width * 0.10
      //anchors.bottom:avatarBacking.bottom
     // anchors.top:companyLabel.bottom
     // anchors.topMargin: 25
      width:parent.width * 0.90
      //text: qsTr("Position:")
      text:useralias

      font.pixelSize: 18

      MouseArea {
          anchors.fill: parent
          onClicked: userAlias.visible = true
      }

      TextField {
         id: userAlias

          anchors.verticalCenter: parent.verticalCenter
            visible: false
            onVisibleChanged: if(visible == true) {focus = true}
            onFocusChanged: if(focus == false) {visible = false}
         anchors.left: parent.left
         //anchors.leftMargin: 4
        // anchors.bottom: parent.bottom
         //anchors.top: parent.top
         placeholderText: qsTr("Job Title")
         font.pixelSize: 18
         width:parent.width
         //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {useralias}
         onTextChanged: if(cardindex == 0) {useralias = userAlias.text}
     }


}

  Item {
      height:40
      width:parent.width

  }

  Text {
      id: companyLabel
      anchors.left:parent.left
        horizontalAlignment: Text.AlignRight
    //  anchors.leftMargin: units.gu(.3)
     // anchors.top:nameLabel.bottom
     // anchors.topMargin: 25
        width:parent.width * 0.98
      //text: qsTr("Company:")
      text:usercompany
      font.pixelSize: 24

      MouseArea {
          anchors.fill: parent
          onClicked: userCompany.visible = true
      }

      TextField {
         id: userCompany
         visible: false
         anchors.left: parent.left
         //anchors.leftMargin: 4
          anchors.verticalCenter: parent.verticalCenter
         //anchors.top: parent.top
         placeholderText: qsTr("Company Name")
         font.pixelSize: 20
         width:parent.width
         onVisibleChanged: if(visible == true) {focus = true}
            onFocusChanged: if(focus == false) {visible = false}

         //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
         text:if(cardindex == 0) {usercompany}
         onTextChanged: if(cardindex == 0) {usercompany = userCompany.text}
     }
}




    }

    }

    Rectangle {
        width: parent.width * 0.98
        height:3
        anchors.horizontalCenter: parent.horizontalCenter

        //color:highLightColor1
        color:"black"

    }

    Item {
        width: parent.width
        height:parent.height * 0.12
        clip:true

    Text {
        anchors.left:parent.left
        anchors.leftMargin: 10
        text: qsTr("(tap to edit)")
        anchors.verticalCenter: parent.verticalCenter
    }

 Text {
     id:onlineLabel
     text: qsTr("Send Card")
     font.pointSize: 12
   //  anchors.top:parent.top
    // anchors.topMargin: 10
     anchors.right:parent.right
     anchors.rightMargin: width * 0.8
     horizontalAlignment: Text.AlignLeft
     anchors.verticalCenter: parent.verticalCenter

     CheckBox {
        id:sendCard

         anchors.left: onlineLabel.right
         anchors.leftMargin: 4
         anchors.verticalCenter: parent.verticalCenter
         //objectName: "switch_checked"

         checked: if(cardindex == 0) {if(stf == "true"){ return true } else {return false} }
         onCheckedChanged: if(cardindex == 0) {stf = sendCard.checked }
     }


 }

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

     }

Text {
    text: qsTr("Contact")
    anchors.left:parent.left

    anchors.leftMargin: 8
    font.pixelSize: 24

}
Rectangle {
    width: parent.width * 0.98
    height:3
    anchors.horizontalCenter: parent.horizontalCenter

    color:highLightColor1

}

Item {
    width:parent.width
    height:parent.height * 0.1


 Rectangle {
    id:contactarea
    clip:true
   // y:cardsava.y + cardsava.height + 10
  //  anchors.top:generalarea.bottom
   //  anchors.topMargin:20
    width:parent.width * 0.98
    height:parent.height
    color:"white"
    anchors.horizontalCenter: parent.horizontalCenter

    Column {
        y:20
        width:parent.width
        height:parent.height
        spacing: 30

        Item {
            width:parent.width
            height:parent.height * 0.01
        }



  Text {
      id: phoneLabel


      anchors.left:parent.left
     // anchors.leftMargin: units.gu(.3)
      //anchors.top:contactLabel.bottom
    //  anchors.topMargin: 25
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
         text:if(cardindex == 0) {userphone}
          onTextChanged: if(cardindex == 0) {userphone = userPhone.text}
     }
  }

  Text {
      id: emailLabel


      anchors.left:phoneLabel.left
     // anchors.leftMargin: units.gu(.3)
     // anchors.top:phoneLabel.bottom
     // anchors.topMargin: 25
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
         onTextChanged: if(cardindex == 0) {useremail = userEmail.text}
     }

  }


  Rectangle {
      width: parent.width * 0.98
      height:3
      anchors.horizontalCenter: parent.horizontalCenter

      //color:highLightColor1
      color:"black"

  }

  Text {
      id:contactLabel
      text: qsTr("Share Contact Info")
      font.pointSize: 12
      //font.bold: true
      horizontalAlignment: Text.AlignLeft
     // anchors.top:parent.top
     // anchors.topMargin: 10
      anchors.right:parent.right
      anchors.rightMargin:  width * 0.5

      CheckBox {
         id:sendContact

          anchors.left: contactLabel.right
          anchors.leftMargin: 5
          anchors.verticalCenter: parent.verticalCenter
          objectName: "switch_checked"

          checked: if(cardindex == 0) { if(ctf == "true"){ return true } else { return false} }
          onCheckedChanged: if(cardindex == 0) {ctf = sendContact.checked }
      }
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


}

Text {
 id: profileSettingLabel
 //x: units.gu(1)
// y: 208
 anchors.left:parent.left
 anchors.leftMargin: 8
 //anchors.top:contactarea.bottom//avatarBacking.bottom
 //anchors.topMargin: 10
 text: qsTr("Info")
 style: Text.Normal
 font.pixelSize: 24
}

Rectangle {
    width: parent.width * 0.98
    height:3
    anchors.horizontalCenter: parent.horizontalCenter

   color:highLightColor1
    //color:"black"

}

Item {
    width:parent.width
    height: personalMotto.y + (personalMotto.height * 1.4)

 Rectangle {
 id: rectangle1


 anchors.left:parent.left
 anchors.leftMargin:1
// anchors.top:profileSettingLabel.bottom
 // anchors.topMargin:1

 //height: pageColumn.height / 4

 height:parent.height
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
          spacing: 30


          Text {
              font.pixelSize: 24
              text:qsTr("Category: ")
              anchors.right:parent.right
              anchors.rightMargin: catbutton.width * 1.1

             Rectangle {
                    id:catbutton
                 width:if(cardindex == 0) {10*usercat.length + catText.width}
                 height:parent.height * 1.1

                 anchors.left:parent.right
                 anchors.verticalCenter: parent.verticalCenter
                 //border.color:"black"
                 radius: 3
                 color:highLightColor1
                 clip:true

              Text {
                     id:catText
                  //anchors.left:parent.right
                     anchors.centerIn: parent
                  font.pixelSize:24
                 // anchors.verticalCenter: parent.verticalCenter
                  text:if(cardindex == 0) { if(usercat.length < 2) {qsTr("Select Category")} else {usercat}}
                 }
                  MouseArea {
                      anchors.fill:parent
                      onClicked: catmenu.state = "Active"
                  }
              }

             DropShadow {

                 anchors.fill: catbutton
                 horizontalOffset: 0
                 verticalOffset: 3
                 radius: 8.0
                 samples: 17
                 color: "#80000000"
                 source: catbutton
                 z:1



             }


          }

          Rectangle {
              //anchors.top:row0.bottom
              width:parent.width
              height:3
              color:highLightColor1


          }


          Text {
           id:mainadvert
           text: qsTr("URL: ")
           font.pixelSize: 18
           TextField {
              id: userMain
              //anchors.bottomMargin: 0
              //anchors.topMargin: 0
              anchors.verticalCenter: parent.verticalCenter

              anchors.left: parent.right
              anchors.leftMargin: parent.width * 0.06
             // anchors.bottom: parent.bottom
             // anchors.top: parent.top
              placeholderText: qsTr("Main Site for Advertising")
              //font.pixelSize: units.gu(2.4)
              //width:if(layouts.width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
              width:(rectangle1.width - parent.width) * 0.90
              text:if(cardindex == 0) {usermain}
              onTextChanged: if(cardindex == 0) {usermain = userMain.text}
          }
          }

          Row {
              id:pmottoRow
              width: parent.width
              height: settingsPage.height / 2

              Text {
                  text:qsTr("About:")

                  Rectangle {
                      anchors.fill: personalMotto
                      border.color:highLightColor1
                      border.width: 1
                  }

              TextArea {
                  anchors.top:parent.bottom
                  anchors.topMargin: .6
                  wrapMode: Text.WordWrap
                  id:personalMotto
                  width:pmottoRow.width
                  height:pmottoRow.height - 3
                  text:if(cardindex == 0) {usermotto}
                  onTextChanged: if(cardindex == 0) {usermotto = personalMotto.text}
                  clip:true


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

}

Text {
 //id: profileSettingLabel
 //x: units.gu(1)
// y: 208
 anchors.left:parent.left
 anchors.leftMargin: 8
 //anchors.top:contactarea.bottom//avatarBacking.bottom
 //anchors.topMargin: 10
 text: qsTr("Social Networks")
 style: Text.Normal
 font.pixelSize: 24
}

Rectangle {
    width: parent.width * 0.98
    height:3
    anchors.horizontalCenter: parent.horizontalCenter

   color:highLightColor1
    //color:"black"

}

Item {
   //
    height:socialNetworks.height
    width:parent.width

Rectangle {
    id:socialNetworks
    color:"white"
    anchors.fill: parent
    width:parent.width
    height:soundcloudButton.y + soundcloudButton.height + 40
        clip:true

                    /* Text {
                          id:websiteLabel

                          text: "Twitter:"
                          font.pixelSize: 18

                         TextField {
                            id:websiteVar

                           anchors.left: parent.right
                            anchors.leftMargin: .5
                             anchors.verticalCenter: parent.verticalCenter

                                 width:plinklist.width - websiteLabel.width

                                    placeholderText: qsTr("www.twitter.com/username")
                                     //font.pixelSize: parent.height
                                     text:if(cardindex == 0) {website1} else {website11}
                                 onTextChanged: if(cardindex == 0) {website1 = websiteVar.text}

                        }


                     } */

                     Item {
                         id:twitterButton
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.top:parent.top
                         anchors.topMargin: 20
                         width:parent.width * 0.95
                         height:80

                     Rectangle {
                         id:twb
                         anchors.fill: parent
                         color:"lightblue"
                         radius:5
                         border.color: "white"

                         Row {
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.98
                             height:parent.height
                             clip:true
                             spacing: 10
                             Image {
                                 source:"./img/twitter.png"
                                 height:parent.height * 0.9
                                 width:parent.height * 0.9
                                 anchors.verticalCenter: parent.verticalCenter

                             }

                             Rectangle {
                                 height:parent.height * 0.9
                                 color:"white"
                                 width:3
                                 anchors.verticalCenter: parent.verticalCenter
                             }

                             Text {
                                 anchors.verticalCenter: parent.verticalCenter
                                 text:"Twitter not connected"
                                 color:"white"
                                 width:parent.width
                                 font.pixelSize: parent.height * 0.3
                                 wrapMode: Text.WordWrap
                             }
                         }
                       }

                     DropShadow {

                        anchors.fill: twb
                        horizontalOffset: 0
                        verticalOffset: 3
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: twb
                        z:1



                          }
                      }

                    Item {
                        id:tumblrButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:twitterButton.bottom
                        anchors.topMargin: 20
                        width:parent.width * 0.95
                        height:80

                    Rectangle {
                        id:trb
                       anchors.fill: parent
                        color:"#343460"
                        radius:5
                        border.color: "white"

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:parent.width * 0.98
                            height:parent.height
                            clip:true
                            spacing: 10
                            Image {
                                source:"./img/tumblr.png"
                                height:parent.height * 0.9
                                width:parent.height * 0.9
                                anchors.verticalCenter: parent.verticalCenter

                            }

                            Rectangle {
                                height:parent.height * 0.9
                                color:"white"
                                width:3
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text:"Tumblr not connected"
                                color:"white"
                                width:parent.width
                                font.pixelSize: parent.height * 0.3
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    DropShadow {

                       anchors.fill: trb
                       horizontalOffset: 0
                       verticalOffset: 3
                       radius: 8.0
                       samples: 17
                       color: "#80000000"
                       source: trb
                       z:1



                         }
                     }

                    Item {
                        id:kickstarterButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:tumblrButton.bottom
                        anchors.topMargin: 20
                        width:parent.width * 0.95
                        height:80

                     Rectangle {
                        id:ksb
                        anchors.fill: parent
                        color:"#3DA1B3"
                        radius:5
                        border.color: "white"

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:parent.width * 0.98
                            height:parent.height
                            clip:true
                            spacing: 10
                            Image {
                                source:"./img/kickstarter-logo-k-color.png"
                                height:parent.height * 0.9
                                width:parent.height * 0.9
                                anchors.verticalCenter: parent.verticalCenter

                            }

                            Rectangle {
                                height:parent.height * 0.9
                                color:"white"
                                width:3
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text:"Kickstarter not connected"
                                color:"white"
                                width:parent.width
                                font.pixelSize: parent.height * 0.3
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                     DropShadow {

                        anchors.fill: ksb
                        horizontalOffset: 0
                        verticalOffset: 3
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: ksb
                        z:1



                          }
                      }

                     Item {
                         id:soundcloudButton
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.top:kickstarterButton.bottom
                         anchors.topMargin: 20
                         width:parent.width * 0.95
                         height:80


                    Rectangle {
                        id:scb
                        anchors.fill: parent
                        color:"orange"
                        radius:5
                        border.color: "white"

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:parent.width * 0.98
                            height:parent.height
                            clip:true
                            spacing: 10
                            Image {
                                source:"./img/soundcloud.png"
                                height:parent.height * 0.9
                                width:parent.height * 0.9
                                anchors.verticalCenter: parent.verticalCenter

                            }

                            Rectangle {
                                height:parent.height * 0.9
                                color:"white"
                                width:3
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text:"SoundCloud not connected"
                                color:"white"
                                font.pixelSize: parent.height * 0.3
                                width:parent.width
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    DropShadow {

                       anchors.fill: scb
                       horizontalOffset: 0
                       verticalOffset: 3
                       radius: 8.0
                       samples: 17
                       color: "#80000000"
                       source: scb
                       z:1



                         }
                     }


      /*  Text {
        id:websiteLabel1

        text: "Tumblr:"
        font.pixelSize: 18
         TextField {
             id:websiteVar1

             anchors.left: parent.right
             anchors.leftMargin: .5
             anchors.verticalCenter: parent.verticalCenter

             width:plinklist.width - websiteLabel1.width

             placeholderText: qsTr("www.example.com")
             //font.pixelSize: parent.height
             text:if(cardindex == 0) {website2} else {website21}
             onTextChanged: if(cardindex == 0) {website2 = websiteVar1.text}

         }

     } */



       /* Text {
        id:websiteLabel2

        text: "Kickstarter:"
        font.pixelSize: 18

         TextField {
             id:websiteVar2

             anchors.left: parent.right
             anchors.leftMargin: .5
             anchors.verticalCenter: parent.verticalCenter

             width:plinklist.width - websiteLabel2.width

             placeholderText: qsTr("www.example.com")
             //font.pixelSize: parent.height
             text:if(cardindex == 0) {website3} else {website31}
             onTextChanged: if(cardindex == 0) {website3 = websiteVar2.text}
         }

     } */
      /*  Text {
        id:websiteLabel3

        text: "SoundCloud:"
        font.pixelSize: 18

         TextField {
             id:websiteVar3

             anchors.left: parent.right
             anchors.leftMargin: .5
             anchors.verticalCenter: parent.verticalCenter

             width:plinklist.width - websiteLabel3.width

             placeholderText: qsTr("www.example.com")
             //font.pixelSize: parent.height
             text:if(cardindex == 0) {website4} else {website41}
             onTextChanged: if(cardindex == 0) {website4 = websiteVar3.text}

         }

     } */

}

    DropShadow {

       anchors.fill: socialNetworks
       horizontalOffset: 0
       verticalOffset: 3
       radius: 8.0
       samples: 17
       color: "#80000000"
       source: socialNetworks
       z:1



   }

}


 Text {
     anchors.left:parent.left
     anchors.leftMargin: 8
    // anchors.top:rectangle1.bottom
    // anchors.topMargin:8
     text: qsTr("Misc.")
     font.pixelSize: 24
     id:misc_title
 }

 Rectangle {
     width: parent.width * 0.98
     height:3
     anchors.horizontalCenter: parent.horizontalCenter

    color:highLightColor1
     //color:"black"

 }

 Item {
     width:parent.width
     height:parent.height / 12


  Rectangle {
     id:miscborder
     anchors.horizontalCenter: parent.horizontalCenter
    // anchors.top:misc_title.bottom
   //  anchors.topMargin:8
     width:parent.width * 0.99
     height: parent.height
     //radius:6
     //border.width:1
    // border.color:"black"

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


         MouseArea {
             anchors.fill: parent
             onPressed:conflash.state = "Active"
             onReleased:conflash.state = "InActive"
         }

     }


 }

 }


  DropShadow {

     anchors.fill: miscborder
     horizontalOffset: 0
     verticalOffset: 3
     radius: 8.0
     samples: 17
     color: "#80000000"
     source: miscborder
     z:1



 }

 }

     }
    }


 Menus {
     id:catmenu
     //anchors.centerIn: parent
     x:0
     y:topBar.height
     width:parent.width
    // y:topBar.height
     height:parent.height - topBar.height
     state:"InActive"
     title:"Category Select"


 }

 SlideShow {
     id:aboutscreen
     y:0
     width: parent.width
     height: parent.height
     state:"InActive"
     maintitle:"About"
     //anchors.top: parent.top


 }

 SourceSelection {
        id:sourceSelector
        width:parent.width
        height:parent.height - topBar.height
        state:"InActive"

 }

SocialConnect {
    id:sConnect
    width:parent.width
    height:parent.height
    state:"InActive"
}



 }



