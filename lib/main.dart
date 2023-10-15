// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tugas1/home.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
