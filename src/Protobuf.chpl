/* Documentation for protobuf */
module Protobuf {

  use SysCTypes;

  // wireTypes
  const varint = 0;
  const lengthDelimited = 2;
  const fixed64Type = 1;
  const fixed32Type = 5;

  proc unsignedVarintDump(val:uint): bytes {
    if val == 0 then
      return b"\x00";

    var s: bytes = b"";
    var newVal = val;
    var shiftVal: uint;
    while newVal != 0 {
      shiftVal = newVal >> 7;
      var k = if shiftVal != 0 then 0x80 else 0x00;
      var newByte = (newVal & 0x7F | k):uint(8);
      s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
      newVal = shiftVal;
    }
    return s;
  }

  proc unsignedVarintLoad(s: bytes): (uint, int) {
    var shift = 0;
    var val:uint;
    var len = 0;
    for i in s {
      val = val + ((i & 0x7F): uint << shift);
      shift = shift + 7;
      len = len + 1;
      if (i & 0x80) == 0 then break;
    }
    return (val, len);
  }

  proc tagLoad(ref s:bytes) {
    var (tag, tlen) = unsignedVarintLoad(s);
    var wireType = (tag & 0x7): int;
    var fieldNumber = (tag >> 3): int;
    s = s[tlen..];
    return fieldNumber;
  }

  proc tagDump(fieldNumber, wireType, ref s: bytes) {
    s = s + unsignedVarintDump(((fieldNumber << 3) | wireType):uint);
  }

  proc uint64Dump(val: uint(64), fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = val:uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc uint64Load(ref s: bytes): uint(64) {
    var (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return val:uint(64);
  }

  proc uint32Dump(val: uint(32), fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = val:uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc uint32Load(ref s: bytes): uint(32) {
    var (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return val:uint(32);
  }

  proc int64Dump(val: int(64), fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = val:uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc int64Load(ref s: bytes): int {
    var (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return val:int(64);
  }

  proc int32Dump(val: int(32), fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = val:uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc int32Load(ref s: bytes): int(32) {
    var (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return val:int(32);
  }

  proc boolDump(val: bool, fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = val:uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc boolLoad(ref s: bytes): bool {
    var (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return val:bool;
  }

  proc sint64Dump(val: int(64), fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = (val << 1):uint ^ (val >> 63):uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc sint64Load(ref s: bytes): int(64) {
    const (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return (val >> 1):int(64) ^ (val):int(64) << 63 >> 63;
  }

  proc sint32Dump(val: int(32), fieldNumber, ref s: bytes) {
    const wireType = varint;
    tagDump(fieldNumber, wireType, s);
    var uintVal = (val << 1):uint ^ (val >> 31):uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc sint32Load(ref s: bytes): int(32) {
    const (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return (val >> 1):int(32) ^ (val):int(32) << 31 >> 31;
  }

  proc bytesDump(val: bytes, fieldNumber, ref s: bytes) {
    const wireType = lengthDelimited;
    tagDump(fieldNumber, wireType, s);
    s =  s + unsignedVarintDump((val.size):uint) + val;
  }

  proc bytesLoad(ref s: bytes): bytes {
    const (byteLen, len) = unsignedVarintLoad(s);
    const byteVal = s[len..byteLen:int+len-1];
    s = s[byteLen:int+len..];
    return byteVal;
  }

  proc stringDump(val: string, fieldNumber, ref s: bytes) {
    bytesDump(val.encode(), fieldNumber, s);
  }

  proc stringLoad(ref s: bytes): string throws {
    return bytesLoad(s).decode();
  }

  proc fixed32Dump(val: uint(32), fieldNumber, ref s: bytes) {
    const wireType = fixed32Type;
    tagDump(fieldNumber, wireType, s);
    for i in 0..24 by 8 {
      var newByte = (val >> i):uint(8);
      s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
    }
  }

  proc fixed32Load(ref s: bytes): uint(32) {
    var val: uint(32);
    var shift = 0;
    for i in 0..3 {
      val = val | (s[i]: uint(32) << shift);
      shift = shift + 8;
    }
    s = s[4..];
    return val;
  }

  proc fixed64Dump(val: uint(64), fieldNumber, ref s: bytes) {
    const wireType = fixed64Type;
    tagDump(fieldNumber, wireType, s);
    for i in 0..56 by 8 {
      var newByte = (val >> i):uint(8);
      s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
    }
  }

  proc fixed64Load(ref s: bytes): uint(64) {
    var val: uint(64);
    var shift = 0;
    for i in 0..7 {
      val = val | (s[i]: uint(64) << shift);
      shift = shift + 8;
    }
    s = s[8..];
    return val;
  }
  
  proc floatDump(val: real(32), fieldNumber, ref s: bytes) {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Dump(b, fieldNumber, s);
  }
  
  proc floatLoad(ref s: bytes): real(32) {
    var a = fixed32Load(s);
    var b: real(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc doubleDump(val: real(64), fieldNumber, ref s: bytes) {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Dump(b, fieldNumber, s);
  }
  
  proc doubleLoad(ref s: bytes): real(64) {
    var a = fixed64Load(s);
    var b: real(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed64Dump(val: int(64), fieldNumber, ref s: bytes) {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Dump(b, fieldNumber, s);
  }

  proc sfixed64Load(ref s: bytes): int(64) {
    var a = fixed64Load(s);
    var b: int(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed32Dump(val: int(32), fieldNumber, ref s: bytes) {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Dump(b, fieldNumber, s);
  }

  proc sfixed32Load(ref s: bytes): int(32) {
    var a = fixed32Load(s);
    var b: int(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

}
