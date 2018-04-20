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
    id:thisWindow

    states: [
        State {
            name: "Active"
            PropertyChanges {
                target:thisWindow

                x:0


            }
        },
        State {
             name: "InActive"
             PropertyChanges {
                 target:thisWindow

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

    Rectangle {
        color:backgroundColor
       // color: "white"
        //y:listthing.height
        width:parent.width
        height:parent.height
        //border.width: 1
    }

    Flickable {
        id:infoFlick
       // anchors.top:nameBack.bottom
        flickableDirection:Flickable.VerticalFlick
        anchors.topMargin:10
        width:parent.width * 0.98
        height:parent.height
        contentWidth: parent.width
        contentHeight: statColumn.height+ thisWindow.height * 0.01
        clip:true


Column {
id:statColumn
width: parent.width * 0.98
anchors.horizontalCenter: parent.horizontalCenter
spacing: mainView.width * 0.02

Text {
    font.pixelSize: mainView.width * 0.1
    text: qsTr("Achievements")
    anchors.horizontalCenter: parent.horizontalCenter
}


Item {
    width: parent.width
    height: statsbox.height
    Rectangle {
        id:statsbox
        width:parent.width * 0.98
        height:statscontent.height + mainView.width * 0.04

        anchors.horizontalCenter: parent.horizontalCenter

        color:cardcolor

        Column {
            id:statscontent
            width:parent.width* 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: mainView.width * 0.04
            anchors.centerIn: parent

            Text{

                anchors.left:parent.left
                text:qsTr("CafeSync:")
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

                CircleStat {
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
                }

                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22

                    whichStat:qsTr("Card")
                    statNumber:"A"
                    statRank:101
                }

                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22

                    whichStat:qsTr("Picture")
                    statNumber:"0"
                    statRank:0
                }
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

Item {
    width: parent.width
    height: osstatsbox.height
    Rectangle {
        id:osstatsbox
        width:parent.width * 0.98
        height:osstatscontent.height + mainView.width * 0.04

        anchors.horizontalCenter: parent.horizontalCenter

        color:cardcolor

        Column {
            id:osstatscontent
            width:parent.width* 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: mainView.width * 0.04
            anchors.centerIn: parent

            Text{
                anchors.left:parent.left
                text:qsTr("OpenSeed:")
            }
            Rectangle {
                     anchors.horizontalCenter: parent.horizontalCenter
                     width:parent.width * 0.98
                     height:3
                     color:seperatorColor1
                 }

            Grid {
                id:osstatRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: mainView.width * 0.01
                width:parent.width * 0.98
                clip:true

                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22

                    whichStat:qsTr("Early Adopter")
                    statNumber:"A"
                    statRank:101
                }

                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22
                    whichStat:qsTr("CafeSync")
                    statNumber:"A"
                    statRank:101
                }
                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22
                    whichStat:qsTr("HelioGraph")
                    statNumber:"0"
                    statRank:0
                }
                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22

                    whichStat:qsTr("Code Breakers")
                    statNumber:"0"
                    statRank:0
                }

                CircleStat {
                    width:mainView.width * 0.22
                    height:mainView.width * 0.22

                    whichStat:qsTr("Patreon")
                    statNumber:"0"
                    statRank:0
                }

              /*  CircleStat {
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
           anchors.fill: osstatsbox
           horizontalOffset: 0
           verticalOffset: 4
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: osstatsbox

       }

}



}

    }

}
