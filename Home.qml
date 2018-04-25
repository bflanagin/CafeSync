import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
//import QtQuick.Controls.Styles 1.3
import QtGraphicalEffects 1.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed
import "requests.js" as Requests
import "microblogger.js" as MicroBlog


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string cardStatus: "No recent status updates"

   // property string backgroundColor:Qt.rgba(0.98,0.98,0.98,1)

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
            border.color: cardcolor
            border.width:1
            radius: 4
        }

        Component.onCompleted: MicroBlog.latest_log_remote("othercard",cardId)




    Flickable {
        id:infoFlick
       // anchors.top:nameBack.bottom
        flickableDirection:Flickable.VerticalFlick
        anchors.topMargin:10
        width:parent.width * 0.98
        height:parent.height
        contentWidth: parent.width
        contentHeight: homeinfo.height+ popup.height * 0.01
        clip:true

        Column {
            id:homeinfo
            anchors.horizontalCenter: parent.horizontalCenter
            width:popup.width * 0.98
           // height:parent.height * 1.2
            spacing:mainView.height * 0.02

            Item {
                width:parent.width
                height:mainView.height * 0.01
            }


            Item {
                id:generalInfo
                anchors.left:parent.left
                height:nameBack.height
                width:parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id:nameBack
                   // anchors.left:parent.left
                   // anchors.top:parent.top
                  //  anchors.topMargin: parent.height * 0.02

                    //color:"white"
                    color:cardcolor
                    //border.color:"black"
                    //radius: units.gu(1)
                    //anchors.fill: parent
                    anchors.centerIn: parent
                    width:parent.width * 0.98
                    height:actions.height + info.height + mainView.width * 0.06
                    //clip:true
                    visible: false

                    Row {
                        x:5
                        y:0
                        width:parent.width
                        height:parent.height

                        CirclePic {
                            id:img
                            width:if(avatarimg.length > 5 && cardsop == 1) {nameBack.height * 0.70} else {nameBack.height * 0.01}
                            height:if(avatarimg.length > 5 && cardsop == 1) {nameBack.height * 0.70} else {nameBack.height * 0.01}
                            thesource:avatarimg

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
                                color:""+spColor
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
                                anchors.rightMargin: parent.width * 0.01
                            }
                            Text {
                                id:email
                                x:10
                                font.pixelSize: (nameBack.width  - cardusername.length * 1.5) * 0.03
                                text:carduseremail
                                anchors.right:parent.right
                                anchors.rightMargin: parent.width * 0.01
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

                Rectangle {
                         anchors.bottom:actions.top
                         anchors.bottomMargin: parent.width * 0.02
                         anchors.horizontalCenter: parent.horizontalCenter
                         width:parent.width * 0.98
                         height:3
                         color:seperatorColor1
                     }

                Actions {
                    id:actions
                    anchors.horizontalCenter: nameBack.horizontalCenter
                    anchors.bottom:nameBack.bottom
                    anchors.bottomMargin: parent.width * 0.02
                    width:nameBack.width
                    height:mainView.width * 0.1
                    carduserName:cardusername
                    companyName:companyname
                    menu:0
                }



            }


            Item {
                width:parent.width
                height:mainView.height * 0.01
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:statuscontent.height + mainView.width * 0.04
                //visible: if(cstatus.length > 2) {true} else {false}

                Rectangle {
                    id:statusbox
                    width:parent.width * 0.98
                    height:parent.height * 0.98
                    anchors.centerIn: parent
                    color:cardcolor
                    visible: if(cardStatus == "") {false} else {true}

                    Column {
                        id:statuscontent
                        width:parent.width* 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: mainView.width * 0.04

                        Text{
                            anchors.left:parent.left
                            padding:parent.width * 0.02
                            text:qsTr("Status Update:")
                        }
                        Rectangle {
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 width:parent.width * 0.98
                                 height:3
                                 color:seperatorColor1
                             }

                        Item {
                            width:parent.width
                            height: if( cardusername != username) {statusText.height} else {statusField.height}
                        Text {
                            id:statusText
                            visible: if( cardusername != username) {true} else {false}
                            anchors.centerIn: parent
                            width:parent.width
                            padding: parent.width * 0.03
                            wrapMode: Text.WordWrap
                            text: cardStatus
                        }

                        TextField {
                            id:statusField
                            visible: if( cardusername == username) {true} else {false}
                            width:parent.width
                            padding:width * 0.05
                            wrapMode: Text.WordWrap
                            maximumLength: 244
                           // text:MicroBlog.latest_log("mycard",cardId)
                            placeholderText: "Update your Status"
                            background: InputBack{}
                            //enabled: false

                            Image {
                                visible: if(statusField.text.length > 1) {true} else {false}
                                anchors.right:parent.right
                                anchors.rightMargin: mainView.width * 0.02
                                anchors.verticalCenter: parent.verticalCenter
                                width: mainView.width * 0.06
                                height:mainView.width * 0.06
                                source: "./icons/check.svg"

                                Flasher {

                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked:{MicroBlog.send_log(usercardNum,statusField.text);
                                                statusField.text = "";
                                                statusField.focus = false;
                                                }
                                }
                            }
                                }
                             }

                       }

                    }

                DropShadow {
                       anchors.fill: statusbox
                       horizontalOffset: 0
                       verticalOffset: 4
                       radius: 8.0
                       samples: 17
                       color: "#80000000"
                       source: statusbox

                   }
            }

            Item {
                width:parent.width
                height:mainView.height * 0.01
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:aboutcontent.height + aboutcontent.y
                visible: if(cardusername !=username && motto.length > 2) {true} else {false}

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
                                color:seperatorColor1
                            }

                    Text {
                            id:aboutcontent
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:parent.width - 10
                            wrapMode: Text.WordWrap
                             text:"<p>"+motto.replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")+"</p>"
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

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:content.height + popup.height * 0.01
                visible: if(cardusername !=username && skillstats.count > 0) {true} else {false}
                    property string dataMine: ""+skills

                    onDataMineChanged: Scripts.formatResume("skill",dataMine);
                 Rectangle {
                     id:skillsbox
                     width:parent.width * 0.98
                     height:parent.height * 0.98
                     anchors.centerIn: parent
                     color:cardcolor

                 Column {
                     id:content
                     anchors.top:parent.top
                     width:parent.width
                     //height:parent.height *0.98
                     spacing:popup.height * 0.01

                        Text {

                             anchors.left:parent.left
                             anchors.margins:10
                             width:parent.width - 10
                             wrapMode: Text.WordWrap
                             text:qsTr("Skills:")
                             font.pixelSize: 24
                        }

                       Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.98
                                height:3
                                color:seperatorColor1
                            }

                       ListView {
                           width:parent.width
                           spacing: popup.height * 0.01
                            height:contentHeight

                           model:ListModel {
                               id:skillstats
                           }


                           delegate: Item {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width:parent.width * 0.98
                                    height:itemcontent.height + 10

                               Rectangle{ anchors.fill: parent
                                   color:"gray"
                                   opacity: if(index %2 == 0) {0.00} else {0.03}

                                    }

                                    Column {
                                        id:itemcontent
                                        anchors.centerIn: parent
                                        width:parent.width * 0.98
                                        spacing: popup.height * 0.01

                                        Text {
                                            font.pixelSize: popup.height * 0.035
                                            text:name.substring(1,name.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                            width:parent.width

                                            Text {
                                                anchors.bottom:parent.bottom
                                                anchors.right:parent.right
                                                anchors.rightMargin: popup.height * 0.01
                                                font.pixelSize: popup.height * 0.02
                                                text:"Years of Experience: "+yoe.substring(1,yoe.length-1)
                                            }
                                        }

                                        Rectangle {
                                                 anchors.horizontalCenter: parent.horizontalCenter
                                                 width:parent.width * 0.98
                                                 height:3
                                                 color:seperatorColor1
                                             }

                                        Text {
                                            anchors.left:parent.left
                                            anchors.leftMargin: popup.height * 0.02
                                            width:parent.width * 0.95
                                            wrapMode: Text.WordWrap
                                            text:"<p>"+discription.substring(1,discription.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")+"</p>"
                                        }
                                    }
                                }
                       }



                    }

                 }

                 DropShadow {
                        anchors.fill: skillsbox
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: skillsbox

                    }
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:scontent.height + popup.height * 0.01
                visible: if(cardusername !=username && schoolstats.count > 0) {true} else {false}

                property string dataMine: ""+school

                onDataMineChanged: Scripts.formatResume("school",dataMine);

                 Rectangle {
                     id:schoolbox
                     width:parent.width * 0.98
                     height:parent.height * 0.98
                     anchors.centerIn: parent
                     color:cardcolor

                 Column {
                     id:scontent
                     anchors.top:parent.top
                     width:parent.width

                     spacing:popup.height * 0.01

                        Text {

                             anchors.left:parent.left
                             anchors.margins:10
                             width:parent.width - 10
                             wrapMode: Text.WordWrap
                             text:qsTr("Education:")
                             font.pixelSize: 24
                        }

                       Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.98
                                height:3
                                color:seperatorColor1
                            }

                       ListView {
                           width:parent.width
                           spacing: popup.height * 0.01
                            height:contentHeight

                           model:ListModel {
                               id:schoolstats
                           }


                           delegate: Item {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width:parent.width * 0.98
                                    height:schoolcontent.height + 10

                               Rectangle{ anchors.fill: parent
                                   color:"gray"
                                   opacity: if(index %2 == 0) {0.00} else {0.03}

                                    }

                                    Column {
                                        id:schoolcontent
                                        anchors.centerIn: parent
                                        width:parent.width * 0.98
                                        spacing: popup.height * 0.01

                                        Text {
                                            font.pixelSize: popup.height * 0.035
                                            text:name.substring(1,name.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")

                                            width:parent.width

                                            Text {
                                                anchors.bottom:parent.bottom
                                                anchors.right:parent.right
                                                anchors.rightMargin: popup.height * 0.01
                                                font.pixelSize: popup.height * 0.02
                                                text:"Degree: "+expdate.substring(1,expdate.length-1)
                                            }
                                        }

                                        Rectangle {
                                                 anchors.horizontalCenter: parent.horizontalCenter
                                                 width:parent.width * 0.98
                                                 height:3
                                                 color:seperatorColor1
                                             }

                                        Text {
                                            anchors.left:parent.left
                                            anchors.leftMargin: popup.height * 0.02
                                            width:parent.width * 0.95
                                            wrapMode: Text.WordWrap
                                            text:"<p>"+discription.substring(1,discription.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")+"</p>"
                                        }
                                    }
                                }
                       }


                    }

                 }

                 DropShadow {
                        anchors.fill: schoolbox
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: schoolbox

                    }
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:wcontent.height + popup.height * 0.01
                visible: if(cardusername !=username && workstats.count > 0) {true} else {false}
                clip:true

                property string dataMine: ""+work

                onDataMineChanged: Scripts.formatResume("work",dataMine);

                 Rectangle {
                     id:workbox
                     width:parent.width * 0.98
                     height:parent.height * 0.98
                     anchors.centerIn: parent
                     color:cardcolor

                     Column {
                         id:wcontent
                         anchors.top:parent.top
                         width:parent.width

                         spacing:popup.height * 0.01

                            Text {

                                 anchors.left:parent.left
                                 anchors.margins:10
                                 width:parent.width - 10
                                 wrapMode: Text.WordWrap
                                 text:qsTr("Work:")
                                 font.pixelSize: 24
                            }

                           Rectangle {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width:parent.width * 0.98
                                    height:3
                                    color:seperatorColor1
                                }

                           ListView {
                               width:parent.width
                               spacing: popup.height * 0.01
                                height:contentHeight

                               model:ListModel {
                                   id:workstats
                               }


                               delegate: Item {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        width:parent.width * 0.98
                                        height:workcontent.height + 10

                                   Rectangle{ anchors.fill: parent
                                       color:"gray"
                                       opacity: if(index %2 == 0) {0.00} else {0.03}

                                        }

                                        Column {
                                            id:workcontent
                                            anchors.centerIn: parent
                                            width:parent.width * 0.98
                                            spacing: popup.height * 0.01

                                            Text {
                                                font.pixelSize: popup.height * 0.035
                                                text:name.substring(1,name.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")
                                                width:parent.width

                                                Text {
                                                    anchors.bottom:parent.bottom
                                                    anchors.right:parent.right
                                                    anchors.rightMargin: popup.height * 0.01
                                                    font.pixelSize: popup.height * 0.02
                                                    text:"Years at Job: "+yoe.substring(1,yoe.length-1)
                                                }
                                            }

                                            Rectangle {
                                                     anchors.horizontalCenter: parent.horizontalCenter
                                                     width:parent.width * 0.98
                                                     height:3
                                                     color:seperatorColor1
                                                 }

                                            Text {
                                                anchors.left:parent.left
                                                anchors.leftMargin: popup.height * 0.02
                                                width:parent.width * 0.95
                                                wrapMode: Text.WordWrap
                                                text:"<p>"+discription.substring(1,discription.length-1).replace(/;#x2c;/g,",").replace(/;#x2b;/g,"+")+"</p>"
                                            }
                                        }
                                    }
                           }


                        }

                 }

                 DropShadow {
                        anchors.fill: workbox
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        source: workbox

                    }
            }


            // This is where YOUR stuff goes //

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                height:statscontent.height  + mainView.width * 0.04 // + eventbox.height
                visible: if( cardusername == username) {true} else {false}

              /*  Rectangle {
                    id:eventbox
                    width:parent.width * 0.98
                    height:eventcontent.height + mainView.width * 0.04
                    //anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    color:cardcolor

                    Column {
                        id:eventcontent
                        width:parent.width* 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: mainView.width * 0.04

                        Text{
                            anchors.left:parent.left
                            text:qsTr("Events:")
                        }
                        Rectangle {
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 width:parent.width * 0.98
                                 height:3
                                 color:seperatorColor1
                             }

                        ListView {
                            id:events
                            width:parent.width
                            height:(mainView.width * 0.11) * model
                            spacing: mainView.width * 0.02
                            model: 0
                            boundsBehavior:Flickable.StopAtBounds

                            delegate: Item {
                                width:parent.width
                                height:mainView.width * 0.1
                                    Rectangle {
                                        anchors.fill: parent
                                        color:if(index % 2 == 0) {cardcolor} else {backgroundColor}
                                    }

                                Row {
                                    anchors.fill: parent
                                    spacing: mainView.width * 0.03
                                    Image {
                                        height:parent.height * 0.9
                                        width:parent.height * 0.9
                                        anchors.verticalCenter: parent.verticalCenter
                                        fillMode: Image.PreserveAspectFit
                                        source:"./icons/calendar-today.svg"
                                    }
                                    Rectangle {
                                             width:parent.width * 0.007
                                             height:parent.height
                                             color:seperatorColor1
                                             anchors.verticalCenter: parent.verticalCenter
                                         }
                                    Text {
                                        text:qsTr("Your thing you should do today")
                                        horizontalAlignment: Text.AlignLeft
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: console.log(index)
                                }
                            }

                        }
                    }
                }

                DropShadow {
                       anchors.fill: eventbox
                       horizontalOffset: 0
                       verticalOffset: 4
                       radius: 8.0
                       samples: 17
                       color: "#80000000"
                       source: eventbox

                   } */

                Rectangle {
                    id:statsbox
                    width:parent.width * 0.98
                    height:statscontent.height + mainView.width * 0.04
                  //  anchors.top:eventbox.bottom
                  //  anchors.topMargin:mainView.width * 0.04
                    anchors.horizontalCenter: parent.horizontalCenter

                    color:cardcolor

                    Column {
                        id:statscontent
                        width:parent.width* 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: mainView.width * 0.04

                        Text{
                            anchors.left:parent.left
                            text:qsTr("Achievements:")
                        }
                        Rectangle {
                                 anchors.horizontalCenter: parent.horizontalCenter
                                 width:parent.width * 0.98
                                 height:3
                                 color:seperatorColor1
                             }

                        Grid {
                            id:statRow
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: mainView.width * 0.01
                            width:parent.width * 0.98
                            clip:true

                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22

                                whichStat:qsTr("Collected")
                                statNumber:ptotal
                                statRank:0
                            }

                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22
                                whichStat:qsTr("Contacts")
                                statNumber:ctotal
                                statRank:0
                            }
                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22
                                whichStat:qsTr("Impact")
                                statNumber:Scripts.load_Stat("Impact")
                                statRank:0
                            }
                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22

                                whichStat:qsTr("2-Way")
                                statNumber:Scripts.load_Stat("2-Way")
                                statRank:0
                            }

                          /*  CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22

                                whichStat:qsTr("Blog Read")
                                statNumber:"0"
                                statRank:0
                            }

                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22

                                whichStat:qsTr("Events")
                                statNumber:"0"
                                statRank:0
                            }

                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22

                                whichStat:qsTr("Personal Log")
                                statNumber:"0"
                                statRank:0
                            }

                            CircleStat {
                                width:mainView.width * 0.22
                                height:mainView.width * 0.22

                                whichStat:qsTr("Replies")
                                statNumber:"0"
                                statRank:0
                            } */
                        }


                       }

                    }

                DropShadow {
                       anchors.fill: statsbox
                       horizontalOffset: 0
                       verticalOffset: 4
                       radius: 8.0
                       samples: 17
                       color: "#80000000"
                       source: statsbox

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



}





