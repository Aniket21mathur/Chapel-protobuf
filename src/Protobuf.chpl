/* Documentation for protobuf */
module Protobuf {

  // wireTypes
  const varint = 0;
  const lengthDelimited = 2;

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

}
