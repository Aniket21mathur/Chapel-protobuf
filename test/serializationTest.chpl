use Protobuf;
use UnitTest;

config const testParam: bool = true;


proc myTest(test: borrowed Test) throws {

  test.assertTrue(unsignedVarintDump(0) == b"\x00");
  test.assertTrue(unsignedVarintDump(3) == b"\x03");
  test.assertTrue(unsignedVarintDump(270) == b"\x8E\x02");
  test.assertTrue(unsignedVarintDump(86942) == b"\x9E\xA7\x05");
  
  test.assertTrue(unsignedVarintLoad(b"\x00")(0) == 0);
  test.assertTrue(unsignedVarintLoad(b"\x03")(0) == 3);
  test.assertTrue(unsignedVarintLoad(b"\x8E\x02")(0) == 270);
  test.assertTrue(unsignedVarintLoad(b"\x9E\xA7\x05")(0) == 86942);

}

UnitTest.main();
