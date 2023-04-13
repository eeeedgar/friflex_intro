import 'dart:math';

class Helper {
  static Random random = Random();

  static int getRandomIntKey() {
    return random.nextInt(900000);
  }
}
