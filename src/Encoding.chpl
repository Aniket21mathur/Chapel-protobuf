/* Documentation for Encoding */
module Encoding {

  use SysCTypes;

  // wireTypes
  const varint = 0;
  const lengthDelimited = 2;
  const fixed64Type = 1;
  const fixed32Type = 5;

  proc unsignedVarintDump(val:uint, ch) throws {
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
      ch.write(createBytesWithNewBuffer(c_ptrTo(newByte), 1));
      newVal = shiftVal;
    }
  }

  proc unsignedVarintLoad(ch): (uint, int) throws {
    var shift = 0;
    var val:uint;
    var len = 0;
    var s:bytes;
    while true {
      s = b"";
      ch.readbytes(s, 1);
      if s == b"" then return (val, -1);
      val = val + ((s[0] & 0x7F): uint << shift);
      shift = shift + 7;
      len = len + 1;
      if (s[0] & 0x80) == 0 then break;
    }
    return (val, len);
  }

  proc tagLoad(ch) throws {
    var (tag, tlen) = unsignedVarintLoad(ch);
    if tlen == -1 then return -1;
    var wireType = (tag & 0x7): int;
    var fieldNumber = (tag >> 3): int;
    return fieldNumber;
  }

  proc tagDump(fieldNumber, wireType, ch) throws {
    unsignedVarintDump(((fieldNumber << 3) | wireType):uint, ch);
  }
  
  proc uint64Dump(val: uint(64), fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = val:uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc uint64Load(ch): uint(64) throws {
    var (val, len) = unsignedVarintLoad(ch);
    return val:uint(64);
  }

  proc uint32Dump(val: uint(32), fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = val:uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc uint32Load(ch): uint(32) throws {
    var (val, len) = unsignedVarintLoad(ch);
    return val:uint(32);
  }
  

  proc int64Dump(val: int(64), fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = val:uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc int64Load(ch): int throws {
    var (val, len) = unsignedVarintLoad(ch);
    return val:int(64);
  }

  proc int32Dump(val: int(32), fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = val:uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc int32Load(ch): int(32) throws {
    var (val, len) = unsignedVarintLoad(ch);
    return val:int(32);
  }

  proc boolDump(val: bool, fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = val:uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc boolLoad(ch): bool throws {
    var (val, len) = unsignedVarintLoad(ch);
    return val:bool;
  }

  proc sint64Dump(val: int(64), fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = (val << 1):uint ^ (val >> 63):uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc sint64Load(ch): int(64) throws {
    const (val, len) = unsignedVarintLoad(ch);
    return (val >> 1):int(64) ^ (val):int(64) << 63 >> 63;
  }

  proc sint32Dump(val: int(32), fieldNumber, ch) throws {
    const wireType = varint;
    tagDump(fieldNumber, wireType, ch);
    var uintVal = (val << 1):uint ^ (val >> 31):uint;
    unsignedVarintDump(uintVal, ch);
  }

  proc sint32Load(ch): int(32) throws {
    const (val, len) = unsignedVarintLoad(ch);
    return (val >> 1):int(32) ^ (val):int(32) << 31 >> 31;
  }

  proc bytesDump(val: bytes, fieldNumber, ch) throws {
    const wireType = lengthDelimited;
    tagDump(fieldNumber, wireType, ch);
    unsignedVarintDump((val.size):uint, ch);
    ch.write(val);
  }

  proc bytesLoad(ch): bytes throws {
    const (byteLen, len) = unsignedVarintLoad(ch);
    var s:bytes;
    ch.readbytes(s, byteLen:int);
    return s;
  }

  proc stringDump(val: string, fieldNumber, ch) throws {
    bytesDump(val.encode(), fieldNumber, ch);
  }

  proc stringLoad(ch): string throws {
    return bytesLoad(ch).decode();
  }


  proc fixed32Dump(val: uint(32), fieldNumber, ch) throws {
    const wireType = fixed32Type;
    tagDump(fieldNumber, wireType, ch);
    for i in 0..24 by 8 {
      var newByte = (val >> i):uint(8);
      ch.write(createBytesWithNewBuffer(c_ptrTo(newByte), 1));
    }
  }

  proc fixed32Load(ch): uint(32) throws {
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

  proc fixed64Dump(val: uint(64), fieldNumber, ch) throws {
    const wireType = fixed64Type;
    tagDump(fieldNumber, wireType, ch);
    for i in 0..56 by 8 {
      var newByte = (val >> i):uint(8);
      ch.write(createBytesWithNewBuffer(c_ptrTo(newByte), 1));
    }
  }

  proc fixed64Load(ch): uint(64) throws {
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
  
  proc floatDump(val: real(32), fieldNumber, ch) throws {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Dump(b, fieldNumber, ch);
  }
  
  proc floatLoad(ch): real(32) throws {
    var a = fixed32Load(ch);
    var b: real(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc doubleDump(val: real(64), fieldNumber, ch) throws {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Dump(b, fieldNumber, ch);
  }
  
  proc doubleLoad(ch): real(64) throws {
    var a = fixed64Load(ch);
    var b: real(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed64Dump(val: int(64), fieldNumber, ch) throws {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Dump(b, fieldNumber, ch);
  }

  proc sfixed64Load(ch): int(64) throws {
    var a = fixed64Load(ch);
    var b: int(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed32Dump(val: int(32), fieldNumber, ch) throws {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Dump(b, fieldNumber, ch);
  }

  proc sfixed32Load(ch): int(32) throws {
    var a = fixed32Load(ch);
    var b: int(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

}
