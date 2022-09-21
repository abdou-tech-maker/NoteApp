import 'package:flutter/material.dart';
import 'Views/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Bachelors Registrations',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.purple,
        primarySwatch: Colors.purple,
      ),
      home: Login(),
    );
  }
}
