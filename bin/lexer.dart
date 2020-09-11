import 'input.dart';
import 'operators.dart';
import 'token.dart';

Iterable<Token> lex() sync* {
  for (var char in read()) {
    if (operators.keys.contains(char)) {
      yield Operator(char);
    } else if (isDigit(char)) {
      yield Number(lexNumber(char));
    } else if (isLetter(char)) {
      yield Variable(lexVariable(char));
    } else if (char == '\n') {
      break;
    } else if (!whitespace.contains(char)) {
      throw 'Unrecognized character $char';
    }
  }
}

num lexNumber(String prefix) {
  var res = num.parse(prefix);
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

String lexVariable(String prefix) {
  var sb = StringBuffer(prefix);
  for (var char in read()) {
    if (isLetter(char) || isDigit(char)) {
      sb.write(char);
    } else {
      putback(char);
      break;
    }
  }
  return sb.toString();
}

bool isDigit(String s) => (s.codeUnitAt(0) ^ 0x30) <= 9;

bool isLetter(String s) =>
    ((s.codeUnitAt(0) ^ 0x40) - 1) <= 26 ||
    ((s.codeUnitAt(0) ^ 0x60) - 1) <= 26;

Set<String> whitespace = {' ', '\n', '\t', '\v'};
