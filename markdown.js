function md2html(text) {
    //console.log("From md2html");
    var splittext = text.split("\\n");
    var formatted = "";

    //first wee need to get rid of the \n's and replace them with <br> //
    for(var num = 0;num < splittext.length;num = num + 1) {
        var changeformat = "";

        if(splittext[num].search("### ") != -1) {
            changeformat = splittext[num].replace("### ","<h3>").replace("\\n","");
            formatted = formatted+changeformat+"</h3><br>";

        } else

        if(splittext[num].search("## ") != -1) {
            changeformat = splittext[num].replace("## ","<h2>").replace("\\n","");
            formatted = formatted+changeformat+"</h2><br>";

        } else

        if(splittext[num].search("# ") != -1) {
            changeformat = splittext[num].replace("# ","<h1>").replace("\\n","");
            formatted = formatted+changeformat+"</h1><br>";

        } else

            if(splittext[num].search("\\+ ") != -1) {
                changeformat = splittext[num].replace("\\+ ","<ul><li>").replace("\\n","");
                formatted = formatted+changeformat+"</li></ul>";

            } else

            if(splittext[num].search("- ") != -1){
            changeformat = splittext[num].replace("- ","<ul><li>").replace("\\n","");
            formatted = formatted+changeformat+"</li></ul>";
        } else {
        formatted = formatted+splittext[num].replace("\\n","<br>");
        }
    }

    return formatted;

}
