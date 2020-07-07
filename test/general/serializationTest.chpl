use Encoding;
use IO;

var f = openmem();

// tests for unsignedVarint
unsignedVarintAppend(0, f.writer(kind=iokind.little, locking=false));
writeln(unsignedVarintConsume(f.reader(kind=iokind.little, locking=false))(0) == 0);

unsignedVarintAppend(86942, f.writer(kind=iokind.little, locking=false));
writeln(unsignedVarintConsume(f.reader(kind=iokind.little, locking=false))(0) == 86942);

// tests for uint64
uint64Append(92233720368, f.writer(kind=iokind.little, locking=false));
writeln(uint64Consume(f.reader(kind=iokind.little, locking=false)) == 92233720368);

uint64Append(1, f.writer(kind=iokind.little, locking=false));
writeln(uint64Consume(f.reader(kind=iokind.little, locking=false)) == 1);

// tests for uint32
uint32Append(4294967294, f.writer(kind=iokind.little, locking=false));
writeln(uint32Consume(f.reader(kind=iokind.little, locking=false)) == 4294967294);

uint32Append(1, f.writer(kind=iokind.little, locking=false));
writeln(uint32Consume(f.reader(kind=iokind.little, locking=false)) == 1);

// tests for int64
int64Append(92233720368547758, f.writer(kind=iokind.little, locking=false));
writeln(int64Consume(f.reader(kind=iokind.little, locking=false)) == 92233720368547758);

int64Append(1, f.writer(kind=iokind.little, locking=false));
writeln(int64Consume(f.reader(kind=iokind.little, locking=false)) == 1);

// tests for int32
int32Append(2147483646, f.writer(kind=iokind.little, locking=false));
writeln(int32Consume(f.reader(kind=iokind.little, locking=false)) == 2147483646);

int32Append(1, f.writer(kind=iokind.little, locking=false));
writeln(int32Consume(f.reader(kind=iokind.little, locking=false)) == 1);

// tests for bool
boolAppend(true, f.writer(kind=iokind.little, locking=false));
writeln(boolConsume(f.reader(kind=iokind.little, locking=false)) == true);

boolAppend(false, f.writer(kind=iokind.little, locking=false));
writeln(boolConsume(f.reader(kind=iokind.little, locking=false)) == false);

// tests for sint32
sint32Append(-214748364, f.writer(kind=iokind.little, locking=false));
writeln(sint32Consume(f.reader(kind=iokind.little, locking=false)) == -214748364);

sint32Append(-1, f.writer(kind=iokind.little, locking=false));
writeln(sint32Consume(f.reader(kind=iokind.little, locking=false)) == -1);

// tests for sint64
sint64Append(-9223372036854775, f.writer(kind=iokind.little, locking=false));
writeln(sint64Consume(f.reader(kind=iokind.little, locking=false)) == -9223372036854775);

sint64Append(-2, f.writer(kind=iokind.little, locking=false));
writeln(sint64Consume(f.reader(kind=iokind.little, locking=false)) == -2);

// tests for bytes
bytesAppend(b"testing", f.writer(kind=iokind.little, locking=false));
writeln(bytesConsume(f.reader(kind=iokind.little, locking=false)) == b"testing");

bytesAppend(b"\x97\xB3\xE6\xCC\x01", f.writer(kind=iokind.little, locking=false));
writeln(bytesConsume(f.reader(kind=iokind.little, locking=false)) == b"\x97\xB3\xE6\xCC\x01");

// tests for string
stringAppend("testing", f.writer(kind=iokind.little, locking=false));
writeln(stringConsume(f.reader(kind=iokind.little, locking=false)) == "testing");

stringAppend("String with space", f.writer(kind=iokind.little, locking=false));
writeln(stringConsume(f.reader(kind=iokind.little, locking=false)) == "String with space");

// tests for fixed32
fixed32Append(0, f.writer(kind=iokind.little, locking=false));
writeln(fixed32Consume(f.reader(kind=iokind.little, locking=false)) == 0);

fixed32Append(300000, f.writer(kind=iokind.little, locking=false));
writeln(fixed32Consume(f.reader(kind=iokind.little, locking=false)) == 300000);

// tests for fixed32
fixed32Append(0, f.writer(kind=iokind.little, locking=false));
writeln(fixed32Consume(f.reader(kind=iokind.little, locking=false)) == 0);

fixed32Append(300000, f.writer(kind=iokind.little, locking=false));
writeln(fixed32Consume(f.reader(kind=iokind.little, locking=false)) == 300000);

// tests for fixed64
fixed64Append(0, f.writer(kind=iokind.little, locking=false));
writeln(fixed64Consume(f.reader(kind=iokind.little, locking=false)) == 0);

fixed64Append(400000000000, f.writer(kind=iokind.little, locking=false));
writeln(fixed64Consume(f.reader(kind=iokind.little, locking=false)) == 400000000000);

// tests for float
floatAppend(4.6789, f.writer(kind=iokind.little, locking=false));
writeln(floatConsume(f.reader(kind=iokind.little, locking=false)) == 4.6789);

floatAppend(4000.34, f.writer(kind=iokind.little, locking=false));
writeln(floatConsume(f.reader(kind=iokind.little, locking=false)) == 4000.34);

// tests for double
doubleAppend(4.578694, f.writer(kind=iokind.little, locking=false));
writeln(doubleConsume(f.reader(kind=iokind.little, locking=false)) == 4.578694);

doubleAppend(444444444444.23444, f.writer(kind=iokind.little, locking=false));
writeln(doubleConsume(f.reader(kind=iokind.little, locking=false)) == 444444444444.23444);

// tests for sfixed32
sfixed32Append(-23, f.writer(kind=iokind.little, locking=false));
writeln(sfixed32Consume(f.reader(kind=iokind.little, locking=false)) == -23);

sfixed32Append(-4000, f.writer(kind=iokind.little, locking=false));
writeln(sfixed32Consume(f.reader(kind=iokind.little, locking=false)) == -4000);

// tests for sfixed64
sfixed64Append(-78, f.writer(kind=iokind.little, locking=false));
writeln(sfixed64Consume(f.reader(kind=iokind.little, locking=false)) == -78);

sfixed64Append(-400000000, f.writer(kind=iokind.little, locking=false));
writeln(sfixed64Consume(f.reader(kind=iokind.little, locking=false)) == -400000000);

f.close();
