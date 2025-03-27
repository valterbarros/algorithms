void nextPermutation(List<int> nums) {
  var p = 0;
  var swap = false;
  
  // swap
  for(var j = nums.length - 1; j > 0; j--) {
    // We look for the first spot (from right to left) where a number is smaller than the one after it.
    // 
    // Compare 3 and 1 → 3 > 1 → decreasing
    // 
    // Compare 2 and 3 → 2 < 3 → 🔥 Found it!
    if (nums[j - 1] < nums[j]) {
      p = j - 1;

      swap = true;
      
      break;
    }
  }

  if (!swap) return nums.sort();
  
  var sIdx = p + 1;

  for(var i = p + 2; i < nums.length; i++) {
    if (nums[i] > nums[p] && nums[i] < nums[sIdx]) {
      sIdx = i;
    }
  }

  // smallest valid option
  var curr = nums[p];
  nums[p] = nums[sIdx];
  nums[sIdx] = curr;

  // sort
  var sub = nums.sublist(p+1, nums.length).reversed;
  print(sub);

  nums.replaceRange(p+1, nums.length, sub);
}

void main(List<String> args) {
  var nums = [2,3,1]; // -> [3,1,2]
  // var nums = [1,1,5]; // -> [1,5,1]
  // var nums = [1,2,3]; // -> [1,3,2]
  // var nums = [3,2,1]; // -> [1,2,3]
  // var nums = [2, 2, 3, 3, 4, 4, 5, 5, 6, 6]; // -> [2, 2, 3, 3, 4, 4, 5, 6, 5, 6]
  // var nums = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]; // -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  // var nums = [1, 3, 5, 4, 2, 6, 9, 8, 7, 0]; // -> [1, 3, 5, 4, 2, 7, 0, 6, 8, 9]
  // var nums = [5, 1, 3, 2, 6, 4, 7, 10, 9, 8]; // -> [5, 1, 3, 2, 6, 4, 8, 7, 9, 10]
  // var nums = [3, 5, 7, 6, 2, 9, 8, 1, 0, 4]; // -> [3, 5, 7, 6, 2, 9, 8, 1, 4, 0]
  // var nums = [0, 2, 4, 6, 8, 9, 7, 5, 3, 1]; // -> [0, 2, 4, 6, 9, 1, 3, 5, 7, 8]
  // var nums = [9, 9, 8, 8, 7, 7, 6, 6, 5, 5]; // -> [5, 5, 6, 6, 7, 7, 8, 8, 9, 9]

  nextPermutation(nums);
  
  print(nums);
}