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

  proc integerDump(val: int): bytes {
    var uintVal = val:uint;
    return unsignedVarintDump(uintVal);
  }

  proc integerLoad(s: bytes): (int, int) {
    var (val, len) = unsignedVarintLoad(s);
    return (val:int, len);
  }

  proc messageFieldDump(fieldVal, fieldNumber, ref s) {
    var wireType = 0;
    var tagDump = integerDump((fieldNumber << 3) | wireType);
    s = s + tagDump;
    //ToDo Should be handled for generalized cases
    s = s + integerDump(fieldVal);
  }

  proc messageFieldLoad(ref s:bytes) {
      var (tag, tlen) = integerLoad(s);
      var wireType = (tag & 0x7): int;
      var fieldNumber = (tag >> 3): int;
      var (val, vlen) = integerLoad(s[tlen..]);
      s = s[tlen+vlen..];
      return (fieldNumber, val);
  }

}
