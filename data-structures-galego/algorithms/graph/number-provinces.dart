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
    
    if (parent1 == parent2) return;

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
  }
}

class Solution {
  int findCircleNum(List<List<int>> isConnected) {
    var dsu = DSU();

    for (var i = 0; i < isConnected.length; i++) {
      for (var j = 0; j < isConnected[i].length; j++) {
        if (isConnected[i][j] == 1) {
          dsu.merge(i, j);
        }
      }
    }
    
    print(dsu.parent);
    print(dsu.parent.keys
        .where((node) => dsu.root(node) == node));
    
    // Ensure that parent is the root or was an old parent just kept on the map
    // the count of parents/root is the answer of question
    return dsu.parent.keys
        .where((node) => dsu.root(node) == node)
        .length;
  }
}

main() {
  // answer = 2
  // var isConnected = [[1,1,0],[1,1,0],[0,0,1]];
  // answer = 3
  // var isConnected = [[1,0,0],[0,1,0],[0,0,1]];
  // answer = 1
  // var isConnected = [[1,0,0,1],[0,1,1,0],[0,1,1,1],[1,0,1,1]];
  // answer = 3
  var isConnected = [
    [1,1,0,0,0,0,0,1,0,0,0,0,0,0,0],
    [1,1,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,1,0,1,1,0,0,0,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,1,1,0,0,0,0],
    [0,0,0,1,0,1,0,0,0,0,1,0,0,0,0],
    [0,0,0,1,0,0,1,0,1,0,0,0,0,1,0],
    [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0],
    [0,0,0,0,0,0,1,1,1,0,0,0,0,1,0],
    [0,0,0,0,1,0,0,0,0,1,0,1,0,0,1],
    [0,0,0,0,1,1,0,0,0,0,1,1,0,0,0],
    [0,0,0,0,0,0,0,0,0,1,1,1,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0],
    [0,0,0,0,0,0,1,0,1,0,0,0,0,1,0],
    [0,0,0,0,0,0,0,0,0,1,0,0,0,0,1]
  ];

  for (var i = 0; i < isConnected.length; i++) {
    for (var j = 0; j < isConnected[i].length; j++) {
      if (isConnected[i][j] == 1) {
        print('$i $j');
      }
    }
  }

  print(Solution().findCircleNum(isConnected));
}
