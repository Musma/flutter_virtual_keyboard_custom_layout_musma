import 'package:flutter/material.dart';
import 'package:flutter_virtual_keyboard_custom_layout_musma/flutter_virtual_keyboard_custom_layout_musma.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Keyboard Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: 'Virtual Keyboard Demo',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Holds the text that user typed.
  String text = '';

  // True if shift enabled.
  bool shiftEnabled = false;

  // is true will show the numeric keyboard.
  bool isNumericMode = false;

  // necessary to maintain the focus and to insert letters in the
  // middle of the string.
  TextEditingController controllerField01 = TextEditingController();
  TextEditingController controllerField02 = TextEditingController();
  TextEditingController controllerField03 = TextEditingController();
  TextEditingController controllerField05 = TextEditingController();

  // key variables to utilize the keyboard with the class KeyboardAux
  var isKeyboardVisible = false;
  var controllerKeyboard = TextEditingController();

  // custom sumit half specify keyboard default language layout
  TypeLayout typeLayout = TypeLayout.alphabet;

  // custom sumit
  late String userLanguage = "english";
  // custom ends

  @override
  void initState() {
    // keyboardListeners();
    super.initState();
    controllerField01.addListener(() {
      controllerKeyboard.text =
          inputFilterForIp(controllerKeyboard.text).toString();
    });
  }

  StringBuffer inputFilterForIp(String newValueText) {
    StringBuffer newText = StringBuffer();

    final String digitsAndDotsOnly =
        newValueText.replaceAll(RegExp(r'[^0-9.]'), '');

    int dotCount = 0;
    for (int i = 0; i < digitsAndDotsOnly.length; i++) {
      final char = digitsAndDotsOnly[i];
      String lastChar = (i - 1) > 0 ? digitsAndDotsOnly[i - 1] : '';
      if (char == '0' ||
          char == '1' ||
          char == '2' ||
          char == '3' ||
          char == '4' ||
          char == '5' ||
          char == '6' ||
          char == '7' ||
          char == '8' ||
          char == '9') {
        if (newText.length % 4 == 3 && dotCount < 3 && lastChar != '.') {
          newText.write('.');
          dotCount++;
        }
        newText.write(char);
      } else if (char == '.') {
        newText.write(char);
        dotCount++;
      }
    }

    // 마지막 문자가 '..'이면 삭제
    String lastChar = '';
    if (newValueText.isNotEmpty) {
      lastChar = newValueText.substring(newValueText.length - 1);
    }
    String lastChar2 = '';
    if (newValueText.length >= 2) {
      lastChar2 = newValueText.substring(
          newValueText.length - 2, newValueText.length - 1);
    }

    if (lastChar == '.' && lastChar2 == '.') {
      newText =
          StringBuffer(newText.toString().substring(0, newText.length - 1));
    }

    return newText;
  }

  void showSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                title: const Text(' English Language '),
                onTap: () {
                  setState(() {
                    typeLayout = TypeLayout.alphabet;
                    userLanguage = "english";
                    isKeyboardVisible = true;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                title: const Text(' Hindi Language'),
                onTap: () {
                  setState(() {
                    typeLayout = TypeLayout.hindi1;
                    userLanguage = "hindi";
                    isKeyboardVisible = true;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                title: const Text(' Marathi Language'),
                onTap: () {
                  setState(() {
                    typeLayout = TypeLayout.marathi1;
                    userLanguage = "marathi";
                    isKeyboardVisible = true;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isKeyboardVisible = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  showSelectionDialog();
                },
                icon: const Icon(
                  Icons.one_k,
                ))
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    // To prevent overflow with android and ios native keyboard
                    keyboardType: TextInputType.none,
                    controller: controllerField01,
                    maxLines: null,
                    minLines: null,
                    maxLength: 10,
                    onTap: () {
                      setState(() {
                        isKeyboardVisible = true;
                        controllerKeyboard = controllerField01;
                        typeLayout = TypeLayout.numeric;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.none,
                    controller: controllerField02,
                    maxLines: null,
                    minLines: null,
                    onTap: () {
                      setState(() {
                        isKeyboardVisible = true;
                        controllerKeyboard = controllerField02;
                        typeLayout = TypeLayout.alphaEmail;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.none,
                    controller: controllerField03,
                    maxLines: null,
                    minLines: null,
                    onTap: () {
                      setState(() {
                        isKeyboardVisible = true;
                        controllerKeyboard = controllerField03;
                        // typeLayout = TypeLayout.numeric;
                      });
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            //
            //
            // sumit onex special keyboard
            //
            //
            if (isKeyboardVisible)
              Align(
                alignment: Alignment.bottomCenter,
                child: KeyboardAux(
                  languageChangeCallback: () {
                    showSelectionDialog();
                  },
                  controller: controllerKeyboard,
                  typeLayout: typeLayout,
                  keyboardLanguage: userLanguage,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
