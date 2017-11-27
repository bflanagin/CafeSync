import QtQuick 2.3
import QtQuick.Window 2.2
//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3


import "main.js" as Scripts
import "slides.js" as Slides


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string maintitle:""

    clip: true

    onStateChanged: if(popup.state == "Active") {Slides.aboutslides(qsTr);} else {slidelist.clear();}

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

    Rectangle {
        anchors.fill:parent
        color:"white"
        //radius:6
        //border.width:1
       // border.color:"black"


    }

    GridView {
    id:ftext

    property string list:""
    //property string pindex:pageindex
    anchors.fill:parent

    z:0
    //width: parent.width * 0.25//- units.gu(.4)
   // height: parent.height //- units.gu(4.8)
    snapMode: GridView.SnapOneRow
    //flow: GridView.FlowLeftToRight
    flow:GridView.FlowTopToBottom
    boundsBehavior: Flickable.DragAndOvershootBounds
    flickableDirection: Flickable.VerticalFlick
    //highlightFollowsCurrentItem: true
    visible: true
    //cellHeight: units.gu(26)
    clip:true
    //enabled:false
    //enabled:if(selection == 2) {true} else {false}

    cellHeight:parent.height //passerbyGrid.height
    cellWidth: popup.width

    delegate: Item {

            //anchors.fill:parent
               width:popup.width
               height:popup.height
               clip:true
            Column {
                    width:parent.width
                    height:parent.height
                    spacing:20
                    Text {
                            id:title
                            text:ftitle
                            font.pixelSize: parent.height * 0.075
                            anchors.horizontalCenter: parent.horizontalCenter
                            //anchors.verticalCenter: parent.verticalCenter
                            //anchors.horizontalCenterOffset: parent.width * (0.01*fHoffset)
                           // anchors.verticalCenterOffset: parent.height * (0.01*fVoffset)

                style: Text.Outline; styleColor: "#FFFFFF"


            }

                    Image {
                        id:picture
                        source:pic
                        fillMode:Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        width:popup.width * 0.8
                        height:popup.height * 0.4


                    }






                    Text {
                            id:discript
                            text:disc
                            font.pixelSize: parent.height * 0.025
                            anchors.leftMargin:10
                            anchors.left:parent.left
                            wrapMode:Text.WordWrap
                            width:parent.width - 10

                style: Text.Outline; styleColor: "#FFFFFF"


            }

            }

            Text {
                    id:slidenum
                    text:qsTr("Pages:")+slidnum +"/"+ftext.count
                    font.pixelSize: parent.height * 0.025
                    anchors.bottom:parent.bottom
                    anchors.right:parent.right
                    anchors.rightMargin: 10

        style: Text.Outline; styleColor: "#FFFFFF"


    }


        }

    model:
        ListModel {
          id:slidelist
        }

   }

    Rectangle {
        anchors.bottom:parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin:90
       // border.color:"black"
       // border.width:1
        color:Qt.rgba(1,1,1,0)
        width:parent.width * 0.34
        height:parent.height * 0.08

        Flasher {
            id:closeflash
        }

 Text {
     id:btext
     font.pixelSize: parent.width * 0.08
     anchors.centerIn: parent
     text:qsTr("close")

 }
 MouseArea {
     anchors.fill:parent
     onPressed:closeflash.state = "Active"
    onReleased:closeflash.state = "InActive"
    onClicked:popup.state = "InActive"
 }
    }

}




