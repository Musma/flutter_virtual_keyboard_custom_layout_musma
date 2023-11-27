part of virtual_keyboard_custom_layout_onex;

// ignore: must_be_immutable
class KeyboardAux extends StatefulWidget {
  final TextEditingController? controller;
  final VirtualKeyboardType typeKeyboard;
  TypeLayout typeLayout;
  final bool alwaysCaps;
  String text = "";
  final VoidCallback? languageChangeCallback;
  // custom sumit
  String? keyboardLanguage = 'english';
  // custom end
  KeyboardAux({
    Key? key,
    this.alwaysCaps = false,
    this.controller,
    this.typeLayout = TypeLayout.alphaEmail,
    this.keyboardLanguage,
    this.typeKeyboard = VirtualKeyboardType.Custom,
    this.languageChangeCallback
  }) : super(key: key);

  @override
  State<KeyboardAux> createState() => _KeyboardAuxState();
}

bool shiftEnabled = false;

class _KeyboardAuxState extends State<KeyboardAux> {
// Function to check the screen orientation
  bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          color: const Color.fromARGB(192, 199, 199, 199),
          child: VirtualKeyboard(
            height: isLandscape(context)
                ? MediaQuery.of(context).size.height * 0.6 // Landscape mode
                : MediaQuery.of(context).size.height * 0.33, // Portrait mode
            width: MediaQuery.of(context).size.width,
            fontSize: 20,
            textColor: const Color.fromARGB(255, 0, 0, 0),
            textController: widget.controller,
            defaultLayouts: const [
              VirtualKeyboardDefaultLayouts.English,
            ],
            alwaysCaps: widget.alwaysCaps,
            borderColor: const Color.fromARGB(255, 151, 151, 151),
            type: widget.typeKeyboard,
            keys: (widget.typeKeyboard == VirtualKeyboardType.Custom)
                ? widget.typeLayout.keyboard
                : [],
            onKeyPress: onKeyPress,
            spaceLongPressCallback: widget.languageChangeCallback
            ),
        ),
      ),
    );
  }

  onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      widget.text = widget.text + (shiftEnabled ? key.capsText! : key.text!);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (widget.text.isEmpty) return;
          widget.text = widget.text.substring(0, widget.text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          widget.text = '${widget.text}\n';
          break;
        // custom sumit
        case VirtualKeyboardKeyAction.NumbersAndSymbols:
          //
          // for english
          //
          if (widget.keyboardLanguage == "english") {
            if (widget.typeLayout == TypeLayout.alphabet) {
              widget.typeLayout = TypeLayout.alphaEmail;
            } else if (widget.typeLayout == TypeLayout.alphaEmail) {
              widget.typeLayout = TypeLayout.alphabet;
            }
          }
          //
          // for hindi
          //
          if (widget.keyboardLanguage == "hindi") {
            if (widget.typeLayout == TypeLayout.hindi1 ||
                widget.typeLayout == TypeLayout.hindi2) {
              widget.typeLayout = TypeLayout.alphaEmail;
            } else if (widget.typeLayout == TypeLayout.alphaEmail) {
              widget.typeLayout = TypeLayout.hindi1;
            }
          }
          if (widget.keyboardLanguage == "marathi") {
            if (widget.typeLayout == TypeLayout.marathi1 ||
                widget.typeLayout == TypeLayout.marathi2) {
              widget.typeLayout = TypeLayout.alphaEmail;
            } else if (widget.typeLayout == TypeLayout.alphaEmail) {
              widget.typeLayout = TypeLayout.marathi1;
            }
          }
          break;
        // custom end
        // custom sumit
        case VirtualKeyboardKeyAction.HindiLayout1:
          if (widget.typeLayout == TypeLayout.hindi1) {
            widget.typeLayout = TypeLayout.hindi2;
          } else if (widget.typeLayout == TypeLayout.hindi2) {
            widget.typeLayout = TypeLayout.hindi1;
          }
          break;
        case VirtualKeyboardKeyAction.MarathiLayout1:
          if (widget.typeLayout == TypeLayout.marathi1) {
            widget.typeLayout = TypeLayout.marathi2;
          } else if (widget.typeLayout == TypeLayout.marathi2) {
            widget.typeLayout = TypeLayout.marathi1;
          }
          break;
        // custom end
        case VirtualKeyboardKeyAction.Space:
          widget.text = widget.text + key.text!;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
    // Update the screen
    setState(() {});
  }
}
