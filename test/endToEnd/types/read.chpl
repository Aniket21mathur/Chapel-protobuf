use types;
use IO;


var messageObj = new Types();
var file = open("out", iomode.r);
var readingChannel = file.reader();

var byteStream:bytes;
readingChannel.read(byteStream);
messageObj.unserialize(byteStream);

writeln(messageObj.age == -150);
writeln(messageObj.year == 1000000);
writeln(messageObj.fun == false);
