// https://leetcode.com/problems/missing-number/description/
missingNumber(List<int> nums) {
  var missing = 0;

  for (var i = 0; i < nums.length; i++) {
    print(i);
    var curr = nums[i];
    // If number is equal it returns 0
    var increment = i ^ curr;
    // If no number is missing it will return original value from nums.length
    missing = missing ^ increment;
  }

  print(missing);
}

main() {
  // equal numbers remove each other if a number is missing that will nome be removed
  // m = 6 ^ 0 ^ 0 = 6
  // m = 6 ^ 1 ^ 1 = 6
  // m = 6 ^ 2 ^ 2 = 6
  // m = 6 ^ 3 ^ 3 = 6
  // m = 6 ^ 4 ^ 5 = 7
  // m = 7 ^ 5 ^ 6 = 4
  missingNumber([0, 1, 2, 3, 5, 6]);

  // 0, 1, 2, 3, 5, 6
  // 0, 1, 2, 3, 4, 5, 6
}
