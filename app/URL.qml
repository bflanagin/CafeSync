import QtQuick 2.3
import QtQuick.Window 2.2

import Ubuntu.Web 0.2

import "main.js" as Scripts



Item {
    id:popup
    property string number: "0"
    property string list:""
    property string service: ""
    property string pagesource: ""

    clip: true


    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: popup
                visible:true
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



    WebView {
      //     visible:if(custompage == 0 & hasrss == 0) {true} else {false}
           // x:units.gu(1)
          //  y:units.gu(3)
            // anchors.fill:parent
           // width:parent.width - units.gu(2)
           // height:parent.height - units.gu(4)
        anchors.centerIn: parent
       width:parent.width * 0.98
        height:parent.height * 0.98
            //url: {if(webview1.length > 2) {return webview1;
              //  } else { if(webview2.length > 2){return webview2;
                //    } else {return webview3;} } }
           url: service

            onUrlChanged:fullWeb.state = "available"


    MouseArea {
      anchors.fill:parent
         onClicked: showurl = page,fullWeb.state = "show"
         ,cardPage.header.hide()

           /*onPressAndHold:showurl = page,fullWeb.state = "show"
           ,cardPage.header.hide() */

     }
    }

}




