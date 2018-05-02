import QtQuick 2.2

import QtQml 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

//import "plugins/webpage.js" as WebPage

//import "plugins/youtube.js" as YouTube

import "./plugins/"



Item {
    id:webthing

    property int number: pageindex
    property string list:""
    property string page: webpage
    property int custompage: 0
    property string thesource:""
    property string mycard: cardId
    property string thebanner:""
    property string theurl:""
    property string theavatar:""
    property string thename:""
    property string themessage:""
    property string thestats:""
    property string theposttitle:""
    property string thepost:""
    property string thepostimage:""
    property string thelink:""
    property string theinfo1:""
    property string theinfo2:""
    property string theinfo3:""
    property string theinfo4:""
    property string theinfo5:""
    property string thebackers:""
    property string theammount:""
    property string thetotal:""
    property int thepercent: 0
    property int thetimeleft: 0
    property string aquote:""

    property int pindex:0
    property int postcount: 0


    property int ispersonal:0
    property int hasrss: 0


    state:thestate


    clip: true

    //x:passerbyGrid.width + units.gu(1)
    width: pagewidth
    height:pageheight
    //anchors.centerIn:parent




    onStateChanged: { if(state == "Active") {

            if(fromRequest == true) {
                notification1.visible = true;notification1.themessage = "\"contact button\" to accept the request. Delete button to decline.";
            }

        //if(layouts.width < mobile_width) {


        if(page.search("facebook") != -1) {
                    custompage = 1;

        } else if(page.search("linkedin") != -1) {
                    custompage = 2;

        } else if(page.search("twitter") != -1) {
                     custompage = 3;

        } else if(page.search("twitch") != -1) {
                     custompage = 4;

        } else if(page.search("youtube") != -1) {
                    custompage = 5;

        } else if(page.search("jamendo") != -1) {
                    custompage = 6;

        } else if(page.search("vimeo") != -1) {
                    custompage = 7;

        } else if(page.search("soundcloud") != -1) {
                     custompage = 8;

        } else if(page.search("tumblr") != -1) {
                     custompage = 9;

        } else if(page.search("etsy") != -1) {
                    custompage = 10;

        } else if(page.search("kickstarter") != -1) {
                   custompage = 11;

       } else if(page.search("gofundme") != -1) {
                 custompage = 12;

        } else if(page.search("medium") != -1) {
                  custompage = 13;

         } else if(page.search("wordpress") != -1) {
                             custompage = 13;

         }else if(page.search("blog") != -1) {
                                 custompage = 13;

          } else if(page.search("steemit") != -1) {
                             custompage = 14;


        } else if(custompage == 0) {
               //  WebPage.get_html(page.split("::")[1]);
                   }

    }

    }



    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: webthing
                z: 3
            }
            PropertyChanges {
                target: web
                visible:true
                enabled:true
            }
            PropertyChanges {
                target: home
                visible:false
                enabled:false
            }
            PropertyChanges {
                target: log
                visible:false
                enabled:false
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: webthing
              z: -2
          }
          PropertyChanges {
              target: web
              visible:false
              enabled:false
          }
          PropertyChanges {
              target: home
              visible:false
              enabled:false
          }
        },
        State {
          name:"Info"
          PropertyChanges {
              target: webthing
              z: 0
          }
        },
        State {
          name:"FullWeb"
          PropertyChanges {
              target: webthing
              z: 0
          }
        },
        State {
          name:"Home"
          PropertyChanges {
              target: webthing
              z: 0
          }
          PropertyChanges {
              target: web
              visible:false
              enabled:false
          }
          PropertyChanges {
              target: log
              visible:false
              enabled:false
          }
          PropertyChanges {
              target: home
              visible:true
              enabled:true
          }
        },

        State {
          name:"MicroBlog"
          PropertyChanges {
              target: webthing
              z: 0
          }
          PropertyChanges {
              target: web
              visible:false
              enabled:false
          }
          PropertyChanges {
              target: home
              visible:false
              enabled:false
          }
          PropertyChanges {
              target: log
              visible:true
          }
        }


    ]
    transitions: [


        Transition {
        //id:sanimation

           NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad;duration:500;}
       },
        Transition {
             NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad;duration:100;}
        }


    ]



    Item {

    id:web
        anchors.fill:parent

    Rectangle {
        id:backing
        x:0
        y:0
        color:backgroundColor
        //border.color:"black"
        radius: 2
        anchors.fill: parent
        width:parent.width
        height:parent.height




        FaceBook {
            state:if(custompage == 1 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page


        }

        Linkedin {
            state:if(custompage == 2 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page


        }



        Twitter {
            state:if(custompage == 3 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page


        }

       /* Twitch {
            state:if(custompage == 4) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
        } */
       /* YouTube {
            state:if(custompage == 5) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
            banner:thebanner
            avatar:theavatar
            profilename:thename
            message:themessage
            stats:thestats

        } */

       /* Jamendo {
            state:if(custompage == 6) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
        }
        Vimeo {
            state:if(custompage == 7) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
        } */

        SoundCloud {
            state:if(custompage == 8 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page

        }

        Tumblr {
            state:if(custompage == 9 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page


        }

        RSS {
            state:if(custompage == 13 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page

           // banner:thebanner
           // avatar:theavatar
          //  name:thename
          //  message:themessage
          //  posttitle:theposttitle
          //  post:thepost
          //  postimage:thepostimage
         //   link:thelink
        }

       Etsy {
            state:if(custompage == 10 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page


        }
       Steemit {
            state:if(custompage == 14 && pindex == ms.indexAt(ms.contentX,0)) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page


        }

       /* Kickstarter {
            state:if(custompage == 11) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page

        }

        GoFundMe {
            state:if(custompage == 12) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
        } */

    /*URL {
        state:if(custompage == 0 && hasrss == 0) {"Active"} else {"InActive"}
        anchors.fill:parent
        pagesource:thesource
        service:page
    } */

    }
         }


     Home {
         //   enabled: if(custompage == 0 && pindex == ms.indexAt(ms.contentX,0)) {true} else {false}
          id:home
          visible:false
          enabled: false
              }

   MicroBlogger {
          //  enabled: if(custompage == 0 && pindex == ms.indexAt(ms.contentX,0)) {true} else {false}
          id:log
          visible:false

              }

   ListModel {
                   id:rssposts

           }
   ListModel {
                   id:tumblrposts

           }
   ListModel {
                   id:twitterposts

           }

   ListModel {
                   id:shopposts

           }
   ListModel {
                   id:steemitposts

           }
}




