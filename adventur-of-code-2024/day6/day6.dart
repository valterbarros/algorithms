import 'dart:io';

enum Dir {
  up(line: -1, col: 0),
  right(line: 0, col: 1),
  down(line: 1, col: 0),
  left(line: 0, col: -1);

  const Dir({
    required this.line,
    required this.col,
  });

  final int line;
  final int col;
}

typedef ListPath = List<List<String>>;

var dirs = [
  Dir.up,
  Dir.right,
  Dir.down,
  Dir.left,
];

getDir(Dir current) {
  return (dirs.indexOf(current) + 1) % dirs.length;
}

int getCycleDir(int inner, line, col, ListPath list) {
  int internalIndex = inner;

  for (int i = inner; i < dirs.length + inner; i++) {
    int futureL = line + dirs[internalIndex].line;
    int futureC = col + dirs[internalIndex].col;

    if (futureC >= 0 && futureL >= 0) {
      if (list.elementAtOrNull(futureL)?.elementAtOrNull(futureC) == '#') {
        // always return a value inside dirs.length
        internalIndex = (internalIndex + 1) % dirs.length;
      } else {
        break;
      }
    }
  }

  return internalIndex;
}

(int, Set<({int first, int second})>, bool infinity) walk(
    ListPath list, int lineS, int colS, log) {
  var colI = 1;
  var lineI = 0;
  Set<({int first, int second})> visited = new Set();
  var inner = 0;
  var count = 0;
  var line = lineS;
  var col = colS;
  var rep = 0;

  while (line < list.length && col < list[line].length) {
    // print('line: $line col: $col direction: ${dirs[inner]}');

    // control when the path is out of bounds
    if (line <= 0 && dirs[inner] == Dir.up ||
        col <= 0 && dirs[inner] == Dir.left) break;

    var el = list[line][col];

    switch (el) {
      case '^':
      case '.':
        var isVisited = visited.contains((first: line, second: col));

        inner = getCycleDir(inner, line, col, list);

        if (!isVisited) count++;

        visited.add((first: line, second: col));
      case '#':
        inner++;
      default:
        throw FormatException('Invalid');
    }

    if (inner > dirs.length - 1) inner = 0;

    lineI = dirs[inner].line;
    colI = dirs[inner].col;

    line += lineI;
    col += colI;

    // detect inifity loop
    if (rep > 6000) {
      // print(rep);
      break;
    }

    rep++;
  }

  // print(rep);

  return (count, visited, rep > 6000);
}

void main(List<String> args) async {
  var path = '''
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...''';
  var file = File('day6/input.txt');
  path = await file.readAsString();

  ListPath list = path.split('\n').map((line) => line.split('')).toList();

  var lineS = list.indexWhere((line) => line.any('^'.contains));
  var colS = list[lineS].indexWhere((char) => char == '^');

  // uncomment to run part 1
  // // part 1
  // var (count, visited, _) = walk(list, lineS, colS, false);

  // print(
  //     visited.where((v) => visited.where((vi) => vi == v).length > 1).toList());

  // // total: 4711
  // print(count);

  // uncomment to run part 2
  // part 2

  var (count, visited, _) = walk(list, lineS, colS, false);

  var sum = 0;

  for (var i = 1; i < visited.length; i++) {
    var newList = list.map((item) => [...item]).toList();

    var line = visited.elementAt(i).first;
    var col = visited.elementAt(i).second;

    // print('Obstruct: line: $line col: $col index: $i');

    newList[line][col] = '#';

    var (_, _, inifity) = walk(newList, lineS, colS, true);

    if (inifity) sum++;
  }

  // 1628 too high
  // 1562 value
  print(sum);
}
