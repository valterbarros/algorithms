// https://leetcode.com/problems/number-of-provinces/description/
// Explain about DSU: https://www.youtube.com/watch?v=aBxjDBC4M1U
// DSU prototype
// store parent and size in maps
// add itens to parent and size
// recursively find parent by node
// merge two elements, put itens at greater group
class DSU {
  var size = <int, int>{}; 
  var parent = <int, int>{}; 

  // find root and do path compression
  root(int node) {
    // is not root
    if (parent[node] != node) {
      // path compression ps: it is not required but is good for performance
      return parent[node] = root(parent[node]!);
    } else {
      return node;
    }
  }

  add(int node) {
    parent.putIfAbsent(node, () => node);
    size.putIfAbsent(node, () => 1);
  }

  // should check if node1 and node2 has no cycle dependency
  merge(int node1, int node2) {
    add(node1);
    add(node2);
    
    var parent1 = root(node1);
    var parent2 = root(node2);
    
    // if same parent and redundant connection return false
    if (parent1 == parent2) {
      return false;
    }

    // swap parents
    swap(int a, int b) {
      parent[a] = b;
      size[b] = size[b]! + size[a]!;
    }

    // swap and sum size
    if (size[parent1]! < size[parent2]!) {
      swap(parent1, parent2);
    } else {
      swap(parent2, parent1);
    }
    
    return true;
  }
}

class Solution {
  List<int> findRedundantConnection(List<List<int>> edges) {
    var dsu = DSU();

    List<int> res = [];
    for (var i = 0; i < edges.length; i++) {
      // -1 because number is 1-indexed
      var hasUnion = dsu.merge(edges[i].first - 1, edges[i].last - 1);
      // no union and redundant get the result but keep interacting to return last redundant
      if (!hasUnion) {
        res = edges[i];
      }
    }

    return res;
  }
}

main() {
  // answer = [2,3]
  // var edges = [[1,2],[1,3],[2,3]];
  // answer = [1,4]
  var edges = [[1,2],[2,3],[3,4],[1,4],[1,5]];

  print(Solution().findRedundantConnection(edges));
}
