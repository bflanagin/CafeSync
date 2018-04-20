import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtSensors 5.9
import QtQuick.LocalStorage 2.0 as Sql


import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
    property int selectedAsspect: 90
    property string thesource:""
    property string thefile:""
    property int selectedEffect:0
    property int isPrivate: 0
    property int capturedAsspect:0
    property int setFlash:0
    property int setExpos:4
    property int setFocus: 0

    property string theComment:""

    id:thisWindow
    states: [

        State {
            name:"Active"

            PropertyChanges {
                target: thisWindow
                y:0
            }
    },

        State {
            name:"InActive"
            PropertyChanges {
                target: thisWindow
                y:height * -1
            }

    }

    ]


     transitions: [
         Transition {
             from: "InActive"
             to: "Active"
             reversible: true


             NumberAnimation {
                 target: thisWindow
                 property: "y"
                 duration: 200
                 easing.type: Easing.InOutQuad
             }
         }
     ]


     onStateChanged: if(thisWindow.state == "Active"){Scripts.listimages()} else {camera.stop()}

     MouseArea {
         anchors.fill: parent
         onClicked: console.log("")
     }



    Rectangle {
        anchors.fill: parent
        color:backgroundColor
    }



    Column {

            width:parent.width
            height:parent.height
            spacing:parent.height * 0.020

       /* GetPic {
               id:photo
               //anchors.centerIn: center
                width:parent.width
                height:parent.height * 0.5
               state:"Show"
            } */

        Item {
            id:photo
            width:parent.width
            height:parent.height * 0.5

            Rectangle {
                anchors.centerIn: photoframe
                radius: width /2
                color:Qt.rgba(0.8,0.8,0.8,0.1)
                border.width:10
                border.color: highLightColor1

                width:parent.width * 0.8
                height:parent.width * 0.8

            }

            Item {
                id:photoframe
                width:parent.width * 0.6
                height:parent.width * 0.6
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
               // anchors.centerIn: parent



                Image {
                    id:current
                    anchors.horizontalCenter:parent.horizontalCenter

                    anchors.top:parent.top
                    anchors.topMargin: parent.height * 0.00

                    width:if(parent.width > parent.height) {parent.width * 0.80} else {parent.width}
                    height:if(parent.width > parent.height) {parent.height} else {parent.width * 0.99}

                    fillMode: Image.PreserveAspectCrop
                    source:if(avimg ==""){"./img/default_avatar.png" }else { if(avimg.search("/9j/4A") != -1) {"data:image/jpeg;base64, "+avimg.replace(/ /g, "+")} else {avimg} }
                   // visible: if(camera.cameraState == 1) {true} else {false}

                }

            VideoOutput {
                    id:viewport
                    source: camera
                    //anchors.fill: parent
                    //anchors.centerIn: parent
                    anchors.horizontalCenter:parent.horizontalCenter
                   // anchors.horizontalCenterOffset: if(parent.width > parent.height) {-parent.width * 0.1} else {0}
                    anchors.top:parent.top
                    anchors.topMargin: parent.height * 0.00
                    //width:parent.width * 0.8
                    //height:parent.height * 0.8
                    width:if(parent.width > parent.height) {parent.width * 0.80} else {parent.width}
                    height:if(parent.width > parent.height) {parent.height} else {parent.width * 0.99}

                    autoOrientation : true


                    fillMode: Image.PreserveAspectCrop
                    focus : true // to receive focus and capture key events when visible

                }




            Image {
                id:check
                anchors.fill:viewport
                fillMode: Image.PreserveAspectCrop

                //visible: if(Image.Ready == 1) {true}
            }


            }

          /*  Image {
                id:mask
                anchors.fill:parent
                source:"/graphics/CafeSync.png"
                visible: false

            } */

            OpacityMask {
                id:opmask
                 anchors.fill: photoframe
                 source: photoframe
                 maskSource: mask

             }

            DropShadow {
                anchors.fill:opmask
                horizontalOffset: 2
                verticalOffset: 4
                radius: 8.0
                samples: 17
                color: "#80000000"
                source:opmask
                z:1

            }

            Image {
                anchors.right:opmask.right
                anchors.bottom:opmask.bottom
                anchors.rightMargin: width * 0.4
                height:parent.height * 0.1
                width:parent.height * 0.1
                fillMode: Image.PreserveAspectFit
                source:if(avimg.search("twitter") != -1) {"./img/twitter.png"} else if (avimg.search("gravatar") != -1) {"./img/gravatar.png"} else if (avimg.search("soundcloud") != -1) {"./img/soundcloud.png"} else if (avimg.search("tumblr") != -1) {"./img/tumblr.png"} else {"./icons/camera-photo.svg"}
            }




            Item {
                id:camerabutton

                 anchors.top:photoframe.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width:if(mainView.width > mainView.height) {parent.width * 0.5}else {parent.height * 0.2}
                height:if(mainView.width > mainView.height){parent.width * 0.5} else {parent.height * 0.2}

                //color:highLightColor1
               // radius:width /2
               // border.color:"black"

                Image {
                     id:cameraicon
                    anchors.centerIn: parent
                    source:if(check.source =="" ) {"./icons/camera-photo.svg"} else {"./icons/reset.svg"}
                    width:parent.width * 0.8
                    height:parent.height * 0.8
                    fillMode:Image.PreserveAspectFit


                }

                ColorOverlay {
                    source:cameraicon
                    anchors.fill: cameraicon
                    color:overlayColor
                }

                Flasher {

                }

                MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                        if(camera.cameraState == 1) {
                                            check.source = "";
                                            camera.start();
                                        } else {
                                            if(check.source == "") {
                                    //capturedAsspect = selectedAsspect;
                                camera.imageCapture.captureToLocation(paths.split(",")[2].trim());
                                camera.imageCapture.capture();
                                            } else { check.source = "";}
                                        }
                            }
                        }
            }

            Item {
                id:savepicture

                anchors.bottom:camerabutton.bottom
                anchors.left:camerabutton.right
                anchors.leftMargin: parent.width * 0.04
                visible: if(check.source == "") {false} else {true}
                //anchors.horizontalCenter: parent.horizontalCenter
                width:if(mainView.width > mainView.height) {parent.width * 0.5}else {parent.height * 0.13}
                height:if(mainView.width > mainView.height){parent.width * 0.5} else {parent.height * 0.13}

               // color:highLightColor1
              // radius:width /2
              //  border.color:"black"

                Image {
                    id:checkbutton
                    anchors.centerIn: parent
                    width:parent.width * 0.6
                    height:parent.width * 0.6
                    source:"./icons/check.svg"


                }

                ColorOverlay {
                       anchors.fill: checkbutton
                       source: checkbutton
                       color: "green"
                   }

                Flasher {

                }



            MouseArea {
                anchors.fill:parent
                onClicked:{

                            if(camera.position == 2) {
                                //capturedAsspect = -90;
                            }
                            //console.log(comment.text);
                            fileio.store ="library,"+thefile+","+userid
                            Scripts.store_img("Library",fileio.store,isPrivate)
                            camera.stop();
                            avimg = "file://"+thefile;
                            Scripts.listimages();
                            thesource = ""
                            //comment.text = ""
                            //reload.running = true
                             check.source = ""
                           // if(heart == "Online") {OpenSeed.sendimage(userid,fileio.store,isPrivate)}
                           // window_container.state = "Hide"
                            }

            }

            }

            Item {
                id:cancelpicture

                anchors.bottom:camerabutton.bottom
                anchors.right:camerabutton.left
                anchors.rightMargin: parent.width * 0.04
                //anchors.horizontalCenter: parent.horizontalCenter
                width:if(mainView.width > mainView.height) {parent.width * 0.5}else {parent.height * 0.13}
                height:if(mainView.width > mainView.height){parent.width * 0.5} else {parent.height * 0.13}
                visible: if(check.source == "") {false} else {true}


               // color:highLightColor1
               // radius:width /2
               // border.color:"black"

                Image {
                    id:closebutton
                    anchors.centerIn: parent
                    width:parent.width * 0.6
                    height:parent.width * 0.6
                    source:"./icons/close.svg"
                }

                ColorOverlay {
                       anchors.fill: closebutton
                       source: closebutton
                       color: "red"
                   }

                Flasher {

                }

            MouseArea {
                anchors.fill:parent
                onClicked:{
                    check.source = "";
                    camera.stop(); }
                          /*  if(camera.position == 2) {
                                capturedAsspect = -90;
                            }
                            console.log(comment.text);
                            fileio.store ="library,"+thefile+","+id
                            Scripts.store_img("Library",fileio.store,selectedEffect+":;:"+capturedAsspect,isPrivate,theComment),
                            thesource = ""
                            comment.text = ""
                            reload.running = true
                            if(heart == "Online") {OpenSeed.sync_library()}
                            window_container.state = "Hide"
                            } */



            }

            }


            Column {

                anchors.left:photoframe.right
                anchors.leftMargin:if(mainView.width > mainView.height){-camerabutton.width / 2.5 } else {parent.height * 0.02}
                width:camerabutton.height * 0.8
                height: parent.height - camerabutton.y
                //y:if(mainView.width > mainView.height){camerabutton.height * 1.1 + camerabutton.y } else {camerabutton.y - width * 0.5}
                anchors.top:photoframe.top
                anchors.topMargin:photoframe.height * 0.2
                spacing:parent.height * 0.07


            Item {
                id:switchcamera
                //anchors.bottom:parent.bottom
                //anchors.bottomMargin: parent.height * 0.01
                width:parent.width
                height:parent.width

                //color:highLightColor1
                //radius:width /2
                //border.color:"black"

                Image {
                    id:cameratype
                    anchors.centerIn: parent
                    source:"./icons/camera-flip.svg"
                    width:parent.width * 0.6
                    height:parent.height * 0.6
                    fillMode:Image.PreserveAspectFit

                    ColorOverlay {
                        anchors.fill: parent
                        source:parent
                        color:overlayColor
                    }
                }

                Flasher {

                }

                MouseArea {
                            anchors.fill: parent;
                            onClicked:if(camera.position == Camera.FrontFace) {camera.position = Camera.BackFace;cameratype.source ="./img/camera-flip.svg"}
                                      else {camera.position = Camera.FrontFace;cameratype.source ="./img/camera-flip.svg"}
            }
            }



            }



            Column  {

                anchors.right:photoframe.left
                anchors.rightMargin:if(mainView.width > mainView.height){-camerabutton.width / 2.5 } else {parent.height * 0.02}
                width:camerabutton.height * 0.8
                height: parent.height - camerabutton.y
                anchors.top:photoframe.top
                anchors.topMargin: photoframe.height * 0.2
               // y:if(mainView.width > mainView.height){camerabutton.height * 1.1 + camerabutton.y } else {camerabutton.y - width * 0.5}
                spacing:parent.height * 0.07

                Item {
                    //id:switchcamera
                    //anchors.bottom:parent.bottom
                    //anchors.bottomMargin: parent.height * 0.01
                    width:parent.width
                    height:parent.width

                   // color:highLightColor1
                  //  radius:width /2
                  //  border.color:"black"

                    Image {
                        id:flashtype
                        anchors.centerIn: parent
                        source:"./icons/flash-auto.svg"
                        width:parent.width * 0.6
                        height:parent.height * 0.6
                        fillMode:Image.PreserveAspectFit

                        ColorOverlay {
                            anchors.fill: parent
                            source:parent
                            color:overlayColor
                        }
                    }

                    Flasher {

                    }

                    MouseArea {
                                anchors.fill: parent;
                                onClicked:switch(setFlash) {
                                          case 0: setFlash =1;flashtype.source = "./icons/flash-off.svg";break;
                                          case 1: setFlash = 2;flashtype.source = "./icons/flash-on.svg";break;
                                          case 2: setFlash = 0;flashtype.source = "./icons/flash-auto.svg";break;
                                          }
                }
                }




           /* Rectangle {
                //id:switchasspect
                //anchors.bottom:parent.bottom
                //anchors.bottomMargin: parent.height * 0.01

                width:parent.width
                height:parent.width

                color:highLightColor1
                radius:width / 2
                border.color:"black"

                Image {
                    id:focustype
                    anchors.centerIn: parent
                    source:"./img/Fauto.png"
                    width:parent.width * 0.6
                    height:parent.height * 0.6
                    fillMode:Image.PreserveAspectFit
                }

                MouseArea {
                            anchors.fill: parent;
                            onClicked: switch(setFocus) {
                                       case 0: setFocus =1;focustype.source = "./icons/Fcount.png";break;
                                       case 1: setFocus = 2;focustype.source = "./icons/Fhyper.png";break;
                                       case 2: setFocus = 3;focustype.source = "./icons/Finf.png";break;
                                       case 3: setFocus = 4;focustype.source = "./icons/Fmacro.png";break;
                                       case 4: setFocus = 0;focustype.source = "./icons/Fauto.png";break;
                                       }
                        }
            }


           Rectangle {
                //id:switchcamera
                //anchors.bottom:parent.bottom
                //anchors.bottomMargin: parent.height * 0.01
                width:parent.width
                height:parent.width

                color:highLightColor1
                radius:width /2
                border.color:"black"


                Text {
                    id:expostype
                    anchors.centerIn: parent
                    width:parent.width * 0.6
                    height:parent.height * 0.6
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color:"#9d9d9d"
                    text:"Au"
                    font.pixelSize: height - text.length
                }

                MouseArea {
                            anchors.fill: parent;
                            onClicked:switch(setExpos) {
                                      case 0: setExpos =1;expostype.text = "LS";break;
                                      case 1: setExpos = 2;expostype.text = "Nt";break;
                                      case 2: setExpos = 3;expostype.text = "Sp";break;
                                      case 3: setExpos = 0;expostype.text = "Au";break;
                                      }
            }
            } */

            }


        }


