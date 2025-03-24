// https://leetcode.com/problems/remove-element/description/?envType=problem-list-v2&envId=two-pointers

int removeElement(List<int> nums, int val) {
  var i = 0;

  for(var j = 0; j < nums.length; j++) {
    if (nums[j] != val) {
      nums[i] = nums[j];
      i++;
    }
  }

  return i;
}

void main(List<String> args) {
  var nums = [3,2,2,3];
  // int k = removeElement(nums, 3);
  // var nums = [0,1,2,2,3,0,4,2];
  int k = removeElement(nums, 3);

  print('${k} : ${nums}');
}
