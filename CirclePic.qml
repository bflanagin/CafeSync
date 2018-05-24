import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "circlepic.js" as Scripts

Item {
        id:card_avatar_backing
        property string whichPic:""
        property string where:""
        property string thesource:""
        property string fixpic: ""
        property int badge: 1000
        //property string theImage:"./img/default_avatar.png"

       // anchors.verticalCenter: parent.verticalCenter


        clip:true

        Component.onCompleted: {Scripts.returnImage(whichPic,where,thesource)}

        onWhichPicChanged: {Scripts.returnImage(whichPic,where,thesource)}

        onWhereChanged:  {Scripts.returnImage(whichPic,where,thesource)}


        Image {
            id:cardsava
            anchors.fill:parent
            anchors.margins: 4
            visible: false
            source: if(fixpic === 'undefined') {"./img/default_avatar.png"} else {fixpic}
            fillMode: Image.PreserveAspectCrop

            Image {

                anchors.fill:parent
                visible: true
                source: "./img/default_avatar.png"
                z:-1
            }
        }



        OpacityMask {
             anchors.fill: cardsava
             source: cardsava
             maskSource: mask

         }

        Image {
            id:thebadge
            width: parent.width * 0.25
            height: parent.width * 0.25
            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.04
            source:switch(badge) {
                   case 0:"./icons/help.svg";break;
                   case 1: "./icons/ok.svg";break;
                   case 2: "./icons/cancel.svg";break;
                   default: "./img/gold-badge.png";break;
                   }
            visible: if(badge == 1000) {false} else {true}
        }

        ColorOverlay {
               anchors.fill: thebadge
               source: thebadge
               visible:if(badge > 2) {false} else {true}
               color: switch(badge) {
                      case 0:"yellow";break;
                      case 1:"green";break;
                      case 2: "red";break;
                      default:"black";break;
                      }
           }




}
