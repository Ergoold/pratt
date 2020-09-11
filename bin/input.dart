import 'dart:io';

var _putback = <String>[];

Iterable<String> read() sync* {
  int rune;
  while (true) {
    if (_putback.isNotEmpty) {
      yield _putback.removeLast();
    } else if ((rune = stdin.readByteSync()) != -1) {
      yield String.fromCharCode(rune);
    } else {
      break;
    }
  }
}

void putback(String char) {
  _putback.add(char);
}
