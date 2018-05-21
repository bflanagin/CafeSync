/*
  This is where we setup the encryption for various functions of the application. This is not meant to be something as secure as RSA,
  but hopefully good enough to keep some prying eyes from the posts. This is in addition to the already encrypted transmission to and from the server.
  Later on we will probably move to a more secure system.
*/

function genkey(extra,type,forwhom) {

        /*The key is generated and stored on the device.
            extra = External source for key creation. An example would be from the openseed server
            type = each encrypted data type will get its on key, so Chat and Notes would be different
            forwhom = Like type this is so each user or chat room can have its own key to reference.
        */

    var d = new Date();


    var begin = userid+d.getTime()+extra+usercardNum;
    var end = "";
    var returned = "";


    db.transaction(function(tx) {

        tx.executeSql("CREATE TABLE IF NOT EXISTS keys (ekey TEXT,type TEXT,forwhom TEXT)");

        var pull = tx.executeSql("SELECT * FROM keys WHERE forwhom ='"+forwhom+"'");

        if(pull.rows.length === 0) {

            /* running the begin variable through a randomizer a couple times :) */
        for(var num = 0;num < 40000;num = num +1) {

          var splitby = begin.charAt(Math.floor((Math.random() * (begin.length - 5)) + 1));
            end = end+begin.substring(splitby,splitby+5);
            end = end.slice(0,userid.length);
        }

        /* and then again just because */

        for(num = 0;num < 40000;num = num +1) {

          var splitby1 = end.charAt(Math.floor((Math.random() * (end.length - 5)) + 1));
            end = end+end.substring(splitby1,splitby1+5);
            end = end.slice(0,userid.length);
        }

        /* the above takes a moment or two so we want to inform the user */
        notification1.visible = true;
        notification1.themessage = "encryption key created";
        notification1.delay = 3;

            var data = [end,type,forwhom];
            var dbstr = "INSERT INTO keys VALUES(?,?,?)";

            tx.executeSql(dbstr,data);

            returned = end;
        } else {

            returned = pull.rows.item(0).ekey;
        }
    });

    return returned;

}

function encrypt(key,message) {

    //where we really screw up the text //

    /* adding begining and ending tags help and using a should be secret string like the userid keeps things more secure*/

    message = "</message/>"+userid.toUpperCase()+"</message/>"+message+"</message/>"+userid.toUpperCase()+"</message/>";
    var salt = "";
    var encrypted1 = "";
    var encrypted2 = "";

    /* we make sure the salt length is always the same length as the message. In the end the whole thing is much larger than the original */

    if(key.length < message.length) {
    while(salt.length < message.length) {
        salt = salt+key;
    }
    } else {
        salt = key;
    }

    salt = salt.substring(0,message.length);

    /* create a random salt value for the salt to be added to the message */

    var encryptnum = Math.floor((Math.random() * 50) + 1);

    /* in future versions we'll need to do this a couple times, to make sure the mix is good and mixed. For no once will do. */
    for(var num = 0;num < salt.length;num =num+1) {
            encrypted1 = encrypted1+message.charAt(num)+salt.slice(num,encryptnum);
    }




    /* these are sprinkled into the string for fun and to replace anything that doesn't behave */
    /* in the future these will be randomized as well, and the decryptor will have to figure them out as well */
    var alpha10 = ['aV','b!','cX','dR','e-','ff','gN','hF','iQ','jE'];

    /* More mathy encryption stuff, replaces values, changes type etc */
    for(num = 0;num < encrypted1.length;num = num + 1) {

        if(Number.isNaN(Number(encrypted1.charAt(num))) === true) {
            encrypted2 = encrypted2+encrypted1.charCodeAt(num);
        } else {


            if(alpha10[encrypted1.charAt(num)] !== undefined) {
            encrypted2 = encrypted2+alpha10[encrypted1.charAt(num)];
            } else {
                encrypted2 = encrypted2+encrypted1.charAt(num);
            }
        }
    }

    return encrypted2;

}

function decrypt(key,message) {
    // Get the message back //

    var salt ="";
    var decrypted1 = "";
    var decrypted2 = "";
    var decrypted3 = "";


    var alpha10 = ['aV','b!','cX','dR','e-','ff','gN','hF','iQ','jE'];

    var alphaoffset = 1;

    /* this undoes the second part of the encryption function above */
    for(var num = 0;num <= message.length;num =num + alphaoffset) {

                if(alpha10.indexOf(message.slice(num,num+2)) != -1) {
                    decrypted3 = decrypted3+alpha10.indexOf(message.slice(num,num+2));
                    alphaoffset = 2;
                } else if(Number.isNaN(Number(message.slice(num,num+3))) === false && message.slice(num,num+3) >= 100 && message.slice(num,num+3) <= 126) {

                    decrypted3 = decrypted3+String.fromCharCode(message.slice(num,num+3));
                    alphaoffset = 3;
                } else if (Number.isNaN(Number(message.slice(num,num+2))) === false && message.slice(num,num+2) >= 32) {

                    decrypted3 = decrypted3+String.fromCharCode(message.slice(num,num+2));
                    alphaoffset = 2;

                } else {
                    decrypted3 = decrypted3+message.charAt(num);
                    alphaoffset = 1;
                }


    }

    /* Now we need to run through all the possible salts that are randomly given
      The while loop just goes through and tries till it successfully gets the </message/> stuff above */

    var decryptnum = 0;

    while(true) {
            var offset = decryptnum;
    for(num = 0;num <= decrypted3.length;num = num + 1) {


        if(num == 0) {
        decrypted1 = decrypted1+decrypted3.charAt(num);
        } else {
            decrypted1 = decrypted1+decrypted3.charAt(num+offset);
            //offset = offset+1;

        }


    }

    if(decrypted1.split("</message/>").length > 4) {

        decrypted1 = decrypted1.split("</message/>")[1];

        if(decrypted1.split("</message/>").length == 2) {

            decrypted1 = decrypted1.split("</message/>")[1];
      }

        break;

    }

    decryptnum = decryptnum + 1;

}

    return decrypted1;

}

