import 'dart:collection';

// Note: If performance is too important use heapq alternative, to add elements from less to greater

// dijkstra is the name of the guy that have created the algorithm
// basically it get minimum distance from start node to all other neighbor
dijkstra(Map<String, Map<String, int>> graph, String start) {
  Queue<(String, int)> queue = new Queue();
  queue.addFirst((start, 0));
  // start all keys with big number to at first interaction the distance be < less
  var distances = { for (var e in graph.keys) e: 999999 };
  distances[start] = 0;

  while(queue.isNotEmpty) {
    var (key, currentDistance) = queue.removeFirst();
    
    var neighbors = graph[key];

    for(var MapEntry(key:neighbor, value:weight) in neighbors!.entries) {
      // currentDistance is distance to node, other node need to sum that because they appear just after
      var distance = currentDistance + weight;
      
      // This is important in case of to have (c, 3) and (c, 4) this would exclude the greater number
      if (currentDistance > distances[neighbor]!) continue;

      // check which distance to same neighbor is less or is null and need to be processed
      if (distances[neighbor] != null && distance < distances[neighbor]!) {
        distances[neighbor] = distance;
        // Add element to queue with distance from neighbor to "start" param
        queue.addLast((neighbor, distance));
      }
    }
  }

  print(distances);
}

// same algorithm using recursion
dijkstraR(Map<String, Map<String, int>> graph, Map<String, int> distances, String key, int currentDistance) {
  var neighbors = graph[key];

  for(var MapEntry(key:neighbor, value:weight) in neighbors!.entries) {
    var distance = currentDistance + weight;

    if (distances[neighbor] == null || (distances[neighbor] != null && distance < distances[neighbor]!)) {
      distances[neighbor] = distance;
      dijkstraR(graph, distances, neighbor, distance);
    }
  }
  
  return distances;
}

main() {
  var graph = {
    'A': { 'B': 1, 'C': 4 }, // distance from A to B and C
    'B': { 'A': 1, 'C': 2, 'D': 5 }, // distance from B to A, C and D
    'C': { 'A': 4, 'B': 2, 'D': 1 }, // distance from C to A, B and D
    'D': { 'B': 5, 'C': 1 }, // distance from D to B and C
  };

  var shortestPath = dijkstra(graph, 'A');
  print(shortestPath);

  var shortestPath2 = dijkstraR(graph, { 'A': 0 }, 'A', 0);
  print(shortestPath2);
  // result: { "A": 0, "B": 1, "C": 3, "D": 4 }
}
