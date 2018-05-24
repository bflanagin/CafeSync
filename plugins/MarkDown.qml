import QtQuick 2.9

import "./markdown.js" as MarkDown

Item {
    id:thisWindow
    property string thedata: ""
    height:markeddownList.height

    onThedataChanged: MarkDown.md2qml(thedata)

    ListView {
        id:markeddownList
        width:parent.width
        height:contentHeight

        model:markdown

        delegate: Item{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:thisWindow.width * 0.98
                    height:if(textItem.visible == true) {textItem.height} else if(imageItem.visible == true) {imageItem.height} else if(codeItem.visible == true) {5}
                 Text {
                     id:textItem
                    anchors.centerIn: parent
                    width:parent.width
                    visible: if(type == "text") {true} else {false}
                    wrapMode: Text.WordWrap
                    clip:true
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: postbg.width * 0.04
                    text:"<div>"+thepost+"</div>"

                }

                    Image {
                        id:imageItem
                        enabled: if(type == "image") {true} else {false}
                        visible: if(type == "image") {true} else {false}
                        source: img
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                        width:parent.width
                    }


                Rectangle {
                    id:codeItem
                    anchors.centerIn:parent
                    width:parent.width
                    height: 3
                    color:highLightColor1
                    visible: if(type == "code") {true} else {false}
                }

        }


    }

    ListModel {
        id:markdown
    }

}
