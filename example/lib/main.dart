import 'package:flutter/material.dart';
import 'package:virtual_keyboard_custom_layout_onex/virtual_keyboard_custom_layout_onex.dart';
import 'package:virtual_keyboard_custom_layout_example/keyboard_aux.dart';
import 'package:virtual_keyboard_custom_layout_example/types_keyboard.dart';

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

  // key variables to utilize the keyboard with the class KeyboardAux
  var isKeyboardVisible = false;
  var controllerKeyboard = TextEditingController();

  // custom sumit half specify keyboard default language layout
  TypeLayout typeLayout = TypeLayout.alphabet;

  // custom sumit
  late String userLanguage = "";
  // custom ends

  @override
  void initState() {
    // keyboardListeners();
    super.initState();
  }

  void showSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Layout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
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
                  // setState(() {
                  //   isKeyboardVisible = true;
                  //   typeLayout = TypeLayout.hindi1;
                  // });
                },
                icon: Icon(
                  Icons.one_k,
                ))
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextFormField(
                // To prevent overflow with android and ios native keyboard
                keyboardType: TextInputType.none,
                controller: controllerField01,
                maxLines: null,
                minLines: null,
                onTap: () {
                  setState(() {
                    isKeyboardVisible = true;
                    controllerKeyboard = controllerField01;
                    // typeLayout = TypeLayout.hindi1;
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
                    // typeLayout = TypeLayout.alphaEmail;
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
              if (isKeyboardVisible)
                Stack(children: [
                  KeyboardAux(
                    alwaysCaps: false,
                    controller: controllerKeyboard,
                    typeLayout: typeLayout,
                    typeKeyboard: VirtualKeyboardType.Custom,
                    keyboardLanguage: userLanguage,
                  ),
                ]),
            ],
          ),
        ),
      ),
    );
  }

  keyboardListeners() {
    // Making the return function properly.
    controllerField01.addListener(() {
      if (controllerField01.value.text.endsWith("\n")) {
        controllerField01.text =
            controllerField01.value.text.replaceAll("\n", "");
        setState(() {
          controllerKeyboard = controllerField02;
          typeLayout = TypeLayout.alphaEmail;
        });
      }
    });
    controllerField02.addListener(() {
      if (controllerField02.value.text.endsWith("\n")) {
        controllerField02.text =
            controllerField02.value.text.replaceAll("\n", "");
        setState(() {
          controllerKeyboard = controllerField03;
          typeLayout = TypeLayout.numeric;
        });
      }
    });
    controllerField03.addListener(() {
      if (controllerField03.value.text.endsWith("\n")) {
        controllerField03.text =
            controllerField03.value.text.replaceAll("\n", "");
        setState(() {
          isKeyboardVisible = false;
        });
      }
    });
  }
}
