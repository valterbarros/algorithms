/** Explicações 
 * Quando perguntam
 * a / c = ?
 * Quer saber se eu tiver um a quantos c isso vale
 * se tiver
 * a / b = 2
 * b / c = 3
 * então
 * a / c = 2 * 3 = 6
 * porque pra ir de a até c você passa por b.
 * Cada variavel a, b, c é um nó e a equeção é uma ponte
 * a —(2)→ b
 * b —(3)→ c
*/
// WIP WIP

class DSU {
  var size = <String, int>{};
  var parent = <String, String>{};
  var weights = <String, double>{};

  root(String node) {
    // is not root
    if (parent[node] != node) {
      // path compression ps: it is not required but is good for performance
      return parent[node] = root(parent[node]!);
    } else {
      return node;
    }
  }
  
  getWeight(String node) {
    
  }

  add(String node) {
    parent.putIfAbsent(node, () => node);
    size.putIfAbsent(node, () => 1);
    weights.putIfAbsent(node, () => 1);
  }

  merge(String node1, String node2, double weight) {
    add(node1);
    add(node2);

    // Atribuir pesos
    // weights[node2] = weight;
    // parent[node2] = node1;
    
    var weight1 = getWeight(node1);
    var weight2 = getWeight(node2);

    var parent1 = root(node1);
    var parent2 = root(node2);

    if (parent1 == parent2) return false;
    
    swap(String a, String b) {
      parent[a] = b;
      size[b] = size[b]! + size[a]!;
    }

    if (size[parent1]! < size[parent2]!) {
      swap(parent1, parent2);
    } else {
      swap(parent2, parent1);
    }

    return true;
  }
}

class Solution {
  List<double> calcEquation(List<List<String>> equations, List<double> values, List<List<String>> queries) {
    var dsu = DSU();

    for (var i = 0; i < equations.length; i++) {
      var pair = equations[i];

      dsu.merge(pair[0], pair[1], values[i]);
    }

    return [0.1];
  }
}

main() {
  var equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]];
  Solution().calcEquation(equations, values, queries);  
}
