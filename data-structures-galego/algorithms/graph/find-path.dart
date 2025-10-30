// TODO: convert to rank
class DSU {
  var roots = <int, int>{};
  var rank = <int, int>{};

  add(int node) {
    roots.putIfAbsent(node, () => node);
    rank.putIfAbsent(node, () => 1);
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

    // using rank to connect vertex
    if (rank[parent1]! < rank[parent2]!) {
      roots[parent1] = parent2;
    } else if (rank[parent2]! < rank[parent1]!) {
      roots[parent2] = parent1;
    } else {
      roots[parent1] = parent2;
      rank[parent1] = rank[parent1]! + 1;
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
  var n = 6, edges = [[0,1],[0,2],[3,5],[5,4],[4,3]], source = 0, destination = 5;
  // answer = true
  // List<List<int>> edges = [[]];
  // var n = 1, source = 0, destination = 0;

  print(Solution().validPath(n, edges, source, destination));
}
