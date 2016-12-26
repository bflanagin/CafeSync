import QtQuick 2.3
import QtQuick.Window 2.2


import "main.js" as Scripts
import "facebook.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string fburl:""
    property string pagesource: ""
    property string extrathing: ""
    property  string avatar: ""
    property string banner: ""
    property string message: ""
    property string profilename: ""
    property string stats:""
    property string pluginlogo: "img/fb.png"
    property int personal: 0

    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(fburl)}

    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              visible:false
          }
        }
    ]

    anchors.centerIn: parent


    Image {
        id:bg
        anchors.centerIn: parent
        //source:pagesource
        source:banner
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
    }
    Image {
        id:subpic
        anchors.left:parent.left
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.leftMargin:10
        source:pluginlogo
        fillMode:Image.PreserveAspectFit
        width:parent.height * 0.15
        height:parent.height * 0.15
        z:1

    }

    Image {
        id:pic
        //anchors.left:parent.left
        //anchors.top: parent.top

        source:avatar
        fillMode:Image.PreserveAspectFit
        anchors.fill:subpic
        z:1
    }
    Text {
        id:name
        anchors.left:pic.right
        anchors.top:pic.top
        text:profilename
        color:"white"
        font.pixelSize: pic.height * 0.60 -text.length
        width:parent.width - pic.width
        wrapMode: Text.WordWrap
    }

    Rectangle {
        //anchors.fill:parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:name.bottom
        width:parent.width * 0.98
        height:parent.height * 0.85 - name.height
        radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.7)
        border.width:1
        z:0
        clip:true

        Text {
            id:statsarea
            anchors.top:parent.top
                anchors.right:parent.right
                anchors.margins: 10
                horizontalAlignment: Text.AlignRight
                font.pixelSize: parent.height / 23
                text:stats
                color:"white"
    }

        Text {
            //y:if(personal == 1) {pic.height} else {pic.height * 1.5}
            anchors.top:statsarea.bottom
            anchors.left:parent.left
            anchors.margins: 10
            width:parent.width - 10
            text:message
            wrapMode: Text.WordWrap
            font.pixelSize: parent.height / 20
            color:"white"
        }

        Text {
            anchors.bottom:parent.bottom
            anchors.right:parent.right
            text:if(personal == 1) {i18n.tr("This is a personal page. Detailed information is restricted.")} else {""}
            color:"white"
            wrapMode: Text.WordWrap
            font.pixelSize: parent.width * 0.03
        }
    }

    Rectangle {
        //y:if(bg.status == Image.Ready) {parent.height} else {0}
        id:blinder
        width:parent.width
        height:parent.height
        color:"white"
        radius:10
        border.color:"black"
        z:2

        states: [
                State {
                     name:"loading"
                    PropertyChanges {
                     target:blinder
                        y:0
                    }
            },
                State {
                    name:"loaded"

                    PropertyChanges {
                   target:blinder
                    y:if (personal == 1) {parent.height} else {parent.height * 0.90}
                    radius:0
                    }
                    //when: bg.status == Image.Ready
            }

        ]
        state:"loading"

       transitions: Transition {
            PropertyAnimation { target: blinder
                                      properties:"y,radius"; duration: 500 }
        }

       Item {
           id:links

          // x:binder.x
           //y:binder.y
           width:parent.width * 0.98
           height: parent.height * 0.98
           clip:true
           opacity: 0

         /*  Text {
               anchors.left:servicelogo.right
                anchors.bottom:servicelogo.bottom
                font.pixelSize: servicelogo.height * 0.6
                font.capitalization: Font.AllUppercase
                font.underline: true
               text:fburl.split("/")[3]

               MouseArea {
                   anchors.fill:parent
                    onClicked: showurl = page,fullWeb.state = "show",cardPage.header.hide()
               }
           } */

           Row {
               anchors.top:parent.top
               //anchors.left:parent.left
               anchors.horizontalCenter: parent.horizontalCenter
               anchors.margins:10
               spacing:10

               Item {
                   width:links.width * 0.30
                    height:links.height * 0.08

                    Rectangle {
                        anchors.fill:parent
                        color:"lightgray"
                        opacity:0.4
                    }

                    Flasher {
                        //anchors.fill:parent
                        id:eventflasher
                    }


                    Text {
                        //anchors.leftMargin: 10
                           //anchors.left:parent.right
                           anchors.centerIn: parent
                            text:i18n.tr("Events")
                            //anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: parent.height * 0.30

                        }

                   MouseArea {
                       anchors.fill:parent
                       onPressed:eventflasher.state = "Active"
                       onClicked: {

                           if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                           showurl = page+extrathing+"events"
                           fullWeb.state = "show"
                           cardPage.header.hide()
                       }
                       onReleased:eventflasher.state = "InActive"
                   }
               }

               Item {
                   width:links.width * 0.30
                    height:links.height * 0.08
                    Flasher {
                        id:aboutflasher
                    }


                    Text {
                        //anchors.leftMargin: 10
                           //anchors.left:parent.right
                           anchors.centerIn: parent
                            text:i18n.tr("About")
                            //anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: parent.height * 0.30

                        }

                   MouseArea {
                       anchors.fill:parent
                       onPressed:aboutflasher.state = "Active"
                       onReleased:aboutflasher.state = "InActive"
                       onClicked: {

                           if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                           showurl = page+extrathing+"info/?tab=overview"
                           fullWeb.state = "show"
                           cardPage.header.hide()
                       }
                   }
               }

               Item {
                   width:links.width * 0.30
                    height:links.height * 0.08

                    Rectangle {
                        anchors.fill:parent
                        color:"lightgray"
                        opacity:0.4
                    }
                    Flasher {
                        id:photoflasher
                    }


                    Text {
                        //anchors.leftMargin: 10
                           //anchors.left:parent.right
                            anchors.centerIn: parent
                            text:i18n.tr("Photos")
                            //anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: parent.height * 0.30
                        }

                   MouseArea {
                       anchors.fill:parent
                       onPressed:photoflasher.state = "Active"
                       onReleased:photoflasher.state = "InActive"
                       onClicked: {

                           if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                           showurl = page+extrathing+"photos"
                           fullWeb.state = "show"
                           cardPage.header.hide()
                       }
                   }
               }

           }


       }

    }




    Image {
        id:logo
        anchors.centerIn: parent
        source:pluginlogo
        width:parent.width /3
        height:parent.height /3
        fillMode:Image.PreserveAspectFit
        z:2
        states: [
            State {  name:"Loading"
                PropertyChanges {
                    target:logo
                    opacity:1

            }
                PropertyChanges {
                    target:links
                    opacity:0
                }
            },
            State { name:"Loaded"
                PropertyChanges {
                   target:logo
                   opacity:0
                }
                PropertyChanges {
                    target:links
                    opacity:1
                }

                //when:bg.status == Image.Ready
            }

        ]
        state:"loading"

        transitions: Transition {
             PropertyAnimation { target: logo
                                       properties:"opacity"; duration: 300 }
         }
    }



}




