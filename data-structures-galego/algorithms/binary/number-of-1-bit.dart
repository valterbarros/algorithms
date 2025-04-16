// https://leetcode.com/problems/number-of-1-bits/description/?envType=problem-list-v2&envId=bit-manipulation
// https://athirabr.medium.com/understanding-hamming-weight-in-binary-numbers-a-php-approach-29b6c2cbc5d5
class Solution {
  int hammingWeight(int n) {
    var count = 0;
    while(n != 0) {
      // examine the last significant bit of the number
      count += n & 1;
      // shift the number to the right to move to next bit check
      n >>= 1;
    }
    
    print(count);

    return count;
  }
}

main() {
  var n = double.parse('1.101010010111011e+98'); // -> // 3
  // var n = 128; // -> 1
  // var n = 2147483645; // -> 30
  Solution().hammingWeight(n.toInt());
}
