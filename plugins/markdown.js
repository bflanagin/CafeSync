function md2qml (text) {
    //console.log("From md2html");
    var splittext = text.split("\\n");
    var formatted = "";

    //first wee need to get rid of the \n's and replace them with <br> //
    for(var num = 0;num < splittext.length;num = num + 1) {
        var changeformat = "";


            if(splittext[num].search("```") !== -1){
            changeformat = splittext[num].replace(/```/,"<br><br>").replace(/\\n/,"");


                markdown.append({
                                  type:"code",
                                  thepost: "--- CODE ---",
                                    img:""
                                });

        } else
                if(splittext[num].search(/\!\[/) !== -1) {

                changeformat = splittext[num].split("](")[1].split(")")[0].replace(/\\/g,"");
                     //console.log(changeformat);

                    markdown.append({
                                      type:"image",
                                      thepost:"",
                                      img:changeformat

                                    });

            }

            else {

                  //  console.log(splittext[num].replace("\\n","<br>"));
                    markdown.append({
                                     type:"text",
                                     thepost:replace_linestarters(splittext[num]),
                                     img: ""
                                    });

        }




    }


}


function replace_linestarters(line) {
    var formatedline = "";

    /*else
                  if(splittext[num].search(/\[/) !== -1) {

                      var url = splittext[num].split("](")[1].split(")")[0].replace(/\\/g,"");
                      var short = splittext[num].split("](")[0].split("[")[1];
                        console.log(changeformat);

                         markdown.append({
                                 type:"link",
                                   thepost:"<a href='"+url+"'>"+short+"</a>",
                                   img:""

                                   });

                            } */



    var linestarters = [["#### ","<h4>","</h4>"],["### ","<h3>","</h3>"],["## ","<h2>","</h2>"],
                        ["# ","<h1>","</h1>"],["- ","<ul><li>","</li></ul>"],[/ \*\*/g,"<b>",""],[/\*\*/g,"<b>",""],[/\*\* /g,"</b>",""],
                        ["\\+ ","<ul><li>","</li></ul>"]];

    for(var rnum = 0;linestarters.length > rnum;rnum = rnum + 1) {

        if(line.search(linestarters[rnum][0]) !== -1) {
                formatedline = line.replace(linestarters[rnum][0],linestarters[rnum][1]).replace(/\\/g,"").replace(/\"/g,'"')+linestarters[rnum][2];
                break;
        } else {
            formatedline = line.replace(/\\/g,"");
        }
    }
        //console.log(formatedline);

    return formatedline.replace(/\\n/,"<br>");
}
