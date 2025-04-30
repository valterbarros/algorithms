typedef Peg = List<int>;

Peg peg1 = [];
Peg peg2 = [];
Peg peg3 = [];

var pegs = [peg1, peg2, peg3];

Peg peg(int idx) => pegs[idx];

// returns the auxiliary peg
int getAuxPeg(int fromPegIdx, int toPegIdx) {
  return [0, 1, 2].firstWhere((i) => i != fromPegIdx && i != toPegIdx);
}

moveDisk(int fromPegIdx, int toPegIdx) {
  var fromPeg = peg(fromPegIdx);
  var toPeg = peg(toPegIdx);
  var fpLast = fromPeg.lastOrNull;
  var tpLast = toPeg.lastOrNull;
  // Not allowed movement
  // check if my last fromPeg item is less than toPeg last item
  if (fpLast != null && tpLast != null && (fpLast > tpLast)) {
    return;
  }

  if (fromPeg.length > 1) {
    toPeg.add(fromPeg.last);
    fromPeg.removeLast();
  } else if (fromPeg.singleOrNull != null) {
    toPeg.add(fromPeg.single);
    fromPeg.removeAt(0);
  }
}

// Three steps to move disks
// https://pt.khanacademy.org/computing/computer-science/algorithms/towers-of-hanoi/a/towers-of-hanoi
// Basically it is saying I want to move n disks from to another peg
hanoi(int numDisks, int fromPegIdx, int toPegIdx) {
  if (numDisks == 0) {
    // Base case of recursion
    return 0;
  }

  var auxPegIdx = getAuxPeg(fromPegIdx, toPegIdx);

  // Call recursive with -1 disks 3, 2, 1...
  // Move disks to aux peg
  hanoi(numDisks - 1, fromPegIdx, auxPegIdx);

  // Move the disk to destiny peg
  moveDisk(fromPegIdx, toPegIdx);

  // Call recursive with -1 disks 3, 2, 1...
  // Move disks to destiny peg
  hanoi(numDisks - 1, auxPegIdx, toPegIdx);
}

void main() {
  var numDisks = 3;
  // fill
  for(var i = numDisks; i > 0; i--) peg1.add(i);
  
  // Movements to move from peg 1 to peg 3
  // 1 - 2
  // 1 - 3
  // 2 - 3
  // 1 - 2
  // 3 - 1
  // 3 - 2
  // 1 - 2

  print('before');
  print('peg0: $peg1');
  print('peg1: $peg2');
  print('peg2: $peg3');

  hanoi(numDisks, 0, 1);
  
  print('after');

  print('peg0: $peg1');
  print('peg1: $peg2');
  print('peg2: $peg3');
}
