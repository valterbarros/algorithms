// Just a example from chatGpt to try to simplify the 3 way partition quickSort
// Using two loops instead of a while with 3 pointers
import '../linked-list/utils.dart';

partition(List<int> nums, int low, int high) {
  var smaller = low;
  var pivot = nums[high];
  var larger = high;

  for(var i = low; i < high; i++) {
    var curr = nums[i];

    if (curr < pivot) {
      swap(nums, i, smaller);

      smaller++;
    }
  }
  
  for(var i = high; i >= smaller; i--) {
    var curr = nums[i];

    if (curr > pivot) {
      print('larger');
      larger--;

      swap(nums, i, larger);
    }
  }
  
  print('$low ${smaller - 1}');
  print('${larger + 1} ${high}');

  swap(nums, larger, high);
}

main() {
  // var nums = [10,4,5,2,3,0,0,1,6,8,1,4];
  var nums = [2,2,2,2,2];
  partition(nums, 0, nums.length - 1);
}
