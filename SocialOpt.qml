import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0



Item {
                property string sourceselected: ""

                           // id:twitterButton
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: if(type != 0) {true} else {false}

                        Rectangle {
                            id:twb
                            anchors.fill: parent
                            color:bgcolor
                            radius:5
                            border.color: "white"


                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.98
                                height:parent.height
                                clip:true
                                spacing: 10
                                Image {
                                    source:serviceLogo
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
                                    text:source
                                   color:if(bgcolor == cardcolor) {"black"} else {"white"}
                                    //color:"black"
                                    width:parent.width * 0.89
                                    font.pixelSize: parent.height * 0.3
                                    wrapMode: Text.WordWrap
                                    clip:true
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
                           //z:1



                             }


                         }


