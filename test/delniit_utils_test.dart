import 'package:delniit_utils/delniit_utils.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(delniit_lower("ΔΣLNIIT") == "ᴧeʟɴııт", isTrue);
    });
  });
}
