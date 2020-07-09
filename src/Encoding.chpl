/* Documentation for Encoding */
module Encoding {

  use IO;

  type writingChannel = channel(true,iokind.little,false);
  type readingChannel = channel(false,iokind.little,false);

  // wireTypes
  const varint = 0;
  const lengthDelimited = 2;
  const fixed64Type = 1;
  const fixed32Type = 5;

  proc unsignedVarintAppend(val:uint, ch: writingChannel) throws {
    if val == 0 {
      var zero: uint(8);
      ch.write(zero);
      return;
    }
  
    var newVal = val;
    var shiftVal: uint;
    while newVal != 0 {
      shiftVal = newVal >> 7;
      var k = if shiftVal != 0 then 0x80 else 0x00;
      var newByte = (newVal & 0x7F | k):uint(8);
      ch.write(newByte);
      newVal = shiftVal;
    }
  }

  proc unsignedVarintConsume(ch: readingChannel): (uint, int) throws {
    var shift = 0;
    var val:uint;
    var len = 0;
    var s:uint(8);
    while true {
      if !ch.read(s) then return (val, -1);
      val = val + ((s & 0x7F): uint << shift);
      shift = shift + 7;
      len = len + 1;
      if (s & 0x80) == 0 then break;
    }
    return (val, len);
  }

  proc tagConsume(ch: readingChannel) throws {
    var (tag, tlen) = unsignedVarintConsume(ch);
    if tlen == -1 then return -1;
    var wireType = (tag & 0x7): int;
    var fieldNumber = (tag >> 3): int;
    return fieldNumber;
  }

  proc tagAppend(fieldNumber: int, wireType: int, ch: writingChannel) throws {
    unsignedVarintAppend(((fieldNumber << 3) | wireType):uint, ch);
  }
  
  proc uint64Append(val: uint(64), ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc uint64Consume(ch: readingChannel): uint(64) throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:uint(64);
  }

  proc uint32Append(val: uint(32), ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc uint32Consume(ch: readingChannel): uint(32) throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:uint(32);
  }
  

  proc int64Append(val: int(64), ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc int64Consume(ch: readingChannel): int throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:int(64);
  }

  proc int32Append(val: int(32), ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc int32Consume(ch: readingChannel): int(32) throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:int(32);
  }

  proc boolAppend(val: bool, ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = val:uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc boolConsume(ch: readingChannel): bool throws {
    var (val, len) = unsignedVarintConsume(ch);
    return val:bool;
  }

  proc sint64Append(val: int(64), ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = (val << 1):uint ^ (val >> 63):uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc sint64Consume(ch: readingChannel): int(64) throws {
    const (val, len) = unsignedVarintConsume(ch);
    return (val >> 1):int(64) ^ (val):int(64) << 63 >> 63;
  }

  proc sint32Append(val: int(64), ch: writingChannel) throws {
    const wireType = varint;
    var uintVal = (val << 1):uint ^ (val >> 31):uint;
    unsignedVarintAppend(uintVal, ch);
  }

  proc sint32Consume(ch: readingChannel): int(32) throws {
    const (val, len) = unsignedVarintConsume(ch);
    return (val >> 1):int(32) ^ (val):int(32) << 31 >> 31;
  }

  proc bytesAppend(val: bytes, ch: writingChannel) throws {
    const wireType = lengthDelimited;
    unsignedVarintAppend((val.size):uint, ch);
    ch.write(val);
  }

  proc bytesConsume(ch: readingChannel): bytes throws {
    const (byteLen, len) = unsignedVarintConsume(ch);
    var s:bytes;
    ch.readbytes(s, byteLen:int);
    return s;
  }

  proc stringAppend(val: string, ch: writingChannel) throws {
    bytesAppend(val.encode(), ch);
  }

  proc stringConsume(ch: readingChannel): string throws {
    return bytesConsume(ch).decode();
  }


  proc fixed32Append(val: uint(32), ch: writingChannel) throws {
    const wireType = fixed32Type;
    ch.write(val);
  }

  proc fixed32Consume(ch: readingChannel): uint(32) throws {
    var val: uint(32);
    ch.read(val);
    return val;
  }

  proc fixed64Append(val: uint(64), ch: writingChannel) throws {
    const wireType = fixed64Type;
    ch.write(val);
  }

  proc fixed64Consume(ch: readingChannel): uint(64) throws {
    var val: uint(64);
    ch.read(val);
    return val;
  }

  proc floatAppend(val: real(32), ch: writingChannel) throws {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Append(b, ch);
  }
  
  proc floatConsume(ch: readingChannel): real(32) throws {
    var a = fixed32Consume(ch);
    var b: real(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc doubleAppend(val: real(64), ch: writingChannel) throws {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Append(b, ch);
  }
  
  proc doubleConsume(ch: readingChannel): real(64) throws {
    var a = fixed64Consume(ch);
    var b: real(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed64Append(val: int(64), ch: writingChannel) throws {
    var a = val;
    var b: uint(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed64Append(b, ch);
  }

  proc sfixed64Consume(ch: readingChannel): int(64) throws {
    var a = fixed64Consume(ch);
    var b: int(64);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc sfixed32Append(val: int(32), ch: writingChannel) throws {
    var a = val;
    var b: uint(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    fixed32Append(b, ch);
  }

  proc sfixed32Consume(ch: readingChannel): int(32) throws {
    var a = fixed32Consume(ch);
    var b: int(32);
    c_memcpy(c_ptrTo(b), c_ptrTo(a), c_sizeof(b.type));
    return b;
  }

  proc writeToOutputFileHelper(ref message, ch) {
    var binCh: channel(writing=true, kind=iokind.little, locking=false) = ch;
    message._writeToOutputFile(binCh);
  }

  proc parseFromInputFileHelper(ref message, ch) {
    var binCh: channel(writing=false, kind=iokind.little, locking=false) = ch;
    message._parseFromInputFile(binCh);
  }

}
