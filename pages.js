// this isn't used yet, the idea is that the pages would be created on the fly to combat the increased amount of memory used when multiple external sites are used.
// However this might even create more memory issues I'll need to test it before implementation.

function createPage(custom) {

    switch (custom) {
            case 89: component = Qt.createComponent("./Home.qml");break;
            case 90: component = Qt.createComponent("./MicroBlogger.qml");break;
            case 1:component = Qt.createComponent("./plugins/Facebook.?ml");break;
            case 2:component = Qt.createComponent("./plugins/Linkedin.?ml");break;
            case 3:component = Qt.createComponent("./plugins/?i??er.?ml");break;
            case 4:component = Qt.createComponent("./plugins/?wi?ch.?ml");break;
            case 5:component = Qt.createComponent("./plugins/You?ube.?ml");break;
            case 6:component = Qt.createComponent("./plugins/Jamendo.?ml");break;
            case 7:component = Qt.createComponent("./plugins/Vimeo.?ml");break;
            case 8:component = Qt.createComponent("./plugins/SoundCloud.?ml");break;
            case 9:component = Qt.createComponent("./plugins/?umblr.?ml");break;
            case 10:component = Qt.createComponent("./plugins/E?sy.?ml");break;
            case 11:component = Qt.createComponent("./plugins/Kicks?ar?er.?ml");break;
            case 12:component = Qt.createComponent("./plugins/GoFundMe.?ml");break;
            case 13:component = Qt.createComponent("./plugins/Medium.?ml");break;
            case 14:component = Qt.createComponent("./plugins/WordPress.?ml");break;
            case 15:component = Qt.createComponent("./plugins/RSS.?ml");break;
            case 16:component = Qt.createComponent("./plugins/S?eemi?.?ml");break;

    // Note that if tile.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().

    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(gameboard);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }
        var blockSizex = gameboard.width /10.7;
        var blockSizey = gameboard.height /10.7;
       if (row % 2 == 0) {
                dynamicObject.x = (column * blockSizex + blockSizex / 2);
            } else {

           dynamicObject.x =(column * blockSizex);
       }
        dynamicObject.y =(row * blockSizey);

        dynamicObject.width = blockSizex * 1.0;
        dynamicObject.height = blockSizey *1.3;

        dynamicObject.num = num;
        dynamicObject.row = row;
        dynamicObject.column = column;
        dynamicObject.type = 98;
        dynamicObject.player = 100;
       dynamicObject.etype = 0;
       tiles[num] = dynamicObject;


    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }

    return true;
}
