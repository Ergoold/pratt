import 'input.dart';
import 'operators.dart';
import 'token.dart';

Iterable<Token> lex() sync* {
  for (var char in read()) {
    if (operators.keys.contains(char)) {
      yield Token.op(char);
    } else if (isDigit(char)) {
      yield Token.atom(lexAtom(char));
    } else if (char == '\n') {
      break;
    } else if (!whitespace.contains(char)) {
      throw 'Unrecognized character $char';
    }
  }
}

String lexAtom(String prefix) {
  var sb = StringBuffer(prefix);
  for (var char in read()) {
    if (isDigit(char)) {
      sb.write(char);
    } else {
      putback(char);
      break;
    }
  }
  return sb.toString();
}

bool isDigit(String s) => (s.codeUnitAt(0) ^ 0x30) <= 9;

Set<String> whitespace = {' ', '\n', '\t', '\v'};
