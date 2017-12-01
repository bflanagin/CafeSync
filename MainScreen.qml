import QtQuick 2.2
import QtQml 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

GridView {
    id:ms
    property string number: "0"
    property string list:""


    z:0
    //width: parent.width * 0.25//- units.gu(.4)
   // height: parent.height //- units.gu(4.8)
    snapMode: GridView.SnapOneRow
    //flow: GridView.FlowLeftToRight
    flow:GridView.FlowTopToBottom
    boundsBehavior: Flickable.DragAndOvershootBounds
    flickableDirection: Flickable.VerticalFlick
    visible: true
    //cellHeight: units.gu(26)
    clip:true

    cellHeight:parent.height //passerbyGrid.height
    cellWidth: mainScreen.width

    //onStateChanged: Scripts.loadActions(list)
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: ms
             //   visible:true
                x:0
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: ms
             // visible:false
              x:-1* width
          }
        }
    ]

    transitions: [
        Transition {
            from: "InActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: ms
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]

    delegate: Pages {}


 }





