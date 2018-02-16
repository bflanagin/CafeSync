import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.LocalStorage 2.0
import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
                property string sourceselected: ""

                property string account: ""

                           // id:twitterButton
                        //    anchors.horizontalCenter: parent.horizontalCenter
                            visible: if(type == 1) {true} else {false}



                        Rectangle {
                            id:twb
                          //  anchors.fill: parent
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: parent.height
                            width: parent.width * 0.98
                           // color:bgcolor
                            radius:5
                            border.color: "white"
                            visible: false


                            Column {
                                //anchors.horizontalCenter: parent.horizontalCenter
                                anchors.centerIn: parent
                                width:parent.width * 0.90
                                height:parent.height * 0.60
                                clip:true
                                spacing: parent.width * 0.06
                               // visible: if(preview == false) {true} else {false}
                                Image {
                                    source:serviceLogo
                                    height:parent.height * 0.8
                                    width:parent.height * 0.8
                                    anchors.horizontalCenter: parent.horizontalCenter

                                }

                                Rectangle {
                                    height:3
                                    color:"white"
                                    width:parent.width * 0.9
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text:source
                                   ///color:if(bgcolor == cardcolor) {"black"} else {"white"}
                                    color:"black"
                                    width:parent.width
                                    horizontalAlignment:Text.AlignHCenter
                                    font.pixelSize: parent.width * 0.055
                                    wrapMode: Text.WordWrap
                                }


                            }

                             Item {
                                 //anchors.horizontalCenter: parent.horizontalCenter
                                 width:parent.width * 0.8
                                 height:parent.width * 0.8
                                 visible: preview
                                anchors.centerIn: parent
                                 anchors.top:parent.top

                                          Image {
                                                  id:photo1
                                                  //anchors.fill:parent
                                                  width:parent.width * 0.3
                                                  height:parent.width * 0.3

                                              fillMode: Image.PreserveAspectFit
                                             source: if(avatar == "" ) {
                                                         if(theserviceLogo == "") {
                                                             if(useraccount.length > 2){Scripts.socialsetup(useraccount.split("::")[0]).split("::")[2]} else if(currentservice.length > 2) {Scripts.socialsetup(currentservice).split("::")[2]} else {"./img/stock_website.svg"}
                                                         } else {theserviceLogo}
                                                     } else {avatar}

                                                 visible: false


                                             }



                                     /* Image {
                                          id:mask1
                                          anchors.fill:parent
                                          source:"/graphics/CafeSync.png"
                                         visible: false

                                      } */

                                     OpacityMask {
                                             id:opmask1
                                             anchors.centerIn: photo1
                                              anchors.fill: photo1
                                              source: photo1
                                              maskSource: mask

                                          }

                                         DropShadow {
                                          anchors.fill:opmask1
                                          horizontalOffset: 2
                                         verticalOffset: 4
                                         radius: 8.0
                                         samples: 17
                                         color: "#80000000"
                                      source:opmask1

                                  }

                                         Image {
                                             width:32
                                             height:32
                                             anchors.right:parent.right
                                             anchors.bottom:parent.bottom
                                             //anchors.bottomMargin: parent.width * 0.2
                                             source:if(avatar != ""){if(useraccount.length > 2) {Scripts.socialsetup(useraccount.split("::")[0]).split("::")[2]} else {
                                                                                                     Scripts.socialsetup(currentservice).split("::")[2]}
                                                    } else {""}
                                         }

                                         Text {
                                             id:pname
                                             anchors.left:opmask1.right
                                             anchors.top:opmask1.top
                                             font.pixelSize: opmask1.height * 0.5 - text.length
                                             width:parent.width - opmask1.width
                                             text:if(profilename == "") {if(currentservice != ""){qsTr("Searching")} else {qsTr("Select Service")} } else {profilename}
                                             wrapMode: Text.WordWrap
                                         }

                                         Text {
                                             anchors.left:pname.left
                                             anchors.top:pname.bottom
                                             anchors.margins: parent.height * 0.1
                                             font.pixelSize: opmask1.height * 0.16
                                             text:if(info == "") {"Please wait...."} else {info}
                                             width:settingsPage.width * 0.7
                                             height:opmask1.height * 0.80
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


