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
            source: fixpic
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
            id:badge
            width: parent.width * 0.2
            height: parent.width * 0.2
            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.1
            source:"./img/gold-badge.png"
        }


}
