void mergeSort(List<int> nums1, int m, List<int> nums2, int n) {
  var i2 = n - 1;
  var i1M = nums1.length - 1;
  var i1 = m - 1;

  while(i2 >= 0) {
    if (i1 >= 0 && nums1[i1] > nums2[i2]) {
      nums1[i1M] = nums1[i1];
      i1--;
    } else {
      nums1[i1M] = nums2[i2];
      i2--;
    }

    i1M--;
  }
}

void main(List<String> args) {
  var nums1 = [1,2,3,0,0,0]; // -> Output: [1,2,2,3,5,6]
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