Item {
    height:10
    width:parent.width
}




        Rectangle {
            width:parent.width
            height:4
            color:seperatorColor1
        }


        ListView {
            width:parent.width
            height: parent.height * 0.1
            orientation: ListView.Horizontal
            spacing: 10
            clip:true

            model: ListModel {
                   id: previousimages
                }

            delegate: Item {
                        height:parent.height
                        width:parent.height
                        anchors.verticalCenter: parent.verticalCenter
                Image {
                    id:cardsava
                    anchors.fill:parent
                    anchors.margins: 4
                    visible: false
                    source: imgsource
                    fillMode: Image.PreserveAspectCrop
                }


                OpacityMask {
                        id:itemb
                     anchors.fill: cardsava
                     source: cardsava
                     maskSource: mask
                   // visible:if(cardsop == 1) {true} else {false}
                 }

                DropShadow {
                    anchors.fill:itemb
                    horizontalOffset: 2
                    verticalOffset: 4
                    radius: 8.0
                    samples: 17
                    color: "#80000000"
                    source:itemb
                    z:1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: avimg = imgsource
                    onPressAndHold:Scripts.Delete_img(imgsource)
                }

            }

        }

    Rectangle {
        width:parent.width
        height:4
        color:seperatorColor1
    }

   /* Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Other Sources")
        font.pixelSize: 18

    } */


    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Item {
            id:gravatarButton
           // anchors.horizontalCenter: parent.horizontalCenter
           // anchors.top:tumblrButton.bottom
           // anchors.topMargin: 20
            width:parent.width * 0.49
            height:thisWindow.height * 0.08

         Rectangle {
            id:ksb
            anchors.fill: parent
            color:"#0E75B8"
            radius:5
            border.color: "white"

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.98
                height:parent.height
                clip:true
                spacing: 10
                Image {
                    source:"./img/gravatarlogo.jpg"
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
                    text:"Use Gravatar"
                    color:"white"
                    width:parent.width
                    font.pixelSize: parent.height * 0.3
                    wrapMode: Text.WordWrap
                }
            }


        }

         DropShadow {

            anchors.fill: ksb
            horizontalOffset: 0
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: ksb
            z:1



              }

                MouseArea {
                    anchors.fill: parent
                    onClicked: sConnect.state = "Active",sConnect.service = "gravatar", sConnect.type = "avatar", sConnect.useraccount = useremail
                }
          }

         Item {
             id:soundcloudButton
             //anchors.horizontalCenter: parent.horizontalCenter
             //anchors.top:kickstarterButton.bottom
            // anchors.topMargin: 20
             width:parent.width * 0.49
             height:thisWindow.height * 0.08


        Rectangle {
            id:scb
            anchors.fill: parent
            color:"#FF3700"
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
                    text:"Use SoundCloud"
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
            onClicked: sConnect.state = "Active",sConnect.service = "soundcloud", sConnect.type = "avatar", sConnect.useraccount = ""
        }

         }
    }

    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Item {
            id:twitterButton
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.top:tumblrButton.bottom
           // anchors.topMargin: 20
            width:parent.width * 0.49
            height:thisWindow.height * 0.08

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
                    text:"Use Twitter"
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
             onClicked: sConnect.state = "Active",sConnect.service = "twitter", sConnect.type = "avatar", sConnect.useraccount = ""
         }
          }

         Item {
             id:tumblrButton
             //anchors.horizontalCenter: parent.horizontalCenter
             //anchors.top:kickstarterButton.bottom
            // anchors.topMargin: 20
             width:parent.width * 0.49
             height:thisWindow.height * 0.08


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
                    text:"Use Tumblr"
                    color:"white"
                    font.pixelSize: parent.height * 0.3
                    width:parent.width
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
            onClicked: sConnect.state = "Active",sConnect.service = "tumblr", sConnect.type = "avatar", sConnect.useraccount = ""
        }
         }
    }

}



    Rectangle {
        id:bottomBar
        anchors.bottom:parent.bottom
        width:parent.width
        height:parent.height * 0.08
        color:bottombarColor

   /* Image {
        id:privimg
        anchors.centerIn: parent
        width:parent.height * 0.7
        height: parent.height * 0.7
        fillMode:Image.PreserveAspectFit
        source:if(stf == "true") {"./icons/share.svg"} else {"./icons/private-browsing.svg"}

        Flasher{
            id:privateb
           // state: if(stf =="true") {"InActive"} else {"Enabled"}
        }
        MouseArea {
            anchors.centerIn: parent
            width:parent.width * 1.2
            height:parent.height * 1.2
            //onPressed:privateb.state = "Active"
          //  onReleased:privateb.state = "InActive"

            preventStealing: true
            onClicked: { if(stf == "true") {stf = "false"; } else { stf = "true";}
                Scripts.save_card(userid,username,userphone,useremail,usercompany,
                                                                          useralias,usermotto,usermain,website1,website2,website3,website4,
                                                                          stf,atf,ctf,avimg,carddesign,usercat);
                                                        OpenSeed.upload_data(userid,username,userphone,useremail,usercompany,
                                                                             useralias,usermotto,stf,atf,ctf,usermain,website1,website2,website3,website4,
                                                                             avimg,carddesign,usercat);

            }


        }
    } */

        Rectangle {
            id:closedialog
            color:highLightColor1
            width:parent.width * 0.36
            height:parent.height * 0.90
            anchors.centerIn: parent
            Text {
                anchors.centerIn: parent
                color:"black"
                text:qsTr("Close")
                font.pixelSize: parent.height * 0.5 - text.length
            }

            MouseArea {
                anchors.fill: parent
                onClicked: photo.state = "Hide", thisWindow.state = "InActive", sourceselect = false
            }
        }

        DropShadow {
            anchors.fill:closedialog
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000"
            source:closedialog
            z:1
        }


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


    Camera {
            id:camera


                position: Camera.FrontFace
            imageProcessing {

                whiteBalanceMode: CameraImageProcessing.WhiteBalanceAuto
            }

            exposure {
               // exposureCompensation: -1.0
                exposureMode: switch(setExpos) {
                              case 0:Camera.ExposureAuto;break;
                              case 1:Camera.ExposureLandscape;break;
                              case 2:Camera.ExposureNight;break;
                              case 3:Camera.ExposureSports;break;
                              case 4: Camera.ExposurePortrait;break;
                              default:Camera.ExposureAuto;break;

                              }

            }

            focus {
                        focusMode: switch(setFocus) {

                                   case 0:Camera.FocusAuto;break;
                                   case 1:Camera.FocusContinuous;break;
                                   case 2:Camera.FocusHyperfocal;break;
                                   case 3:Camera.FocusInfinity;break;
                                   case 4:Camera.FocusMacro;break;
                                   default:Camera.FocusAuto;break;

                                   }
                        focusPointMode: Camera.FocusPointAuto
                    }




            flash.mode: switch(setFlash) {
                        case 0: Camera.FlashAuto;break;
                        case 1: Camera.FlashOff;break;
                        case 2: Camera.FlashSlowSyncFrontCurtain;break;
                        default:Camera.FlashRedEyeReduction;break;
                        }

            imageCapture {
                resolution: "640x480"

                onImageCaptured: {
                    check.source = preview
                    //thesource = preview  // Show the preview in an Image

                    //check.visible = true;

                }
                onImageSaved: {

                    thefile = path


                }
            }



        }



}
