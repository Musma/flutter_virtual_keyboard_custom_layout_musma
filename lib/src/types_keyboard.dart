part of flutter_virtual_keyboard_custom_layout_musma;

/// alphabet: all letters, return, backspace, shift, space.
/// numeric: 0-9, return, backspace.
/// alphaEmail: all letters, 0-9, [. - _ @], @gmail.com.
enum TypeLayout {
  alphabet,
  numeric,
  alphaEmail,
  hindi1,
  hindi2,
  marathi1,
  marathi2,
}

extension TypeLayoutExtension on TypeLayout {
  List<List> get keyboard {
    switch (this) {
      case TypeLayout.alphabet:
        return [
          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
          ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
          ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
          ["SHIFT", "z", "x", "c", "v", "b", "n", "m", "BACKSPACE"],
          ["NumbersAndSymbols", ",", "SPACE", ".", "RETURN"],
        ];
      // case TypeLayout.numeric:
      //   return [
      //     ["1", "2", "3"],
      //     ["4", "5", "6"],
      //     ["7", "8", "9"],
      //     ["BACKSPACE", "0", "RETURN"],
      //   ];
      case TypeLayout.alphaEmail:
        return [
          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
          ["@", "#", "\$", "_", "&", "-", "+", "(", ")", "/"],
          ["*", "\"", "'", ":", ";", "!", "?", "~", "<", ">"],
          ["SHIFT", "=", "{", "}", "[", "]", "\\", "%", "^", "BACKSPACE"],
          ["NumbersAndSymbols", ",", "SPACE", ".", "RETURN"],
          // ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
          // ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "BACKSPACE"],
          // ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ç", "RETURN"],
          // ["SHIFT", "z", "x", "c", "v", "b", "n", "m", "SHIFT"],
          // [
          //   ".",
          //   "~",
          //   "!",
          //   "%",
          //   "^",
          //   "&",
          //   "*",
          //   "=",
          //   "+",
          //   "{",
          //   "}",
          //   "'",
          //   "?",
          //   "-"
          // ],
          // ["@hotmail.com", "@", "SPACE", "_", "@gmail.com"],
        ];
      case TypeLayout.hindi1:
        return [
          [
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
            'ँ',
            'ॅ',
          ],
          ['क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ'],
          ['ट', 'ठ', 'ड', 'ढ', 'ण', 'त', 'थ', 'द', 'ध', 'न'],
          [
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
          ],
          ['HindiLayout1', 'स', 'ह', 'क्ष', 'त्र', 'श्र', 'ज्ञ', "BACKSPACE"],
          ["NumbersAndSymbols", '।', "SPACE", 'ऋ', '्', "RETURN"],
        ];
      case TypeLayout.hindi2:
        return [
          ['अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ए', 'ऐ', 'ओ', 'औ'],
          ['अं', 'अः', "१", "२", "३", "४", "५", "६", "७", "८", "९", "०"],
          ['ा', 'ि', 'ी', 'ु', 'ू', 'े', 'ै', 'ो'],
          ['HindiLayout1', 'ौ', 'ं', 'ँ', 'ृ', 'ॐ', '।', '॥', "BACKSPACE"],
          ["NumbersAndSymbols", '।', "SPACE", 'ऋ', '्', "RETURN"],
        ];
      case TypeLayout.marathi1:
        return [
          ['ा', 'ि', 'ी', 'ु', 'ू', 'े', 'ै', 'ो', 'ौ', 'ं', 'ँ', 'ॅ'],
          ['क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ'],
          ['ट', 'ठ', 'ड', 'ढ', 'ण', 'त', 'थ', 'द', 'ध', 'न'],
          [
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
          ],
          [
            'MarathiLayout1',
            'स',
            'ह',
            'ळ',
            'क्ष',
            'त्र',
            'ज्ञ',
            'श्र',
            "BACKSPACE"
          ],
          ["NumbersAndSymbols", '.', "SPACE", 'ऋ', '्', "RETURN"],
        ];
      case TypeLayout.marathi2:
        return [
          ['अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ए', 'ऐ', 'ओ', 'औ'],
          ['अं', 'अः', "१", "२", "३", "४", "५", "६", "७", "८", "९", "०"],
          ['ा', 'ि', 'ी', 'ु', 'ू', 'े', 'ै', 'ो'],
          ['MarathiLayout1', 'ौ', 'ं', 'ँ', 'ृ', 'ॐ', '।', '॥', "BACKSPACE"],
          ["NumbersAndSymbols", '.', "SPACE", 'ऋ', '्', "RETURN"],
        ];
      default:
        return [];
    }
  }
}
