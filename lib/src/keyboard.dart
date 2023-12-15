part of virtual_keyboard_custom_layout_onex;

/// The default keyboard height. Can we overriden by passing
///  `height` argument to `VirtualKeyboard` widget.
const double _virtualKeyboardDefaultHeight = 300;

const int _virtualKeyboardBackspaceEventPerioud = 30;

/// Virtual Keyboard widget.
class VirtualKeyboard extends StatefulWidget {
  /// Keyboard Type: Should be inited in creation time.
  final VirtualKeyboardType type;

  /// Callback for Key press event. Called with pressed `Key` object.
  final Function? onKeyPress;

  /// Virtual keyboard height. Default is 300
  final double height;

  /// Virtual keyboard height. Default is full screen width
  final double? width;

  /// Color for key texts and icons.
  final Color textColor;

  /// Font size for keyboard keys.
  final double fontSize;

  /// the custom layout for multi or single language
  final VirtualKeyboardLayoutKeys? customLayoutKeys;

  /// the text controller go get the output and send the default input
  final TextEditingController? textController;

  /// The builder function will be called for each Key object.
  final Widget Function(BuildContext context, VirtualKeyboardKey key)? builder;

  /// Set to true if you want only to show Caps letters.
  final bool alwaysCaps;

  /// inverse the layout to fix the issues with right to left languages.
  final bool reverseLayout;

  /// custom keys used if type `Custom` is being used. If `Custom` is selected
  /// and keys is null, the default alphanumeric keyboard will be used.
  /// To order to facilitate the usability, use `BACKSPACE`, `RETURN`, `SHIFT`,
  /// `SPACE` and `SWITCHLANGUAGE` for it's respective values in the keyboard.
  final List<List>? keys;

  /// border of every key in the keyboard.
  final Color? borderColor;

  /// used for multi-languages with default layouts, the default is English only
  /// will be ignored if customLayoutKeys is not null
  final List<VirtualKeyboardDefaultLayouts>? defaultLayouts;

  final VoidCallback? spaceLongPressCallback;

  /// keyboard langauage currently user is using
  ///
  final String? keyboardLanguage;

  const VirtualKeyboard(
      {Key? key,
      required this.type,
      this.onKeyPress,
      this.builder,
      this.width,
      this.defaultLayouts,
      this.customLayoutKeys,
      this.textController,
      this.reverseLayout = false,
      this.height = _virtualKeyboardDefaultHeight,
      this.textColor = Colors.black,
      this.fontSize = 14,
      required this.alwaysCaps,
      this.keys,
      this.borderColor,
      this.keyboardLanguage,
      this.spaceLongPressCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardState();
  }
}

/// Holds the state for Virtual Keyboard class.
class _VirtualKeyboardState extends State<VirtualKeyboard> {
  late VirtualKeyboardType type;
  Function? onKeyPress;
  late TextEditingController textController;
  // The builder function will be called for each Key object.
  Widget Function(BuildContext context, VirtualKeyboardKey key)? builder;
  late double height;
  double? width;
  late Color textColor;
  late double fontSize;
  bool alwaysCaps = false;
  late bool reverseLayout;
  late VirtualKeyboardLayoutKeys customLayoutKeys;
  // Text Style for keys.
  late TextStyle textStyle;
  late List<List> keys;
  // Utilized later to calculate the size of the keys
  bool customKeys = false;
  late Color borderColor;
  // True if shift is enabled.
  bool isShiftEnabled = true;

