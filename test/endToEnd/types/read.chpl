use types;
use IO;


var messageObj = new Types();
var file = open("out", iomode.r);
var readingChannel = file.reader();

var byteStream:bytes;
readingChannel.readbytes(byteStream);
messageObj.unserialize(byteStream);

writeln(messageObj.ui64 == 9223372036854);
writeln(messageObj.ui32 == 429496729);
writeln(messageObj.i64 == -600000);
writeln(messageObj.i32 == 214748364);
writeln(messageObj.bo == true);
writeln(messageObj.si64 == -675348989989);
writeln(messageObj.si32 == -214748364);
