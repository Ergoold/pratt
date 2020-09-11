import 'token.dart';
import 'tree.dart';

Tree flatten(Tree tree) {
  if (tree.root.type == Type.atom) return tree;
  switch (tree.root.value) {
    case '+':
    case '*':
      if (tree.children.length == 1) return tree;
      for (var i = 0; i < tree.children.length; i++) {
        if (tree.children[0].root.value == tree.root.value) {
          var children = tree.children[0].children;
          tree.children.removeAt(0);
          tree.children.insertAll(0, children);
        }
      }
      break;
  }
  return tree;
}
