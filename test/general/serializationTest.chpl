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
uint64Dump(92233720368, 1, s);
writeln(s == b"\x08\xB0\xC4\xBB\xCC\xD7\x02" );
s = b"";
uint64Dump(1, 1, s);
writeln(s == b"\x08\x01");

s = b"\xB0\xC4\xBB\xCC\xD7\x02";
writeln(uint64Load(s) == 92233720368);
s = b"\x01";
writeln(uint64Load(s) == 1);

s = b"";
uint32Dump(4294967294, 1, s);
writeln(s == b"\x08\xFE\xFF\xFF\xFF\x0F");
s = b"";
uint32Dump(1, 1, s);
writeln(s == b"\x08\x01");

s = b"\xFE\xFF\xFF\xFF\x0F";
writeln(uint32Load(s) == 4294967294);
s = b"\x01";
writeln(uint32Load(s) == 1);

s = b"";
int64Dump(92233720368547758, 1, s);
writeln(s == b"\x08\xAE\x8F\x85\xD7\xC7\xC2\xEB\xA3\x01");
s = b"";
int64Dump(1, 1, s);
writeln(s == b"\x08\x01");

s = b"\xAE\x8F\x85\xD7\xC7\xC2\xEB\xA3\x01";
writeln(int64Load(s) ==  92233720368547758);
s = b"\x01";
writeln(int64Load(s) == 1);

s = b"";
int32Dump(2147483646, 1, s);
writeln(s == b"\x08\xFE\xFF\xFF\xFF\x07");
s = b"";
int32Dump(1, 1, s);
writeln(s == b"\x08\x01");

s = b"\xFE\xFF\xFF\xFF\x07";
writeln(int32Load(s) == 2147483646);
s = b"\x01";
writeln(int32Load(s) == 1);

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

s = b"";
sint32Dump(-214748364, 1, s);
writeln(s ==  b"\x08\x97\xB3\xE6\xCC\x01");
s = b"";
sint32Dump(-1, 1, s);
writeln(s == b"\x08\x01");

s = b"\x97\xB3\xE6\xCC\x01";
writeln(sint32Load(s) == -214748364);
s = b"\x01";
writeln(sint32Load(s) == -1);

s = b"";
sint64Dump(-9223372036854775, 1, s);
writeln(s == b"\x08\xED\xCF\x9A\xDE\xF4\xA6\xE2 ");
s = b"";
sint64Dump(-2, 1, s);
writeln(s == b"\x08\x03");

s = b"\xED\xCF\x9A\xDE\xF4\xA6\xE2 ";
writeln(sint64Load(s) == -9223372036854775);
s = b"\x03";
writeln(sint64Load(s) == -2);

s = b"";
bytesDump(b"testing", 1, s);
writeln(s == b"\n\x07testing");
s = b"";
bytesDump(b"\x97\xB3\xE6\xCC\x01", 1, s);
writeln(s == b"\n\x05\x97\xB3\xE6\xCC\x01");

s = b"\x07testing";
writeln(bytesLoad(s) == b"testing");
s = b"\x05\x97\xB3\xE6\xCC\x01";
writeln(bytesLoad(s) == b"\x97\xB3\xE6\xCC\x01");

s = b"";
stringDump("testing", 1, s);
writeln(s == b"\n\x07testing");
s = b"";
stringDump("String with space", 1, s);
writeln(s == b"\n\x11String with space");

s = b"\x07testing";
writeln(stringLoad(s) == "testing");
s = b"\x11String with space";
writeln(stringLoad(s) == "String with space");

s = b"";
fixed32Dump(0, 1, s);
writeln(s == b"\x0D\x00\x00\x00\x00");
s = b"";
fixed32Dump(300000, 1, s);
writeln(s == b"\x0D\xE0\x93\x04\x00");

s = b"\x00\x00\x00\x00";
writeln(fixed32Load(s) == 0);
s = b"\xE0\x93\x04\x00";
writeln(fixed32Load(s) == 300000);

s = b"";
fixed64Dump(0, 1, s);
writeln(s == b"\x09\x00\x00\x00\x00\x00\x00\x00\x00");
s = b"";
fixed64Dump(400000000000, 1, s);
writeln(s == b"\x09\x00\xA0\xDB!]\x00\x00\x00");

s = b"\x00\x00\x00\x00\x00\x00\x00\x00";
writeln(fixed64Load(s) == 0);
s = b"\x00\xA0\xDB!]\x00\x00\x00";
writeln(fixed64Load(s) == 400000000000);

s = b"";
floatDump(4.6789, 1, s);
writeln(s == b"\x0D\x8C\xB9\x95@");
s = b"";
floatDump(4000.34, 1, s);
writeln(s == b"\x0Dq\x05zE");

s = b"\x8C\xB9\x95@";
writeln(ceil(floatLoad(s)) == 5);
s = b"q\x05zE";
writeln(ceil(floatLoad(s)) == 4001);

s = b"";
doubleDump(4.578694, 1, s);
writeln(s == b"\x09\xD1\x90\xF1(\x95P\x12@");
s = b"";
doubleDump(444444444444.23444, 1, s);
writeln(s == b"\x09\x01\x0F\xC7\x01\xBD\xDEYB");

s = b"\xD1\x90\xF1(\x95P\x12@";
writeln(ceil(doubleLoad(s)) == 5);
s = b"\x01\x0F\xC7\x01\xBD\xDEYB";
writeln(ceil(doubleLoad(s)) == 444444444445);

s = b"";
sfixed32Dump(-23, 1, s);
writeln(s == b"\x0D\xE9\xFF\xFF\xFF");
s = b"";
sfixed32Dump(-4000, 1, s);
writeln(s == b"\x0D`\xF0\xFF\xFF");

s = b"\xE9\xFF\xFF\xFF";
writeln(sfixed32Load(s) == -23);
s = b"`\xF0\xFF\xFF";
writeln(sfixed32Load(s) == -4000);

s = b"";
sfixed64Dump(-78, 1, s);
writeln(s == b"\x09\xB2\xFF\xFF\xFF\xFF\xFF\xFF\xFF");
s = b"";
sfixed64Dump(-400000000, 1, s);
writeln(s == b"\x09\x00|(\xE8\xFF\xFF\xFF\xFF");

s = b"\xB2\xFF\xFF\xFF\xFF\xFF\xFF\xFF";
writeln(sfixed64Load(s) == -78);
s = b"\x00|(\xE8\xFF\xFF\xFF\xFF";
writeln(sfixed64Load(s) == -400000000);
