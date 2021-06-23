import 'dart:math';

extension RandomInt on int {
  static int generate({int min = 1, required int max}) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }
}
