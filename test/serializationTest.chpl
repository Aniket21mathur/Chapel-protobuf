use Protobuf;
use UnitTest;

config const testParam: bool = true;


proc myTest(test: borrowed Test) throws {

  test.assertTrue(unsignedVarintDump(0) == b"\x00");
  test.assertTrue(unsignedVarintDump(3) == b"\x03");
  test.assertTrue(unsignedVarintDump(270) == b"\x8E\x02");
  test.assertTrue(unsignedVarintDump(86942) == b"\x9E\xA7\x05");
  
  test.assertTrue(unsignedVarintLoad(b"\x00") == 0);
  test.assertTrue(unsignedVarintLoad(b"\x03") == 3);
  test.assertTrue(unsignedVarintLoad(b"\x8E\x02") == 270);
  test.assertTrue(unsignedVarintLoad(b"\x9E\xA7\x05") == 86942);
  
  test.assertTrue(signedVarintDump(0) == b"\x00");
  test.assertTrue(signedVarintDump(-1) == b"\x01");
  test.assertTrue(signedVarintDump(1) == b"\x02");
  test.assertTrue(signedVarintDump(-2) == b"\x03");

  test.assertTrue(signedVarintLoad(b"\x00") == 0);
  test.assertTrue(signedVarintLoad(b"\x01") == -1);
  test.assertTrue(signedVarintLoad(b"\x02") == 1);
  test.assertTrue(signedVarintLoad(b"\x03") == -2);
  
  test.assertTrue(bytesDump(b"testing") == b"\x07testing");
  test.assertTrue(bytesDump(b"chapel") == b"\x06chapel");
}

UnitTest.main();
