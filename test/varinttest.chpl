use Protobuf;
use UnitTest;
use Map;

config const testParam: bool = true;

proc testVarintdump(x: int): bytes {
  var obj = new VarintValue(x);
  return obj.dump();
}

proc testVarintload(x: bytes): int {
  var obj = new VarintValue();
  obj.load(x);
  return obj.getValue();
}

proc testMessagedump(): bytes {
  var mytuple: owned VarintValue? = new VarintValue();
  var rnd = new Message([('a', mytuple)]);
  rnd.setValue('a', 150);
  return rnd.dump();
}

proc myTest(test: borrowed Test) throws{
  
  test.assertTrue(testVarintdump(0) == b"\x00");
  test.assertTrue(testVarintdump(3) == b"\x03");
  test.assertTrue(testVarintdump(270) == b"\x8E\x02");
  test.assertTrue(testVarintdump(86942) == b"\x9E\xA7\x05");
  
  test.assertTrue(testVarintload(b"\x00") == 0);
  test.assertTrue(testVarintload(b"\x03") == 3);
  test.assertTrue(testVarintload(b"\x8E\x02") == 270);
  test.assertTrue(testVarintload(b"\x9E\xA7\x05") == 86942);
  
  test.assertTrue(testMessagedump() == b"\x08\x96\x01");
  
}

UnitTest.main();
