import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Combine the characters "त्र"
    String devanagari_tra = 'त' + '्' + 'र';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Devanagari Character'),
        ),
        body: Center(
          child: Text(
            ('त' 'र').toString(),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
