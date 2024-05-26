import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To Do App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 0, 6, 42),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: HomeScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
