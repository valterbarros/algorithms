// https://leetcode.com/problems/counting-bits/?envType=problem-list-v2&envId=bit-manipulation
// https://www.youtube.com/watch?v=nNX5Gmnlt88
class Solution {
  // This approach uses the Brian Kernighan’s algorithm
  // returns the number of 1s bits of number
  List<int> countBits(int n) {
    List<int> counts = List.filled(n + 1, 0);

    for(var i = 1; i <= n; i++) {
      // if (i & 1) = 1 it is odd else it is even
      // i >> 1 is same from i / 2
      // Steps for n = 5
      // 0(000) -> 0 >> 1 + 0 = 0
      // 1(001) -> 1 >> 1 + 0 = 1 
      // 2(010) -> 2 >> 1 + 0 = 1
      // 3(011) -> 3 >> 1 + 1 = 2
      // 4(100) -> 4 >> 1 + 1 = 1
      // 5(101) -> 5 >> 1 + 1 = 2
      counts[i] = counts[i >> 1] + (i & 1);
    }

    return counts;
  }
}

main() {
  print(Solution().countBits(2));
}
