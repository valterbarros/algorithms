// https://leetcode.com/problems/valid-parentheses/

class Solution {
  bool isValid(String s) {
    const mapping = { '(': ')', '{': '}', '[': ']' };
    List<String> stack = [];

    for (var i = 0; i < s.length; i++) {
      var current = s[i];

      if (mapping.containsKey(current)) {
        stack.add(current);
      } else {
        // stack cant be empty here because should have at minimum an opening parenteses
        if (stack.isEmpty) return false;

        var last = stack.removeLast();
        if (mapping[last] != current) {
          return false;
        }
      }
    }

    return stack.isEmpty;
  }
}

main() {
  // var s = '()';
  // var s = '([)]';
  var s = '([])';
  // var s = '()[]{}';
  // var s = '[';
  // var s = ']';
  print(Solution().isValid(s));  
}
