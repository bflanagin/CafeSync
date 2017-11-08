import QtQuick 2.2
//import Ubuntu.Components 1.2
//import Ubuntu.Components.Pickers 0.1
//import Ubuntu.Components.ListItems 1.0 as ListItem
//import Ubuntu.Content 1.1
//import Ubuntu.Layouts 1.0
//import Ubuntu.Web 0.2
//import Ubuntu.Components.Popups 1.0
import QtQml 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

Item {
    id:popup
    property string number: "0"
    property string list:""
    property int selection: 0


    clip: true



    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                z: 3
                visible:true
            }
            PropertyChanges {
                target:fbackground
                currentIndex:fbgnum
            }
            PropertyChanges {
                target:fsymbol
                currentIndex:fsymbolnum
            }
            PropertyChanges {
                target:ftext
                currentIndex:ftextnum
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

    onStateChanged:{selection = 0;Scripts.cardcreator();fixit.running = true;}

    Timer {id:fixit;interval:1000; running: false; repeat:false
        onTriggered: {if(cardindex == 0) {
                fbackground.currentIndex = 0;fbackground.currentIndex = fbgnum
                fsymbol.currentIndex = 0;fsymbol.currentIndex = fsymbolnum
                    ftext.currentIndex = 0;ftext.currentIndex = ftextnum
                } else {
                    fbackground.currentIndex = 0;fbackground.currentIndex = fbgnum1
                    fsymbol.currentIndex = 0;fsymbol.currentIndex = fsymbolnum1
                        ftext.currentIndex = 0;ftext.currentIndex = ftextnum1
                    }
                        }
    }

 Image {
     width:parent.width
     height:parent.height
     //color:"white"
     source:"img/Suru_Wallpaper_Desktop_4096x2304_Gray.png"
     MouseArea {
         anchors.fill:parent
     }

 }

 VeButton {
     id:savebutton
     //width:parent.width * 0.90
      height:parent.height /10
      anchors.left:basecard.right
      anchors.right:parent.right
      anchors.rightMargin: 15
      anchors.leftMargin: -15

      anchors.bottom:cancelbutton.top
      anchors.bottomMargin:5
      //state:if(selection == 2) {"pressed"} else {"normal"}
     // anchors.horizontalCenter: parent.horizontalCenter
     title:"Set"
     enabled:1
     MouseArea {
         anchors.fill:parent
         onClicked:{if(cardindex == 0) {
                 carddesign = "internal:"+fbackground.currentIndex+','+fsymbol.currentIndex+','+ftext.currentIndex;
                 cardbImg = Scripts.Card_Set("background",fbackground.currentIndex);
                 cardsImg = Scripts.Card_Set("symbol",fsymbol.currentIndex);
                 text_Locations = Scripts.Card_Set("text",ftext.currentIndex);
                 } else {
                     carddesign1 = "internal:"+fbackground.currentIndex+','+fsymbol.currentIndex+','+ftext.currentIndex;
                     cardbImg1 = Scripts.Card_Set("background",fbackground.currentIndex);
                     cardsImg1 = Scripts.Card_Set("symbol",fsymbol.currentIndex);
                     text_Locations = Scripts.Card_Set("text",ftext.currentIndex);
                 }
             popup.state = "InActive";
             savflick.state = "Alert";}

         onPressed: savebutton.state = "pressed"
         onReleased: savebutton.state ="normal"
     }

 }


 VeButton {
     id:cancelbutton
     width:parent.width * 0.90
      height:parent.height /10
      anchors.left:basecard.right
      anchors.right:parent.right
      anchors.rightMargin: 15
      anchors.leftMargin: -15

      anchors.bottom:basecard.bottom
      //state:if(selection == 2) {"pressed"} else {"normal"}
     // anchors.horizontalCenter: parent.horizontalCenter
     title:"Cancel"
     enabled:1
     MouseArea {
         anchors.fill:parent
         onClicked: popup.state = "InActive"
         onPressed: cancelbutton.state = "pressed"
         onReleased: cancelbutton.state ="normal"
     }

 }

 Column {
  anchors.left:basecard.right
  anchors.leftMargin: -15
  anchors.right:parent.right
  anchors.top:basecard.top
  anchors.topMargin: -3
  //anchors.bottom:basecard.bottom
  height:parent.height * 0.80
  spacing:2


 VeButton {
     width:parent.width * 0.95
     height:parent.height /8
     state:if(selection == 0) {"pressed"} else {"normal"}
     //anchors.horizontalCenter: parent.horizontalCenter
     title:"Background"
     enabled:1
     MouseArea {
         anchors.fill:parent
         onClicked: selection = 0;
     }

 }
 VeButton {
     width:parent.width * 0.95
      height:parent.height /8
      state:if(selection == 1) {"pressed"} else {"normal"}
      //anchors.horizontalCenter: parent.horizontalCenter
     title:"Symbol"
     enabled:1
     MouseArea {
         anchors.fill:parent
         onClicked: selection = 1;
     }

 }
 VeButton {
     width:parent.width * 0.95
      height:parent.height /8
      state:if(selection == 2) {"pressed"} else {"normal"}
     // anchors.horizontalCenter: parent.horizontalCenter
     title:"Text"
     enabled:1
     MouseArea {
         anchors.fill:parent
         onClicked: selection = 2;
     }

 }
 }

 Rectangle {
     anchors.centerIn: basecard
     width:basecard.width * 1.01
     height:basecard.height* 1.01
     border.color:"black"
     border.width:0
     color:"gray"
 }

 Flipable {
     id:basecard
     anchors.verticalCenter: parent.verticalCenter
     anchors.left:parent.left
     //anchors.leftMargin: 10
     width:parent.width * 0.80
     height:parent.height * 0.90
    clip:true

front:

    GridView {
     id:fbackground

     property string list:""
     //property string pindex:pageindex
       anchors.fill:parent

     z:0
     //width: parent.width * 0.25//- units.gu(.4)
    // height: parent.height //- units.gu(4.8)
     snapMode: GridView.SnapOneRow
     //flow: GridView.FlowLeftToRight
     enabled:false
     flow:GridView.FlowTopToBottom
     boundsBehavior: Flickable.DragAndOvershootBounds
     flickableDirection: Flickable.VerticalFlick
     //highlightFollowsCurrentItem: true
     visible: true
     //cellHeight: units.gu(26)
     clip:true
     //enabled:if(selection == 0) {true} else {false}

     cellHeight:parent.height //passerbyGrid.height
     cellWidth: basecard.width

     delegate: Image {
                id:bg
             source:img
             //anchors.fill:parent
             width:basecard.width
             height:basecard.height
             //id:index
             //fillMode: Image.PreserveAspectFit
         }

     model:
         ListModel {
            id:fbackground_list
         }

}

GridView {
 id:fsymbol

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
 enabled:false
 //enabled:if(selection == 1) {true} else {false}

 cellHeight:parent.height //passerbyGrid.height
 cellWidth: basecard.width

 delegate: Item {
            height:basecard.height
             width:basecard.width
             //id:index
             clip:true

         Image {
         source:img
         //anchors.fill:parent
         x:parent.width * (0.01*placement)
         height:parent.height * 0.50
         width:parent.width * 0.50
         fillMode: Image.PreserveAspectFit
         anchors.verticalCenter: parent.verticalCenter
     }
 }

 model:
     ListModel {
        id:fsymbol_list
     }

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
 enabled:false
 //enabled:if(selection == 2) {true} else {false}

 cellHeight:parent.height //passerbyGrid.height
 cellWidth: basecard.width

 delegate: Item {

         //anchors.fill:parent
            width:basecard.width
            height:basecard.height
            clip:true

         Text {
             id:title
             text:ftitle
             font.pixelSize: parent.height * (0.0075*ftitlesize)
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenterOffset: parent.width * (0.01*fHoffset)
             anchors.verticalCenterOffset: parent.height * (0.01*fVoffset)
              width:(parent.width * 0.95) - parent.width * (0.01*fHoffset)
              wrapMode:Text.WordWrap
             style: Text.Outline; styleColor: "#FFFFFF"

         Text {
             id:subtitle
             text:fsubtitle
             font.pixelSize: parent.height * (0.0075*fsubtitlesize)
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenterOffset:title.text.length
             anchors.verticalCenterOffset: parent.height * (0.01*fsVoffset)

             style: Text.Outline; styleColor: "#FFFFFF"
         }
         }
     }

 model:
     ListModel {
        id:ftext_list
     }

}

back:
    Rectangle {
    anchors.fill:parent
    color:"white"
}

transform: Rotation {
    id: rotation
    origin.x: basecard.width/2
    origin.y: basecard.height/2
    axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
    angle: 0    // the default angle
}

states: State {
    name: "back"
    PropertyChanges { target: rotation; angle: 180 }
    //when:  currentcard == index //&& cards.flipped
}

transitions: Transition {
    NumberAnimation { target: rotation; property: "angle"; duration: 400 }
}


 }


LeftTab {
    anchors.left:basecard.left
    anchors.verticalCenter: basecard.verticalCenter
    width:basecard.width * 0.05
    height:basecard.height / 3
    MouseArea {
        anchors.fill:parent
        onClicked:switch(selection) {
                  case 0:if(fbackground.currentIndex >0) {fbackground.currentIndex = fbackground.currentIndex - 1};break;
                  case 1:if(fsymbol.currentIndex >0) {fsymbol.currentIndex = fsymbol.currentIndex - 1};break;
                  case 2:if(ftext.currentIndex >0) {ftext.currentIndex = ftext.currentIndex - 1};break;
                  default: console.log("nope");break;
                  }
    }

}
RightTab {
    anchors.right:basecard.right
    anchors.verticalCenter: basecard.verticalCenter
    width:basecard.width * 0.05
    height:basecard.height / 3
    MouseArea {
        anchors.fill:parent
        onClicked:switch(selection) {
                  case 0:if(fbackground.currentIndex < fbackground.count -1) {fbackground.currentIndex = fbackground.currentIndex + 1};break;
                  case 1:if(fsymbol.currentIndex < fsymbol.count -1) {fsymbol.currentIndex = fsymbol.currentIndex + 1};break;
                  case 2:if(ftext.currentIndex < ftext.count -1) {ftext.currentIndex = ftext.currentIndex + 1};break;
                  default: console.log("nope");break;
                  }
    }
}

Rectangle {
    anchors.horizontalCenter: basecard.horizontalCenter
    anchors.top:basecard.bottom
    anchors.topMargin:-30
    height:selectionttitle.height * 3.0
    width:selectionttitle.width * 1.5
    z:1
    color:"white"
    border.width:2
    border.color:"gray"
    radius:10


Text {
    id:selectionttitle
    anchors.centerIn: parent
    font.pixelSize: basecard.width * 0.02
    text:qsTr("Use you own")
}

Flasher {
    id:own

}

MouseArea {
    anchors.fill:parent
    onPressed:own.state = "Active"
    onReleased:own.state = "InActive"
    onClicked: payments.state = "Active"
}


}

Payment {
    id:payments
    state:"InActive"

}


}




