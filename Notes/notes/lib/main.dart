import 'package:flutter/material.dart';
import 'package:notes/Screens/noteList.dart';
import 'Screens/noteList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: NoteList(),
    );
  }
}
