/* Documentation for RepeatedFields */
module RepeatedFields {
  
  use Encoding;
  use List;
  use IO;

  proc uint64RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
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

  proc uint64RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(uint(64));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = uint64Consume(ch);
      returnList.append(val);
    }
    return returnList;
  }

  proc uint32RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
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
  
  proc uint32RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(uint(32));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = uint32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc int64RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
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
  
  proc int64RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(int(64));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = int64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc int32RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
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
  
  proc int32RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(int(32));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = int32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc boolRepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      boolAppend(val, ch);
    }
  }

  proc boolRepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(bool);
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = boolConsume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sint64RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
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
  
  proc sint64RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(int(64));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = sint64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sint32RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
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
  
  proc sint32RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(int(32));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = sint32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc fixed32RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size * 4; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      fixed32Append(val, ch);
    }
  }

  proc fixed32RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(uint(32));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = fixed32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc fixed64RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size * 8; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      fixed64Append(val, ch);
    }
  }

  proc fixed64RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(uint(64));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = fixed64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }

  proc floatRepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size * 4; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      floatAppend(val, ch);
    }
  }

  proc floatRepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(real(32));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = floatConsume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc doubleRepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size * 8; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      doubleAppend(val, ch);
    }
  }

  proc doubleRepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(real(64));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = doubleConsume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sfixed64RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size * 8; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      sfixed64Append(val, ch);
    }
  }

  proc sfixed64RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(int(64));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = sfixed64Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }
  
  proc sfixed32RepeatedAppend(valList, ch: channel(true,iokind.little,false)) throws {
    var payloadLength = valList.size * 4; 
    unsignedVarintAppend(payloadLength:uint, ch);
    for val in valList {
      sfixed32Append(val, ch);
    }
  }

  proc sfixed32RepeatedConsume(ch: channel(false,iokind.little,false)) throws {
    var (payloadLength, _) = unsignedVarintConsume(ch);
    var initialOffset = ch.offset();

    var returnList = new list(int(32));
    while true {
      if (ch.offset() - initialOffset) == payloadLength then break;
      var val = sfixed32Consume(ch);
      returnList.append(val);
    }
    return returnList; 
  }

}
