/* Documentation for protobuf */
module protobuf {
  
  use Map;

  //Varint wire type to support int
  class VarintValue {
    var val: int;

    proc setValue(x: int): bool {
      val = x;
      return true;
    }
    
    proc getValue(): int {
      return val; 
    }
    
    proc dump(): bytes throws {
      var s: bytes = b"";

      if val == 0 {
        return b"\x00";
      }  
      else if !isInt(val) {
        compilerError('val must be integer type');
      }
      else if val < 0 {
        throw new owned IllegalArgumentError('val must be non-negative');
      }
      else {
        var new_val: int;
        while val != 0 {
        new_val = val >> 7;
        var k = if new_val != 0 then 0x80 else 0x00;
        var newByte = (val & 0x7F | k):uint(8);
        s = s + createBytesWithNewBuffer(c_ptrTo(newByte), 1);
        val = new_val;
        }
      }
      return s;
    }
    
    proc load(s: bytes) {
      var shift = 0;
      val = 0;
      for i in s {
          val = val + ((i & 0x7F): int << shift);
          shift = shift + 7;
      }
    }

  }


  class Message {
    var tupl;
    var fieldNames, fieldValues;

    proc init(tupl) {
      this.tupl = tupl;

      var x: [0..tupl.size-1] string;
      var y = new map(string, this.tupl[0](1).type);
      for i in 0..tupl.size-1 {
        x[i] = this.tupl[i](0);
        y[this.tupl[i][0]] = this.tupl[i][1];
      }
      this.fieldNames = x;
      this.fieldValues = y;
    }

    proc setValue(fieldName: string, fieldValue) {
      fieldValues[fieldName]!.setValue(fieldValue);
    }

    proc getValue(fieldName: string) {
      return fieldValues[fieldName]!.getValue();
    }
    
  }

}

use protobuf;
var mytuple: owned VarintValue? = new VarintValue();
var rnd = new Message([('a', mytuple)]);
rnd.setValue('a', 150);
writeln(rnd.getValue('a'));
