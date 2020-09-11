var operators = {
  '+': BindingPower._full(5, null, 1, 2),
  '-': BindingPower._full(5, null, 1, 2),
  '*': BindingPower._infix(3, 4),
  '/': BindingPower._infix(3, 4),
  '%': BindingPower._infix(3, 4),
  '!': BindingPower._postfix(7),
  '^': BindingPower._infix(10, 9),
  '(': BindingPower._paren(),
  ')': BindingPower._paren()
};

class BindingPower {
  final num preBP;
  final num postBP;
  final num leftBP;
  final num rightBP;

  BindingPower._full(this.preBP, this.postBP,
      this.leftBP, this.rightBP);

  BindingPower._infix(this.leftBP, this.rightBP)
      : preBP = null,
        postBP = null;

  BindingPower._postfix(this.postBP)
      : preBP = null,
        leftBP = null,
        rightBP = null;

  BindingPower._paren()
      : preBP = null,
        postBP = null,
        leftBP = null,
        rightBP = null;
}
