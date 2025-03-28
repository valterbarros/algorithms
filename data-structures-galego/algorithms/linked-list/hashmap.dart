import 'utils.dart';

class MyHashMap {
  var map = Map<int, dynamic>();

  MyHashMap() {}

  void put(int key, int value) {
    if (!this.map.containsKey(key)) {
      this.map[key] = Node(value);
      return;
    }

    if (this.map.containsKey(key) && map[key] is Node) {
      var head = map[key];

      head?.val = value;
    }
  }

  int get(int key) {
    var el = this.map[key];

    if (el == null) return -1;

    return el.val;
  }

  void remove(int key) {
    if (map.containsKey(key)) {
      map.remove(key);
    }
  }
}

main() {
  var myHashMap = MyHashMap();
  // 99
  myHashMap.get(79);
  myHashMap.put(72, 7);
  myHashMap.put(77, 1);
  myHashMap.put(10, 21);
  myHashMap.remove(26);

  myHashMap.put(94, 5);
  myHashMap.put(53, 35);
  myHashMap.put(34, 9);
  myHashMap.get(94);

  myHashMap.put(96, 8);
  myHashMap.put(73, 79);
  myHashMap.put(7, 60);
  myHashMap.put(84, 79);
  myHashMap.get(94);

  myHashMap.put(18, 13);
  myHashMap.get(18);
  myHashMap.put(69, 34);
  myHashMap.put(21, 82);
  myHashMap.put(57, 64);
  myHashMap.put(23, 60);
  myHashMap.remove(0);

  myHashMap.put(12, 97);
  myHashMap.put(56, 90);
  myHashMap.put(44, 57);
  myHashMap.put(30, 12);
  myHashMap.put(17, 10);
  myHashMap.put(42, 13);
  myHashMap.put(62, 6);
  myHashMap.get(34);
  myHashMap.put(70, 16);

  myHashMap.put(51, 39);
  myHashMap.put(22, 98);
  myHashMap.put(82, 42);
  myHashMap.put(84, 7);
  myHashMap.put(29, 32);
  myHashMap.put(96, 54);
  myHashMap.put(57, 36);
  myHashMap.put(85, 82);
  myHashMap.put(49, 33);
  myHashMap.put(22, 14);
  myHashMap.put(63, 8);
  myHashMap.put(56, 8);
  myHashMap.remove(94);

  myHashMap.put(78, 77);
  myHashMap.remove(51);
  myHashMap.put(20, 89);

  myHashMap.remove(51);
  myHashMap.put(9, 38);
  myHashMap.remove(20);
  myHashMap.put(29, 64);
  myHashMap.put(92, 69);
  myHashMap.put(72, 25);

  myHashMap.remove(73);
  myHashMap.put(6, 90);
  myHashMap.put(1, 67);
  myHashMap.put(70, 83);
  myHashMap.put(58, 49);

  myHashMap.get(79);
  myHashMap.put(73, 2);
  myHashMap.put(56, 16);
  myHashMap.put(58, 26);

  myHashMap.get(53);
  myHashMap.remove(7);
  myHashMap.put(27, 17);
  myHashMap.put(55, 40);
  myHashMap.put(55, 13);
  myHashMap.put(89, 32);
  myHashMap.remove(49);
  myHashMap.put(75, 75);
  myHashMap.put(64, 52);
  myHashMap.put(94, 74); // insert 94
  myHashMap.get(81);
  myHashMap.put(39, 82);
  myHashMap.put(47, 36);
  myHashMap.get(57);

  myHashMap.get(66);
  myHashMap.put(3, 7);
  myHashMap.put(54, 34);
  myHashMap.put(56, 46);
  myHashMap.put(58, 64);
  myHashMap.put(22, 81);
  myHashMap.put(3, 1);
  myHashMap.put(21, 96);
  myHashMap.put(6, 19);
  myHashMap.get(77);
  myHashMap.put(60, 66);
  myHashMap.put(48, 85);
  myHashMap.put(77, 16);

  myHashMap.get(78);
  myHashMap.get(23);
  myHashMap.remove(72);
  myHashMap.remove(27);
  myHashMap.put(20,80);
  myHashMap.get(30);
  print(myHashMap.get(94)); // -1
  myHashMap.put(74,85);
  myHashMap.get(49);
  myHashMap.put(79,59);
  myHashMap.put(15,15);
  myHashMap.get(26);
}
