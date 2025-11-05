// https://leetcode.com/problems/evaluate-division/description/

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

  // Encontra a raiz e comprime o caminho, ATUALIZANDO OS PESOS no processo
  String root(String node) {
    if (parent[node] != node) {
      var originalParent = parent[node]!;

      // 1. Encontra a raiz do originalParent (e comprime o caminho dele)
      var newParent = root(originalParent);

      // 2. O 'weights[originalParent]!' AGORA contém o peso ATUALIZADO:
      //    value[originalParent] / value[newParent]

      // 3. ATUALIZA o peso de 'node':
      //    novo weights[node] = (value[node] / value[originalParent]) * (value[originalParent] / value[newParent])
      weights[node] = weights[node]! * weights[originalParent]!;

      // 4. Reanexa 'node' diretamente à raiz
      parent[node] = newParent;
    }
    return parent[node]!;
  }

  // Função auxiliar para calcular o peso acumulado até a raiz.
  // Na verdade, chamar 'root(node)' já garante que 'weights[node]' contenha
  // a razão de 'node' para a raiz, mas esta é a lógica correta:
  double getRatioToRoot(String node) {
    root(node); // Garante que 'weights[node]' está atualizado para a razão em relação à raiz
    return weights[node]!;
  }

  add(String node) {
    parent.putIfAbsent(node, () => node);
    size.putIfAbsent(node, () => 1);
    weights.putIfAbsent(node, () => 1);
  }

  merge(String node1, String node2, double ratio) {
    add(node1);
    add(node2);
    
    var weight1 = getRatioToRoot(node1);
    var weight2 = getRatioToRoot(node2);

    var parent1 = root(node1);
    var parent2 = root(node2);

    if (parent1 == parent2) return false;
    
    swap(String a, String b) {
      parent[a] = b;
      size[b] = size[b]! + size[a]!;
    }

    // Une os componentes de node1 e node2, mantendo a proporção node1 / node2 = ratio.
    //
    // Cada weight[x] representa a razão entre o valor do nó e o valor do seu pai (value[x] / value[parent[x]]).
    // 
    // Se o root menor for anexado ao root maior, ajustamos o peso de forma que a relação
    // entre node1 e node2 continue válida:
    //
    //   - Quando rootY é anexado a rootX:
    //       weights[rootY] = weight1 * ratio / weight2
    //
    //   - Quando rootX é anexado a rootY:
    //       weights[rootX] = weight2 / (weight1 * ratio)
    //
    // Assim garantimos que, mesmo após a união, getWeight(node) continua retornando
    // o peso acumulado correto em relação à raiz do seu componente.
    if (size[parent1]! < size[parent2]!) {
      weights[parent1] = weight2 * ratio / weight1;
      swap(parent1, parent2);
    } else {
      weights[parent2] = weight1 / (weight2 * ratio);
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
    
    List<double> results = [];
    for (var query in queries) {
      var a = query[0];
      var b = query[1];

      // Se qualquer um dos nós não existe, a resposta é -1.0
      if (!dsu.parent.containsKey(a) || !dsu.parent.containsKey(b)) {
        results.add(-1.0);
        continue;
      }

      var rootA = dsu.root(a);
      var rootB = dsu.root(b);

      // Se as raízes são diferentes, eles não estão conectados, a resposta é -1.0
      if (rootA != rootB) {
        results.add(-1.0);
        continue;
      }

      var ratioA = dsu.getRatioToRoot(a);
      var ratioB = dsu.getRatioToRoot(b);

      results.add(ratioA / ratioB);
    }

    return results;
  }
}

main() {
  // var equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]];
  // var equations = [["a","b"],["b","c"],["bc","cd"]], values = [1.5,2.5,5.0], queries = [["a","c"],["c","b"],["bc","cd"],["cd","bc"]];
  var equations = [["a","b"]], values = [0.5], queries = [["a","b"],["b","a"],["a","c"],["x","y"]];
  Solution().calcEquation(equations, values, queries);
}
