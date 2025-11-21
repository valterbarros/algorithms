// map keys and replace recursion to use stack
class Solution {
  T _emptyClone<T>(T value) {
    if (value is Map) return <String, Object?>{} as T;
    if (value is List) return <Object?>[] as T;
    return value; // primitivo
  }

  T mapKeys<T>(Object original, String Function(String key) fn) {
    List<(Object, Object)> stack = [];

    final target = _emptyClone(original);
    stack.add((original, target));

    while(stack.isNotEmpty) {
      var (old, cloned) = stack.removeLast();

      // old and cloned is always equal type
      if (old is Map && cloned is Map) {
        var entries = old.entries;

        for (var MapEntry(key: key, value: value) in entries) {
          // create object and save reference add to cloned
          // and add itens to right place
          // send item that hold reference from parent to stack
          var item = _emptyClone(value);
          cloned[fn(key)] = item;
          stack.add((value, item));
        }
      } else if (old is List && cloned is List) {
        // create object and save reference add to cloned
        // and add itens to right place
        // send item that hold reference from parent to stack
        old.forEach((itemOld) {
          var item = _emptyClone(itemOld);
          cloned.add(item);
          stack.add((itemOld, item));
        });
      }

      // if it is string or int or other than object or array just continue
    }

    return target as T;
  }
}

main() {
  final Map<String, Object> obj = {
    'name': 'valter',
    'telephone': '21312312312',
    'buys': [
      { 'name_buy': 'fish', 'attributes': [{ 'weight': 2 }] },
      { 'name_buy': 'bear', 'attributes': [{ 'weight': 3 }] },
      { 'name_buy': 'dog', 'attributes': [{ 'weight': 4 }] },
    ],
    'prices': {
      'sunday': 100,
      'tuesday': 80,
      'wednesday': 99,
      'thursday': 70,
      'friday': 65,
    },
    'deep': {
      '0': {
        '1': {
          '2': {
            '3': {
              '4': {
                '5': {
                  '6': {
                    '7': {
                      '8': {
                        '9': [{'10': {}}]
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  };
  // ->
  // {
  //  _name: valter,
  //  _telephone: 21312312312,
  //  _buys: [
  //    {
  //      _name_buy: fish,
  //      _attributes: [{_weight: 2}]
  //    },
  //    {
  //      _name_buy: fish,
  //      _attributes: [{_weight: 2}]
  //    },
//      {
//        _name_buy: fish,
//        _attributes: [{_weight: 2}]}]
//      } 
  print(Solution().mapKeys(obj, (key) => '_$key'));

  // var original = [{'key': 'value'}, 'valter'];
  // print(Solution().mapKeys(original, (key) => '_$key'));
}