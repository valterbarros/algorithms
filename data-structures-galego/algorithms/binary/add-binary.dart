// https://leetcode.com/problems/add-binary/description/?envType=problem-list-v2&envId=bit-manipulation

// Formula to convert binary to decimal
// sum += sum * 2 + bitVal

// dec = dec << 1 | na | nb;

// dec += pow(2, i).toInt() * (nb + na);

class Solution {
  // sum binaries font: https://byjus.com/maths/binary-addition/
  // binary sum rules
  // 1 + 1 = 10
  // 1 + 1 + 1 = 11
  // 1 + 0 = 1
  // 0 + 0 = 0
  List<int> getVal(int bits) {
    // if all is one that mean it is 1 and has rest 1 too
    if (bits == 3) return [1,1];
    // if just one bit is 1 set val to 1 
    if (bits == 1) return [1,0];
    // if two bit are 1 in that case current value is duplicated
    if (bits == 2) return [0,1];

    return [0,0];
  }

  String addBinary(String a, String b) {
    var bits = StringBuffer();
    var rest = 0;

    var decrA = a.length - 1;
    var decrB = b.length - 1;

    // Check rest on that condition to on the last while execution
    // If there is rest value add that to bits
    while(decrA >= 0 || decrB >= 0 || rest != 0) {
      // the code unit of the '0' is 48 and for '1' is 49
      // the subtraction would returns 0 or 1
      // This is faster than split string into array and acess elements by index
      // 48 - 48 = 0
      // 49 - 48 = 1
      int na = decrA >= 0 ? a.codeUnitAt(decrA) - 48 : 0;
      int nb = decrB >= 0 ? b.codeUnitAt(decrB) - 48 : 0;

      var [val, r] = getVal(na + nb + rest);

      bits.write(val);
      // return rest for next execution
      rest = r;

      decrA--;
      decrB--;
    }
    
    print(bits.toString().split('').reversed.join(''));

    return bits.toString().split('').reversed.join('');
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
