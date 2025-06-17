import 'dart:collection';

// dijkstra is the name of the guy that have created the algorithm
dijkstra(Map<String, Map<String, int>> graph, String start) {
  Queue<(String, int)> queue = new Queue();
  queue.addFirst(('A', 0));
  var distances = { 'A': 0 };

  while(queue.isNotEmpty) {
    var (key, currentDistance) = queue.removeFirst();
    
    var neighbors = graph[key];

    if (neighbors != null) {
      for(var MapEntry(key:neighbor, value:weight) in neighbors.entries) {
        var distance = currentDistance + weight;
        
        // TODO: check if that if is redundant
        // if (distances[neighbor] != null && currentDistance > distances[neighbor]!) continue;

        // check which distance to same neighbor is less or is null and need to be processed
        if (distances[neighbor] == null || (distances[neighbor] != null && currentDistance < distances[neighbor]!)) {
          distances[neighbor] = distance;
          // Add element to queue with distance from neighbor to "start" param
          queue.addLast((neighbor, distance));
        }
      }
    }
  }

  print(distances);
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

  // result: { "A": 0, "B": 1, "C": 3, "D": 4 }
}
