// https://www.hackerrank.com/challenges/value-of-friendship/problem
// WIP WIP WIP WIP
import 'dart:math';

typedef Graph = Map<int, Set<int>>;

// Disjoint Set Union
class DSU {
  var parent = <int, int>{};
  var sz = <int, int>{};
  // add if necessary to parent set and size set
  add(int node) {
    parent.putIfAbsent(node, () => node);
    sz.putIfAbsent(node, () => 1);
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
  int union(int node1, int node2) {
    add(node1);
    add(node2);
    
    // parent node 1
    var pnode1 = find(node1);
    // parent node 2
    var pnode2 = find(node2);
    
    // same parent
    if (pnode1 == pnode2) return sz[pnode1]! * (sz[pnode1]! - 1);
  
    // Check which parent will receive another
    // inc ANTES de unir
    var inc = (sz[pnode1]! - 1) + (sz[pnode2]! - 1);

    // inverse parent
    if (sz[pnode1]! < sz[pnode2]!) {
      var tmp = pnode1;
      pnode1 = pnode2;
      pnode2 = tmp;
    }

    parent[pnode2] = pnode1;
    sz[pnode1] = sz[pnode1]! + sz[pnode2]!;

    // print(increment);
    return inc;
  }
  int size(int node) => sz[find(node)]!;
}

class Solution {
  void count(int n, List<String> pairs) {
    final dsu = DSU();

    // adiciona todos os nós
    for (int i = 1; i <= n; i++) {
      dsu.add(i);
    }

    // processa todas as amizades (somente para garantir que todos estão no DSU)
    for (var pair in pairs) {
      var split = pair.split(RegExp(r'\s+'));
      if (split.length < 2) continue;
      int a = int.parse(split[0]);
      int b = int.parse(split[1]);
      dsu.add(a);
      dsu.add(b);
    }

    // pega todos os componentes finais (raiz => tamanho)
    List<int> comps = [];
    Set<int> seen = {};
    for (var node in dsu.parent.keys) {
      int root = dsu.find(node);
      if (!seen.contains(root)) {
        comps.add(dsu.sz[root]!);
        seen.add(root);
      }
    }

    // agora simula unir sempre os maiores grupos
    comps.sort((b, a) => a - b); // decrescente

    int total = 0;

    while (comps.length > 1) {
      // pega os dois maiores grupos
      int a = comps.removeAt(0);
      int b = comps.removeAt(0);

      total += (a - 1) + (b - 1);

      // novo grupo resultante
      int newSize = a + b;
      // insere de volta mantendo ordem decrescente
      int idx = comps.indexWhere((x) => x <= newSize);
      if (idx == -1) {
        comps.add(newSize);
      } else {
        comps.insert(idx, newSize);
      }
    }

    print(total);
  }
}

main() {
//   var input = """
//   1
// 5 4
// 1 2
// 2 4
// 3 4
// 3 2""";

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

// answer: 205348
var input = """
1
100 335
1 15
1 35
1 45
1 70
2 10
2 27
2 44
2 66
2 87
3 22
3 25
3 36
3 42
3 43
3 46
3 67
3 91
4 19
4 68
4 77
5 12
5 17
5 30
5 31
5 50
5 58
5 59
5 65
5 69
5 76
5 80
5 82
5 86
5 89
5 97
5 100
6 7
6 23
6 32
6 48
6 60
6 75
6 78
7 23
7 32
7 48
7 60
7 75
7 78
8 14
8 20
8 29
8 38
8 88
8 93
8 94
9 16
10 27
10 44
10 66
10 87
11 13
11 33
11 39
11 79
11 98
12 17
12 30
12 31
12 50
12 58
12 59
12 65
12 69
12 76
12 80
12 82
12 86
12 89
12 97
12 100
13 33
13 39
13 79
13 98
14 20
14 29
14 38
14 88
14 93
14 94
15 35
15 45
15 70
17 30
17 31
17 50
17 58
17 59
17 65
17 69
17 76
17 80
17 82
17 86
17 89
17 97
17 100
18 53
19 68
19 77
20 29
20 38
20 88
20 93
20 94
21 92
22 25
22 36
22 42
22 43
22 46
22 67
22 91
23 32
23 48
23 60
23 75
23 78
24 84
25 36
25 42
25 43
25 46
25 67
25 91
26 57
27 44
27 66
27 87
28 47
28 64
28 72
28 73
29 38
29 88
29 93
29 94
30 31
30 50
30 58
30 59
30 65
30 69
30 76
30 80
30 82
30 86
30 89
30 97
30 100
31 50
31 58
31 59
31 65
31 69
31 76
31 80
31 82
31 86
31 89
31 97
31 100
32 48
32 60
32 75
32 78
33 39
33 79
33 98
34 90
35 45
35 70
36 42
36 43
36 46
36 67
36 91
37 52
37 83
37 95
38 88
38 93
38 94
39 79
39 98
40 51
40 61
40 62
40 71
40 74
40 81
40 85
40 96
41 49
42 43
42 46
42 67
42 91
43 46
43 67
43 91
44 66
44 87
45 70
46 67
46 91
47 64
47 72
47 73
48 60
48 75
48 78
50 58
50 59
50 65
50 69
50 76
50 80
50 82
50 86
50 89
50 97
50 100
51 61
51 62
51 71
51 74
51 81
51 85
51 96
52 83
52 95
54 99
55 63
58 59
58 65
58 69
58 76
58 80
58 82
58 86
58 89
58 97
58 100
59 65
59 69
59 76
59 80
59 82
59 86
59 89
59 97
59 100
60 75
60 78
61 62
61 71
61 74
61 81
61 85
61 96
62 71
62 74
62 81
62 85
62 96
64 72
64 73
65 69
65 76
65 80
65 82
65 86
65 89
65 97
65 100
66 87
67 91
68 77
69 76
69 80
69 82
69 86
69 89
69 97
69 100
71 74
71 81
71 85
71 96
72 73
74 81
74 85
74 96
75 78
76 80
76 82
76 86
76 89
76 97
76 100
79 98
80 82
80 86
80 89
80 97
80 100
81 85
81 96
82 86
82 89
82 97
82 100
83 95
85 96
86 89
86 97
86 100
88 93
88 94
89 97
89 100
93 94
97 100
93 206
1 75
2 8
2 11
2 23
2 29
2 33
2 37
2 42
2 56
2 72
3 27
4 49
5 6
5 13
5 17
5 21
5 32
5 51
5 65
6 13
6 17
6 21
6 32
6 51
6 65
7 18
7 34
7 71
8 11
8 23
8 29
8 33
8 37
8 42
8 56""";
  
  var [query, studentDirect, ...rest] = input.split('\n');

  Solution().count(355, rest);
}
