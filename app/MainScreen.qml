import QtQuick 2.2
import Ubuntu.Components 1.2
import Ubuntu.Components.Pickers 0.1
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Content 1.1
import Ubuntu.Layouts 1.0
import Ubuntu.Web 0.2
import Ubuntu.Components.Popups 1.0
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

    property string list:""



    z:0

    snapMode: GridView.SnapOneRow

    flow:GridView.FlowTopToBottom
    boundsBehavior: Flickable.DragAndOvershootBounds
    flickableDirection: Flickable.HorizontalFlick

    visible: true

    clip:true

    cellHeight:parent.height //passerbyGrid.height
    cellWidth: mainScreen.width


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: ms
                visible:true
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: ms
                visible:false
          }
        }
    ]

    delegate: Pages {}


 }





