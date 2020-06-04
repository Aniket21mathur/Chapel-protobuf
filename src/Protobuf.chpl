/* Documentation for protobuf */
module Protobuf {

  // wireTypes
  const Varint = 0;
  const Bit64 = 1;
  const LengthDelimited = 2;
  const Bit32 = 5;

  proc unsignedVarintDump(val: int): bytes throws {
    if val < 0 {
      throw new owned IllegalArgumentError('val must be non-negative');
    } else if val == 0 {
      return b"\x00";
    }
    
    var s: bytes = b"";
    var newVal: int = val;
    var shiftVal: int;
    while newVal != 0 {
      shiftVal = newVal >> 7;
      var k = if shiftVal != 0 then 0x80 else 0x00;
      var newByte = (newVal & 0x7F | k):uint(8);
      s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
      newVal = shiftVal;
    }
    return s;
  }

  proc unsignedVarintLoad(s: bytes): (int, int) {
    var shift: int = 0;
    var val: int = 0;
    var len: int = 0;
    for i in s {
      val = val + ((i & 0x7F): int << shift);
      shift = shift + 7;
      len = len + 1;
      if (i & 0x80) == 0 then break;
    }
    return (val, len);
  }

  proc signedVarintDump(val: int): bytes throws {
    const newVal = abs(val)*2 - (val < 0);
    return unsignedVarintDump(newVal);
  }

  proc signedVarintLoad(s: bytes): int {
    const (t, l) = unsignedVarintLoad(s);
    return (t >> 1) ^ (-(t & 1));
  }

  proc bytesDump(val: bytes): bytes throws {
    const newVal = unsignedVarintDump(val.size);
    return newVal + val;
  }

  proc bytesLoad(s: bytes): bytes {
    const (len, l) = unsignedVarintLoad(s);
    return s[s.size-len..s.size-1];
  }

  proc stringDump(val: string): bytes throws {
    const newVal = val.encode();
    return bytesDump(newVal);
  }

  proc stringLoad(s: bytes): string throws {
    const bVaL = bytesLoad(s);
    return bVaL.decode();
  }

  proc boolDump(val: bool): bytes throws {
    return unsignedVarintDump(val: int);
  }

  proc boolLoad(s: bytes): bool {
    return unsignedVarintLoad(s)(0): bool;
  }

  proc enumDump(val: int): bytes throws {
    return unsignedVarintDump(val);
  }

  proc enumLoad(s: bytes): int {
    return unsignedVarintLoad(s)(0);
  }

  proc unsignedFixed32Dump(val: int(32)): bytes {
    var s: bytes = b"";
    for i in 0..24 by 8 {
      var newByte = ((val >> i) & 0xFF): uint(8);
      s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
    }
    return s;
  }

  proc unsignedFixed32Load(s: bytes): int(32) {
    var val:int(32);
    var shift: int;
    for i in s {
      val = val | (i: int(32) << shift);
      shift = shift + 8;
    }
    return val;
  }

  proc unsignedFixed64Dump(val: int(64)): bytes {
    var s: bytes = b"";
    for i in 0..56 by 8 {
      var newByte = ((val >> i) & 0xFF): uint(8);
      s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
    }
    return s;
  }

  proc unsignedFixed64Load(s: bytes): int(64) {
    var val:int(64);
    var shift: int;
    for i in s {
      val = val | (i: int(64) << shift);
      shift = shift + 8;
    }
    return val;
  }

  proc messageDump(numValMap): bytes throws {
    var s: bytes = b"";
    var wireType = 0;
    for fieldNumber in numValMap.keys() {
      var tagDump = unsignedVarintDump((fieldNumber << 3) | wireType);
      s = s + tagDump;
      //ToDo Should be handled for generalized cases
      s = s + unsignedVarintDump((numValMap[fieldNumber]:c_ptr(int)).deref());
    }
    return s;
  }

  proc messageLoad(s:bytes, ref numValMap) throws {
    var tmp = s;
    while tmp.size > 0 {
      var (tag, tlen) = unsignedVarintLoad(tmp);
      var wireType = (tag & 0x7): int;
      var fieldNumber = (tag >> 3): int;
      var (val, vlen) = unsignedVarintLoad(tmp[tlen..]);
      tmp = tmp[tlen+vlen..];
      (numValMap[fieldNumber]:c_ptr(int)).deref() = val;
    }
    return 0;
  }

}
