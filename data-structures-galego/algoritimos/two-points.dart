String reverse(String str) {
  var l = 0;
  var r = 0;
  var res = '';

  for(var i = 0; i < str.length; i++) {
    if (str[r] != ' ') {
      r ++;
    } else {
      res += ' ';
      res += str.substring(l, r).split('').reversed.join();

      r++;
      
      l = r;
    }
  }
  
  res += ' ';
  res += str.substring(l, r).split('').reversed.join();
  
  return res.substring(1);
}

void main(List<String> args) {
  var str = "Let's take LeetCode contest";

  reverse(str);
}
