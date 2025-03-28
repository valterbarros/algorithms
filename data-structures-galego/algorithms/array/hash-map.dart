// Aula 3 estrutura de dados
_hashMap(String s) {
  var d = Map<String, int>();
  
  for (var ch in s.split('')) {
    d.update(ch, (value) => value + 1, ifAbsent: () => 1);
  }

  for (var MapEntry(:key, :value) in d.entries) {
    if (value == 1) return s.indexOf(key);
  }
  
  return -1;
}

void main(List<String> args) {
  var s = "leetcode";
  
  var value = _hashMap(s);
  
  print(value);  
}
