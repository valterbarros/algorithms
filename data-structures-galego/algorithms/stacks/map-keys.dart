typedef MapObject = Map<String, Object>;

// map keys and replace recursion to use stack
class Solution {
  map(MapObject original, Function(String key) fn) {
    List<(MapObject, MapObject)> stack = [];
    MapObject newObj = {}; 

    stack.add((original, newObj));

    while(stack.isNotEmpty) {
      // Values is always a MapObject
      var (value, clonedPopped) = stack.removeLast();

      var entries = value.entries;

      for (var MapEntry(key: key, value: value) in entries) {
        if (value is List) {
          // create object and save reference add to clonedPopped
          // and add itens to right place
          var curr = [];
          clonedPopped[fn(key)] = curr;
          // send item that hold reference from parent to stack
          value.forEach((itemOld) {
            MapObject item = {};
            curr.add(item);
            stack.add((itemOld, item));
          });
        } else if (value is MapObject) {
          MapObject item = {};
          // Same trick of reference here when element is a MapObject
          clonedPopped[fn(key)] = item;
          stack.add((value, item));
        } else {
          // when value is string or int
          clonedPopped[fn(key)] = value;
        }
      }
    }

    return newObj;
  }
}

main() {
  final Map<String, Object> obj = {
    'name': 'valter',
    'telephone': '21312312312',
    'buys': [
      { 'name_buy': 'fish', 'attributes': [{ 'weight': 2 }] },
      { 'name_buy': 'fish', 'attributes': [{ 'weight': 2 }] },
      { 'name_buy': 'fish', 'attributes': [{ 'weight': 2 }] },
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
  
  print(Solution().map(obj, (key) => '_$key'));
}