// https://leetcode.com/problems/two-sum/description/
import 'dart:math';

twoSumQuad(List<int> nums, int target) {
  for(var i = 0; i < nums.length; i++) {
    var el = nums[i];

    for(var j = i + 1; j < nums.length; j++) {
      var el2 = nums[j];

      if ((el + el2) == target) return [i,j];
    }
  }

  return [];
}

twoSum(List<int> nums, int target) {
  var d = Map<int, int>();

  for(var i = 0; i < nums.length; i++) {
    var el = nums[i];

    var rest = (el - target).abs();
    
    if (d.containsKey(rest)) {
      var idx = d[rest];

      return [idx, i];
    }

    d.putIfAbsent(el, () => i);
  }

  return [];
}

benchMark() {
  var rng = Random();
  Stopwatch stopwatch = Stopwatch()..start();
  List<int> nums = List.generate(10000000, (i) => rng.nextInt(100000)); // Array com 10 milhões de números aleatórios
  int target = 999999; // Definindo um target aleatório que é possível de ser alcançado com os números gerados
  stopwatch.stop();

  // var result = twoSum(nums, target);
  var result = twoSumQuad(nums, target);
  
  print('result: ${result}');
  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
}

void main(List<String> args) {
  //var value = twoSum([3,2,4], 6);
  // var value = twoSum([3,3], 6);
  // var value = twoSum([2,7,11,15], 9);
  
  // print(value);

  benchMark();
}
