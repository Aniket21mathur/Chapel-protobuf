use Protobuf;

var s:bytes;

writeln(unsignedVarintDump(0) == b"\x00");
writeln(unsignedVarintDump(3) == b"\x03");
writeln(unsignedVarintDump(270) == b"\x8E\x02");
writeln(unsignedVarintDump(86942) == b"\x9E\xA7\x05");

writeln(unsignedVarintLoad(b"\x00")(0) == 0);
writeln(unsignedVarintLoad(b"\x03")(0) == 3);
writeln(unsignedVarintLoad(b"\x8E\x02")(0) == 270);
writeln(unsignedVarintLoad(b"\x9E\xA7\x05")(0) == 86942);

s = b"";
boolDump(true, 1, s);
writeln(s == b"\x08\x01");
s = b"";
boolDump(false, 1, s);
writeln(s == b"\x08\x00");

s = b"\x01";
writeln(boolLoad(s) == true);
s = b"\x00";
writeln(boolLoad(s) == false);
