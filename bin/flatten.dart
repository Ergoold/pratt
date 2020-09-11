import 'token.dart';
import 'tree.dart';

Tree flatten(Tree tree) {
  if (tree.root is Atom) return tree;
  switch ((tree.root as Operator).value) {
    case '+':
    case '*':
      if (tree.children.length == 1) return tree;
      for (var i = 0; i < tree.children.length; i++) {
        if (tree.children[0].root is! Operator) break;
        if ((tree.children[0].root as Operator).value ==
            (tree.root as Operator).value) {
          var children = tree.children[0].children;
          tree.children.removeAt(0);
          tree.children.insertAll(0, children);
        }
      }
      break;
  }
  for (var child in tree.children) {
    flatten(child);
  }
  return tree;
}
