import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() {
  runApp(MaterialApp(
    title: 'QuizMe',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xff6750a4),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}
