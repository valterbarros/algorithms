isEven(int exponent) {
  // first bit of a number say if that is even or odd
  return exponent & 1 == 0;
}

isOdd(int exponent) {
  return !isEven(exponent);
}

power(int base, int exponent) {
  if (exponent == 0) {
    return 1;
  }

  // negative
  if (exponent < 0) {
    return 1 / power(base, -exponent);
  }

  // recursive case: n is odd
  if (isOdd(exponent)) {
    return base * power(base, exponent - 1);
  }
  // recursive case: n is even
  if (isEven(exponent)) {
    var p = power(base, exponent ~/ 2);
    return p * p;
  }
}

main() {
  // var val = power(3, 3);
  // var val = power(5,5);
  // var val = power(5,-3); // 0.008
  var val = power(3, -2); // 0.008

  print(val);
}
