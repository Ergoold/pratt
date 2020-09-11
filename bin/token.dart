class Token {
  final String value;
  final Type type;

  Token.op(this.value) : type = Type.op;
  Token.atom(this.value) : type = Type.atom;

  @override
  String toString() {
    return '$value';
  }
}

enum Type {
  op, atom
}
