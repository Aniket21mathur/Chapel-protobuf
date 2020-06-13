use types;
use IO;

var file = open("out", iomode.cw);
var writingChannel = file.writer();

var messageObj = new Types();
messageObj.age = -150;
messageObj.year = 1000000;

messageObj.fun = false;
writingChannel.write(messageObj.serialize());
