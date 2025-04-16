// https://leetcode.com/problems/add-binary/description/?envType=problem-list-v2&envId=bit-manipulation

// Formula to convert binary to decimal
// sum += sum * 2 + bitVal

// dec = dec << 1 | na | nb;

// dec += pow(2, i).toInt() * (nb + na);

class Solution {
  // binary sum rules
  // 1 + 1 = 10
  // 1 + 1 + 1 = 11
  // 1 + 0 = 1
  // 0 + 0 = 0
  List<int> getPattern(int bits) {
    // if all is one that mean it is 1 and has rest 1 too
    if (bits == 3) return [1,1];
    // if just one bit is 1 set val to 1 
    if (bits == 1) return [1,0];
    // if two bit are 1 in that case current value is duplicated
    if (bits == 2) return [0,1];

    return [0,0];
  }

  List<String> addPad(String a, String b) {
    return [
      a.padLeft(b.length, '0'),
      b.padLeft(a.length, '0'),
    ];
  }

  String addBinary(String a, String b) {
    var [pa, pb] = addPad(a,b);
    var charsA = pa.split('').toList();
    var charsB = pb.split('').toList();
    // TODO: try to replace for StringBuffer
    var bits = [];
    var rest = 0;

    for(var i = charsA.length - 1; i >= 0; i--) {
      var na = int.parse(charsA.elementAtOrNull(i) ?? '0');
      var nb = int.parse(charsB.elementAtOrNull(i) ?? '0');

      var [val, r] = getPattern(na + nb + rest);

      bits.add(val);
      rest = r;
    }

    bits.add(rest);

    // I think zero on last is not important
    if (bits.lastOrNull == 0) bits.removeLast();
    
    print(bits.reversed.join(''));

    return bits.reversed.join('');
  }
}

main() {
  // Solution().addBinary('111', '111'); // -> 1110
  // Solution().addBinary('101', '111'); // -> 1100
  // Solution().addBinary('000111', '111001'); // -> 1000000
  
  // Solution().addBinary('11', '1'); // -> 4 -> 100
  var a = "10100000100100110110010000010101111011011001101110111111111101000000101111001110001111100001101";
  var b = "110101001011101110001111100110001010100001101011101010000011011011001011101111001100000011011110011";
  Solution().addBinary(a, b);

  // print(Solution().getPattern([1,1,1]));
  // print(Solution().getPattern([1,0,1]));
}
