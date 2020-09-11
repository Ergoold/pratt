abstract class Token {}

class Operator extends Token {
  final String value;

  Operator(this.value);

  @override
  String toString() {
    return value.toString();
  }
}

class Atom extends Token {}

class Variable extends Atom {
  final String name;

  Variable(this.name);

  @override
  String toString() {
    return name.toString();
  }
}

class Number extends Atom {
  final num value;

  Number(this.value);

  @override
  String toString() {
    return value.toString();
  }
}
