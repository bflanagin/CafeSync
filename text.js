function replaceSpecials(thestring) {
/*'& ;#x26;',
'# ;#x23;',
'; ;#x3b;',
 '\ ;#x5c;',*/
var spchar = [
'\! ;#x21;',
'\" ;#x22;',
'\$ ;#x24;',
'\% ;#x25;',
"\' ;#x27;",
'\( ;#x28;',
'\) ;#x29;',
'\* ;#x2a;',
'\+ ;#x2b;',
'\, ;#x2c;',
'\- ;#x2d;',
'\. ;#x2e;',
'\/ ;#x2f;',
'\: ;#x3a;',
'\< ;#x3c;',
'\= ;#x3d;',
'\> ;#x3e;',
'\? ;#x3f;',
'\@ ;#x40;',
'\[ ;#x5b;',
'\] ;#x5d;',
'\^ ;#x5e;',
'\_ ;#x5f;',
'\` ;#x60;',
'\{ ;#x7b;',
'\| ;#x7c;',
'\} ;#x7d;',
'\~ ;#x7e;',
'\¡ ;#xa1;',
'\¢ ;#xa2;',
'\£ ;#xa3;',
'\¤ ;#xa4;',
'\¥ ;#xa5;',
'\¦ ;#xa6;',
'\§ ;#xa7;',
'\¨ ;#xa8;',
'\© ;#xa9;',
'\ª ;#xaa;',
'\« ;#xab;',
'\¬ ;#xac;',
'\® ;#xae;',
'\¯ ;#xaf;',
'\° ;#xb0;',
'\± ;#xb1;',
'\² ;#xb2;',
'\³ ;#xb3;',
'\´ ;#xb4;',
'\µ ;#xb5;',
'\¶ ;#xb6;',
'\· ;#xb7;',
'\¸ ;#xb8;',
'\¹ ;#xb9;',
'\º ;#xba;',
'\» ;#xbb;',
'\¼ ;#xbc;',
'\½ ;#xbd;',
'\¾ ;#xbe;',
'\¿ ;#xbf;',
'À ;#xc0;',
'Á ;#xc1;',
'Â ;#xc2;',
'Ã ;#xc3;',
'Ä ;#xc4;',
'Å ;#xc5;',
'Æ ;#xc6;',
'Ç ;#xc7;',
'È ;#xc8;',
'É ;#xc9;',
'Ê ;#xca;',
'Ë ;#xcb;',
'Ì ;#xcc;',
'Í ;#xcd;',
'Î ;#xce;',
'Ï ;#xcf;',
'Ð ;#xd0;',
'Ñ ;#xd1;',
'Ò ;#xd2;',
'Ó ;#xd3;',
'Ô ;#xd4;',
'Õ ;#xd5;',
'Ö ;#xd6;',
'× ;#xd7;',
'Ø ;#xd8;',
'Ù ;#xd9;',
'Ú ;#xda;',
'Û ;#xdb;',
'Ü ;#xdc;',
'Ý ;#xdd;',
'Þ ;#xde;',
'ß ;#xdf;',
'à ;#xe0;',
'á ;#xe1;',
'â ;#xe2;',
'ã ;#xe3;',
'ä ;#xe4;',
'å ;#xe5;',
'æ ;#xe6;',
'ç ;#xe7;',
'è ;#xe8;',
'é ;#xe9;',
'ê ;#xea;',
'ë ;#xeb;',
'ì ;#xec;',
'í ;#xed;',
'î ;#xee;',
'ï ;#xef;',
'ð ;#xf0;',
'ñ ;#xf1;',
'ò ;#xf2;',
'ó ;#xf3;',
'ô ;#xf4;',
'õ ;#xf5;',
'ö ;#xf6;',
'÷ ;#xf7;',
'ø ;#xf8;',
'ù ;#xf9;',
'ú ;#xfa;',
'û ;#xfb;',
'ü ;#xfc;',
'ý ;#xfd;',
'þ ;#xfe;',
'ÿ ;#xff;'
]
var num = 0;
//    console.log("spchar list length "+spchar.length+"\n");

while(spchar.length-1 > num) {
    //var sp = spchar[num].split("'")[1].split("'")[0];
    //"' ;#x27;",
    thestring = thestring.replace(spchar[num].split(" ")[0],spchar[num].split(" ")[1]);
    //console.log("testing "+spchar[num].split(" ")[0]+" "+spchar[num].split(" ")[1]+ "\n");
num = num + 1;
}

//console.log(thestring);
return thestring;
}

