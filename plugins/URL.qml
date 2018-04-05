import QtQuick 2.3
import QtQuick.Window 2.2

//import Ubuntu.Web 0.2

import "../main.js" as Scripts
import "../openseed.js" as OpenSeed


Item {
    id:popup
    property string number: "0"
    property string list:""
    property string service: ""
    property string pagesource: ""
    property string thesource:""

    clip: true


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                enabled:true
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: popup
              enabled:false

          }

        }
    ]

    anchors.centerIn: parent

    onStateChanged: if(popup.state == "Active") {OpenSeed.website_snap(mycard,page,index)}

   /* WebView {

        anchors.centerIn: parent
       width:parent.width * 0.98
        height:parent.height * 0.98
           url: service
            onUrlChanged:fullWeb.state = "available"

*/
    Image {
                    visible:if(custompage == 0 & hasrss == 0) {true} else {false}

                   anchors.centerIn: parent
                   fillMode:Image.PreserveAspectCrop
                 width:backing.width * 0.98
                 height:backing.height * 0.98

                    source:thesource

    MouseArea {
      anchors.fill:parent
         //onClicked: showurl = page,fullWeb.state = "show"
         //,cardPage.header.hide()
         onClicked:Qt.openUrlExternally(page);

           /*onPressAndHold:showurl = page,fullWeb.state = "show"
           ,cardPage.header.hide() */

     }
    }

}




