// https://leetcode.com/problems/remove-duplicates-from-sorted-array/?envType=problem-list-v2&envId=two-pointers

int removeDuplicates(List<int> nums) {
  var i = 0;

  for(var j = 0; j < nums.length; j++) {
    if (nums[j] != nums[i]) {
      print('${i} : ${j}');
      i++;
      nums[i] = nums[j];
    }
  }
  
  return i + 1;
}

void main(List<String> args) {
  // var nums = [1,1,2];
  var nums = [0,0,1,1,1,2,2,3,3,4];
  // var nums = [0,0,0,0,0,0,0,0,0,0,1];
  removeDuplicates(nums);
  
  print(nums);
}
