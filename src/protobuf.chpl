/* Documentation for protobuf */
module protobuf {
  
  //Variant wire type to support int, bool, enum
  class VariantValue {
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

  }
}

use protobuf;
var foo = new VariantValue(270);
writeln(foo.getValue());
writeln(foo.dump());
