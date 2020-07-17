use messagefield;
use IO;

var file = open("out", iomode.cw);
var writingChannel = file.writer();

var messageObj = new messageA();

messageObj.a.b = 150;
messageObj.a.c = "String with spaces";

messageObj.writeToOutputFile(writingChannel);