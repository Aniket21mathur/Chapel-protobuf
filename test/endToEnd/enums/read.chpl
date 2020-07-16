use enums;
use IO;

var messageObj = new enumTest();
var file = open("out", iomode.r);
var readingChannel = file.reader();

messageObj.parseFromInputFile(readingChannel);

writeln(messageObj.a == color.blue);
writeln(messageObj.b == 564);
