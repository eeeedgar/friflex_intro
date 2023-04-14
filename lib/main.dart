import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';

void main() async {
  await dotenv.load(fileName: ".env"); // в .env хранится API_KEY от сервиса с погодой
  runApp(const FliflexIntroApp()); // за ключом можете обратиться ко мне: https://t.me/ocoru
} // .env конечно же в гитигноре
