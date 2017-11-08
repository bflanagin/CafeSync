import QtQuick 2.0
import QtQuick.Controls 1.3

Item {

    id:cardbackList

    states: [
            State {
                name:"show"
                PropertyChanges {
                    target:cardbackList
                    visible:true
                }
                },
                State {
                    name:"hide"
                    PropertyChanges {
                        target:cardbackList
                        visible:false
                    }
                }

    ]

    state:"hide"



    Rectangle {
        width:parent.width
        height:parent.height
        color:"white"
        border.color:"black"
        border.width:2
        radius:5
    }

    Text {
        id:title
        anchors.top:parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    text: "Select Card Back."
    font.pixelSize: parent.width * 0.1

    }
     Text {
         id:subtitle
         anchors.top:title.bottom
         anchors.horizontalCenter: parent.horizontalCenter
     text: "Scroll up or down to select card back."

     }
     GridView {
         id: backGrid
        anchors.top:subtitle.bottom
        anchors.topMargin:10
        anchors.horizontalCenter: parent.horizontalCenter
         width: parent.width * 0.9
         height: backGrid.width / 1.75
         snapMode: GridView.SnapToRow
         flow: GridView.FlowLeftToRight
         boundsBehavior: Flickable.DragAndOvershootBounds
         flickableDirection: Flickable.VerticalFlick
         visible: true
         clip:true


         delegate:
             Rectangle {
                    width: parent.width
                    height:backGrid.width / 1.75
                    //color: colorCode
                    radius: 0
                    border.color: "black"
                    border.width: 1

                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        anchors.fill:parent
                        source:img

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                 cardbImg = img

                                cardbackList.state = "hide"

                            }
                        }
                    }
                                                     }
         cellHeight: backGrid.width / 1.75 //passerbyGrid.height
         cellWidth: backGrid.width

         model: ListModel {
                 id: backmodel

                 ListElement {
                     img:"img/default_card.png"

                 }

                 ListElement {
                     img:"img/art-default.png"
                 }
                 ListElement {
                     img:"img/music-default.png"
                 }
                 ListElement {
                     img:"img/theatre-default.png"
                 }
                 ListElement {
                     img:"img/business-default.png"
                 }
                 ListElement {
                     img:"img/communication-default.png"
                 }
                 ListElement {
                     img:"img/author-default.png"
                 }
         }



     }

     Text {
         anchors.top:backGrid.bottom
         anchors.topMargin:10
         anchors.horizontalCenter: parent.horizontalCenter
         //text: "Use your own?"
         text:'<a href="http://www.vagueentertainment.com/applications/cafesync/?page_id=30">Use your own?</a>'
         onLinkActivated: Qt.openUrlExternally("http://www.vagueentertainment.com/applications/cafesync/?page_id=30")
     }

     Button {
        // anchors.left:parent.left
         anchors.bottom:parent.bottom
         anchors.horizontalCenter: parent.horizontalCenter
         width:parent.width * 0.9
         height:parent.height * 0.05
         anchors.margins:10
         text: "Cancel"
         onClicked: cardbackList.state = "hide"
     }

 }