  void _onKeyPress(VirtualKeyboardKey key) {
    final currentOffset = textController.selection.baseOffset == -1
        ? textController.text.length
        : textController.selection.baseOffset;
    String newText = "";
    final TextSelection newSelection;
    if (key.keyType == VirtualKeyboardKeyType.String) {
      final String newCharacters;
      if (alwaysCaps) {
        newCharacters = key.capsText ?? "";
      } else if (isShiftEnabled) {
        newCharacters = key.capsText ?? '';
        setState(() {
          if (isShiftEnabled) {
            isShiftEnabled = false;
          }
        });
      } else {
        newCharacters = key.text ?? '';
      }

      newText = textController.text.substring(0, currentOffset) +
          newCharacters +
          textController.text.substring(currentOffset);

      newSelection =
          TextSelection.collapsed(offset: currentOffset + newCharacters.length);

      textController.value =
          TextEditingValue(text: newText, selection: newSelection);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (textController.selection
              .textInside(textController.text)
              .isNotEmpty) {
            int startIndex = textController.selection.start;
            int lastIndex = textController.selection.end;
            newText =
                textController.text.replaceRange(startIndex, lastIndex, "");

            newSelection = TextSelection.collapsed(offset: currentOffset);
            textController.value =
                TextEditingValue(text: newText, selection: newSelection);
          } else {
            if (textController.text.isEmpty || currentOffset < 1) {
              if (!isShiftEnabled) {
                setState(() {
                  isShiftEnabled = true;
                });
              }
              return;
            }
            newText = textController.text.substring(0, currentOffset - 1) +
                textController.text.substring(currentOffset);
            newSelection = TextSelection.collapsed(offset: currentOffset - 1);
            textController.value =
                TextEditingValue(text: newText, selection: newSelection);
          }
          break;
        case VirtualKeyboardKeyAction.Return:
          newText = textController.text.substring(0, currentOffset) +
              (key.text ?? '\n') +
              textController.text.substring(currentOffset);
          newSelection = TextSelection.collapsed(
              offset: currentOffset + (key.text?.length ?? 1));
          textController.value =
              TextEditingValue(text: newText, selection: newSelection);
          setState(() {
            if (!isShiftEnabled) {
              isShiftEnabled = true;
            }
          });
          break;
        case VirtualKeyboardKeyAction.Space:
          newText = textController.text.substring(0, currentOffset) +
              (key.text ?? '') +
              textController.text.substring(currentOffset);
          newSelection = TextSelection.collapsed(
              offset: currentOffset + (key.text?.length ?? 1));
          textController.value =
              TextEditingValue(text: newText, selection: newSelection);
          print(newText.substring(newText.length - 2, newText.length));
          if (newText.substring(newText.length - 2, newText.length) == ". ") {
            if (!isShiftEnabled) {
              setState(() {
                isShiftEnabled = true;
              });
            }
          }
          break;
        case VirtualKeyboardKeyAction.Shift:
          isShiftEnabled = !isShiftEnabled;
          break;
        default:
      }
    }
    onKeyPress?.call(key);
  }

  @override
  dispose() {
    if (widget.textController == null) {
      textController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(VirtualKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      type = widget.type;
      builder = widget.builder;
      onKeyPress = widget.onKeyPress;
      height = widget.height;
      width = widget.width;
      textColor = widget.textColor;
      fontSize = widget.fontSize;
      alwaysCaps = widget.alwaysCaps;
      reverseLayout = widget.reverseLayout;
      textController = widget.textController ?? textController;
      customLayoutKeys = widget.customLayoutKeys ?? customLayoutKeys;
      // Init the Text Style for keys.
      textStyle = TextStyle(
        fontSize: fontSize,
        color: textColor,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    borderColor = widget.borderColor ?? Colors.transparent;
    textController = widget.textController ?? TextEditingController();
    width = widget.width;
    type = widget.type;
    customLayoutKeys = widget.customLayoutKeys ??
        VirtualKeyboardDefaultLayoutKeys(
            widget.defaultLayouts ?? [VirtualKeyboardDefaultLayouts.English]);
    builder = widget.builder;
    onKeyPress = widget.onKeyPress;
    height = widget.height;
    textColor = widget.textColor;
    fontSize = widget.fontSize;
    alwaysCaps = widget.alwaysCaps;
    reverseLayout = widget.reverseLayout;
    // Init the Text Style for keys.
    textStyle = TextStyle(
      fontSize: fontSize,
      color: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    // because sometimes you may transition between 2 different textfields,
    // you cant initialize the keys in the initstate because it would cause the
    // keyboard to assume the first selected controller's row quantity.
    keys = widget.keys ?? [];
    if (widget.type == VirtualKeyboardType.Custom && keys.isNotEmpty) {
      customKeys = true;
    }

    switch (type) {
      case VirtualKeyboardType.Numeric:
        return _numeric();
      case VirtualKeyboardType.Alphanumeric:
        return _alphanumeric();
      case VirtualKeyboardType.Custom:
        return _custom();
    }
  }

  Widget _alphanumeric() {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(),
      ),
    );
  }

  Widget _numeric() {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(),
      ),
    );
  }

