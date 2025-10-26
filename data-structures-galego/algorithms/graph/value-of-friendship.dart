// https://www.hackerrank.com/challenges/value-of-friendship/problem
// WIP WIP WIP WIP
import 'dart:math';

typedef Graph = Map<int, Set<int>>;

// Disjoint Set Union
class DSU {
  var parent = <int, int>{};
  var size = <int, int>{};
  // add if necessary to parent set and size set
  add(int node) {
    parent.putIfAbsent(node, () => node);
    size.putIfAbsent(node, () => 1);
  }
  
  // find recursive parent until edge
  find(int node) {
    // not myself
    if (parent[node] != node) {
      return find(parent[node]!);
    }
    
    return node;
  }

  // union two sets
  union(int node1, int node2) {
    add(node1);
    add(node2);
    
    // parent node 1
    var pnode1 = find(node1);
    // parent node 2
    var pnode2 = find(node2);
    
    // same parent
    if (pnode1 == pnode2) return 0;

    // cálculo do incremento antes de unir
    var increment = size[pnode1]! * size[pnode2]!;
  
    // Check which parent will receive another

    // inverse parent
    if (size[pnode1]! < size[pnode2]!) {
      var tmp = pnode1;
      pnode1 = pnode2;
      pnode2 = tmp;
    }

    parent[pnode2] = pnode1;
    size[pnode1] = size[pnode1]! + size[pnode2]!;

    // print(parent);
    // print(size);
    print(increment);
    return increment;
  }
}

class Solution {
  count(List<String> pairs) {
    // instantiate dsu
    var dsu = DSU();
    var maxSize = 0;
    var totalValue = 0;

    for (var pair in pairs) {
      var split = pair.split(' ');
      var a = int.parse(split[0]);
      var b = int.parse(split[1]);

      totalValue += int.parse(dsu.union(a, b).toString());
    }
    
    print(totalValue);
  }
}

main() {
  var input = """
  1
5 4
1 2
2 4
3 4
3 2""";

//   final input = """
//   1
// 4 5
// 1 2
// 3 2
// 4 2
// 4 3
// 6 7
// 7 8
// 8 6""";

// var input = """
//   1
// 5 4
// 1 2
// 2 3
// 3 4
// 4 5
// 6 7
// 7 8
// 8 6
// 9 10
// 10 11
// 11 9
// 12 13
// 13 14
// 15 16
// 16 17
// 17 18
// 18 19
// 20 21
// 21 22
// 22 23
// 23 20""";
  
  var [q, s, ...rest] = input.split('\n');

  Solution().count(rest);
}
