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

  test.assertTrue(bytesLoad(b"\x06chapel") == b"chapel");
  test.assertTrue(bytesLoad(b"\x07testing") == b"testing");

  test.assertTrue(stringDump("testing") == b"\x07testing");
  test.assertTrue(stringDump("chapel") == b"\x06chapel");

  test.assertTrue(stringLoad(b"\x07testing") == "testing");
  test.assertTrue(stringLoad(b"\x06chapel") == "chapel");

  test.assertTrue(boolDump(true) == b"\x01");
  test.assertTrue(boolDump(false) == b"\x00");

  test.assertTrue(boolLoad(b"\x01") == true);
  test.assertTrue(boolLoad(b"\x00") == false);

  enum Color {GREEN = 0, RED = 1, BLUE = 2};
  test.assertTrue(enumDump(Color.GREEN: int) == b"\x00");
  test.assertTrue(enumDump(Color.RED: int) == b"\x01");
  test.assertTrue(enumDump(Color.BLUE: int) == b"\x02");

  test.assertTrue(enumLoad(b"\x00") == Color.GREEN: int);
  test.assertTrue(enumLoad(b"\x01") == Color.RED: int);
  test.assertTrue(enumLoad(b"\x02") == Color.BLUE: int);

  test.assertTrue(unsignedFixed32Dump(0) == b"\x00\x00\x00\x00");
  test.assertTrue(unsignedFixed32Dump(1000) == b"\xE8\x03\x00\x00");
  test.assertTrue(unsignedFixed32Dump(300000000) == b"\x00\xA3\xE1\x11");

  test.assertTrue(unsignedFixed32Load(b"\x00\x00\x00\x00") == 0);
  test.assertTrue(unsignedFixed32Load(b"\xE8\x03\x00\x00") == 1000);
  test.assertTrue(unsignedFixed32Load(b"\x00\xA3\xE1\x11") == 300000000);

  test.assertTrue(unsignedFixed64Dump(0) == b"\x00\x00\x00\x00\x00\x00\x00\x00");
  test.assertTrue(unsignedFixed64Dump(1000) == b"\xE8\x03\x00\x00\x00\x00\x00\x00");
  test.assertTrue(unsignedFixed64Dump(300000000) == b"\x00\xA3\xE1\x11\x00\x00\x00\x00");

  test.assertTrue(unsignedFixed64Load(b"\x00\x00\x00\x00\x00\x00\x00\x00") == 0);
  test.assertTrue(unsignedFixed64Load(b"\xE8\x03\x00\x00\x00\x00\x00\x00") == 1000);
  test.assertTrue(unsignedFixed64Load(b"\x00\xA3\xE1\x11\x00\x00\x00\x00") == 300000000);
}

UnitTest.main();
