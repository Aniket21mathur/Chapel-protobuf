use enums;
use IO;

var file = open("out", iomode.cw);
var writingChannel = file.writer();

var messageObj = new enumTest();

messageObj.a = color.blue;

messageObj.b = 564;

messageObj.writeToOutputFile(writingChannel);