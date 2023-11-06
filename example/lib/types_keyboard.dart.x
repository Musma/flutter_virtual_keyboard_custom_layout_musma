/// alphabet: all letters, return, backspace, shift, space.
/// numeric: 0-9, return, backspace.
/// alphaEmail: all letters, 0-9, [. - _ @], @gmail.com.
enum TypeLayout { alphabet, numeric, alphaEmail, hindi1, hindi2 }

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
          ["*", "\"", "'", ":", ";", "!", "?", ",", "."],
          ["SHIFT", "=", "{", "}", "[", "]", "\\", "%", "BACKSPACE"],
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
          ['क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ'],
          ['ट', 'ठ', 'ड', 'ढ', 'ण', 'त', 'थ', 'द', 'ध', 'न'],
          ['प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'ळ', 'व', 'श'],
          [
            'HindiLayout1',
            'ष',
            'स',
            'ह',
            'ज्ञ',
            'क्ष',
            'श्र',
            'ऋ',
            "BACKSPACE",
          ],
          ["NumbersAndSymbols", ",", "SPACE", ".", "RETURN"],
        ];
      case TypeLayout.hindi2:
        return [
          ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
          ['अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ए', 'ऐ', 'ओ', 'औ'],
          ['अं', 'अः', 'ा', 'ि', 'ी', 'ु', 'ू', 'े', 'ै', 'ो'],
          ['HindiLayout1', 'ौ', 'ं', 'ृ', '्', 'ॐ', '।', '॥', "BACKSPACE"],
          ["NumbersAndSymbols", ",", "SPACE", ".", "RETURN"],
        ];
      default:
        return [];
    }
  }
}