  Widget _custom() {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // keyboard main layouts
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _rows(),
        ),
      ),
    );
  }

  /// Returns the rows for keyboard.
  List<Widget> _rows() {
    // Get the keyboard Rows
    List<List<VirtualKeyboardKey>> keyboardRows;

    switch (type) {
      case VirtualKeyboardType.Numeric:
        keyboardRows = _getKeyboardRowsNumeric();
        break;
      case VirtualKeyboardType.Alphanumeric:
        keyboardRows = _getKeyboardRows(customLayoutKeys);
        break;
      case VirtualKeyboardType.Custom:
        keyboardRows = widget.keys != []
            ? _getKeyboardCustom(widget.keys!)
            : _getKeyboardRows(customLayoutKeys);
        break;
    }

    // Generate keyboard row.
    List<Widget> rows = List.generate(keyboardRows.length, (int rowNum) {
      var items = List.generate(keyboardRows[rowNum].length, (int keyNum) {
        // Get the VirtualKeyboardKey object.
        VirtualKeyboardKey virtualKeyboardKey = keyboardRows[rowNum][keyNum];

        Widget keyWidget;

        // Check if builder is specified.
        // Call builder function if specified or use default
        //  Key widgets if not.
        if (builder == null) {
          // Check the key type.
          switch (virtualKeyboardKey.keyType) {
            case VirtualKeyboardKeyType.String:
              // Draw String key.
              keyWidget = _keyboardDefaultKey(virtualKeyboardKey);
              break;
            case VirtualKeyboardKeyType.Action:
              // Draw action key.
              keyWidget = _keyboardDefaultActionKey(virtualKeyboardKey);
              break;
          }
        } else {
          // Call the builder function, so the user can specify custom UI for keys.
          keyWidget = builder!(context, virtualKeyboardKey);

          // if (keyWidget == null) {
          //   throw 'builder function must return Widget';
          // }
        }

        return keyWidget;
      });

      if (reverseLayout) items = items.reversed.toList();
      return Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Generate keboard keys
          children: items,
        ),
      );
    });

    return rows;
  }

  // True if long press is enabled.
  bool longPress = false;

  //
  //
  // sumit main key UI
  //
  //

  /// Creates default UI element for keyboard Key.
  Widget _keyboardDefaultKey(VirtualKeyboardKey key) {
    return Expanded(
      child: InkWell(
        splashColor: actionButtonColor,
        onTap: () {
          // HapticFeedback.lightImpact();
          _onKeyPress(key);
        },
        // triggerMode: TooltipTriggerMode.tap,
        // // waitDuration: const Duration(milliseconds: 50),
        // height: 50,
        // decoration: const BoxDecoration(
        //   color: Colors.black,
        // ),
        // textStyle: const TextStyle(color: Colors.white, fontSize: 25),
        // preferBelow: false,
        // showDuration: const Duration(milliseconds: 150),
        // message: key.text,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Ink(
            height: customKeys
                ? widget.keyboardLanguage == 'english'
                    ? (height / (keys.length + 0.25))
                    : (height / (keys.length + 0.4))
                : height / customLayoutKeys.activeLayout.length,
            decoration: const BoxDecoration(
              // border: Border.all(color: borderColor, width: 0),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: keyboardKeysColor,
              // color: keyboardKeysColor,
              // shape: BoxShape.circle,
            ),
            child: Container(
              child: Center(
                  child: Text(
                alwaysCaps
                    ? key.capsText ?? ''
                    : (isShiftEnabled ? key.capsText : key.text) ?? '',
                style: textStyle,
              )),
            ),
          ),
        ),
      ),
    );
  }

  /// Creates default UI element for keyboard Action Key.
  Widget _keyboardDefaultActionKey(VirtualKeyboardKey key) {
    // Holds the action key widget.
    Widget? actionKey;

    // Switch the action type to build action Key widget.
    switch (key.action ?? VirtualKeyboardKeyAction.SwitchLanguage) {
      case VirtualKeyboardKeyAction.Backspace:
        actionKey = InkWell(
            // onLongPress: () {
            //   print(" onlongpress ");
            //   //custom sumit code
            //   print("haptic");
            //   HapticFeedback.lightImpact();
            //   //ends
            //   longPress = true;
            //   // Start sending backspace key events while longPress is true
            //   Timer.periodic(
            //       const Duration(
            //           milliseconds: _virtualKeyboardBackspaceEventPerioud),
            //       (timer) {
            //     if (longPress) {
            //       _onKeyPress(key);
            //     } else {
            //       // Cancel timer.
            //       timer.cancel();
            //     }
            //   });
            // },
            // onLongPressUp: () {
            //   // Cancel event loop
            //   longPress = false;
            // },

            child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Icon(
            Icons.backspace,
            color: textColor,
            size: 15,
          ),
        ));
        break;
      case VirtualKeyboardKeyAction.Shift:
        actionKey = Icon(
            alwaysCaps
                ? Icons.arrow_circle_up_outlined
                : isShiftEnabled
                    ? Icons.arrow_upward
                    : Icons.keyboard_arrow_up_outlined,
            color: textColor);
        break;
      case VirtualKeyboardKeyAction.Space:
        actionKey = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20,
              ),
              Icon(Icons.space_bar, color: textColor),
              if (widget.keyboardLanguage == 'english')
                Text(
                  'eng',
                  style: TextStyle(color: textColor),
                ),
              if (widget.keyboardLanguage == 'marathi')
                Text(
                  'mar',
                  style: TextStyle(color: textColor),
                ),
              if (widget.keyboardLanguage == 'hindi')
                Text(
                  'hin',
                  style: TextStyle(color: textColor),
                ),
            ],
          ),
        );

        // custom ends
        // actionKey = Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
        //   child: Icon(Icons.space_bar, color: textColor),
        // );
        break;
      case VirtualKeyboardKeyAction.Return:
        actionKey = Icon(
          Icons.keyboard_return,
          color: textColor,
        );
        break;
      // custom sumit
      case VirtualKeyboardKeyAction.NumbersAndSymbols:
        actionKey = Icon(
          Icons.numbers,
          color: textColor,
        );
        break;

      // custom end
      // custom sumit
      case VirtualKeyboardKeyAction.HindiLayout1:
        // actionKey = Icon(
        //   Icons.language_rounded,
        //   color: textColor,
        // );
        actionKey = const Text(
          "more",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
        break;
      case VirtualKeyboardKeyAction.MarathiLayout1:
        // actionKey = Icon(
        //   Icons.language_rounded,
        //   color: textColor,
        // );
        actionKey = const Text(
          "more",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
        break;

      // custom end
      // case VirtualKeyboardKeyAction.SwitchLanguage:
      //   actionKey = GestureDetector(
      //       onTap: () {
      //         setState(() {
      //           customLayoutKeys.switchLanguage();
      //         });
      //       },
      //       child: SizedBox(
      //         height: double.infinity,
      //         width: double.infinity,
      //         child: Icon(
      //           Icons.language,
      //           color: textColor,
      //         ),
      //       ));
      //   break;
    }

    var wdgt = GestureDetector(
      onTap: () {
        //custom sumit code
        // print("haptic");
        HapticFeedback.lightImpact();
        //ends
        // actionButtonColor = Colors.amber;
        _onKeyPress(key);
      },
      onDoubleTap: key.action == VirtualKeyboardKeyAction.Shift
          ? () {
              if (key.action == VirtualKeyboardKeyAction.Shift) {
                setState(() {
                  alwaysCaps = !alwaysCaps;
                  isShiftEnabled = false;
                });
                HapticFeedback.lightImpact();
              }
            }
          : null,
      onLongPress: () {
        print(" onlongpress ");
        //custom sumit code
        print("haptic");
        HapticFeedback.lightImpact();
        //ends
        if (key.action == VirtualKeyboardKeyAction.Backspace) {
          longPress = true;
        }
        // Start sending backspace key events while longPress is true
        Timer.periodic(
            const Duration(milliseconds: _virtualKeyboardBackspaceEventPerioud),
            (timer) {
          if (longPress) {
            _onKeyPress(key);
          } else {
            // Cancel timer.
            timer.cancel();
          }
        });
      },
      onLongPressUp: () {
        // Cancel event loop
        longPress = false;
        // actionButtonColor = Color(0xFFE6E6E6);
      },
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
            // border: Border.all(color: borderColor, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            // shape: BoxShape.circle,
            color: actionButtonColor),
        alignment: Alignment.center,
        height: customKeys
            ? widget.keyboardLanguage == 'english'
                ? (height / (keys.length + 0.25))
                : (height / (keys.length + 0.4))
            : height / customLayoutKeys.activeLayout.length,
        child: actionKey,
      ),
    );

