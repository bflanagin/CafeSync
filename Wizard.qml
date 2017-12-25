import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
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


    property int uniquemail: 0
    property int uniquename: 0
    property int uniqueaccount:0
    property int uniqueid:0


    Timer {
        id:checkname
        running:false
        repeat:false
        interval: 1000
        onTriggered: OpenSeed.checkcreds("username",osUsername.trim());

    }

    Timer {
        id:checkemail
        running:false
        repeat:false
        interval: 1000
        onTriggered: OpenSeed.checkcreds("email",osEmail.trim());


    }

    Timer {
        id:checkpassword
        running:false
        repeat:false
        interval: 1000
        onTriggered: OpenSeed.checkcreds("passphrase",osUsername+","+osEmail+","+osPassphrase);

    }

    Timer {
        id:checkexists
        running:false
        repeat:false
        interval: 1000
        onTriggered: if(osUsername.length > 1 && osEmail.length > 1) {OpenSeed.checkcreds("account",osUsername+","+osEmail);}
    }


    Timer {
        id:populate
        running:false
        repeat:true
        interval: 300
        onTriggered:if(userid != "") {OpenSeed.datasync(userid,0);populate.stop();}
    }

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
                            text:if(slideview.indexAt(slideview.contentX,0) == 1) {
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
                            font.pixelSize: parent.height * 0.08

                        }

                        Rectangle {
                           //  visible: if(type != 8) {true} else {false}
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: parent.height * 0.01
                            color: seperatorColor1
                        }

                        Text {
                           //  visible: if(type != 8) {true} else {false}
                            width:parent.width * 0.9
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            text:message
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: parent.height * 0.04

                        }

                        Rectangle {
                           //  visible: if(type != 8) {true} else {false}
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.9
                            height: parent.height * 0.01
                            color: seperatorColor1
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
                                font.pixelSize: parent.height * 0.08
                                wrapMode: Text.WordWrap
                                onVisibleChanged: slideview.interactive = true
                            }

                        Item {
                            anchors.fill: parent
                            visible: if(userid == "") {true} else {false}

                            Text {
                                id:loginmessage
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top:parent.top
                                text:if(uniqueaccount ==1 ) {
                                                if(uniqueid == 1 ) {
                                                        qsTr("Welcome Back")
                                                        } else {
                                                            qsTr("Welcome Back - Please enter password")
                                                }
                                        } else if(uniquename == 0 ) {qsTr("New User")} else {"User name in use"}

                            }

                        TextField{
                             id:osUsernameField
                             anchors.top:parent.top
                             anchors.topMargin:thisWindow.height * 0.05
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.85
                             placeholderText: qsTr("User Name")
                             horizontalAlignment: Text.AlignHCenter
                             text:osUsername
                             onTextChanged:osUsername = text,checkname.restart(),checkexists.restart()

                             Rectangle {
                                 visible:if(uniquename == 1) {true} else {false}
                                 anchors.right:parent.right
                                 anchors.rightMargin: 10
                                 anchors.verticalCenter: parent.verticalCenter
                                 width:parent.height * 0.8
                                 height:parent.height * 0.8
                                 color:Qt.rgba(0,0,0,0.1)
                                 radius: width /2

                                 Image {

                                     anchors.centerIn: parent
                                     width:parent.width * 0.7
                                     height:parent.height * 0.7
                                     source:if(uniqueaccount == 1) {"./img/check.svg"} else{"./img/close.svg"}
                                 }


                             }

                         }

                        TextField{
                            id:osEmailField
                            anchors.top:osUsernameField.bottom
                            anchors.topMargin:thisWindow.height * 0.03
                             anchors.horizontalCenter: parent.horizontalCenter
                             width:parent.width * 0.85
                            placeholderText: qsTr("Email")
                           horizontalAlignment: Text.AlignHCenter
                            text:osEmail
                           onTextChanged: osEmail = text,checkemail.restart(),checkexists.restart()

                            Rectangle {
                                visible:if(uniquemail != 0) {true} else {false}
                                anchors.right:parent.right
                                anchors.rightMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                width:parent.height * 0.8
                                height:parent.height * 0.8
                                color:Qt.rgba(0,0,0,0.1)
                                radius: width /2

                                Image {
                                    anchors.centerIn: parent
                                    width:parent.width * 0.7
                                    height:parent.height * 0.7
                                    source:if(uniqueaccount == 1) {"./img/check.svg"} else{"./img/close.svg"}
                                }


                            }

                        }

                         TextField{
                             id:osPassField
                             anchors.top:osEmailField.bottom
                            anchors.topMargin:thisWindow.height * 0.03
                              anchors.horizontalCenter: parent.horizontalCenter
                              width:parent.width * 0.85
                             placeholderText: qsTr("Passphrase")
                             horizontalAlignment: Text.AlignHCenter
                             echoMode: TextInput.Password
                             text:osPassphrase
                              onTextChanged:osPassphrase = text,checkpassword.restart()

                             Rectangle {
                                  visible:if(uniqueaccount == 1) {true} else {false}
                                 anchors.right:parent.right
                                 anchors.rightMargin: 10
                                 anchors.verticalCenter: parent.verticalCenter
                                 width:parent.height * 0.8
                                 height:parent.height * 0.8
                                 color:Qt.rgba(0,0,0,0.1)
                                 radius: width /2

                                 Image {
                                     anchors.centerIn: parent
                                     width:parent.width * 0.7
                                     height:parent.height * 0.7
                                     source:if(uniqueid == 1) {"./img/check.svg"} else {"./img/close.svg"}
                                 }


                             }


                         }

                         Rectangle {
                             id:connectB
                             anchors.top: osPassField.bottom
                             anchors.horizontalCenter: parent.horizontalCenter
                             anchors.topMargin: thisWindow.height * 0.03
                             width: parent.width * 0.45
                             height: thisWindow.height * 0.08
                             color:highLightColor1
                             radius:4

                              Text {
                                  id:cb
                                  anchors.centerIn: parent
                                  text:qsTr("Connect")
                                  color:"black"
                                  font.pixelSize: parent.height * 0.45
                              }

                              MouseArea {
                                  anchors.fill: parent

                              onClicked:
                                  { if(osEmail.length > 2) {
                                     if(osUsername.length > 2) {
                                         if(osPassphrase.length > 2) {
                                        //  console.log("sending info to server");
                                          OpenSeed.oseed_auth(osUsernameField.text,osEmailField.text,osPassField.text);
                                                    cb.text = qsTr("Loading");
                                                        if(uniqueid == 1) {
                                                        populate.start();
                                                        }
                                                 //Scripts.load_Card();
                                                  //OpenSeed.retrieve_data(userid);
                                                //  settingsPage.state = "Active";
                                                //  slideshow.state = "Active";
                                               //  firstrun.state = "close";
                              }} }}
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
                                 color:"gray"
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
                                 anchors.topMargin: thisWindow.height * 0.03
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
                                 anchors.topMargin: thisWindow.height * 0.03
                                   onTextChanged: usercompany = text
                             }

                             Text {
                                 font.pixelSize: parent.height * 0.06
                                 text:qsTr("Category: ")
                                 anchors.right:parent.right
                                 anchors.rightMargin: catbutton.width * 1.1
                                 anchors.top: companyField.bottom
                                 anchors.topMargin: thisWindow.height * 0.03

                                Rectangle {
                                       id:catbutton
                                    width:if(cardindex == 0) {10*usercat.length + catText.width}
                                    height:parent.height * 1.2

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
                                     font.pixelSize:parent.height * 0.4
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
                                anchors.topMargin: thisWindow.height * 0.03
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
                                anchors.topMargin: thisWindow.height * 0.03
                                width:parent.width * 0.95
                                height:thisWindow.height * 0.09

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
                               anchors.topMargin: thisWindow.height * 0.03
                               width:parent.width * 0.95
                               height:thisWindow.height * 0.09

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
                                anchors.topMargin: thisWindow.height * 0.03
                                width:parent.width * 0.95
                                height:thisWindow.height * 0.09


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
                                    font.pixelSize: parent.height * 0.4
                                    color:"black"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                                    usercat = currentcat;
                                                Scripts.save_card(userid,username.replace(/'/g," "),userphone,useremail,usercompany,useralias,usermotto+";::;;::;;::;"," ",
                                                                 website1,website2,website3,website4,0,0,0," "," ",usercat);
                                                OpenSeed.upload_data(userid,username.replace(/'/g," "),userphone,useremail,usercompany,
                                                             useralias,usermotto+";::;;::;;::;",0,0,0," ",website1,website2,website3,website4,
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
                            anchors.margins: thisWindow.height * 0.01
                            width: thisWindow.height * 0.1
                            height: thisWindow.height * 0.1
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
            message:  qsTr("CafeSync is a location-based card sharing service. That connects you to the world around you")
            type:1
            image:"./img/overlay-dark.png"
        }
       /* ListElement {
            thetitle: qsTr("EULA")
            message:qsTr("We haven't written one yet. It will be pretty bog standard though. No hacking,cracking, or pretending to be someone else. So on and So forth")
            type:2
            image:"./img/OpenSeed.png"
        }*/
        ListElement {
            thetitle: qsTr("OpenSeed Connect")
            message:qsTr("OpenSeed's network is used for app and user authentication, as well as the background services that CafeSync relies on.\n(Note: If you don't have an account the system will create one for you.) ")
            type:3
            image:"./img/OpenSeed.png"
        }
        ListElement {
            thetitle: qsTr("Your Card")
            message:  qsTr("Now that you're connected to OpenSeed's network, we'll need to setup your CafeSync card.\n\n We'll get the easy stuff out of the way here, but it will be up to you to finish your profile.")
            type:1
            image:"./img/overlay-dark.png"
        }

        ListElement {
            thetitle: qsTr("Who?")
            message:qsTr("Who are you?")
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
            message:qsTr("How can others contact you?")
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
            message:  qsTr("We're all set. Tapping \"finish\" will close this dialog and let you start using the network. \n Note: Because of our commitment to your privacy, your card is set to private.\
 \n .Change this by hitting the center bottom button on the main screen or check the \"share card\" check-box in settings under \"Your Card\"")
            type:9
            image:"./img/overlay-dark.png"
        }


    }







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
         //color: seperatorColor1
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
                       width: mainView.height * 0.01
                       height: mainView.height * 0.01
                       border.width: 1
                       border.color:seperatorColor1
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
