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

  }
}

use protobuf;
var foo = new VariantValue(150);
writeln(foo.getValue());
foo.setValue(100);
writeln(foo.getValue());
