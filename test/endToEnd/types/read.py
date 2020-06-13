import types_pb2

messageObj = types_pb2.Types()

file = open("out", "rb")
messageObj.ParseFromString(file.read())
file.close()

if messageObj.age != -150 or messageObj.year != 1000000:
    print("false")
else:
    print("true")

if messageObj.fun != False:
    print("false")
else:
    print("true")