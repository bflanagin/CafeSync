import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
import QtWebView 1.0
import QtQuick.Window 2.0
import QtPositioning 5.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
    id:thisWindow


  /*  property string name: ""
    property string position: ""
    property string email: ""
    property string phone: ""
    property string company: ""
    property string about: ""
    property string mainsite: ""

    property string web1: ""
    property string web2: ""
    property string web3: ""
    property string web4: "" */



    states: [
        State {
            name: "InActive"
            PropertyChanges {
                target: thisWindow
                x:0
                y:parent.height
            }
        },
        State {
            name: "Active"
            PropertyChanges {
                target: thisWindow
                x:0
                y:parent.height * 0.02
            }
        }

    ]
    state: "InActive"

    Rectangle {
        anchors.fill: slideview
        color:backgroundColor
        //color:"green"
    }

    onStateChanged: if(thisWindow.state == "Active") {topBar.state = "Wizard"} else {topBar.state = "standard"}

    GridView {
            id:slideview
            width:parent.width
            height:parent.height
           // y:parent.height * 0.08
        snapMode: GridView.SnapOneRow
        //flow: GridView.FlowLeftToRight
        flow:GridView.FlowTopToBottom
        boundsBehavior: Flickable.DragAndOvershootBounds
        flickableDirection: Flickable.VerticalFlick
       // highlightFollowsCurrentItem: true
        focus:true
        visible: true
        //cellHeight: units.gu(26)
        clip:true
        cacheBuffer : 80
        cellHeight:parent.height //passerbyGrid.height
        cellWidth: thisWindow.width



        delegate: Item {
                    width:slideview.cellWidth
                     height:slideview.cellHeight
                     Rectangle {

                            anchors.centerIn: parent
                            width: parent.width * 0.95
                            height: parent.height * 0.8
                            id:dialogue1

                        color:cardcolor
                        clip: true

                        Text {
                            visible: false
                            text:if(slideview.indexAt(slideview.contentX,0) == 2) {
                                     "bla"} else {"bleh"}
                            onTextChanged: if(text == "bla" && userid == "") {slideview.interactive = false} else {slideview.interactive = true}
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: parent.height * 0.90
                            spacing: 20
                        Text {
                            //visible: if(type != 8) {true} else {false}
                            text: thetitle
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 48

                        }

                        Rectangle {
                           //  visible: if(type != 8) {true} else {false}
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: 3
                            color: highLightColor1
                        }

                        Text {
                           //  visible: if(type != 8) {true} else {false}
                            width:parent.width * 0.9
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            text:message
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18

                        }

                        Rectangle {
                           //  visible: if(type != 8) {true} else {false}
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: 3
                            color: highLightColor1
                        }

                        Item {
                            visible: if(type == 3) {true} else {false}
                            width: parent.width
                            height: parent.height * 0.5

                            Text {
                                visible: if(userid != "") {true} else {false}
                                anchors.centerIn: parent
                                text:qsTr("Connected!\n\n You May Continue -->")
                                color:"black"
                                horizontalAlignment: Text.AlignHCenter
                                font.pixelSize: 30
                                wrapMode: Text.WordWrap
                                onVisibleChanged: slideview.interactive = true
                            }

                        Item {
                            anchors.fill: parent
                            visible: if(userid == "") {true} else {false}

                        TextField{
                             id:osUsernameField
                             anchors.top:parent.top
                             anchors.topMargin:10
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.85
                             placeholderText: qsTr("User Name")
                             horizontalAlignment: Text.AlignHCenter
                             text:osUsername
                             onTextChanged: uniquename = 0, osUsername = text,OpenSeed.checkcreds(osUsername,osPassphrase);


                         }

                        TextField{
                            id:osEmailField
                            anchors.top:osUsernameField.bottom
                            anchors.topMargin:15
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.85
                            placeholderText: qsTr("Email")
                           horizontalAlignment: Text.AlignHCenter
                            text:osEmail
                            onTextChanged:uniquename = 0,osEmail = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                        }

                         TextField{
                             id:osPassField
                             anchors.top:osEmailField.bottom
                            anchors.topMargin:15
                              anchors.horizontalCenter: parent.horizontalCenter
                              width:parent.width * 0.85
                             placeholderText: qsTr("Passphrase")
                             horizontalAlignment: Text.AlignHCenter
                             echoMode: TextInput.Password
                             text:osPassphrase
                             onTextChanged:uniquename = 0,osPassphrase = text,OpenSeed.checkcreds(osUsername,osPassphrase);


                         }

                         Rectangle {
                             id:connectB
                             anchors.top: osPassField.bottom
                             anchors.horizontalCenter: parent.horizontalCenter
                             anchors.topMargin: 30
                             width: parent.width * 0.45
                             height: 60
                             color:highLightColor1
                             radius:4

                              Text {
                                  id:cb
                                  anchors.centerIn: parent
                                  text:qsTr("Connect")
                                  color:"black"
                                  font.pixelSize: 24
                              }

                              MouseArea {
                                  anchors.fill: parent

                              onClicked:
                                  { if(osEmail.length > 2) {
                                     if(osUsername.length > 2) {
                                        //  console.log("sending info to server");
                                          OpenSeed.oseed_auth(osUsernameField.text,osEmailField.text,osPassField.text);
                                                    cb.text = qsTr("Loading");
                                                  //OpenSeed.datasync(userid);
                                                 //Scripts.load_Card();
                                                  //OpenSeed.retrieve_data(userid);
                                                //  settingsPage.state = "Active";
                                                //  slideshow.state = "Active";
                                               //  firstrun.state = "close";
                              }}}
                                }

                         }

                         DropShadow {
                             anchors.fill:connectB
                             horizontalOffset: 0
                             verticalOffset: 4
                             radius: 8.0
                             samples: 17
                             color: "#80000000"
                             source:connectB
                             z:1
                         }

                  }}


                        Item {
                            visible: if(type == 4) {true} else {false}
                            width: parent.width
                            height: parent.height * 0.8


                             TextField{
                               id:usernameField
                               text:username
                               placeholderText: "Name"
                               width:parent.width * 0.95
                               anchors.horizontalCenter: parent.horizontalCenter
                               anchors.top: parent.top
                               onTextChanged: username = text
                             }

                             Text {
                                 anchors.left: about.left
                                 anchors.bottom: about.top
                                 text:qsTr("About:")
                             }
                             Rectangle {
                                 anchors.centerIn: about
                                 width:about.width
                                 height: about.height
                                 border.width: 1
                                 color:"white"
                                 border.color: "gray"
                             }

                             TextArea {
                                 id:about
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 anchors.top: usernameField.bottom
                                 anchors.topMargin: 20
                                 text:usermotto
                                 height: parent.height * 0.6
                                 width: parent.width * 0.95
                                 wrapMode: Text.WordWrap
                                 onTextChanged: usermotto = text

                             }

                        }


                        Item {
                            visible: if(type == 5) {true} else {false}
                            width: parent.width
                            height: parent.height * 0.8


                             TextField{
                                 id:job
                                 text:useralias
                                 placeholderText: "Job Title"
                                 width:parent.width * 0.95
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 anchors.top: parent.top
                                  onTextChanged: useralias = text
                             }

                             TextField{
                                 id:companyField
                                 text:usercompany
                                 placeholderText: "Company Name"
                                 width:parent.width * 0.95
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 anchors.top: job.bottom
                                 anchors.topMargin: 20
                                  onTextChanged: usercompany = text
                             }

                             Text {
                                 font.pixelSize: 24
                                 text:qsTr("Category: ")
                                 anchors.right:parent.right
                                 anchors.rightMargin: catbutton.width * 1.1
                                 anchors.top: companyField.bottom
                                 anchors.topMargin: 20

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
                                     text: if(currentcat.length < 2) {qsTr("Select Category")} else {currentcat}
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

                        }



                        Item {
                            visible: if(type == 6) {true} else {false}
                            width: parent.width
                            height: parent.height * 0.1


                            TextField{
                                id:phoneField
                                text:userphone
                                inputMethodHints: Qt.ImhDialableCharactersOnly
                                placeholderText: "Phone Number"
                                width:parent.width * 0.95
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                 onTextChanged: userphone = text
                            }

                            TextField{
                                id:emailField
                                text:useremail
                                placeholderText: "Email Address"
                                width:parent.width * 0.95
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: phoneField.bottom
                                anchors.topMargin: 20
                                onTextChanged: useremail = text
                            }

                        }

                        Item {
                            visible: if(type == 7) {true} else {false}
                            width: parent.width
                            height: parent.height * 0.1


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
                                        text:if(website1.search("twitter") == -1){"Twitter not connected"} else {website1.split("::")[1]}
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

                            MouseArea {
                                anchors.fill: parent
                                onClicked: sConnect.state = "Active",sConnect.service = "twitter", sConnect.type = "intergration"
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
                                       text:if(website2.search("tumblr") == -1){"Tumblr not connected"} else {website2.split("::")[1]}
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

                           MouseArea {
                               anchors.fill: parent
                               onClicked: sConnect.state = "Active",sConnect.service = "tumblr", sConnect.type = "intergration"
                           }

                            }



                            Item {
                                id:soundcloudButton
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top:tumblrButton.bottom
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
                                       text:if(website4.search("soundcloud") == -1){"SoundCloud not connected"} else {website4.split("::")[1]}
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
                           MouseArea {
                               anchors.fill: parent
                               onClicked: sConnect.state = "Active",sConnect.service = "soundcloud", sConnect.type = "intergration"
                           }

                            }


                        }

                      /*  Item {
                            visible: if(type == 8) {true} else {false}
                            width: parent.width
                            height: parent.height

                            SourceSelection {
                                width: parent.width
                                height: parent.height
                                state:"InActive"
                            }


                        } */

                        Item {
                            visible: if(type == 9) {true} else {false}
                            width:parent.width
                            height: parent.height * 0.1
                           // anchors.bottom: parent.bottom

                            Rectangle {

                                width: parent.width * 0.3
                                height: parent.height * 0.98
                                anchors.centerIn: parent
                                color:highLightColor1

                                Text {
                                    anchors.centerIn:parent
                                    text:qsTr("Finish")
                                    font.pixelSize: 24
                                    color:"black"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                                    usercat = currentcat;
                                                Scripts.save_card(userid,usernameField.text.replace(/'/g," "),phoneField.text,emailField.text,companyField.text,job.text,about.text," ",
                                                                 website1,website2,website3,website4,0,0,0," "," ",usercat);
                                                OpenSeed.upload_data(userid,usernameField.text.replace(/'/g," "),phoneField.text,emailField.text,companyField.text,
                                                             job.text,about.text,0,0,0," ",website1,website2,website3,website4,
                                                             " "," ",usercat);
                                                    currentcat = "All Cards";
                                                    thisWindow.state = "InActive"
                                                 }
                                }
                            }



                        }


                        }



                        Image {
                            id: logo
                            source:image
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.margins: 10
                            width: 64
                            height: 64
                        }

            }

            DropShadow {
                anchors.fill:dialogue1
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: "#80000000"
                source:dialogue1
                z:1
            }

        }






        model: slides


    }




    ListModel {
            id:slides
        ListElement {
            thetitle: qsTr("Welcome")
            message:  qsTr("CafeSync is a location based card sharing service. That connects you to the world around you")
            type:1
            image:"./img/overlay-dark.png"
        }
        ListElement {
            thetitle: qsTr("EULA")
            message:qsTr("We haven't written one yet. It will be pretty bog standard though. No hacking,cracking, or pretending to be someone else. So on and So forth")
            type:2
            image:"./img/OpenSeed.png"
        }
        ListElement {
            thetitle: qsTr("OpenSeed Connect")
            message:qsTr("OpenSeed's network is used for app and user authentication as well as the background services that CafeSync relies on.\n\n(Note: If you don't have an account the system will create one for you.) ")
            type:3
            image:"./img/OpenSeed.png"
        }
        ListElement {
            thetitle: qsTr("Your Card")
            message:  qsTr("Now that you're connected to OpenSeed's network we'll need to setup your CafeSync card.\n\n We'll get the easy stuff out of the way here, but it will be up to you to finish your profile.")
            type:1
            image:"./img/overlay-dark.png"
        }

        ListElement {
            thetitle: qsTr("Who?")
            message:qsTr("Who Are you?")
            type:4
            image:"./img/contact.svg"
        }

        ListElement {
            thetitle: qsTr("What?")
            message:qsTr("What do you do?")
            type:5
            image:"./img/overlay-dark.png"
        }

        ListElement {
            thetitle: qsTr("How?")
            message:qsTr("How Can others contact you?")
            type:6
            image:"./img/email.svg"
        }

        ListElement {
            thetitle: qsTr("Online")
            message:qsTr("To make your card shine consider connecting to one or more of these services")
            type:7
            image:"./img/stock_website.svg"
        }

       /* ListElement {
            thetitle: qsTr("Say Cheese!")
            message:qsTr("A picture is worth a thousand words. How do you want the world to know you.\n Take a picture or choose from a list of compatable services on the nex page!")
            type:1
            image:"./img/stock_website.svg"
        }

        ListElement {
            thetitle: qsTr("Show Time")
            message:""
            type:8
            image:"./img/camera-photo.svg"
        } */

        ListElement {
            thetitle: qsTr("Congratulations!")
            message:  qsTr("We're all set. Tapping finish will close this dialog and let you start using the network. \n Note: Due to our commitment to your privacy your card is set to private.\
 Change this by hitting the center bottom button.")
            type:9
            image:"./img/overlay-dark.png"
        }


    }



/*

Item {

                        width:parent.cellWidth
                        height:parent.cellHeight

                        id: slide

                     Rectangle {

                            anchors.centerIn: parent
                            width: parent.width * 0.95
                            height: parent.height * 0.8
                            id:dialogue1

                        color:cardcolor
                        clip: true

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: parent.height * 0.80
                            spacing: 20
                        Text {
                            text: thetitle
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 48

                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: 3
                            color: highLightColor1
                        }

                        Text {
                            width:parent.width * 0.9
                            wrapMode: Text.WordWrap
                            text: qsTr("CafeSync is a location based card sharing service. That connects you to the world around you")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18

                        }


                        }

                        Image {
                            id: logo
                            source: "./img/overlay-dark.png"
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.margins: 10
                            width: 64
                            height: 64
                        }

            }

            DropShadow {
                anchors.fill:dialogue1
                horizontalOffset: 0
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: "#80000000"
                source:dialogue1
                z:1
            }



}





    Item {
        x:0
       // y:0
        //anchors.fill:parent
        width:parent.width
        height:parent.height
       // anchors.top:topBar.bottom
        id: openseedLogin
       // anchors.margins: 50


        states: [
            State {
                name: "InActive"
                PropertyChanges {
                    target: openseedLogin
                    x:parent.width

                }
            },
            State {
                name: "Active"
                PropertyChanges {
                    target: openseedLogin
                    x:0

                }
            }

        ]
        state: "InActive"




        Rectangle {
                    //anchors.fill:parent
                    //anchors.margins: 100
                  //  x: parent.width * 0.1
                   // y: parent.height * 0.1
                    anchors.centerIn: parent
                    width: parent.width * 0.95
                    height: parent.height * 0.8
                   // radius: 6
                  //  border.width:1
                   // border.color:"black"
                    color:cardcolor
                    clip: true

                     id: dialogue2


                     Image {

                         anchors.horizontalCenter: parent.horizontalCenter
                         anchors.top:parent.top
                         anchors.topMargin: parent.height * 0.1
                         source:"img/OpenSeed.png"
                         fillMode: Image.PreserveAspectFit
                         //height:parent.height * 0.14
                         width:parent.width * 0.5
                     }

                     Text {
                     id:diaTitle
                     anchors.top:logo.bottom
                     anchors.horizontalCenter:parent.horizontalCenter
                     anchors.topMargin: 5
                     text: qsTr("Connect to OpenSeed")
                     horizontalAlignment: Text.AlignHCenter
                     color:"black"
                        }
                     Text {

                     id:diaSubTitle
                     anchors.top:diaTitle.bottom
                     anchors.topMargin: 5
                     anchors.horizontalCenter: parent.horizontalCenter
                     width:parent.width - 10
                     text: qsTr("CafeSync uses the Openseed network for app and user authentication.")
                     wrapMode:Text.Wrap
                     horizontalAlignment: Text.AlignHCenter
                     color:"black"
                        }


                    TextField{
                         id:osUsernameField
                         anchors.top:diaSubTitle.bottom
                         anchors.topMargin:10
                         anchors.horizontalCenter: parent.horizontalCenter
                         width:parent.width - 10
                         placeholderText: qsTr("User Name")
                         horizontalAlignment: Text.AlignHCenter
                         text:osUsername
                         onTextChanged: uniquename = 0, osUsername = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                     }

                    TextField{
                        id:osEmailField
                        anchors.top:osUsernameField.bottom
                        anchors.topMargin:10
                         anchors.horizontalCenter: parent.horizontalCenter
                         width:parent.width - 10
                        placeholderText: qsTr("Email")
                       horizontalAlignment: Text.AlignHCenter
                        text:osEmail
                        onTextChanged:uniquename = 0,osEmail = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                    }

                     TextField{
                         id:osPassField
                         anchors.top:osEmailField.bottom
                         anchors.topMargin:10
                          anchors.horizontalCenter: parent.horizontalCenter
                          width:parent.width - 10
                         placeholderText: qsTr("Passphrase")
                         horizontalAlignment: Text.AlignHCenter
                         echoMode: TextInput.Password
                         text:osPassphrase
                         onTextChanged:uniquename = 0,osPassphrase = text,OpenSeed.checkcreds(osUsername,osPassphrase);

                     }



                    /* Text {
                                text:switch(uniquename) {
                                     case 0:qsTr("In Use");break;
                                     case 1:qsTr("Available");break;
                                     case 2:if(osUsername.length > 2) {qsTr("Welcome Back")} else {qsTr("No User Name")};break;
                                     default:qsTr("No User Name");break;
                                     }
                                color:switch(uniquename) {
                                      case 0:"Red";break;
                                      case 1:"Black";break;
                                      case 2:"Black";break;
                                      default:"white";break;
                                      }

                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 24
                                anchors.top:osPassField.bottom

                            }


                 }

        DropShadow {
            anchors.fill:dialogue2
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:dialogue2
            z:1
        }

    }*/




    Rectangle {
        id:bottomBar
        anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height * 0.08
        color:bottombarColor

  /*  Row {
        spacing: 10
        anchors.bottom:parent.bottom
        anchors.bottomMargin:10
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            text: qsTr("Cancel")
            onClicked: firstrun.state = "close",Qt.quit();
        }

     Button {
         text: qsTr("Okay")
         //color: highLightColor1
         onClicked:
             { if(osEmail.length > 2) {
                if(osUsername.length > 2) {
                     console.log("sending info to server");
                     OpenSeed.oseed_auth(osUsernameField.text,osEmailField.text,osPassField.text);

                             //OpenSeed.datasync(userid);
                            //Scripts.load_Card();
                             //OpenSeed.retrieve_data(userid);
                             settingsPage.state = "Active";
                             slideshow.state = "Active";
                            firstrun.state = "close";
         }}}

     }

    } */

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

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.11
        spacing: 10
    Repeater {
            model:slideview.count
            id:pageIndicator
            Rectangle {
                       width: 10
                       height: 10
                       border.width: 1
                       border.color:barColor
                       color: if(index == slideview.indexAt(slideview.contentX,0)) {highLightColor1} else {Qt.rgba(9,9,9,0);}
                       radius:width /2




                        MouseArea {
                            anchors.fill:parent
                            onClicked: ms.positionViewAtIndex(index,GridView.Center)
                        }
                   }

            }
    }

}
