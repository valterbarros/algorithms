class DSU {
  var roots = <int, int>{};
  var size = <int, int>{};

  add(int node) {
    roots.putIfAbsent(node, () => node);
    size.putIfAbsent(node, () => 1);
  }

  root(int node) {
    // should ensure that add is called before that fn
    if (roots[node] == null) return node;

    if (roots[node] == node) return node;
    return roots[node] = root(roots[node]!);
  }

  merge(int node1, int node2) {
    add(node1);
    add(node2);

    var parent1 = root(node1);
    var parent2 = root(node2);

    if (parent1 == parent2) return;

    // swap parents
    swap(int a, int b) {
      roots[a] = b;
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
  bool validPath(int n, List<List<int?>> edges, int source, int destination) {
    if (source == destination) return true;

    var dsu = DSU();

    for (var i = 0; i < edges.length; i++) {
      if (edges[i].elementAtOrNull(0) == null || edges[i].elementAtOrNull(1) == null) continue;
      dsu.merge(edges[i][0]!, edges[i][1]!);
    }

    return dsu.root(source) == dsu.root(destination);
  }
}

main() {
  // answer = true
  // var n = 3, edges = [[0,1],[1,2],[2,0]], source = 0, destination = 2;
  // answer = false
  // var n = 6, edges = [[0,1],[0,2],[3,5],[5,4],[4,3]], source = 0, destination = 5;
  List<List<int>> edges = [[]];
  var n = 1, source = 0, destination = 0;

  print(Solution().validPath(n, edges, source, destination));
}
