import 'dart:collection';

class Solution {
  bool isBipartite(List<List<int>> graph) {
    var queue = new Queue<int>();
    var colors = <int, bool>{};

    for (var i = 0; i < graph.length; i++) {
      if (colors.containsKey(i)) continue;

      queue.addLast(i);
      colors[i] = true;

      // bfs
      while(queue.isNotEmpty) {
        var index = queue.removeFirst();
        var neighbors = graph[index];
        var parentCol = colors[index];

        for (var node in neighbors) {
          if (!colors.containsKey(node)) {
            queue.addLast(node);
            colors.putIfAbsent(node, () => !parentCol!);
          } else if (parentCol == colors[node]) {
            return false;
          }
        }
      }
    }

    return true;
  }
}

main() {
  // Not bipartite
  // var graph = [[1,2,3],[0,2],[0,1,3],[0,2]];
  // Bipartite
  // var graph = [[1,3],[0,2],[1,3],[0,2]];
  // other bipartite
  // List<List<int>> graph = [[4],[],[4],[4],[0,2,3]];
  // other bipartite
  // List<List<int>> graph = [[],[3],[],[1],[]];
  // other no bipartite
  // List<List<int>> graph = [[],[2,4,6],[1,4,8,9],[7,8],[1,2,8,9],[6,9],[1,5,7,8,9],[3,6,9],[2,3,4,6,9],[2,4,5,6,7,8]];
  // edge case
  // List<List<int>> graph = [[]];
  // no bipartite
  // List<List<int>> graph = [[2,4],[2,3,4],[0,1],[1],[0,1],[7],[9],[5],[],[6],[12,14],[],[10],[],[10],[19],[18],[],[16],[15],[23],[23],[],[20,21],[],[],[27],[26],[],[],[34],[33,34],[],[31],[30,31],[38,39],[37,38,39],[36],[35,36],[35,36],[43],[],[],[40],[],[49],[47,48,49],[46,48,49],[46,47,49],[45,46,47,48]];
  // no bipartite
  // List<List<int>> graph = [[6,7,8],[2,5],[1,3],[2,4],[3,5],[4,1],[0,9,10],[0],[0,11],[6],[6],[8,12],[11],[],[],[]];
  // bipartite
  List<List<int>> graph = [[1],[0],[4],[4],[2,3]];
  
  print(Solution().isBipartite(graph));
}
