import 'lexer.dart';
import 'operators.dart';
import 'token.dart';
import 'tree.dart';

Tree parse() {
  var tokens = lex().iterator;
  tokens.moveNext();
  return expr(tokens, 0);
}

Tree expr(Iterator<Token> tokens, num mbp) {
  var lhs = Tree(tokens.current, []);
  tokens.moveNext();
  if (lhs.root is Operator) {
    if ((lhs.root as Operator).value == '(') {
      lhs = expr(tokens, 0);
      if ((tokens.current as Operator).value != ')') {
        throw 'Unexpected ${tokens.current}; Expected )';
      }
      tokens.moveNext();
    } else {
      num pbp;
      if ((pbp = operators[(lhs.root as Operator).value].preBindingPower) != null) {
        lhs.children.add(expr(tokens, pbp));
      } else {
        throw 'Unexpected ${lhs.root}; Expected atom or unary operator';
      }
    }
  }
  while (true) {
    if (tokens.current == null) break;
    var root = tokens.current;
    if (root is! Operator) throw 'Unexpected ${root}; Expected op';
    num pbp;
    if ((pbp = operators[(root as Operator).value].postBindingPower) != null) {
      if (pbp < mbp) break;
      tokens.moveNext();
      lhs = Tree(root, [lhs]);
      continue;
    }
    num lbp, rbp;
    if ((lbp = operators[(root as Operator).value].leftBindingPower) != null &&
        (rbp = operators[(root as Operator).value].rightBindingPower) != null) {
      if (lbp < mbp) break;
      tokens.moveNext();
      lhs = Tree(root, [lhs, expr(tokens, rbp)]);
      continue;
    }
    break;
  }
  return lhs;
}
