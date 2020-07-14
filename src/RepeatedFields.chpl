/* Documentation for RepeatedFields */
module RepeatedFields {
  
  use WireEncoding;
  use List;
  use IO;

  proc uint64RepeatedAppend(valList: list(uint(64)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var initialOffset = ch.offset();
    ch.mark();
    for val in valList {
      uint64Append(val, ch);
    }
    var currentOffset = ch.offset();
    ch.revert();
    unsignedVarintAppend((currentOffset-initialOffset):uint, ch);
    for val in valList {
      uint64Append(val, ch);
    }
  }

  proc uint64RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(uint(64));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = uint64Consume(ch);
      returnList.append(val);
    }
    return returnList;
  }

  proc uint32RepeatedAppend(valList: list(uint(32)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var initialOffset = ch.offset();
    ch.mark();
    for val in valList {
      uint32Append(val, ch);
    }
    var currentOffset = ch.offset();
    ch.revert();
    unsignedVarintAppend((currentOffset-initialOffset):uint, ch);
    for val in valList {
      uint32Append(val, ch);
    }
  }
  
  proc uint32RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(uint(32));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = uint32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc int64RepeatedAppend(valList: list(int(64)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var initialOffset = ch.offset();
    ch.mark();
    for val in valList {
      int64Append(val, ch);
    }
    var currentOffset = ch.offset();
    ch.revert();
    unsignedVarintAppend((currentOffset-initialOffset):uint, ch);
    for val in valList {
      int64Append(val, ch);
    }
  }
  
  proc int64RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(int(64));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = int64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc int32RepeatedAppend(valList: list(int(32)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var initialOffset = ch.offset();
    ch.mark();
    for val in valList {
      int32Append(val, ch);
    }
    var currentOffset = ch.offset();
    ch.revert();
    unsignedVarintAppend((currentOffset-initialOffset):uint, ch);
    for val in valList {
      int32Append(val, ch);
    }
  }
  
  proc int32RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(int(32));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = int32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc boolRepeatedAppend(valList: list(bool), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      boolAppend(val, ch);
    }
  }

  proc boolRepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(bool);
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = boolConsume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sint64RepeatedAppend(valList: list(int(64)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var initialOffset = ch.offset();
    ch.mark();
    for val in valList {
      sint64Append(val, ch);
    }
    var currentOffset = ch.offset();
    ch.revert();
    unsignedVarintAppend((currentOffset-initialOffset):uint, ch);
    for val in valList {
      sint64Append(val, ch);
    }
  }
  
  proc sint64RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(int(64));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = sint64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sint32RepeatedAppend(valList: list(int(32)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var initialOffset = ch.offset();
    ch.mark();
    for val in valList {
      sint32Append(val, ch);
    }
    var currentOffset = ch.offset();
    ch.revert();
    unsignedVarintAppend((currentOffset-initialOffset):uint, ch);
    for val in valList {
      sint32Append(val, ch);
    }
  }
  
  proc sint32RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(int(32));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = sint32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc bytesRepeatedAppend(valList: list(bytes), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;
    for val in valList {
      tagAppend(fieldNumber, lengthDelimited, ch);
      bytesAppend(val, ch);
    }
  }

  proc bytesRepeatedConsume(ch: readingChannel) throws {
    var returnList: list(bytes);
    var val = bytesConsume(ch);
    returnList.append(val);
    return returnList;
  }

  proc stringRepeatedAppend(valList: list(string), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;
    for val in valList {
      tagAppend(fieldNumber, lengthDelimited, ch);
      stringAppend(val, ch);
    }
  }

  proc stringRepeatedConsume(ch: readingChannel) throws {
    var returnList: list(string);
    var val = stringConsume(ch);
    returnList.append(val);
    return returnList;
  }

  proc fixed32RepeatedAppend(valList: list(uint(32)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size * 4; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      fixed32Append(val, ch);
    }
  }

  proc fixed32RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(uint(32));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = fixed32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc fixed64RepeatedAppend(valList: list(uint(64)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size * 8; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      fixed64Append(val, ch);
    }
  }

  proc fixed64RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(uint(64));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = fixed64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }

  proc floatRepeatedAppend(valList: list(real(32)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size * 4; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      floatAppend(val, ch);
    }
  }

  proc floatRepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(real(32));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = floatConsume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc doubleRepeatedAppend(valList: list(real(64)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size * 8; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      doubleAppend(val, ch);
    }
  }

  proc doubleRepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(real(64));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = doubleConsume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sfixed64RepeatedAppend(valList: list(int(64)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size * 8; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      sfixed64Append(val, ch);
    }
  }

  proc sfixed64RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(int(64));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = sfixed64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sfixed32RepeatedAppend(valList: list(int(32)), fieldNumber: int, ch: writingChannel) throws {
    if valList.isEmpty() then return;

    tagAppend(fieldNumber, lengthDelimited, ch);
    var payloadLength = valList.size * 4; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      sfixed32Append(val, ch);
    }
  }

  proc sfixed32RepeatedConsume(ch: readingChannel) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList: list(int(32));
    while true {
      if (ch.offset() - initialOffset) >= payloadLength then break;
      var val = sfixed32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }

}