/* Documentation for protobuf */
module Protobuf {

  // wireTypes
  const Varint = 0;
  const Bit64 = 1;
  const LengthDelimited = 2;
  const Bit32 = 5;

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

  proc integerDump64(val: int(64)): bytes {
    var uintVal = val:uint;
    return unsignedVarintDump(uintVal);
  }

  proc integerLoad64(s: bytes): (int, int) {
    var (val, len) = unsignedVarintLoad(s);
    return (val:int(64), len);
  }
  
  proc integerDump32(val: int(32)): bytes {
    var uintVal = val:uint;
    return unsignedVarintDump(uintVal);
  }

  proc integerLoad32(s: bytes): (int(32), int) {
    var (val, len) = unsignedVarintLoad(s);
    return (val:int(32), len);
  }

  proc boolDump(val: bool): bytes {
    var uintVal = val:uint;
    return unsignedVarintDump(uintVal);
  }

  proc boolLoad(s: bytes): (bool, int) {
    var (val, len) = unsignedVarintLoad(s);
    return (val:bool, len);
  }

  proc messageFieldDump(fieldVal, fieldNumber, ref s) {
    var wireType = 0;
    var tagDump = unsignedVarintDump(((fieldNumber << 3) | wireType):uint);
    s = s + tagDump;
    //ToDo Should be handled for generalized cases
    if fieldVal.type == int(32) then
      s = s + integerDump32(fieldVal);
    else if fieldVal.type == int(64) then
      s = s + integerDump64(fieldVal);
    else if fieldVal.type == bool then
      s = s + boolDump(fieldVal);
  }

  proc getFieldNumber(ref s:bytes) {
    var (tag, tlen) = unsignedVarintLoad(s);
    var wireType = (tag & 0x7): int;
    var fieldNumber = (tag >> 3): int;
    s = s[tlen..];
    return fieldNumber;
  }  

  proc messageFieldLoad(ref s:bytes, type t) {
    var val:t, vlen:int;
    if t == int(32) {
      (val, vlen) = integerLoad32(s);
    } else if t == int(64) {
      (val, vlen) = integerLoad64(s);
    } else if t == bool {
      (val, vlen) = boolLoad(s);
    }
    s = s[vlen..];
    return val;
  }

}
