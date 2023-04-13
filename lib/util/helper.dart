import 'dart:math';

import 'package:flutter/material.dart';

class Helper {
  static Random random = Random();

  static int getRandomIntKey() {
    return random.nextInt(900000);
  }

  static SnackBar snackBar(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height / 2,
        left: 50,
        right: 50,
      ),
      content: const Text(
        "Error receiving data",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
