use Protobuf;

writeln(unsignedVarintDump(0) == b"\x00");
writeln(unsignedVarintDump(3) == b"\x03");
writeln(unsignedVarintDump(270) == b"\x8E\x02");
writeln(unsignedVarintDump(86942) == b"\x9E\xA7\x05");

writeln(unsignedVarintLoad(b"\x00")(0) == 0);
writeln(unsignedVarintLoad(b"\x03")(0) == 3);
writeln(unsignedVarintLoad(b"\x8E\x02")(0) == 270);
writeln(unsignedVarintLoad(b"\x9E\xA7\x05")(0) == 86942);
