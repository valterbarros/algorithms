// https://leetcode.com/problems/contains-duplicate-ii/description/
import 'dart:math';

findPairsQuadratic(List<int> nums, int k) {
  List<List<int>> result = [];

  // Encontrando todos os pares
  for (int i = 0; i < nums.length; i++) {
    for (int j = i + 1; j < nums.length; j++) {
      // Verifica se os valores são iguais e se a soma dos índices é <= k
      if (nums[i] == nums[j] && (i + j) <= k) {
        result.add([i, j]);
      }
    }
  }

  return result;
}

findPairs(List<int> nums, int k) {
  var d = Map<int, List<int>>();
  List<List<int>> result = [];

  for(var i = 0; i < nums.length; i++) {
    var item = nums[i];
    
    if (d.containsKey(item)) {
      for (var j in d[item]!) {
        if ((i-j).abs() <= k) result.add([j, i]);
      }
    }

    d.putIfAbsent(item, () => []).add(i);
  }

  return result;
}

void benchmark() {
  int n = 100000; // Tamanho do array
  int k = 50000; // Limite da soma dos índices
  Random rand = Random();

  // Gerando um array grande com valores repetidos para garantir pares
  List<int> nums = List.generate(n, (_) => rand.nextInt(500) + 1);

  Stopwatch stopwatch = Stopwatch()..start();
  List<List<int>> pairs = findPairs(nums, k);
  // List<List<int>> pairs = findPairsQuadratic(nums, k);
  stopwatch.stop();

  print('Tempo de execução: ${stopwatch.elapsedMilliseconds} ms');
  print('Número de pares encontrados: ${pairs.length}');
}

void main(List<String> args) {
  // var value = findPairsQuadratic([1,0,1,1], 1);
  // var value = findPairsQuadratic([1,2,3,1,2,3], 2);
  // var value = findPairsQuadratic([1,2,3,1], 3);
  // print(value);

  // List<int> nums = [1, 2, 3, 1, 2, 3, 1, 2, 3];
  // int k = 10;

  // List<List<int>> pairs = findPairsQuadratic(nums, k);
  // List<List<int>> pairs = findPairs(nums, k);

  benchmark();
}
