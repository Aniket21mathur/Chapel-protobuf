import types_pb2

messageObj = types_pb2.Types()

messageObj.age = -150
messageObj.year = 1000000

messageObj.fun = False

file = open("out", "wb")
file.write(messageObj.SerializeToString())
file.close()
