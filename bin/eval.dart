import 'dart:math';

import 'token.dart';
import 'tree.dart';

@deprecated
int eval(Tree tree) {
  if (tree.root.type == Type.atom) return int.parse(tree.root.value);
  switch (tree.root.value) {
    case '+':
      if (tree.children.length == 1) return eval(tree.children.first);
      return eval(tree.children[0]) + eval(tree.children[1]);
    case '-':
      if (tree.children.length == 1) return -eval(tree.children.first);
      return eval(tree.children[0]) - eval(tree.children[1]);
    case '*':
      return eval(tree.children[0]) * eval(tree.children[1]);
    case '/':
      return eval(tree.children[0]) ~/ eval(tree.children[1]);
    case '%':
      return eval(tree.children[0]) % eval(tree.children[1]);
    case '!':
      return _factorial(eval(tree.children[0]));
    case '^':
      return pow(eval(tree.children[0]), eval(tree.children[1]));
  }
  throw 'Your Tree is messed up';
}

int _factorial(int n) {
  if (n < 0) throw 'Error: factorial operand must be positive';
  if (n < 2) return 1;
  return n * _factorial(n - 1);
}
