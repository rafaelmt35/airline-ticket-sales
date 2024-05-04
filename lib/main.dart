// ignore_for_file: avoid_print

import 'package:effective_mobile_test/main_Page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import the date_symbol_data_local.dart package

void initializeDateFormattingCustom(String locale) {
  initializeDateFormatting(locale, null).then((_) {
    runApp(const MyApp());
  });
}

void main() {
  initializeDateFormattingCustom('ru');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