function recoverSpecial(thestring) {
    /*
    !	;#33;	;#x21;
    "	;#34;	;#x22;	&quot;
    #	;#35;	;#x23;
    $	;#36;	;#x24;
    %	;#37;	;#x25;
    &	;#38;	;#x26;	&amp;
    '	;#39;	;#x27;
    (	;#40;	;#x28;
    )	;#41;	;#x29;
    *	;#42;	;#x2a;
    +	;#43;	;#x2b;
    ,	;#44;	;#x2c;
    -	;#45;	;#x2d;
    .	;#46;	;#x2e;
    /	;#47;	;#x2f;
    :	;#58;	;#x3a;
    ;	;#59;	;#x3b;
    <	;#60;	;#x3c;	&lt;
    =	;#61;	;#x3d;
    >	;#62;	;#x3e;	&gt;
    ?	;#63;	;#x3f;
    @	;#64;	;#x40;
    [	;#91;	;#x5b;
    \	;#92;	;#x5c;
    ]	;#93;	;#x5d;
    ^	;#94;	;#x5e;
    _	;#95;	;#x5f;
    `	;#96;	;#x60;
    {	;#123;	;#x7b;
    |	;#124;	;#x7c;
    }	;#125;	;#x7d;
    ~	;#126;	;#x7e;
        ;#160;	;#xa0;	&nbsp;
    ¡	;#161;	;#xa1;	&iexl;
    ¢	;#162;	;#xa2;	&cent;
    £	;#163;	;#xa3;	&pound;
    ¤	;#164;	;#xa4;	&curren;
    ¥	;#165;	;#xa5;	&yen;
    ¦	;#166;	;#xa6;	&brvbar;
    §	;#167;	;#xa7;	&sect;
    ¨	;#168;	;#xa8;	&uml;
    ©	;#169;	;#xa9;	&copy;
    ª	;#170;	;#xaa;	&ordf;
    «	;#171;	;#xab;	&laquo;
    ¬	;#172;	;#xac;	&not;
    ­	;#173;	;#xad;	&shy;
    ®	;#174;	;#xae;	&reg;
    ¯	;#175;	;#xaf;	&macr;
    °	;#176;	;#xb0;	&deg;
    ±	;#177;	;#xb1;	&plusmn;
    ²	;#178;	;#xb2;	&sup2;
    ³	;#179;	;#xb3;	&sup3;
    ´	;#180;	;#xb4;	&acute;
    µ	;#181;	;#xb5;	&micro;
    ¶	;#182;	;#xb6;	&para;
    ·	;#183;	;#xb7;	&middot;
    ¸	;#184;	;#xb8;	&cedil;
    ¹	;#185;	;#xb9;	&sup1;
    º	;#186;	;#xba;	&ordm;
    »	;#187;	;#xbb;	&raquo;
    ¼	;#188;	;#xbc;	&frac14;
    ½	;#189;	;#xbd;	&frac12;
    ¾	;#190;	;#xbe;	&frac34;
    ¿	;#191;	;#xbf;	&iquest;
    À	;#192;	;#xc0;	&Agrave;
    Á	;#193;	;#xc1;	&Aacute;
    Â	;#194;	;#xc2;	&Acirc;
    Ã	;#195;	;#xc3;	&Atilde;
    Ä	;#196;	;#xc4;	&Auml;
    Å	;#197;	;#xc5;	&Aring;
    Æ	;#198;	;#xc6;	&AElig;
    Ç	;#199;	;#xc7;	&Ccedil;
    È	;#200;	;#xc8;	&Egrave;
    É	;#201;	;#xc9;	&Eacute;
    Ê	;#202;	;#xca;	&Ecirc;
    Ë	;#203;	;#xcb;	&Euml;
    Ì	;#204;	;#xcc;	&Igrave;
    Í	;#205;	;#xcd;	&Iacute;
    Î	;#206;	;#xce;	&Icirc;
    Ï	;#207;	;#xcf;	&Iuml;
    Ð	;#208;	;#xd0;	&ETH;
    Ñ	;#209;	;#xd1;	&Ntilde;
    Ò	;#210;	;#xd2;	&Ograve;
    Ó	;#211;	;#xd3;	&Oacute;
    Ô	;#212;	;#xd4;	&Ocirc;
    Õ	;#213;	;#xd5;	&Otilde;
    Ö	;#214;	;#xd6;	&Ouml;
    ×	;#215;	;#xd7;	&times;
    Ø	;#216;	;#xd8;	&Oslash;
    Ù	;#217;	;#xd9;	&Ugrave;
    Ú	;#218;	;#xda;	&Uacute;
    Û	;#219;	;#xdb;	&Ucirc;
    Ü	;#220;	;#xdc;	&Uuml;
    Ý	;#221;	;#xdd;	&Yacute;
    Þ	;#222;	;#xde;	&THORN;
    ß	;#223;	;#xdf;	&szlig;
    à	;#224;	;#xe0;	&agrave;
    á	;#225;	;#xe1;	&aacute;
    â	;#226;	;#xe2;	&acirc;
    ã	;#227;	;#xe3;	&atilde;
    ä	;#228;	;#xe4;	&auml;
    å	;#229;	;#xe5;	&aring;
    æ	;#230;	;#xe6;	&aelig;
    ç	;#231;	;#xe7;	&ccedil;
    è	;#232;	;#xe8;	&egrave;
    é	;#233;	;#xe9;	&eacute;
    ê	;#234;	;#xea;	&ecirc;
    ë	;#235;	;#xeb;	&euml;
    ì	;#236;	;#xec;	&igrave;
    í	;#237;	;#xed;	&iacute;
    î	;#238;	;#xee;	&icirc;
    ï	;#239;	;#xef;	&iuml;
    ð	;#240;	;#xf0;	&eth;
    ñ	;#241;	;#xf1;	&ntilde;
    ò	;#242;	;#xf2;	&ograve;
    ó	;#243;	;#xf3;	&oacute;
    ô	;#244;	;#xf4;	&ocirc;
    õ	;#245;	;#xf5;	&otilde;
    ö	;#246;	;#xf6;	&ouml;
    ÷	;#247;	;#xf7;	&divide;
    ø	;#248;	;#xf8;	&oslash;
    ù	;#249;	;#xf9;	&ugrave;
    ú	;#250;	;#xfa;	&uacute;
    û	;#251;	;#xfb;	&ucirc;
    ü	;#252;	;#xfc;	&uuml;
    ý	;#253;	;#xfd;	&yacute;
    þ	;#254;	;#xfe;	&thorn;
    ÿ	;#255;	;#xff;	&yuml;
    */
}
