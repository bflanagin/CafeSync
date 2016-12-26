
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



Item {
    //width:parent.width
   // height:parent.height
id:settingsPage
//clip: true

states: [
    State {
        name:"hide"
        PropertyChanges{
            target:settingsPage
            visible:false
        }
    },
    State {
        name:"show"
        PropertyChanges {
            target:settingsPage
            visible:true


        }


    }

]
state:"hide"

Image {
    width:parent.width
    height:parent.height
    source:"img/Suru_Wallpaper_Desktop_4096x2304_Gray.png"
}

Flickable {
    clip:true
    contentHeight:parent.height * 2.4
    anchors {
        top: parent.top
        bottom:parent.bottom
        left:parent.left
        right:parent.right
    }

    Column {
        id:pageColumn

        anchors {
            top: parent.top
            bottom:parent.bottom
            left:parent.left
            right:parent.right
        }
        clip:true
Item {

    height:parent.height
    width:parent.width



    Rectangle {
        id: cardBacking

        states: [
            State {
                name:"vert"
                when:window_width < units.gu(mobile_vert)

                PropertyChanges {
                    target:cardBacking
                    y: units.gu(.5)
                    x:(parent.width / 2) - ( width /2 )
                    height: parent.height * 0.13
                    width:height * 1.7
                }
            },
            State {
                name:"hor"
                when:window_width > units.gu(mobile_vert)
                PropertyChanges {
                    target:cardBacking

                    y: units.gu(.5)

                    //height: parent.height * 0.33
                    height:aliasLabel.height + aliasLabel.y
                    width:height * 1.7
                }
            }
        ]



        border.width: 1
        clip: true

        Image {
            //anchors.fill:parent
            width:parent.width
            height:parent.height
            //source: if(cardbImg.search("internal:") == -1) {cardbImg} else {Scripts.Card_Set("background",fbgnum);}
             source:if(cardindex == 0) { if(cardbImg.search("internal:") == -1) {cardbImg}
                        else {Scripts.Card_Set("background",fbgnum);}
                    } else {if(cardbImg1.search("internal:") == -1) {cardbImg1} else {Scripts.Card_Set("background",fbgnum);}
                                }
           //fillMode: Image.PreserveAspectFit
           Image {
                source:if(cardindex == 0) {cardsImg.split(":")[0]} else {cardsImg1.split(":")[0]}
                //anchors.fill:parent
                x:if(cardindex == 0) {parent.width * (0.01*cardsImg.split(":")[1])} else {parent.width * (0.01*cardsImg1.split(":")[1])}
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
                         text:if(cardindex == 0) {if(usercompany.length >1) {usercompany} else {username}} else {if(usercompany1.length >1) {usercompany1} else {username1}}
                         font.pixelSize:if(cardindex == 0) { parent.height * (0.0075*cardtplace.split(":")[0]) } else { parent.height * (0.0075*cardtplace1.split(":")[0]) }
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.verticalCenter: parent.verticalCenter
                         anchors.horizontalCenterOffset: if(cardindex == 0) { parent.width * (0.01*cardtplace.split(":")[1]) } else { parent.width * (0.01*cardtplace1.split(":")[1])}
                         anchors.verticalCenterOffset: if(cardindex == 0) { parent.height * (0.01*cardtplace.split(":")[2]) } else { parent.height * (0.01*cardtplace1.split(":")[2])}


                         style: Text.Outline; styleColor: "#FFFFFF"
                         //onTextChanged: usercompany


                     Text {
                         id:subtitle
                         text:if(cardindex == 0) { if(usercompany.length >1) {username} else {""} } else { if(usercompany1.length >1) {username1} else {""} }
                         font.pixelSize: parent.height * (0.01*30)
                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.verticalCenter: parent.verticalCenter
                         anchors.horizontalCenterOffset:parent.width * (0.01*35)
                         anchors.verticalCenterOffset: parent.height * (0.01*70)

                         style: Text.Outline; styleColor: "#FFFFFF"
                         //onTextChanged: username
                     }
                     }
                 }




           MouseArea {

               anchors.fill:parent
               //onClicked:{console.log("clicked");PopupUtils.open(cardbackList)}
                onClicked:{creator.state = "Active",
                           Scripts.save_card(userid,username,userphone,useremail,usercompany,
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
                    }

           }
        }

Rectangle {
    id: avatarBacking


    anchors.right:parent.right
    anchors.bottom:parent.bottom
    anchors.rightMargin: units.gu(1)
    anchors.bottomMargin: units.gu(1)

    width: units.gu(8)
    height: units.gu(8)

    border.width: 1
    clip: true



    Image {
        id: avatar

        anchors.fill:parent
        anchors.margins: units.gu(.5)
        source: if(cardindex == 0) {avimg} else {avimg1}
        fillMode: Image.PreserveAspectCrop




        MouseArea {
            anchors.fill:parent
            onClicked: {
              // activeTransfer = picSourceSingle.request(appStore)

            }
        }

        }

    }

}

 Text {
       id: nameLabel

       anchors.left:if(window_width > units.gu(mobile_vert)){ cardBacking.right} else {parent.left}
       anchors.leftMargin: units.gu(.3)
       anchors.top:if(window_width > units.gu(mobile_vert)){cardBacking.top} else {cardBacking.bottom}
       anchors.topMargin:if(window_width > units.gu(mobile_vert)){return 0} else {units.gu(.5)}

        text: i18n.tr("Name:")
        font.pixelSize: units.gu(3.4)

     TextField {
        id: userName
        anchors.left: parent.right
        anchors.leftMargin: units.gu(.5)
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        text:if(cardindex == 0) {username } else {username1}
        onTextChanged: if(cardindex == 0) {username = userName.text} else {username1 = userName.text}
        placeholderText: i18n.tr("User Name")
        font.pixelSize: units.gu(2.4)
        width:if(window_width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
    }
}

 Text {
     id: phoneLabel


     anchors.left:nameLabel.left
    // anchors.leftMargin: units.gu(.3)
     anchors.top:nameLabel.bottom
     anchors.topMargin: units.gu(.3)
     text: i18n.tr("Phone:")
     font.pixelSize: units.gu(3.4)


     TextField {
        id: userPhone

        anchors.left: parent.right
        anchors.leftMargin: units.gu(.5)
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        placeholderText: i18n.tr("0 555-555-5555")
        font.pixelSize: units.gu(2.4)
        width:if(window_width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
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
     anchors.topMargin: units.gu(.3)

     text: i18n.tr("Email:")
     font.pixelSize: units.gu(3.4)

     TextField {
        id: userEmail

        anchors.left: parent.right
        anchors.leftMargin: units.gu(.5)
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        placeholderText: i18n.tr("johndoe@example.com")
        font.pixelSize: units.gu(2.4)
        width:if(window_width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
        text:if(cardindex == 0) {useremail} else {useremail1}
        onTextChanged: if(cardindex == 0) {useremail = userEmail.text} else {useremail1 = userEmail.text}
    }

 }




    Text {
        id: companyLabel

        anchors.left:emailLabel.left
      //  anchors.leftMargin: units.gu(.3)
        anchors.top:emailLabel.bottom
        anchors.topMargin: units.gu(.3)

        text: i18n.tr("Company:")
        font.pixelSize: units.gu(3.4)

        TextField {
           id: userCompany

           anchors.left: parent.right
           anchors.leftMargin: units.gu(.5)
           anchors.bottom: parent.bottom
           anchors.top: parent.top
           placeholderText: i18n.tr("Company Name")
           font.pixelSize: units.gu(2.4)
           width:if(window_width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
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
        anchors.topMargin: units.gu(3)

        text: i18n.tr("Alias:")
        font.pixelSize: units.gu(3.4)

        TextField {
           id: userAlias
           anchors.bottomMargin: 0
           anchors.topMargin: 0

           anchors.left: parent.right
           anchors.leftMargin: units.gu(.5)
           anchors.bottom: parent.bottom
           anchors.top: parent.top
           placeholderText: i18n.tr("User Alias")
           font.pixelSize: units.gu(2.4)
           width:if(window_width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
           text:if(cardindex == 0) {useralias} else {useralias1}
           onTextChanged: if(cardindex == 0) {useralias = userAlias.text} else {useralias1 = userAlias.text}
       }
 }


Text {
id: profileSettingLabel

anchors.left:parent.left
anchors.leftMargin: units.gu(2)
anchors.top:aliasLabel.bottom//avatarBacking.bottom
anchors.topMargin: units.gu(1)

text: i18n.tr("Card")
style: Text.Normal
font.pixelSize: units.gu(2)
}

Rectangle {
id: rectangle1


//anchors.left:parent.left
//anchors.leftMargin:units.gu(1)
anchors.top:profileSettingLabel.bottom
anchors.topMargin:units.gu(1)

anchors.horizontalCenter: parent.horizontalCenter
width:parent.width * 0.99

height: units.gu(40)
//anchors.right:parent.right
//anchors.rightMargin:units.gu(1)



clip:true
color: "#ffffff"
radius: 6
//z: -1
border.width: 1


     Column {

         anchors.top:parent.top
         anchors.topMargin:10
         anchors.left:parent.left
         anchors.leftMargin: 10
         anchors.bottom: parent.bottom
         anchors.bottomMargin: 10
         anchors.right:parent.right
         anchors.rightMargin:10

         clip: true
         spacing: units.gu(1)

         Text {
             font.pixelSize: parent.height * 0.07
             text:i18n.tr("Category: ")
            Rectangle {
                width:if(cardindex == 0) {10*usercat.length + catText.width} else {10*usercat1.length + catText.width}
                height:parent.height
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
                border.color:"black"
                border.width:1
                radius: 5
                clip:true
             Text {
                    id:catText
                 //anchors.left:parent.right
                    anchors.centerIn: parent
                 font.pixelSize:parent.height * 0.85
                // anchors.verticalCenter: parent.verticalCenter
                 text:if(cardindex == 0) { if(usercat.length < 2) {i18n.tr("Select Category")} else {usercat}} else {if(usercat1.length < 2) {i18n.tr("Select Category")} else {usercat1}}
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
             font.pixelSize: units.gu(1)
             font.bold: true
             text: "Privacy:"
             //horizontalAlignment: Text.AlignLeft
         }
         Row {
             id: row0
             clip: false
                 spacing: units.gu(5)
                 width: parent.width
                 height: units.gu(2)
                 anchors.horizontalCenter: parent.horizontalCenter


                 Text {
                     id:onlineLabel
                     text: i18n.tr("Send")
                     font.pixelSize:units.gu(1)
                     //anchors.left:parent.right
                    // anchors.leftMargin:5
                     //font.bold: true
                     horizontalAlignment: Text.AlignLeft

                     CheckBox {
                        id:sendCard

                         anchors.left: onlineLabel.right
                         anchors.leftMargin: 1
                         anchors.verticalCenter: parent.verticalCenter
                         //objectName: "switch_checked"

                         checked: if(cardindex == 0) {if(stf == "true"){ return true } else {return false} } else { if(stf1 == "true"){ return true } else {return false} }
                         onCheckedChanged: if(cardindex == 0) {stf = sendCard.checked } else {stf1 = sendCard.checked}

                     }
                 }

                 Text {
                     id:aLabel
                     text: i18n.tr("Alias")
                     font.pixelSize: units.gu(1)
                     //font.bold: true
                     horizontalAlignment: Text.AlignLeft

                     CheckBox {
                        id:useAlias

                         anchors.left: aLabel.right
                         anchors.leftMargin: 1
                         anchors.verticalCenter: parent.verticalCenter
                        // objectName: "switch_checked"

                         checked: if(cardindex == 0) { if(atf == "true"){ return true } else { return false} } else { if(atf1 == "true"){ return true } else { return false} }
                         onCheckedChanged: if(cardindex == 0) {atf = useAlias.checked } else {atf1 = useAlias.checked}
                     }
                 }
                 Text {
                     id:contactLabel
                     text: i18n.tr("Contact")
                     font.pixelSize: units.gu(1)
                     //font.bold: true
                     horizontalAlignment: Text.AlignLeft

                     CheckBox {
                        id:sendContact

                         anchors.left: contactLabel.right
                         anchors.leftMargin: 1
                         anchors.verticalCenter: parent.verticalCenter
                         //objectName: "switch_checked"

                         checked: if(cardindex == 0) { if(ctf == "true"){ return true } else { return false} } else { if(ctf1 == "true"){ return true } else { return false} }
                         onCheckedChanged: if(cardindex == 0) {ctf = sendContact.checked } else {ctf1 = sendContact.checked}
                     }
                 }


        }
         Item {

         }

         Rectangle {
             //anchors.top:row0.bottom
             width:parent.width
             height:3
             color:"gray"


         }
         Item {

         }

         Text {
          id:mainadvert
          text: i18n.tr("Main Page:")
          font.pixelSize: units.gu(2.4)
          TextField {
             id: userMain
             //anchors.bottomMargin: 0
             //anchors.topMargin: 0
             anchors.verticalCenter: parent.verticalCenter

             anchors.left: parent.right
             anchors.leftMargin: units.gu(.5)
            // anchors.bottom: parent.bottom
            // anchors.top: parent.top
             placeholderText: i18n.tr("Main Site for Advertising")
             //font.pixelSize: units.gu(2.4)
             //width:if(window_width > units.gu(mobile_vert)){appWindow.width - parent.width - cardBacking.width - units.gu(12)} else {appWindow.width - parent.width - units.gu(1)}
             width:(rectangle1.width - parent.width) * 0.98
             text:if(cardindex == 0) {usermain} else {usermain1}
             onTextChanged: if(cardindex == 0) {usermain = userMain.text} else {usermain1 = userMain.text}
         }
         }

         Row {
             id:pmottoRow
             width: parent.width
             height: rectangle1.height - (y * 1.15)
                clip:true
             Text {
                 text:i18n.tr("About:")


             TextField {
                 anchors.top:parent.bottom
                 anchors.topMargin: units.gu(.2)


                 id:personalMotto
                 width:pmottoRow.width
                 height:pmottoRow.height - y
                 text:if(cardindex == 0) {usermotto} else {usermotto1}
                 onTextChanged: if(cardindex == 0) {usermotto = personalMotto.text} else {usermotto1 = personalMotto.text}
                }
             }
         }
     }
}

Text {
    anchors.left:parent.left
    anchors.leftMargin: 8
    anchors.top:rectangle1.bottom
    anchors.topMargin:8
    text: i18n.tr("Other Sites")
    id:sn_title
}

Rectangle {
    id:socialNetworkingB
    anchors.top:sn_title.bottom
    anchors.topMargin:8
    clip:true
    width:parent.width * 0.99
    height:plinklist.height * 1.5
    anchors.horizontalCenter: parent.horizontalCenter
    color: "#ffffff"
    radius: 6
    //z: -1
    border.width: 1



        Column {
            //anchors.top:socialNetworkingB.top
            //anchors.topMargin:20
            y:parent.height * 0.10
            anchors.left:parent.left
            anchors.leftMargin: 2
            id:plinklist
            //x:0
           // y:pmottoRow.height + pmottoRow.y + units.gu(25)

            width:parent.width
           // height:parent.height - pmottoRow.height + pmottoRow.y + units.gu(25)
            //height:websiteLabel3.height
            spacing: units.gu(2.5)



                Text {
                id:websiteLabel

                text: "Web Site:"
                font.pixelSize:units.gu(1.5)

                 TextField {
                     id:websiteVar

                     anchors.left: parent.right
                     anchors.leftMargin: units.gu(.5)
                     anchors.verticalCenter: parent.verticalCenter

                     width:rectangle1.width - websiteLabel.width - units.gu(1)

                     placeholderText: i18n.tr("www.example.com")
                     font.pixelSize: units.gu(1.5)
                     text:if(cardindex == 0) {website1} else {website11}
                     onTextChanged: if(cardindex == 0) {website1 = websiteVar.text} else {website11 = websiteVar.text}


                 }

             }


                Text {
                id:websiteLabel1

                text: "Web Site:"
                font.pixelSize:units.gu(1.5)

                 TextField {
                     id:websiteVar1

                     anchors.left: parent.right
                     anchors.leftMargin: units.gu(.5)
                     anchors.verticalCenter: parent.verticalCenter

                     width:rectangle1.width - websiteLabel.width - units.gu(1)

                     placeholderText: i18n.tr("www.example.com")
                     font.pixelSize: units.gu(1.5)
                     text:if(cardindex == 0) {website2} else {website21}
                     onTextChanged: if(cardindex == 0) {website2 = websiteVar1.text} else {website21 = websiteVar1.text}


                 }

             }

                Text {
                id:websiteLabel2

                text: "Web Site:"
                font.pixelSize:units.gu(1.5)

                 TextField {
                     id:websiteVar2

                     anchors.left: parent.right
                     anchors.leftMargin: units.gu(.5)
                     anchors.verticalCenter: parent.verticalCenter

                     width:rectangle1.width - websiteLabel.width - units.gu(1)

                     placeholderText: i18n.tr("www.example.com")
                     font.pixelSize: units.gu(1.5)
                     text:if(cardindex == 0) {website3} else {website31}
                     onTextChanged: if(cardindex == 0) {website3 = websiteVar2.text} else {website31 = websiteVar2.text}



                 }

             }

                Text {
                id:websiteLabel3

                text: "Web Site:"
                font.pixelSize:units.gu(1.5)

                 TextField {
                     id:websiteVar3

                     anchors.left: parent.right
                     anchors.leftMargin: units.gu(.5)
                     anchors.verticalCenter: parent.verticalCenter

                     width:rectangle1.width - websiteLabel.width - units.gu(1)

                     placeholderText: i18n.tr("www.example.com")
                     font.pixelSize: units.gu(1.5)
                     text:if(cardindex == 0) {website4} else {website41}
                     onTextChanged: if(cardindex == 0) {website4 = websiteVar3.text} else {website41 = websiteVar3.text}


                 }

             }

        }

    }

Text {
    anchors.left:parent.left
    anchors.leftMargin: 8
    anchors.top:socialNetworkingB.bottom
    anchors.topMargin:8
    text: i18n.tr("Misc.")
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
        Flasher {
            id:aboutflash
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
        Flasher {
            id:creditsflash
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
        Flasher {
            id:conflash
        }

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
}

Menus {
    id:catmenu
    anchors.centerIn: parent

    state:"InActive"
    title:"Category Select"


}

SlideShow {
    id:aboutscreen

    width: if(window_width > mobile_width) {parent.width * 0.40} else {parent.width * 0.90}
    height: parent.height * 0.90
    state:"InActive"
    maintitle:"About"


}



}

