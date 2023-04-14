import 'dart:math';


class Helper { // нужен для генерации ключей для отличия состояний блока без полей
  static Random random = Random();

  static int getRandomIntKey() {
    return random.nextInt(900000);
  }
}
