use Encoding;
use IO;


// tests for unsignedVarint
var f = opentmp();
unsignedVarintDump(0, f.writer());
var r = f.reader();
writeln(unsignedVarintLoad(r)(0) == 0);
f.close();

f = opentmp();
unsignedVarintDump(86942, f.writer());
r = f.reader();
writeln(unsignedVarintLoad(r)(0) == 86942);
f.close();

// tests for uint64
f = opentmp();
uint64Dump(92233720368, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(uint64Load(r) == 92233720368);
f.close();

f = opentmp();
uint64Dump(1, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(uint64Load(r) == 1);
f.close();

// tests for uint32
f = opentmp();
uint32Dump(4294967294, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(uint32Load(r) == 4294967294);
f.close();

f = opentmp();
uint32Dump(1, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(uint32Load(r) == 1);
f.close();

// tests for int64
f = opentmp();
int64Dump(92233720368547758, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(int64Load(r) == 92233720368547758);
f.close();

f = opentmp();
int64Dump(1, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(int64Load(r) == 1);
f.close();

// tests for int32
f = opentmp();
int32Dump(2147483646, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(int32Load(r) == 2147483646);
f.close();

f = opentmp();
int32Dump(1, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(int32Load(r) == 1);
f.close();

// tests for bool
f = opentmp();
boolDump(true, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(boolLoad(r) == true);
f.close();

f = opentmp();
boolDump(false, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(boolLoad(r) == false);
f.close();

// tests for sint32
f = opentmp();
sint32Dump(-214748364, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sint32Load(r) == -214748364);
f.close();

f = opentmp();
sint32Dump(-1, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sint32Load(r) == -1);
f.close();

// tests for sint64
f = opentmp();
sint64Dump(-9223372036854775, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sint64Load(r) == -9223372036854775);
f.close();

f = opentmp();
sint64Dump(-2, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sint64Load(r) == -2);
f.close();

// tests for bytes
f = opentmp();
bytesDump(b"testing", 1, f.writer());
r = f.reader();
r.advance(1);
writeln(bytesLoad(r) == b"testing");
f.close();

f = opentmp();
bytesDump(b"\x97\xB3\xE6\xCC\x01", 1, f.writer());
r = f.reader();
r.advance(1);
writeln(bytesLoad(r) == b"\x97\xB3\xE6\xCC\x01");
f.close();

// tests for string
f = opentmp();
stringDump("testing", 1, f.writer());
r = f.reader();
r.advance(1);
writeln(stringLoad(r) == "testing");
f.close();

f = opentmp();
stringDump("String with space", 1, f.writer());
r = f.reader();
r.advance(1);
writeln(stringLoad(r) == "String with space");
f.close();

// tests for fixed32
f = opentmp();
fixed32Dump(0, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(fixed32Load(r) == 0);
f.close();

f = opentmp();
fixed32Dump(300000, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(fixed32Load(r) == 300000);
f.close();

// tests for fixed32
f = opentmp();
fixed32Dump(0, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(fixed32Load(r) == 0);
f.close();

f = opentmp();
fixed32Dump(300000, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(fixed32Load(r) == 300000);
f.close();

// tests for fixed64
f = opentmp();
fixed64Dump(0, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(fixed64Load(r) == 0);
f.close();

f = opentmp();
fixed64Dump(400000000000, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(fixed64Load(r) == 400000000000);
f.close();

// tests for float
f = opentmp();
floatDump(4.6789, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(floatLoad(r) == 4.6789);
f.close();

f = opentmp();
floatDump(4000.34, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(floatLoad(r) == 4000.34);
f.close();

// tests for double
f = opentmp();
doubleDump(4.578694, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(doubleLoad(r) == 4.578694);
f.close();

f = opentmp();
doubleDump(444444444444.23444, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(doubleLoad(r) == 444444444444.23444);
f.close();

// tests for sfixed32
f = opentmp();
sfixed32Dump(-23, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sfixed32Load(r) == -23);
f.close();

f = opentmp();
sfixed32Dump(-4000, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sfixed32Load(r) == -4000);
f.close();

// tests for sfixed64
f = opentmp();
sfixed64Dump(-78, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sfixed64Load(r) == -78);
f.close();

f = opentmp();
sfixed64Dump(-400000000, 1, f.writer());
r = f.reader();
r.advance(1);
writeln(sfixed64Load(r) == -400000000);
f.close();
