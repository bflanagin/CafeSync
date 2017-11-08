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

import "webpage.js" as WebPage

import "youtube.js" as YouTube

Item {
    id:webthing

    property int number: pageindex
    property string list:""
    property string page: webpage
    property int custompage: 0
    property string thesource:""
    property string mycard: thecard
    property string thebanner:""
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


    property int ispersonal:0
    property int hasrss: 0


    state:thestate


    clip: true

    //x:passerbyGrid.width + units.gu(1)
    width: pagewidth
    height:pageheight
    //anchors.centerIn:parent




    onStateChanged: {

        //if(layouts.width < mobile_width) {


        if(page.search("facebook") != -1) {

                                custompage = 1;
                                //FaceBook.get_html(page);
                                //OpenSeed.website_snap(mycard,page,index)

                } else {
                    if(page.search("linkedin") != -1) {
                            //Linkedin.get_html(page);
                            custompage = 2;
                            //OpenSeed.website_snap(mycard,page,index)
            } else {
                    if(page.search("twitter") != -1) {

                            custompage = 3;

                            //Twitter.get_html(page);
                            //OpenSeed.website_snap(mycard,page,index);
            } else {
                    if(page.search("twitch") != -1) {

                            custompage = 4;

                            //OpenSeed.website_snap(mycard,page,index);
            } else {

                    if(page.search("youtube") != -1) {

                            custompage = 5;

                            //YouTube.get_html(page);

                            //OpenSeed.website_snap(mycard,page,index);
            } else {

                    if(page.search("jamendo") != -1) {

                            custompage = 6;

                            //OpenSeed.website_snap(mycard,page,index);
            } else {

                    if(page.search("vimeo") != -1) {

                            custompage = 7;

                           // OpenSeed.website_snap(mycard,page,index);
            } else {
                    if(page.search("soundcloud") != -1) {

                            custompage = 8;

                            //Soundcloud.get_html(page);
            } else {

                    if(page.search("tumblr") != -1) {

                            custompage = 9;

                            //Tumblr.get_html(page);

                           // OpenSeed.website_snap(mycard,page,index);
            } else {

                        if(page.search("etsy") != -1) {

                                custompage = 10;

                                //Etsy.get_html(page);

                               // OpenSeed.website_snap(mycard,page,index);
                } else {

                            if(page.search("kickstarter") != -1) {

                                    custompage = 11;

                                    //Kickstarter.get_html(page);

                                    //OpenSeed.website_snap(mycard,page,index);
                    } else {

                                if(page.search("gofundme") != -1) {

                                        custompage = 12;

                                       // GoFundMe.get_html(page);

                                       // OpenSeed.website_snap(mycard,page,index);
                        }

             } } } } } } } } } } }

                if(custompage == 0) {
                    WebPage.get_html(page);
                    //console.log("Found feed: "+hasrss);

                }

        //}
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
            }
            PropertyChanges {
                target: home
                visible:false
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
          }
          PropertyChanges {
              target: home
              visible:false
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
          }
          PropertyChanges {
              target: home
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
        color:"white"
        border.color:"black"
        radius: 4
        anchors.fill: parent
        width:parent.width
        height:parent.height


        FaceBook {
            state:if(custompage == 1) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            fburl:page

        }

        Linkedin {
            state:if(custompage == 2) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page




        }
        Twitter {
            state:if(custompage == 3) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page

        }

        Twitch {
            state:if(custompage == 4) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
        }
        YouTube {
            state:if(custompage == 5) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
            banner:thebanner
            avatar:theavatar
            profilename:thename
            message:themessage
            stats:thestats

        }
        Jamendo {
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
        }

        SoundCloud {
            state:if(custompage == 8) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
        }

        Tumblr {
            state:if(custompage == 9) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page

        }

        RSS {
            state:if(hasrss) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page
            banner:thebanner
            avatar:theavatar
            name:thename
            message:themessage
            posttitle:theposttitle
            post:thepost
            postimage:thepostimage
            link:thelink
        }

        Etsy {
            state:if(custompage == 10) {"Active"} else {"InActive"}
            anchors.fill:parent
            pagesource:thesource
            service:page

        }

        Kickstarter {
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
        }

    URL {
        state:if(custompage == 0 && hasrss == 0) {"Active"} else {"InActive"}
        anchors.fill:parent
        pagesource:thesource
        service:page
    }



    }
         }


   Home {
          id:home
          visible:false
              }

}




