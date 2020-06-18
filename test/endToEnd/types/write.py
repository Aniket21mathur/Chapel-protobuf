import types_pb2

messageObj = types_pb2.Types()

messageObj.ui64 = 9223372036854
messageObj.ui32 = 429496729

messageObj.i64 = -600000
messageObj.i32 = 214748364

messageObj.bo = True

messageObj.si64 = -675348989989
messageObj.si32 = -214748364

messageObj.byt = b'\x97\xB3\xE6\xCC\x01';

messageObj.st = "Protobuf implementation for chapel"

messageObj.fi32 = 1000000;
messageObj.fi64 = 100000000000;

file = open("out", "wb")
file.write(messageObj.SerializeToString())
file.close()
