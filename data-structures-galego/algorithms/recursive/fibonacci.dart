int fib(int n) {
  // base case
  if (n <= 1) return n;

  // Call recursive multiple times
  var val = fib(n - 1) + fib(n - 2);
  
  return val;
}

main() {
  // It returns the fibonacci in n position
  // 10 first elements from fibonacci: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34
  print(fib(3));
}
