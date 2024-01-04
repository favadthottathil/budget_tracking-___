import 'package:flutter/material.dart';


class AppButtonStyle {
  static final buttonStyle1 = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue[900],
    fixedSize: const Size(200, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
