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
  final num preBindingPower;
  final num postBindingPower;
  final num leftBindingPower;
  final num rightBindingPower;

  BindingPower._full(this.preBindingPower, this.postBindingPower,
      this.leftBindingPower, this.rightBindingPower);

  BindingPower._infix(this.leftBindingPower, this.rightBindingPower)
      : preBindingPower = null,
        postBindingPower = null;

  BindingPower._postfix(this.postBindingPower)
      : preBindingPower = null,
        leftBindingPower = null,
        rightBindingPower = null;

  BindingPower._paren()
      : preBindingPower = null,
        postBindingPower = null,
        leftBindingPower = null,
        rightBindingPower = null;
}
