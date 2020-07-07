use Encoding;
use IO;


// tests for unsignedVarint
var f = opentmp();
unsignedVarintAppend(0, f.writer());
writeln(unsignedVarintConsume(f.reader())(0) == 0);
f.close();

f = opentmp();
unsignedVarintAppend(86942, f.writer());
writeln(unsignedVarintConsume(f.reader())(0) == 86942);
f.close();

// tests for uint64
f = opentmp();
uint64Append(92233720368, 1, f.writer());
writeln(uint64Consume(f.reader()) == 92233720368);
f.close();

f = opentmp();
uint64Append(1, 1, f.writer());
writeln(uint64Consume(f.reader()) == 1);
f.close();

// tests for uint32
f = opentmp();
uint32Append(4294967294, 1, f.writer());
writeln(uint32Consume(f.reader()) == 4294967294);
f.close();

f = opentmp();
uint32Append(1, 1, f.writer());
writeln(uint32Consume(f.reader()) == 1);
f.close();

// tests for int64
f = opentmp();
int64Append(92233720368547758, 1, f.writer());
writeln(int64Consume(f.reader()) == 92233720368547758);
f.close();

f = opentmp();
int64Append(1, 1, f.writer());
writeln(int64Consume(f.reader()) == 1);
f.close();

// tests for int32
f = opentmp();
int32Append(2147483646, 1, f.writer());
writeln(int32Consume(f.reader()) == 2147483646);
f.close();

f = opentmp();
int32Append(1, 1, f.writer());
writeln(int32Consume(f.reader()) == 1);
f.close();

// tests for bool
f = opentmp();
boolAppend(true, 1, f.writer());
writeln(boolConsume(f.reader()) == true);
f.close();

f = opentmp();
boolAppend(false, 1, f.writer());
writeln(boolConsume(f.reader()) == false);
f.close();

// tests for sint32
f = opentmp();
sint32Append(-214748364, 1, f.writer());
writeln(sint32Consume(f.reader()) == -214748364);
f.close();

f = opentmp();
sint32Append(-1, 1, f.writer());
writeln(sint32Consume(f.reader()) == -1);
f.close();

// tests for sint64
f = opentmp();
sint64Append(-9223372036854775, 1, f.writer());
writeln(sint64Consume(f.reader()) == -9223372036854775);
f.close();

f = opentmp();
sint64Append(-2, 1, f.writer());
writeln(sint64Consume(f.reader()) == -2);
f.close();

// tests for bytes
f = opentmp();
bytesAppend(b"testing", 1, f.writer());
writeln(bytesConsume(f.reader()) == b"testing");
f.close();

f = opentmp();
bytesAppend(b"\x97\xB3\xE6\xCC\x01", 1, f.writer());
writeln(bytesConsume(f.reader()) == b"\x97\xB3\xE6\xCC\x01");
f.close();

// tests for string
f = opentmp();
stringAppend("testing", 1, f.writer());
writeln(stringConsume(f.reader()) == "testing");
f.close();

f = opentmp();
stringAppend("String with space", 1, f.writer());
writeln(stringConsume(f.reader()) == "String with space");
f.close();

// tests for fixed32
f = opentmp();
fixed32Append(0, 1, f.writer());
writeln(fixed32Consume(f.reader()) == 0);
f.close();

f = opentmp();
fixed32Append(300000, 1, f.writer());
writeln(fixed32Consume(f.reader()) == 300000);
f.close();

// tests for fixed32
f = opentmp();
fixed32Append(0, 1, f.writer());
writeln(fixed32Consume(f.reader()) == 0);
f.close();

f = opentmp();
fixed32Append(300000, 1, f.writer());
writeln(fixed32Consume(f.reader()) == 300000);
f.close();

// tests for fixed64
f = opentmp();
fixed64Append(0, 1, f.writer());
writeln(fixed64Consume(f.reader()) == 0);
f.close();

f = opentmp();
fixed64Append(400000000000, 1, f.writer());
writeln(fixed64Consume(f.reader()) == 400000000000);
f.close();

// tests for float
f = opentmp();
floatAppend(4.6789, 1, f.writer());
writeln(floatConsume(f.reader()) == 4.6789);
f.close();

f = opentmp();
floatAppend(4000.34, 1, f.writer());
writeln(floatConsume(f.reader()) == 4000.34);
f.close();

// tests for double
f = opentmp();
doubleAppend(4.578694, 1, f.writer());
writeln(doubleConsume(f.reader()) == 4.578694);
f.close();

f = opentmp();
doubleAppend(444444444444.23444, 1, f.writer());
writeln(doubleConsume(f.reader()) == 444444444444.23444);
f.close();

// tests for sfixed32
f = opentmp();
sfixed32Append(-23, 1, f.writer());
writeln(sfixed32Consume(f.reader()) == -23);
f.close();

f = opentmp();
sfixed32Append(-4000, 1, f.writer());
writeln(sfixed32Consume(f.reader()) == -4000);
f.close();

// tests for sfixed64
f = opentmp();
sfixed64Append(-78, 1, f.writer());
writeln(sfixed64Consume(f.reader()) == -78);
f.close();

f = opentmp();
sfixed64Append(-400000000, 1, f.writer());
writeln(sfixed64Consume(f.reader()) == -400000000);
f.close();
