// https://leetcode.com/problems/merge-sorted-array/description/
void mergeSort(List<int> nums1, int m, List<int> nums2, int n) {
  var i2 = n - 1;
  var i1M = nums1.length - 1;
  var i1 = m - 1;

  while(i2 >= 0) {
    print('times');
    if (i1 >= 0 && nums1[i1] > nums2[i2]) {
      print('here ${i1M}');
      nums1[i1M] = nums1[i1];
      i1--;
    } else {
      print(i1M);
      nums1[i1M] = nums2[i2];
      i2--;
    }

    // Backwards to not override the array items
    i1M--;
  }
}

void main(List<String> args) {
  var nums1 = [20,10,9,0,0,0]; // -> Output: [1,2,2,3,5,6]
  var m = 3;
  var nums2 = [2,5,6];
  var n = 3;
  
  // var nums1 = [1]; // -> Output: [1]
  // var m = 1;
  // var nums2 = <int>[];
  // var n = 0;

  // var nums1 = [0]; // -> Output: [0]
  // var m = 0;
  // var nums2 = [1];
  // var n = 0;

  // var nums1 = [2, 0]; // -> Output [1,2]
  // var m = 1; 
  // var nums2 = [1];
  // var n = 1;

  mergeSort(nums1, m, nums2, n);
  
  print(nums1);
}