//
//
    var spaceBarWidget = InkWell(
      splashColor: actionButtonColor,
      onTap: () {
        _onKeyPress(key);
      },
      onLongPress: () {
        // Add haptic feedback before calling the callback function
        HapticFeedback.lightImpact();

        // Call the long press callback function
        widget.spaceLongPressCallback!();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Ink(
          height: customKeys
              ? widget.keyboardLanguage == 'english'
                  ? (height / (keys.length + 0.25))
                  : (height / (keys.length + 0.4))
              : height / customLayoutKeys.activeLayout.length,
          decoration: const BoxDecoration(
            // border: Border.all(color: borderColor, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: actionSpaceBarButtonColor,
            // color: keyboardKeysColor,
            // shape: BoxShape.circle,
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              // border: Border.all(color: borderColor, width: 0),
              borderRadius: BorderRadius.all(Radius.circular(0)),
              // shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: actionKey,
          ),
        ),
      ),
    );

    // change keyboard backspace
    if (key.action == VirtualKeyboardKeyAction.Backspace) {
      return SizedBox(
          // decoration:
          //     BoxDecoration(border: Border.all(color: borderColor, width: 0)),
          width: (width ?? MediaQuery.of(context).size.width) / 7,
          child: wdgt);
    }

    if (key.action == VirtualKeyboardKeyAction.Space) {
      return SizedBox(
          // decoration:
          //     BoxDecoration(border: Border.all(color: borderColor, width: 0)),
          width: (width ?? MediaQuery.of(context).size.width) / 2,
          child: spaceBarWidget);
    } else {
      return Expanded(child: wdgt);
    }
  }
}
