import types_pb2

messageObj = types_pb2.Types()

file = open("out", "rb")
messageObj.ParseFromString(file.read())
file.close()

if messageObj.ui64 != 9223372036854 or messageObj.ui32 != 429496729:
    print("false")
else:
    print("true")

if messageObj.i64 != -600000 or messageObj.i32 != 214748364:
    print("false")
else:
    print("true")

if messageObj.si64 != -675348989989 or messageObj.si32 != -214748364:
    print("false")
else:
    print("true")

if messageObj.bo != True:
    print("false")
else:
    print("true")

if messageObj.byt != b'\x97\xB3\xE6\xCC\x01':
    print("false")
else:
    print("true")

if messageObj.st != "Protobuf implementation for chapel":
    print("false")
else:
    print("true")
