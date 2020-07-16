import enums_pb2

messageObj = enums_pb2.enumTest()

file = open("out", "rb")
messageObj.ParseFromString(file.read())
file.close()

if messageObj.a != enums_pb2.color.blue:
    print("false")
else:
    print("true")

if messageObj.b != 564:
    print("false")
else:
    print("true")
    