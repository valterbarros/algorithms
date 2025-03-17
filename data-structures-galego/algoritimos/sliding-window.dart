import 'dart:math';

int slideWindow(String s) {
  var l = 0;
  var r = 0;
  
  var _max = 1;
  
  var counter = Map<String, int>();
  
  counter[s[0]] = 1;

  while (r < (s.length - 1)) {
    r += 1;
    counter.update(s[r], (value) => value + 1, ifAbsent: () => 1);

    while (counter[s[r]] == 3) {
      counter.update(s[l], (value) => value - 1);

      l += 1;
    }

    _max = max(_max, (r-l)+1);

    print("max: ${_max}, ${l} -> ${r}");
  }
  
  return _max;
}

void main(List<String> args) {
  var input = 'bcbbbcba';
  var value = slideWindow(input);
  
  // print(value);
}
