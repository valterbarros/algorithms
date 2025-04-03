// https://leetcode.com/problems/sort-an-array/
class Solution {
  swap(List<int> arr, int i, int j) {
    var n1 = arr[j];
    var n2 = arr[i];

    arr[i] = n1;
    arr[j] = n2;
  }

  partition(List<int> nums, int low, int high) {
    var pivot = nums[high];
    var i = low;
    var lt = low;
    var gt = high;

    while(i <= gt) {
      var curr = nums[i];

      if (curr < pivot) {
        swap(nums, lt, i);
        i++;
        lt++;
      } else if (curr > pivot) {
        swap(nums, i, gt);
        gt--;
      } else {
        i++;
      }
    }

    return (lt, gt);
  }

  List<int> sortArray(List<int> nums, [int? low, int? high]) {
    if (low == null) low = 0;
    if (high == null) high = nums.length - 1;
    
    if (low < high) {
      var (lt, gt) = partition(nums, low, high);

      sortArray(nums, low, lt - 1);
      sortArray(nums, gt + 1, high);
    }

    return nums;
  }
}

main() async {
  // var nums = [5,2,3,1];
  var nums = [5,2,3,0,0,1,6,8,1,4];
  // var nums = List.generate(100000, (index) => 2);
  // var nums = [2,2,2,2,2];

  var n = Solution().sortArray(nums, 0, nums.length - 1);

  print('---final---');
  print(n);
}
