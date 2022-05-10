import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 5, 0, 23),
          primaryColor: Colors.teal,
          accentColor: Colors.orangeAccent),
      title: 'TODO TASKS',
      home: MyHomePage(),
    );
  }
}
