use types;
use IO;

var file = open("out", iomode.cw);
var writingChannel = file.writer();

var messageObj = new Types();
messageObj.age = -150;
messageObj.year = 1000000;
writingChannel.write(messageObj.serialize());
