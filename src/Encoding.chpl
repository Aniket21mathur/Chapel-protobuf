/* Documentation for Encoding */
module Encoding {

  use SysCTypes;

  // wireTypes
  const varint = 0;
  const lengthDelimited = 2;
  const fixed64Type = 1;
  const fixed32Type = 5;

  proc unsignedVarintAppend(val:uint, ch) throws {
    if val == 0 {
      ch.write(b"\x00");
      return;
    }
  
    var newVal = val;
    var shiftVal: uint;
    while newVal != 0 {
      shiftVal = newVal >> 7;
      var k = if shiftVal != 0 then 0x80 else 0x00;
      var newByte = (newVal & 0x7F | k):uint(8);
      ch.writeBytes(newByte, 1);
      newVal = shiftVal;
    }
  }

  proc unsignedVarintConsume(ch): (uint, int) throws {
    var shift = 0;
    var val:uint;
    var len = 0;
    var s:bytes;
    while true {
      s = b"";
      if !ch.readbytes(s, 1) then return (val, -1);
      val = val + ((s[0] & 0x7F): uint << shift);
      shift = shift + 7;
      len = len + 1;
      if (s[0] & 0x80) == 0 then break;
    }
    return (val, len);
  }

  proc tagConsume(ch) throws {
    var (tag, tlen) = unsignedVarintConsume(ch);
    if tlen == -1 then return -1;
    var wireType = (tag & 0x7): int;
    var fieldNumber = (tag >> 3): int;
    return fieldNumber;
  }

  proc tagAppend(fieldNumber, wireType, ch) throws {
    unsignedVarintAppend(((fieldNumber << 3) | wireType):uint, ch);
  }
  
  proc uint64Append(val: uint(64), fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc uint64Consume(ch): uint(64) throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:uint(64);
  }

  proc uint32Append(val: uint(32), fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc uint32Consume(ch): uint(32) throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:uint(32);
  }
  

  proc int64Append(val: int(64), fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc int64Consume(ch): int throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:int(64);
  }

  proc int32Append(val: int(32), fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc int32Consume(ch): int(32) throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:int(32);
  }

  proc boolAppend(val: bool, fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc boolConsume(ch): bool throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:bool;
  }

  proc sint64Append(val: int(64), fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = (val << 1):uint ^ (val >> 63):uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc sint64Consume(ch): int(64) throws {
    const (val, len) = unsignedVarintConsume(ch);
    return (val >> 1):int(64) ^ (val):int(64) << 63 >> 63;
  }

  proc sint32Append(val: int(32), fieldNumber, ch) throws {
    const wireType = varint;
    var uintVal = (val << 1):uint ^ (val >> 31):uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc sint32Consume(ch): int(32) throws {
    const (val, len) = unsignedVarintConsume(ch);
    return (val >> 1):int(32) ^ (val):int(32) << 31 >> 31;
  }

  proc bytesAppend(val: bytes, fieldNumber, ch) throws {
    const wireType = lengthDelimited;
    unsignedVarintAppend((val.size):uint, ch);
    ch.write(val);
  }

  proc bytesConsume(ch): bytes throws {
    const (byteLen, len) = unsignedVarintConsume(ch);
    var s:bytes;
    ch.readbytes(s, byteLen:int);
    return s;
  }

  proc stringAppend(val: string, fieldNumber, ch) throws {
    bytesAppend(val.encode(), fieldNumber, ch);
  }

  proc stringConsume(ch): string throws {
    return bytesConsume(ch).decode();
  }


  proc fixed32Append(val: uint(32), fieldNumber, ch) throws {
    const wireType = fixed32Type;
    for i in 0..24 by 8 {
      var newByte = (val >> i):uint(8);
      ch.writeBytes(newByte, 1);
    }
  }

  proc fixed32Consume(ch): uint(32) throws {
    var val: uint(32);
    var shift = 0;
    var s: bytes;
    for i in 0..3 {
      s = b"";
      ch.readbytes(s, 1);
      val = val | (s[0]: uint(32) << shift);
      shift = shift + 8;
    }
    return val;
  }

  proc fixed64Append(val: uint(64), fieldNumber, ch) throws {
    const wireType = fixed64Type;
    for i in 0..56 by 8 {
      var newByte = (val >> i):uint(8);
      ch.writeBytes(newByte, 1);
    }
  }

  proc fixed64Consume(ch): uint(64) throws {
    var val: uint(64);
    var shift = 0;
    var s: bytes;
    for i in 0..7 {
      s = b"";
      ch.readbytes(s, 1);
      val = val | (s[0]: uint(64) << shift);
      shift = shift + 8;
    }
    return val;
  }

  proc floatAppend(val: real(32), fieldNumber, ch) throws {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Append(b, fieldNumber, ch);
  }
  
  proc floatConsume(ch): real(32) throws {
    var a = fixed32Consume(ch);
    var b: real(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc doubleAppend(val: real(64), fieldNumber, ch) throws {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Append(b, fieldNumber, ch);
  }
  
  proc doubleConsume(ch): real(64) throws {
    var a = fixed64Consume(ch);
    var b: real(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed64Append(val: int(64), fieldNumber, ch) throws {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Append(b, fieldNumber, ch);
  }

  proc sfixed64Consume(ch): int(64) throws {
    var a = fixed64Consume(ch);
    var b: int(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed32Append(val: int(32), fieldNumber, ch) throws {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Append(b, fieldNumber, ch);
  }

  proc sfixed32Consume(ch): int(32) throws {
    var a = fixed32Consume(ch);
    var b: int(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

}
