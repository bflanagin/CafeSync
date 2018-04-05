function get_html(account) {

    var url = "https://www.facebook.com/"+account.split("::")[1];

    var sitedata = "";
    var profilepic = "";
    var profilebanner = "";
    var personalpage = "";
    var profile = "";


var http = new XMLHttpRequest();
//var url = "http://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
//console.log(url)
http.onreadystatechange = function() {
    if (http.readyState == 4) {
        //console.log(http.responseText);
        //userid = http.responseText;
        if(http.responseText == 100) {
            console.log("Incorrect DevID");
        } else if(http.responseText == 101) {
            console.log("Incorrect AppID");
        } else {
          //  console.log(http.responseText);
            //userid = http.responseText;
            //datasync(http.responseText);
            sitedata = http.responseText;

            personalpage = sitedata.search('type":"Person","name":')

            loading_info.text = personalpage;

            if(personalpage != -1) {
                personal = 1;

               if(personal ==1) {loading_info.text = "Personal page"};

            profilebanner = sitedata.substring(sitedata.search("coverPhotoImg photo img"),sitedata.search("coverPhotoImg photo img")+400);
            profilebanner = profilebanner.split('"');
            banner = profilebanner[2];

            profilepic = sitedata.substring(sitedata.search("Profile Photo"),sitedata.search("Profile Photo")+400);
            profilepic = profilepic.split('"');
                avatar = profilepic[2];

            profile = sitedata.substring(sitedata.search('"Person","name":'),sitedata.search('"Person","name":')+800);
            profile = profile.split('","');
            name = profile[1].split('":"')[1];
               loading_info.text = name;

                var jobtitle = "Vocation:"+profile[2].split('":"')[1];
                var locality = "Location:"+profile[4].split('":"')[1].split('"},"')[0];
                var num = 0;
                var organizations = "";
                while(profile.length > num) {

                    if(profile[num].split('":"')[0] == "name") {
                        if(profile[num].split('":"')[1] != thename) {
                       // console.log(profile[num].split('":"')[1].split('"}')[0]);
                            if(organizations != "") {
                            organizations = organizations+"Affliation: "+profile[num].split('":"')[1].split('"}')[0]+"\n";
                            } else {
                                organizations = "Affliation: "+profile[num].split('":"')[1].split('"}')[0]+"\n";
                            }
                        }
                    }
                    num = num + 1;
                }

                message = jobtitle+"\n\n"+organizations+"\n"+locality+"\n";




            } else {
                personal = 0;

               profilebanner = sitedata.substring(sitedata.search("coverPhoto"),sitedata.search("coverPhoto")+400);
                profilebanner = profilebanner.split('"');
                //thebanner = profilebanner[2];
                banner = "./img/fb.png"

                //profilepic = sitedata.substring(sitedata.search("Profile Photo"),sitedata.search("Profile Photo")+400);
                //profilepic = profilepic.split('"');
                    //theavatar = profilepic[2];

                profile = sitedata.substring(sitedata.search('title='),sitedata.search('title=')+800);
                profile = profile.split('"');

                name = sitedata.split('<title id="pageTitle">')[1].split('| Facebook</title>')[0];

                stats = profile[5].split(".")[1].split("&#xb7;")[0]+"\n"+profile[5].split(".")[1].split("&#xb7;")[1];


                profile =  sitedata.substring(sitedata.search('<div class="_5ay5">'),sitedata.search('<div class="_5ay5">')+4000);


                profile = profile.split('<p>')[1].split("</p>");

                message  = profile[0];

                //console.log("From Facebook Page: "+profile[1].split("src=")[1].split('"')[1]);
                //thebanner = '"'+profile[1].split("src=")[1].split('"')[1]+'"';
                //thebanner = "./img/fb.png"



            }



        }

    }
}
http.open('GET', url.trim(), true);
http.send(null);

}
