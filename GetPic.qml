import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0


import QtQuick.LocalStorage 2.0 as Sql


import "main.js" as Scripts
import "openseed.js" as OpenSeed


Item {
    id:window_container

    property string thesource:""
    property string thefile:""
    property int selectedEffect:0
    property int isPrivate: 0
    property int capturedAsspect:0
    property int setFlash:0
    property int setExpos:0
    property int setFocus: 0

    property string theComment:""



   states: [

       State {
           name: "Show"

           PropertyChanges {
               target:window_container
             //  y:0

           }

       },

       State {
           name: "Hide"

           PropertyChanges {
               target:window_container
             //  y:parent.height


           }


       }

   ]

  /* transitions: [
       Transition {
           from: "Hide"
           to: "Show"
           reversible: true


           NumberAnimation {
               target: window_container
               property: "y"
               duration: 200
               easing.type: Easing.InOutQuad
           }
       }
   ] */

   state:"Hide"


   onStateChanged: if(window_container.state == "Show") {camera.start()

                   } else {camera.stop()}



clip:true






   /* Rectangle {
        anchors.fill:parent
        //color:"#9d9d9d"
        //color:"black"
        color:"#4e4e4e"
        //color:"#202020"
    } */

    Camera {
            id:camera



            imageProcessing {

                whiteBalanceMode: CameraImageProcessing.WhiteBalanceAuto
            }

            exposure {
                exposureCompensation: -1.0
                exposureMode: switch(setExpos) {
                              case 0:Camera.ExposureAuto;break;
                              case 1:Camera.ExposureLandscape;break;
                              case 2:Camera.ExposureNight;break;
                              case 3:Camera.ExposureSports;break;
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

    Rectangle {
        color:"#9d9d9d"
        anchors.centerIn:border
        width:border.width * 1.01
        height:border.height * 1.01

    }

    Item {
        id:photoframe
        width:parent.width * 0.6
        height:parent.width * 0.6
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
       // anchors.centerIn: parent

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

            //rotation:90

            fillMode: Image.PreserveAspectCrop
            focus : visible // to receive focus and capture key events when visible

        }


    Image {
        id:check
        anchors.fill:viewport
        fillMode: Image.PreserveAspectCrop
        //visible: if(Image.Ready == 1) {true}
    }


    }

    Image {
        id:mask
        anchors.fill:parent
        source:"/graphics/CafeSync.png"
        visible: false

    }

    OpacityMask {
        id:opmask
         anchors.fill: photoframe
         source: photoframe
         maskSource: mask

     }



    Rectangle {
        id:camerabutton
        //anchors.bottom:parent.bottom
        //anchors.bottomMargin: parent.height * 0.01
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top:photoframe.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:if(mainView.width > mainView.height) {parent.width * 0.5}else {parent.height * 0.2}
        height:if(mainView.width > mainView.height){parent.width * 0.5} else {parent.height * 0.2}

        color:highLightColor1
        radius:width /2
        border.color:"black"

        Image {
            anchors.centerIn: parent
            source:"./img/camera-photo.svg"
            width:parent.width * 0.8
            height:parent.height * 0.8
            fillMode:Image.PreserveAspectFit
        }

        MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                            capturedAsspect = selectedAsspect;
                        camera.imageCapture.captureToLocation(paths.split(",")[2].trim());
                        camera.imageCapture.capture();
                    }
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


    Rectangle {
        id:switchcamera
        //anchors.bottom:parent.bottom
        //anchors.bottomMargin: parent.height * 0.01
        width:parent.width
        height:parent.width

        color:highLightColor1
        radius:width /2
        border.color:"black"

        Image {
            id:cameratype
            anchors.centerIn: parent
            source:"./img/backC.png"
            width:parent.width * 0.6
            height:parent.height * 0.6
            fillMode:Image.PreserveAspectFit
        }

        MouseArea {
                    anchors.fill: parent;
                    onClicked:if(camera.position == 1) {camera.position = 2;cameratype.source ="./img/frontC.png"}
                              else {camera.position = 1;cameratype.source ="./img/backC.png"}
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

        Image {
            id:flashtype
            anchors.centerIn: parent
            source:"./img/FA.png"
            width:parent.width * 0.6
            height:parent.height * 0.6
            fillMode:Image.PreserveAspectFit
        }

        MouseArea {
                    anchors.fill: parent;
                    onClicked:switch(setFlash) {
                              case 0: setFlash =1;flashtype.source = "./img/FO.png";break;
                              case 1: setFlash = 2;flashtype.source = "./img/FS.png";break;
                              case 2: setFlash = 0;flashtype.source = "./img/FA.png";break;
                              }
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

    Rectangle {
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
                               case 0: setFocus =1;focustype.source = "./img/Fcount.png";break;
                               case 1: setFocus = 2;focustype.source = "./img/Fhyper.png";break;
                               case 2: setFocus = 3;focustype.source = "./img/Finf.png";break;
                               case 3: setFocus = 4;focustype.source = "./img/Fmacro.png";break;
                               case 4: setFocus = 0;focustype.source = "./img/Fauto.png";break;
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
    }

    }





  /*  Column {
        id:settings_pic
        y:parent.height * 0.2
        x:check.width * 1.01
        width:parent.width - check.width
        height:parent.height

        clip:true
    Item {

        width:parent.width
        height:mainView.height * 0.1

    Rectangle {
        anchors.centerIn: effectsRow
        width:effectsRow.width * 1.02
        height:effectsRow.height * 1.01
        color:"#4e4e4e"
        radius:8
        border.color:"gray"
        border.width:2
    }

    GridView {
        id:effectsRow

        width:parent.width * 0.99
        height:parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        flow:GridView.FlowTopToBottom

        clip:true
        cellHeight:height
        cellWidth:height

        model:5

        delegate: Effects {
            effect:modelData

            height:effectsRow.cellHeight * 0.8
            width:effectsRow.cellHeight * 0.8

            MouseArea {
                anchors.fill:parent
                onClicked: {

                            selectedEffect = modelData


                }
            }
        }

    }

    }

    Item {

        width:parent.width * 0.99
        height:parent.height * 0.06

    Rectangle {
        anchors.centerIn: commonTags
        width:commonTags.width * 1.02
        height:commonTags.height * 1.08
        color:"#4e4e4e"
        radius:8
        border.color:"gray"
        border.width:2
    }

    Flow {
        id:commonTags
        //anchors.top:effectsRow.bottom
        //anchors.topMargin:parent.height * 0.01
        width:parent.width
        height:parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
                width:tagtext.width  * 1.1
                height:tagtext.height * 1.1
                radius:4
                color:"#4e4e4e"
                border.color:"gray"

        Text {
            id:tagtext
            text:"#selfie"
            color:"white"
            font.pixelSize: commonTags.height * 0.3
            anchors.centerIn: parent
        }
        }


    }
    } */

   /*  Rectangle {
        anchors.centerIn: comment
        width:comment.width * 1.02
        height:comment.height * 1.1
        color:"white"
        radius:8
        border.color:"gray"
        border.width:10
    }

    TextField {
            visible:if(thesource == "") {false} else {true}
            id:comment
            //anchors.top:commonTags.bottom
            //anchors.topMargin: parent.height * 0.02
           // anchors.bottom:footer.top
            //anchors.bottomMargin: parent.height * 0.02
           // anchors.horizontalCenter: parent.horizontalCenter
            //horizontalAlignment: Text.AlignLeft
            //verticalAlignment: Text.AlignTop
            //maximumLength: 144
            height:parent.height * 0.18
            width:parent.width * 0.99
            placeholderText: "Add # to create new hashtags."
            onTextChanged: theComment = comment.text


    }

} */


  /*      Item {
            id:footer
            //anchors.bottom:parent.bottom
            y:if(parent.width > parent.height) {
                  if(thesource == "") {0}
                              else {parent.height - parent.height * 0.08}
              } else {
                if(thesource == "") {viewport.y + viewport.height}
                            else {parent.height - parent.height * 0.08}
              }
            x:if(parent.width > parent.height) {border.width} else {0}
            width:if(parent.width > parent.height) {parent.width - border.width} else {parent.width}
            height:if(thesource == "") {parent.height - y} else {parent.height * 0.08}


        Rectangle {
            visible:if(thesource == "") {true} else {false}
            id:footerStandard
            width:parent.width
            height:parent.height
            color:"#4e4e4e"

            Rectangle {
                anchors.top:parent.top
                width:parent.width
                height:parent.height * 0.04
                color:"#9d9d9d"
                visible:if(mainView.width > mainView.height) {false} else {true}

            }

            Rectangle {
                width:parent.width * 0.05
                height:parent.height
                color:"#9d9d9d"
                radius:10
                x:parent.x - width / 2
                visible:if(mainView.width > mainView.height) {true} else {false}
            }

            Image {
                visible:if(mainView.width > mainView.height) {true} else {false}
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.9
                height:parent.width
                anchors.top:parent.top
                source:"graphics/title.png"
                fillMode:Image.PreserveAspectFit
            }








        Rectangle {
            visible:if(thesource != "") {true} else {false}
            id:footerSaveOpts
            width:parent.width
            height:parent.height
            color:"#4e4e4e"

            Rectangle {
                anchors.top:parent.top
                width:parent.width
                height:parent.height * 0.06
                color:"gray"

            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:parent.right
                anchors.rightMargin: parent.height *0.05
                width:(parent.height * 1.5) + okaytext.text.length
                height:parent.height * 0.8
                radius:8
                color:"#9d9d9d"

                Text {
                    id:okaytext
                    anchors.centerIn: parent
                    font.pixelSize: parent.height * 0.5
                    text:"Okay"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:{
                                if(camera.position == 2) {
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
                                }

                }
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:parent.left
                anchors.rightMargin: parent.left *0.05
                width:(parent.height * 1.5) + canceltext.text.length
                height:parent.height * 0.8
                radius:8
                color:"#9d9d9d"

                Text {
                    id:canceltext
                    anchors.centerIn: parent
                    font.pixelSize: parent.height * 0.5
                    text:"Cancel"
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:thesource = "",comment.text = ""
                }
            }

        }


        }

        Rectangle {
            anchors.top:parent.top
            anchors.right:parent.right
            anchors.margins: parent.height * 0.01
            width:parent.height * 0.05
            height: parent.height * 0.05
            color:"#4e4e4e"
            radius: 8
            border.color:"gray"
            border.width:2


            Image {
                source:"graphics/backbutton.png"
                anchors.centerIn: parent
                width:parent.width * 0.7
                height:parent.height * 0.7
                mirror:true
            }

            MouseArea {
                anchors.fill: parent
                onClicked:window_container.state = "Hide"
            }


        } */


}

