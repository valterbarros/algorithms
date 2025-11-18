// https://leetcode.com/problems/daily-temperatures/submissions/1833681404/
class Solution {
  List<int> dailyTemperatures(List<int> temperatures) {
    // Salvar temperature indexers no stack
    var stack = [];
    List<int> results = List.generate(temperatures.length, (index) => 0);

    for (var i = 0; i < temperatures.length; i++) {
      var temp = temperatures[i];
      
      //comparar a temp com as ultimas temperaturas que passaram
      // quando encontrar menor remove da stack
      
      while (stack.isNotEmpty && temperatures[stack.lastOrNull] < temp) {
        var index = stack.lastOrNull;
        results[index] = (i - index).toInt();
        stack.removeLast();
      }

      stack.add(i);
    }

    return results;
  }
} 

main() {
  var temperatures = [73,74,75,71,69,72,76,73];
  print(Solution().dailyTemperatures(temperatures));  
}