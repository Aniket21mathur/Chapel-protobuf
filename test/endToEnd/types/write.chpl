use types;
use IO;

var file = open("out", iomode.cw);
var writingChannel = file.writer();

var messageObj = new Types();
messageObj.ui64 = 9223372036854;
messageObj.ui32 = 429496729;

messageObj.i64 = -600000;
messageObj.i32 = 214748364;

messageObj.bo = true;

messageObj.si64 = -675348989989;
messageObj.si32 = -214748364;

writingChannel.write(messageObj.serialize());
