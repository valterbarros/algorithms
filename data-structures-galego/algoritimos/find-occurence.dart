int strStr(String haystack, String needle) {
  var l = 0;
  var r = 0;
  var first;

  while (l < haystack.length && r < needle.length) {
    if (haystack[l] == needle[r]) {
      first ??= l;
      r++;
    } else if(first != null) {
      l = first + 1;
      first = null;
      r = 0;
    }

    l++;
  }

  if (r == needle.length) return first;

  return -1;
}

void main(List<String> args) {
  // var value = strStr('sadbutsad', 'sad'); // -> 0
  // var value = strStr('leetcode', 'leeto'); // -> -1
  // var value = strStr('leetcodeleeto', 'leeto'); // -> 8
  var value = strStr('mississippi', 'issip'); // -> 4

  print('value: $value');
}
