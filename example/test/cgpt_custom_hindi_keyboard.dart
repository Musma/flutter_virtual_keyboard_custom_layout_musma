import 'package:flutter/material.dart';

void main() {
  runApp(HindiKeyboardApp());
}

class HindiKeyboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HindiKeyboardDemo(),
    );
  }
}

class HindiKeyboardDemo extends StatefulWidget {
  @override
  _HindiKeyboardDemoState createState() => _HindiKeyboardDemoState();
}

class _HindiKeyboardDemoState extends State<HindiKeyboardDemo> {
  String typedText = '';

  void onKeyTapped(String key) {
    setState(() {
      typedText += key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hindi Keyboard Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                typedText,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 200, // Minimum height
              maxHeight: 300, // Maximum height
            ),
            child: Keyboard(onKeyTapped: onKeyTapped),
          ),
        ],
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  final Function(String) onKeyTapped;

  Keyboard({required this.onKeyTapped});

  final List<String> hindiCharacters = [
    'क',
    'ख',
    'ग',
    'घ',
    'ङ',
    'च',
    'छ',
    'ज',
    'झ',
    'ञ',
    'ट',
    'ठ',
    'ड',
    'ढ',
    'ण',
    'त',
    'थ',
    'द',
    'ध',
    'न',
    'प',
    'फ',
    'ब',
    'भ',
    'म',
    'य',
    'र',
    'ल',
    'व',
    'श',
    'ष',
    'स',
    'ह',
    'ा',
    'ि',
    'ी',
    'ु',
    'ू',
    'े',
    'ै',
    'ो',
    'ौ',
    'ं',
    'ृ',
    'ॄ',
    'ॢ',
    'ॣ',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
      ),
      itemCount: hindiCharacters.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onKeyTapped(hindiCharacters[index]);
          },
          child: Center(
            child: Text(
              hindiCharacters[index],
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
