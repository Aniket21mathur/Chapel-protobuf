import messagefield_pb2

messageObj = messagefield_pb2.messageA()

file = open("out", "rb")
messageObj.ParseFromString(file.read())
file.close()

if messageObj.a.b != 150 or messageObj.a.c != "String with spaces":
    print("false")
else:
    print("true")
    