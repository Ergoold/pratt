import 'token.dart';

class Tree {
  final Token root;
  final List<Tree> children;

  Tree(this.root, this.children);

  @override
  String toString() {
    return '$root${children.isEmpty ? '' : children}';
  }
}
