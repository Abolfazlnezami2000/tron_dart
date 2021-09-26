import 'package:hex/hex.dart';
import 'package:characters/characters.dart';

abstract class AbiClass {
  String decodeString(Iterable b);

  BigInt decodeUint256(Iterable b);
}

class Abi implements AbiClass {
  @override
  String decodeString(Iterable b) {
    var length = decodeInt(b);
    var testB = b.skip(32).take(length).toList();
    String testD = "";
    testB.forEach((element) {
      testD = testD + element.toString();
    });
    String test = String.fromCharCodes(HEX.decode(testD));
    String finalResult = "";
    test.characters.forEach((element) {
      if (element.hashCode != 1) {
        finalResult = finalResult + element;
      }
    });
    return finalResult;
  }

  @override
  BigInt decodeUint256(Iterable b) {
    var testB = b.skip(32).take(b.length).toList();
    String testD = "";
    testB.forEach((element) {
      testD = testD + element;
    });

    return BigInt.parse(testD, radix: 16);
  }

  int decodeInt(Iterable b) {
    return decodeUint256(b).toInt();
  }
}
