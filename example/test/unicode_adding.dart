import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Combine the characters "त्र"
    String devanagariTra = 'त' '्' 'र';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Devanagari Character'),
        ),
        body: Center(
          child: Text(
            devanagariTra,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
