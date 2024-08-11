import 'dart:math';

String generateRandNumber(int length) {
  const val = '0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => val.codeUnitAt(random.nextInt(val.length))));
}
