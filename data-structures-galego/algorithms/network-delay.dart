// https://leetcode.com/problems/network-delay-time/
import 'dart:collection';
import 'dart:math';

// see dijkstra.dart file for more explanation
class Solution {
  // We will send a signal from a given node k. Return the minimum time it takes
  // for all the n nodes to receive the signal. If it is impossible for all the
  // n nodes to receive the signal, return -1.
  networkDelayTime(List<List<int>> times, int reach, int selected) {
    Queue<(int, int)> queue = new Queue();
    queue.addFirst((selected, 0));
    var graph = <int, Map<int, int>>{};;
    // Convert to graph structure
    // ex:
    // {
    //   2: { 1: 1, 3: 1 },
    //   3: { 4: 1 }
    // }
    for (var item in times) {
      if (graph.containsKey(item[0])) {
        graph[item[0]]?[item[1]] = item[2];
      } else {
        graph[item[0]] = {item[1]: item[2] };
      }
    }

    // print(graph);

    // start all keys with big number to at first interaction the distance be < less
    var distances = { for (var e in graph.keys) e: 999999 };
    distances[selected] = 0;

    while(queue.isNotEmpty) {
      var (node, dist) = queue.removeFirst();
      
      var neighbors = graph[node];

      if (neighbors != null) {
        for(var MapEntry(key:neighbor, value:weight) in neighbors.entries) {
          var distance = dist + weight;
          
          // Avoid null error
          distances.putIfAbsent(neighbor, () => 99999);

          if (distance < distances[neighbor]!) {
            distances[neighbor] = distance;
            queue.addLast((neighbor, distance));
          }
        }
      }
    }
    
    var _max = -1;
    if (distances.length < reach) {
      return _max;
    }

    // Get max to get minimum time to reach nodes,
    // many nodes can be reach at same time
    _max = distances.values.toList().reduce(max);
    
    if (_max == 0) return -1;

    return _max;
  }
}

main (){
  // [source, target, time]
  // source -> target = time
  var times = [[2,1,1], [2,3,1], [3,4,1]];
  var reach = 4;
  var selected = 2;
  Solution().networkDelayTime(times, reach, selected);  
}
