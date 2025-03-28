// https://leetcode.com/problems/sort-colors/description/
class Solution {
  void sortColors(List<int> nums) {
    var c = 0;
    var swap = -1;
    while(swap != 0) {
      swap = 0;

      for(var j = 0; j < nums.length - 1; j++) {
        if (nums[j] > nums[j + 1]) {
          var a = nums[j];
          var b = nums[j + 1];
          
          nums[j] = b;
          nums[j + 1] = a;

          swap += 1;
        }
      }
    }
    
    print(c);
  }
}

main() {
  var nums = [9,4,1,10,3];
  // var nums = [2,0,2,1,1,0];
  // var nums = [1,2,3,4,5,6];
  // var nums = [2,0,1];

  Solution().sortColors(nums);

  print(nums);
}
