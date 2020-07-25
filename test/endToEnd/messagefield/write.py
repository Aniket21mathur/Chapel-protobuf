import messagefield_pb2

messageObj = messagefield_pb2.messageA()

messageObj.a.b = 150
messageObj.a.c = "String with spaces"

tmpObj1 = messagefield_pb2.messageC()
tmpObj2 = messagefield_pb2.messageC()
tmpObj1.d = 26
tmpObj1.e = True
messageObj.f.append(tmpObj1)
tmpObj2.d = 36
tmpObj2.e = False
messageObj.f.append(tmpObj2)

file = open("out", "wb")
file.write(messageObj.SerializeToString())
file.close()
