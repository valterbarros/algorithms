// https://leetcode.com/problems/course-schedule/
class Solution {
  bool canFinish(int numCourses, List<List<int>> prerequisites) {
    Map<int, List<int>> graph = {
      for (var i = 0; i < numCourses; i++) i: [] 
    };

    // convert [[1,0],[0,2],[2,1]] to
    // { 0: [1], 1: [2], 2: [0] }
    for (var [a,b] in prerequisites) {
      graph[b]!.add(a);
    }
    
    // 0 -> not visited
    // 1 -> visiting
    // 2 -> visited
    var state = List.generate(numCourses, (int index) => 0);

    hasCycle(int v) {
      if (state[v] == 1) return true;
      // Already checked and has no cycle can return safely and avoid execution
      if (state[v] == 2) return false;

      // visiting
      state[v] = 1;
      
      // visit all neighbor
      for(var neighbor in graph[v]!) {
        if (hasCycle(neighbor)) return true;
      }

      // finish all recursion without return, then no cycle detected
      state[v] = 2;
      return false;
    }

    for(var i = 0; i < numCourses; i++) {
      if (hasCycle(i) == true) return false;
    }

    return true;
  }
}

main() {
  // to make course 1 you need to finish course 0
  // [[1,0],[0,1]]
  // impossible case since they are in cycle 1 -> 0 / 0 -> 1
  print(Solution().canFinish(2, [[1,0],[0,1]]));  
  // this case is possible case
  // Solution().canFinish(2, [[1,0]]);

  print(Solution().canFinish(11, [[1,0],[2,1],[10,2]]));
}
