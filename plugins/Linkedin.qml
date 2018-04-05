import QtQuick 2.3
import QtQuick.Window 2.2


import "../main.js" as Scripts
import "linkedin.js" as Site


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string pagesource:""
    property string service:""
    property string extrathing:""
    property string sitedata:""
    property string pluginlogo:"../img/linkedin.png"

    property string avatar: ""
    property string name: ""
    property string banner: ""
    property string stats: ""
    property string message: ""
    property string posttitle:""
    property string post:""
    property string postimage:""
    property string link: ""

    property string info1: ""
    property string info2: ""
    property string info3: ""
    property string info4: ""
    property string info5: ""


    clip: true

    onStateChanged: if(popup.state == "Active") {Site.get_html(service),Site.get_articles(service);}


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
        source:banner
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
    }

    /*Rectangle {
        anchors.fill:parent
        radius:10
        color:Qt.rgba(0.5,0.5,0.5,0.6)
        border.width:1
    }*/

    Image {
        id:shade
        anchors.centerIn: parent
        source:"../img/shade.png"
        anchors.fill: parent
        //fillMode:Image.PreserveAspectCrop
    }

    GridView {
        id: articles
        //x: units.gu(12)
        //y: units.gu(4.5)
        //anchors.top:pCount.bottom
        anchors.centerIn: parent

        width: parent.width * 0.90//- units.gu(.4)
        height: parent.height * 0.90 //- units.gu(4.8)
        snapMode: GridView.SnapOneRow
        flow: GridView.FlowLeftToRight
        boundsBehavior: Flickable.DragAndOvershootBounds
        flickableDirection: Flickable.VerticalFlick
        visible: true
        //cellHeight: units.gu(26)
        //clip:true


        delegate: Item {
                    width:articles.width  * 0.98
                    height:articles.height * 0.50
                    clip:true


            Rectangle {
                anchors.fill:parent
                color:"darkgray"
                radius:10
                border.color:"lightgray"
                border.width:5
            }

            Image {
                source:articleimg
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: -10

                width:parent.width * 0.90
                //height:parent.height * 0.60
                fillMode:Image.PreserveAspectFit
                id:articleimage

            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:articleimage.bottom
                color:"white"
                text:title
                font.pixelSize: parent.width * 0.05
                width:parent.width
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }



            MouseArea {
                anchors.fill:parent
                onPressed:wrflasher.state = "Active"
               /* onClicked: {

                    showurl = link
                    fullWeb.state = "show"
                    cardPage.header.hide()
                } */
                onClicked:Qt.openUrlExternally(link);

                onReleased:wrflasher.state = "InActive"
            }

        }


        cellHeight: height * 0.50
        cellWidth: width



        model: ListModel {
                id: articlelist


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

        states: [
                State {
                     name:"loading"
                    PropertyChanges {
                     target:blinder
                        y:0
                    }
                    PropertyChanges {
                        target:links
                        opacity:0
                    }
            },
                State {
                    name:"loaded"

                    PropertyChanges {
                   target:blinder
                    y:parent.height * 0.90
                   opacity: 0.8
                    radius:0
                    }

                    PropertyChanges {
                        target:links
                        opacity:1
                    }

                    when: bg.status == Image.Ready
            },
            State {
                 name:"view"
                PropertyChanges {
                 target:blinder
                    y:0
                }
                PropertyChanges {
                    target:links
                    opacity:1
                }
        }

        ]
        state:"loading"

       transitions: Transition {
            PropertyAnimation { target: blinder
                                      properties:"y,radius"; duration: 500 }
        }

    Item {
        id:links
        height:parent.height
        width:parent.width
        opacity:0

        Image {
            id:servicelogo
            source:pluginlogo
            width:parent.width * 0.10
            height:parent.height * 0.10
            fillMode:Image.PreserveAspectFit

        }
        Text {
            anchors.left:servicelogo.right
            anchors.verticalCenter:servicelogo.verticalCenter
            font.underline: true
            font.pixelSize: servicelogo.height * 0.3
            text:name

            MouseArea {
                anchors.fill: parent
                onClicked:if(blinder.state != "view") {blinder.state = "view" } else {blinder.state = "loaded"}
            }
        }
        Text {
            anchors.right:parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: servicelogo.verticalCenter
            font.pixelSize: servicelogo.height * 0.3
            text:stats
        }
        Flickable {
            anchors.top:servicelogo.bottom
            width:parent.width
            height:parent.height - servicelogo.height
            contentHeight: infocolumn.height
            flickableDirection: Flickable.VerticalFlick
            clip:true
        Column {
            width:parent.width * 0.90
            //anchors.top:servicelogo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            //height:parent.height
            //height:info4area.y+info4area.height

            //anchors.margins:20
            spacing:10
            id:infocolumn
            clip:true

            Item {
                width:links.width * 0.98 - infocolumn.x
                 //height:links.height * 0.08
                    height:info1area.height * 1.5
                   // anchors.fill: parent
                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                     //opacity:0.4


                 Text {
                        id:info1area
                        //anchors.leftMargin: 10
                        //anchors.left:parent.right
                         text:info1
                         anchors.verticalCenter: parent.verticalCenter
                         horizontalAlignment: Text.AlignHCenter
                         font.pixelSize: parent.width * 0.025
                         wrapMode:Text.WordWrap
                         width:parent.width * 0.98


                     }
                 }

                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                   /* onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    } */
                    onClicked:Qt.openUrlExternally(page);

                    onReleased:wrflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.98 - infocolumn.x
                 //height:links.height * 0.08
                    height:info2area.height * 1.05
                   // anchors.fill: parent
                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                    opacity:0.4


                 Text {
                        id:info2area
                        anchors.leftMargin: 10
                        anchors.left:parent.left
                         text:info2
                         //anchors.verticalCenter: parent.verticalCenter
                         //horizontalAlignment: Text.AlignHCenter
                         font.pixelSize: parent.width * 0.025
                         wrapMode:Text.WordWrap
                         width:parent.width * 0.98

                     }
                 }

                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    /*onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    } */
                    onClicked:Qt.openUrlExternally(page);

                    onReleased:wrflasher.state = "InActive"
                }
            }



            Item {
                width:links.width * 0.98 - infocolumn.x
                 //height:links.height * 0.08
                    height:info3area.height * 1.05
                   // anchors.fill: parent
                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                     opacity:0.4


                 Text {
                        id:info3area
                        anchors.leftMargin: 10
                        anchors.left:parent.left
                         text:info3
                         //anchors.verticalCenter: parent.verticalCenter
                         //horizontalAlignment: Text.AlignHCenter
                         font.pixelSize: parent.width * 0.025
                         wrapMode:Text.WordWrap
                         width:parent.width * 0.98

                     }
                 }

                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    }
                    onReleased:wrflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.98 - infocolumn.x
                 //height:links.height * 0.08
                    height:info4area.height * 1.05
                   // anchors.fill: parent
                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                     opacity:0.4


                 Text {
                        id:info4area
                        anchors.leftMargin: 10
                        anchors.left:parent.left
                         text:info4
                         //anchors.verticalCenter: parent.verticalCenter
                         //horizontalAlignment: Text.AlignHCenter
                         font.pixelSize: parent.width * 0.025
                         wrapMode:Text.WordWrap
                         width:parent.width * 0.98

                     }
                 }

                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    /*onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    } */
                    onClicked:Qt.openUrlExternally(page);
                    onReleased:wrflasher.state = "InActive"
                }
            }

            Item {
                width:links.width * 0.98 - infocolumn.x
                 //height:links.height * 0.08
                    height:info5area.height * 1.05
                   // anchors.fill: parent
                 Rectangle {
                     anchors.fill:parent
                     color:"lightgray"
                     opacity:0.4


                 Text {
                        id:info5area
                        anchors.leftMargin: 10
                        anchors.left:parent.left
                         text:info5
                         //anchors.verticalCenter: parent.verticalCenter
                         //horizontalAlignment: Text.AlignHCenter
                         font.pixelSize: parent.width * 0.025
                         wrapMode:Text.WordWrap
                         width:parent.width * 0.98

                     }
                 }

                MouseArea {
                    anchors.fill:parent
                    onPressed:wrflasher.state = "Active"
                    /*onClicked: {

                        if(page.substr(page.length-1,page.length) == "/"){extrathing =""} else {extrathing="/"}
                        showurl = page+extrathing+"chat"
                        fullWeb.state = "show"
                        cardPage.header.hide()
                    } */
                    onClicked:Qt.openUrlExternally(page);
                    onReleased:wrflasher.state = "InActive"
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

                         when:bg.status == Image.Ready
                     }

                 ]
                 state:"loading"

                 transitions: Transition {
                      PropertyAnimation { target: logo
                                                properties:"opacity"; duration: 300 }
                  }

                 Rectangle {anchors.centerIn: loading_info
                             width:loading_info.width * 1.2
                             height:loading_info.height *1.5
                             color:Qt.rgba(0.4,0.4,0.4,0.5)
                             radius: width /2
                             opacity: logo.opacity
                             z:2
                 }
                 Text {
                     id:loading_info
                     anchors.top:logo.bottom
                     horizontalAlignment: Text.AlignHCenter
                     anchors.horizontalCenter: parent.horizontalCenter
                     text:"The Service is:"+service
                     width:parent.width * 0.8
                     wrapMode: Text.WordWrap
                     z:3
                     color:"white"

                     opacity:logo.opacity
                 }


    }

}




