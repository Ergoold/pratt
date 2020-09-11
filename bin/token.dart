abstract class Token {}

class Operator extends Token {
  final String value;

  Operator(this.value);
}

class Atom extends Token {}

class Variable extends Atom {
  final String name;

  Variable(this.name);
}

class Number extends Atom {
  final num value;

  Number(this.value);
}
