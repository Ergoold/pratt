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
  if (lhs.root.type == Type.op) {
    if (lhs.root.value == '(') {
      lhs = expr(tokens, 0);
      if (tokens.current.value != ')') {
        throw 'Unexpected ${tokens.current}; Expected )';
      }
      tokens.moveNext();
    } else {
      num pbp;
      if ((pbp = operators[lhs.root.value].preBindingPower) != null) {
        var rhs = expr(tokens, pbp);
        lhs.children.add(rhs);
      } else {
        throw 'Unexpected ${lhs.root}; Expected atom or unary operator';
      }
    }
  }
  while (true) {
    if (tokens.current == null) break;
    var root = tokens.current;
    if (root.type != Type.op) throw 'Unexpected ${root}; Expected op';
    num pbp;
    if ((pbp = operators[root.value].postBindingPower) != null) {
      if (pbp < mbp) break;
      tokens.moveNext();
      lhs = Tree(root, [lhs]);
      continue;
    }
    num lbp, rbp;
    if ((lbp = operators[root.value].leftBindingPower) != null &&
        (rbp = operators[root.value].rightBindingPower) != null) {
      if (lbp < mbp) break;
      tokens.moveNext();
      var rhs = expr(tokens, rbp);
      lhs = Tree(root, [lhs, rhs]);
      continue;
    }
    break;
  }
  return lhs;
}
