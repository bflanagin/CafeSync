import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "getpic.js" as Scripts

Item {
        id:card_avatar_backing
        property string whichPic:""
        property string where:"mycard"
        property string thesource:""
        //property string theImage:"./img/default_avatar.png"

       // anchors.verticalCenter: parent.verticalCenter


        clip:true



        Image {
            id:cardsava
            anchors.fill:parent
            anchors.margins: 4
            visible: false
            source: if(thesource == "") {Scripts.returnImage(whichPic,where)} else {thesource}
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




}
