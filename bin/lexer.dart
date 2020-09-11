import 'input.dart';
import 'operators.dart';
import 'token.dart';

Iterable<Token> lex() sync* {
  for (var char in read()) {
    if (operators.keys.contains(char)) {
      yield Operator(char);
    } else if (isDigit(char)) {
      yield Number(lexAtom(char));
    } else if (char == '\n') {
      break;
    } else if (!whitespace.contains(char)) {
      throw 'Unrecognized character $char';
    }
  }
}

num lexAtom(String prefix) {
  num res;
  for (var char in read()) {
    if (isDigit(char)) {
      res *= 10;
      res += char.codeUnitAt(0) - 0x30;
    } else {
      putback(char);
      break;
    }
  }
  return res;
}

bool isDigit(String s) => (s.codeUnitAt(0) ^ 0x30) <= 9;

Set<String> whitespace = {' ', '\n', '\t', '\v'};
