import enums_pb2

messageObj = enums_pb2.enumTest();

messageObj.a = enums_pb2.color.blue

messageObj.b = 564

file = open("out", "wb")
file.write(messageObj.SerializeToString())
file.close()
