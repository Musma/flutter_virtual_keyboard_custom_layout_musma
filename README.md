# virtual_keyboard_custom_layout_onex

Attribution to dev -  EliasDalvite and owner of virtual_keyboard_multi_language

# Goal
- keyboard with no clipboard
- hindi keyboard (devnagri - india)
- marathi supported (devnagri)
- english supported 
- symbols supported
- good UI (on demand customisable)
- easy customised modifiable keyboard for other languages aswell


<br>
<p align="center">
<img style="height:200px;" alt="FlutterBlue" src="https://github.com/ysumiit005/virtual_keyboard_custom_layout_onex/blob/master/s1.jpg?raw=true" />
</p>
<br>
<p align="center">
<img style="width:200px;" alt="FlutterBlue" src="https://github.com/ysumiit005/virtual_keyboard_custom_layout_onex/blob/master/s2.jpg?raw=true" />
</p>
<br>
<p align="center">
<img style="height:200px;" alt="FlutterBlue" src="https://github.com/ysumiit005/virtual_keyboard_custom_layout_onex/blob/master/s3.jpg?raw=true" />
</p>
<p align="center">
<img style="height:200px;" alt="FlutterBlue" src="https://github.com/ysumiit005/virtual_keyboard_custom_layout_onex/blob/master/s4.jpg?raw=true" />
</p>
<p align="center">
<img style="height:200px;" alt="FlutterBlue" src="https://github.com/ysumiit005/virtual_keyboard_custom_layout_onex/blob/master/s5.jpg?raw=true" />
</p>
<hr>

```dart
// main code
import 'package:flutter/material.dart';
import 'package:virtual_keyboard_custom_layout_onex/virtual_keyboard_custom_layout_onex.dart';

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
  late String userLanguage = "english";
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
          title: const Text('Select Layout'),
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
                },
                icon: const Icon(
                  Icons.one_k,
                ))
          ],
        ),
        body: Stack(
          children: [
            //
            //
            //
            Center(
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
```



- [Onex Sumit](https://github.com/ysumiit005)
- [LICENSE - MIT](https://github.com/ahmed-eg/virtual_keyboard_multi_language/blob/master/LICENSE)

