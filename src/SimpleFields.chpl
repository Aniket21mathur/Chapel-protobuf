/* Documentation for SimpleFields */
module SimpleFields {

  use IO;
  use WireEncoding;

  proc uint64SimpleAppend(val: uint(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    uint64Append(val, ch);
  }

  proc uint64SimpleConsume(ch: readingChannel): uint(64) throws {
    return uint64Consume(ch);
  }

  proc uint32SimpleAppend(val: uint(32), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    uint32Append(val, ch);
  }

  proc uint32SimpleConsume(ch: readingChannel): uint(32) throws {
    return uint32Consume(ch);
  }
  
  proc int64SimpleAppend(val: int(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    int64Append(val, ch);
  }

  proc int64SimpleConsume(ch: readingChannel): int throws {
    return int64Consume(ch);
  }

  proc int32SimpleAppend(val: int(32), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    int32Append(val, ch);
  }

  proc int32SimpleConsume(ch: readingChannel): int(32) throws {
    return int32Consume(ch);
  }

  proc boolSimpleAppend(val: bool, fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    boolAppend(val, ch);
  }

  proc boolSimpleConsume(ch: readingChannel): bool throws {
    return boolConsume(ch);
  }

  proc sint64SimpleAppend(val: int(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    sint64Append(val, ch);
  }

  proc sint64SimpleConsume(ch: readingChannel): int(64) throws {
    return sint64Consume(ch);
  }

  proc sint32SimpleAppend(val: int(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, varint, ch);
    sint32Append(val, ch);
  }

  proc sint32SimpleConsume(ch: readingChannel): int(32) throws {
    return sint32Consume(ch);
  }

  proc bytesSimpleAppend(val: bytes, fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, lengthDelimited, ch);
    bytesAppend(val, ch);
  }

  proc bytesSimpleConsume(ch: readingChannel): bytes throws {
    return bytesConsume(ch);
  }

  proc stringSimpleAppend(val: string, fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, lengthDelimited, ch);
    stringAppend(val, ch);
  }

  proc stringSimpleConsume(ch: readingChannel): string throws {
    return stringConsume(ch);
  }

  proc fixed32SimpleAppend(val: uint(32), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, fixed32Type, ch);
    fixed32Append(val, ch);
  }

  proc fixed32SimpleConsume(ch: readingChannel): uint(32) throws {
    return fixed32Consume(ch);
  }

  proc fixed64SimpleAppend(val: uint(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, fixed64Type, ch);
    fixed64Append(val, ch);
  }

  proc fixed64SimpleConsume(ch: readingChannel): uint(64) throws {
    return fixed64Consume(ch);
  }

  proc floatSimpleAppend(val: real(32), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, fixed32Type, ch);
    floatAppend(val, ch);
  }
  
  proc floatSimpleConsume(ch: readingChannel): real(32) throws {
    return floatConsume(ch);
  }

  proc doubleSimpleAppend(val: real(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, fixed64Type, ch);
    doubleAppend(val, ch);
  }
  
  proc doubleSimpleConsume(ch: readingChannel): real(64) throws {
    return doubleConsume(ch);
  }

  proc sfixed64SimpleAppend(val: int(64), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, fixed64Type, ch);
    sfixed64Append(val, ch);
  }

  proc sfixed64SimpleConsume(ch: readingChannel): int(64) throws {
    return sfixed64Consume(ch);
  }

  proc sfixed32SimpleAppend(val: int(32), fieldNumber: int, ch: writingChannel) throws {
    tagAppend(fieldNumber, fixed32Type, ch);
    sfixed32Append(val, ch);
  }

  proc sfixed32SimpleConsume(ch: readingChannel): int(32) throws {
    return sfixed32Consume(ch);
  }

}
