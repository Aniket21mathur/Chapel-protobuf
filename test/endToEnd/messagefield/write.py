import messagefield_pb2

messageObj = messagefield_pb2.messageA()

messageObj.a.b = 150
messageObj.a.c = "String with spaces"

file = open("out", "wb")
file.write(messageObj.SerializeToString())
file.close()
