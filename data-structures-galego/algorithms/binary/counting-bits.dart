// https://leetcode.com/problems/counting-bits/?envType=problem-list-v2&envId=bit-manipulation
// https://www.youtube.com/watch?v=nNX5Gmnlt88
class Solution {
  List<int> countBits(int n) {
    List<int> counts = List.filled(n + 1, 0);

    for(var i = 1; i <= n; i++) {
      counts[i] = counts[i >> 1] + (i & 1);
    }

    print(counts);

    return counts;
  }
}

main() {
  Solution().countBits(5);
}
