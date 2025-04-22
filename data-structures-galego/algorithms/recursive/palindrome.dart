palindrome(String part, int left, int right) {
  var first = part.codeUnitAt(left);
  var last = part.codeUnitAt(right);

  if (first != last) return false;
  if (left == right) return true;
 
  return palindrome(part, left + 1, right - 1);
}

main() {
  // var result = palindrome('rotor', 0, 4);
  // var result = palindrome('motor', 0, 4);
  var result = palindrome('rater', 0, 4);
    // var result = palindrome('xyzyzyx', 0, 6);

  print(result);
}
