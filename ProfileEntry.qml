import QtQuick 2.3
import QtQuick.Dialogs 1.2
//import QtWebKit 3.0
//import QtWebView 1.0
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

Item {
    id:thisWindow

    property string type:""
    property int listindex: -1
    property string aboutme: ""

    onListindexChanged: if(listindex != -1) {Scripts.editItem(type,listindex)}

    onAboutmeChanged: if(aboutme == "") {aboutyou.text = ""} else { aboutyou.text = aboutme}

    onStateChanged: if(state == "InActive") {thisWindow.enabled = false,skillname.text ="", certifed.checked ="", skillDiscription.text="",skillstartdate.text="",skillexpiredate.text="",years.text="",
                    companyname.text="",currentlyEmployeed.checked="",workDiscription.text="",workstartdate.text="",workleftdate.text="",workyears.text="",
                    schoolname.text="",graduated.checked="",schoolDiscription.text="",graddate.text="",degree.text="",topBar.state ="settings"
                    } else {thisWindow.enabled = true}

    MouseArea {
        anchors.fill: parent

    }

    states: [

            State {
                name: "Active"

                PropertyChanges {
                    target: thisWindow
                    x:0
                }
        },

        State {
            name:"InActive"

            PropertyChanges {
                target: thisWindow
                x:-width
            }

        }
    ]

    transitions: [

        Transition {
            from: "InActive"
            to: "Active"
            reversible: true


            NumberAnimation {
                target: thisWindow
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }

        }


    ]


    Item {
        id:about

        visible: if(type == "about") {true} else {false}
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        width:parent.width
        height:parent.height
        clip:true

        Rectangle {
            id:backing
            //y:parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            height:parent.height
            color:cardcolor
            border.color: "black"
            border.width:1
            radius: 4

        }
Flickable {
        width:parent.width
        height:parent.height * 0.98
        contentHeight:aboutcolumn.height * 1.2
    Column {
        id:aboutcolumn
        width:parent.width * 0.98

        spacing:parent.height * 0.01
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text:"About"
            font.pixelSize: thisWindow.height * 0.05
        }

        Rectangle {
            width:parent.width
            height:thisWindow.height * 0.008
            color:seperatorColor1
        }

        TextArea {
            id:aboutyou
            width:parent.width
            height:thisWindow.height / 1.4
            placeholderText: "Tell the world about yourself."
            wrapMode: Text.WordWrap

            Rectangle {
                anchors.centerIn: parent
                color:"white"
                width:parent.width * 1.01
                height:parent.height * 1.01
                border.color: "black"
                border.width: 1
                z:-1
            }
        }


}



    Image {
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./icons/close.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: thisWindow.state = "InActive"
        }
    }

    Image {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./icons/check.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: yourabout = aboutyou.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;"),thisWindow.state = "InActive"
        }

    }

}
    }


    Item {
        id:skill
        //anchors.fill: parent
        visible: if(type == "skill") {true} else {false}
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        width:parent.width
        height:parent.height
        clip:true


    Rectangle {
        id:backing1
        //y:parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:parent.height
        color:cardcolor
        border.color: "black"
        border.width:1
        radius: 4

    }

    Column {
        width:parent.width * 0.98
        height:parent.height * 0.98
        spacing:parent.height * 0.01
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text:if(listindex == -1 ) {"New Skill"} else {"Edit Skill"}
            font.pixelSize: thisWindow.height * 0.05
        }

        Rectangle {
            width:parent.width
            height:thisWindow.height * 0.008
            color:seperatorColor1
        }

        TextField {
            id:skillname
           // anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98

            placeholderText: "Skill Name"
        }
        Row {
            width:parent.width
            height:thisWindow.height * 0.04

            Text {
                text:"Years:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id:years
               width:parent.width * 0.06
                placeholderText: "0"
                 anchors.verticalCenter: parent.verticalCenter
                  inputMethodHints: Qt.ImhDialableCharactersOnly
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text:"Certified:"
            }
            CheckBox {
                id:certifed
                checked: false
                 anchors.verticalCenter: parent.verticalCenter

            }
            Text {
                visible: certifed.checked
              anchors.verticalCenter: parent.verticalCenter
             text:"Rec:"
            }
            TextField {
                visible: certifed.checked
                id:skillstartdate
                width:parent.width * 0.15
                placeholderText: "12/31/2017"
                 anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                visible: certifed.checked
              anchors.verticalCenter: parent.verticalCenter
             text:"Expr:"
            }
            TextField {
                visible: certifed.checked
                id:skillexpiredate
                width:parent.width * 0.15
                placeholderText: "12/31/2017"
                 anchors.verticalCenter: parent.verticalCenter
            }

        }

        TextArea {
            id:skillDiscription
            width:parent.width
            height:thisWindow.height / 1.6
            placeholderText: "Skill Discription"
            wrapMode: Text.WordWrap

            Rectangle {
                anchors.centerIn: parent
                color:"white"
                width:parent.width * 1.01
                height:parent.height * 1.01
                border.color: "black"
                border.width: 1
                z:-1
            }
        }





    }
    Image {
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./icons/close.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: thisWindow.state = "InActive",listindex = -1
        }
    }

    Image {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./icons/check.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: if(skillname.text !="") {
                           if(listindex != -1) {
                           yourskills[listindex] = "'"+skillname.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                           +"':::'"+certifed.checked
                           +"':::'"+skillDiscription.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                           +"':::'"+skillstartdate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                           +"':::'"+skillexpiredate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                           +"':::'"+years.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")+"'";

                               thisWindow.state = "InActive";
                           //listindex = -1;
                       } else {
        yourskills.push("'"+skillname.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                        +"':::'"+certifed.checked
                        +"':::'"+skillDiscription.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                        +"':::'"+skillstartdate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                        +"':::'"+skillexpiredate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                        +"':::'"+years.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")+"'"),

        thisWindow.state = "InActive"
        //listindex = -1
        }
                       }
    }

    }

    }


    Item {
        id:work
        visible: if(type == "work") {true} else {false}
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        width:parent.width
        height:parent.height
        clip:true

        Rectangle {
            id:backing2
            //y:parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            height:parent.height
            color:cardcolor
            border.color: "black"
            border.width:1
            radius: 4

        }

    Column {
        width:parent.width * 0.98
        height:parent.height * 0.98
        spacing:parent.height * 0.01
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text:if(listindex == -1 ) {"New Work Experience"} else {"Edit Work Experience"}
            font.pixelSize: thisWindow.height * 0.05
        }

        Rectangle {
            width:parent.width
            height:thisWindow.height * 0.008
            color:seperatorColor1
        }

        TextField {
            id:companyname
           // anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98

            placeholderText: "Company Name"


        }
        Row {
            width:parent.width
            height:thisWindow.height * 0.04

            Text {
                text:"Years:"
                anchors.verticalCenter: parent.verticalCenter
            }
            TextField {
                id:workyears
                width:parent.width * 0.06
                placeholderText: "0"
                 anchors.verticalCenter: parent.verticalCenter
                  inputMethodHints: Qt.ImhDialableCharactersOnly
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text:"Current:"
            }
            CheckBox {
                id:currentlyEmployeed
                checked: false
                 anchors.verticalCenter: parent.verticalCenter

            }
            Text {
                //visible: currentlyEmployeed .checked
              anchors.verticalCenter: parent.verticalCenter
             text:"Started: "
            }
            TextField {
                //visible: currentlyEmployeed .checked
                id:workstartdate
                width:parent.width * 0.15
                placeholderText: "12/31/2017"
                 anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                visible: if(currentlyEmployeed.checked == true) {false} else {true}
              anchors.verticalCenter: parent.verticalCenter
             text:"Left: "
            }
            TextField {
                visible: if(currentlyEmployeed.checked == true) {false} else {true}
                id:workleftdate
                width:parent.width * 0.15
                placeholderText: "12/31/2017"
                 anchors.verticalCenter: parent.verticalCenter
            }

        }

        TextArea {
            id:workDiscription
            width:parent.width
            height:thisWindow.height / 1.6
            placeholderText: " Discription"
            wrapMode: Text.WordWrap


            Rectangle {
                anchors.centerIn: parent
                color:"white"
                width:parent.width * 1.01
                height:parent.height * 1.01
                border.color: "black"
                border.width: 1
                z:-1
            }
        }





    }

    Image {
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./icons/close.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: thisWindow.state = "InActive",listindex = -1
        }
    }

    Image {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.04
        source:"./icons/check.svg"
        width:parent.height * 0.05
        height:parent.height * 0.05
        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked: if(companyname.text !="") {
                           if(listindex != -1) {
                         yourworked[listindex] = "'"+companyname.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                         +"':::'"+currentlyEmployeed.checked
                         +"':::'"+workDiscription.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                         +"':::'"+workstartdate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                         +"':::'"+workleftdate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                         +"':::'"+workyears.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")+"'";

                               thisWindow.state = "InActive";
                          // listindex = -1;
                       } else {
                yourworked.push("'"+companyname.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                                +"':::'"+currentlyEmployeed.checked
                                +"':::'"+workDiscription.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                                +"':::'"+workstartdate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                                +"':::'"+workleftdate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                                +"':::'"+workyears.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")+"'"),


                thisWindow.state = "InActive"
                           //listindex = -1
        }
                       }

        }

    }

    }


    Item {
        id:school

        visible: if(type == "school") {true} else {false}
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        width:parent.width
        height:parent.height
        clip:true

        Rectangle {
            id:backing3
            //y:parent.height * 0.04
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            height:parent.height
            color:cardcolor
            border.color: "black"
            border.width:1
            radius: 4

        }

    Column {
        width:parent.width * 0.98
        height:parent.height * 0.98
        spacing:parent.height * 0.01
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text:if(listindex == -1 ) {"New School"} else {"Edit School"}
            font.pixelSize: thisWindow.height * 0.05
        }

        Rectangle {
            width:parent.width
            height:thisWindow.height * 0.008
            color:seperatorColor1
        }

        TextField {
            id:schoolname
           // anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98

            placeholderText: "School Name"


        }
        Row {
            width:parent.width
            height:thisWindow.height * 0.04

            Text {

              anchors.verticalCenter: parent.verticalCenter
             text:"D:"
            }
            TextField {

                id:degree
                width:parent.width * 0.35
                placeholderText: "BS:Computer Science"
                 anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text:"Graduated:"
            }
            CheckBox {
                id:graduated
                checked: false
                 anchors.verticalCenter: parent.verticalCenter

            }


            Text {
                visible: graduated.checked
              anchors.verticalCenter: parent.verticalCenter
             text:"on:"
            }
            TextField {
                visible: graduated.checked
                id:graddate
                width:parent.width * 0.15
                placeholderText: "12/31/2017"
                 anchors.verticalCenter: parent.verticalCenter
                  inputMethodHints: Qt.ImhDialableCharactersOnly
            }

        }

        TextArea {
            id:schoolDiscription
            width:parent.width
            height:thisWindow.height / 1.6
            placeholderText: "School Discription"
            wrapMode: Text.WordWrap

            Rectangle {
                anchors.centerIn: parent
                color:"white"
                width:parent.width * 1.01
                height:parent.height * 1.01
                border.color: "black"
                border.width: 1
                z:-1
            }
        }





    }

    Item {
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: mainView.width * 0.04
        width:parent.width * 0.08
        height:parent.width * 0.08


    Image {

        source:"./icons/close.svg"
        width:parent.height * 0.7
        height:parent.height * 0.7
        anchors.centerIn: parent

    }

    Flasher {

    }

    MouseArea {
        anchors.fill: parent
        onClicked: thisWindow.state = "InActive",listindex = -1
    }

    }

    Item {
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.margins: mainView.width * 0.04
        width:parent.width * 0.08
        height:parent.width * 0.08
    Image {

        source:"./icons/check.svg"
        width:parent.height * 0.7
        height:parent.height * 0.7
        anchors.centerIn: parent

    }

        Flasher {

        }

        MouseArea {
            anchors.fill: parent
            onClicked:if(schoolname.text !="") {
                          if(listindex != -1) {
                          yourschooling[listindex]= "'"+schoolname.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                          +"':::'"+graduated.checked
                          +"':::'"+schoolDiscription.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                          +"':::'"+graddate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                          +"':::'"+degree.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")+"'";


                              thisWindow.state = "InActive";
                         // listindex = -1;
                      } else {
                yourschooling.push("'"+schoolname.text.replace(/\,/g,";#x2c;").replace(/+/g,";#x2b;")
                                   +"':::'"+graduated.checked+
                                   "':::'"+schoolDiscription.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                                   +"':::'"+graddate.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")
                                   +"':::'"+degree.text.replace(/\,/g,";#x2c;").replace(/\+/g,";#x2b;")+"'"),

                thisWindow.state = "InActive"
               // listindex = -1
        }
                      }
        }

    }

    }

}
