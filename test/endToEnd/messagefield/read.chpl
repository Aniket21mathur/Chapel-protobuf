use messagefield;
use IO;
use List;

var messageObj = new messageA();
var file = open("out", iomode.r);
var readingChannel = file.reader();

messageObj.parseFromInputFile(readingChannel);

writeln(messageObj.a.b == 150);
writeln(messageObj.a.c ==  "String with spaces");
