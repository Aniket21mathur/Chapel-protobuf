/* Documentation for protobuf */
module Protobuf {

  // wireTypes
  const wireType = 0;

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

  proc int64Dump(val: int(64), fieldNumber, ref s: bytes) {
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
    tagDump(fieldNumber, wireType, s);
    var uintVal = val:uint;
    s = s + unsignedVarintDump(uintVal);
  }

  proc boolLoad(ref s: bytes): bool {
    var (val, len) = unsignedVarintLoad(s);
    s = s[len..];
    return val:bool;
  }

}
