import { readFile } from "node:fs/promises";

async function read(name: string): Promise<string> {
  return await readFile(`./${name}`, { encoding: 'utf8' });
}

async function adventurDay5part1() {
  let contents = await read('./day5/input5.txt');
  // let contents = await read('input5-custom.txt');

  const input = contents.split(/\s+/).reduce<{ order: [number, number][], updates: [number, number][] }>((acc, item) => {
    if (item.includes('|')) {
      acc.order.push(item.split('|').map(Number) as [number, number]);
      return acc;
    } else {
      acc.updates.push(item.split(',').map(Number) as [number, number]);
      return acc;
    }
  }, { order: [], updates: [] });

  const { order, updates } = input;

  let sum = 0;
  let val = 0;

  for (let i = 0; i < updates.length; i++) {
    let canAdd = true;

    for (let j = 0; j < updates.length; j++) {
      const current = updates[i][j];
      const future = updates[i][j + 1];

      if (!current || !future) continue;

      const o = order.find(([item1, item2]) => {
        return item1 === current && item2 === future
      });

      if (!o) canAdd = false;
    }

    if (canAdd) sum += updates[i][Math.floor(updates[i].length / 2)];
    if (canAdd) val++;
  }

  console.log(val++);

  // 5991
  console.log('sum: ', sum);
}

// adventurDay5part1();

// Too much: 11500
// answer: 4151

async function adventurDay5part2() {
  let contents = `47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47`;
  // input:       91,35,79,15,71,46,59,19,75,93,45,67,76,77,85,53,97,36,17,57,24,84,13
  // Right order: 13,53,91,59,75,67,84,15,77,79,57,46,24,36,71,19,45,85,97,93,76,17,35
  contents = await read('./day5/input5.txt');
  // contents = await read('input5-custom.txt');

  const input = contents.split(/\s+/).reduce<{ orders: [number, number][], updates: Array<number>[] }>((acc, item) => {
    if (item.includes('|')) {
      acc.orders.push(item.split('|').map(Number) as [number, number]);
      return acc;
    } else {
      acc.updates.push(item.split(',').map(Number) as Array<number>);
      return acc;
    }
  }, { orders: [], updates: [] });

  let { orders, updates } = input;

  let sum = 0;

  function isValid(update: Array<number>) {
    for (let j = 0; j < update.length; j++) {
      const current = update[j];
      const future = update[j + 1];

      if (!current || !future) continue;

      const natural = orders.some(([first, second]) => first === current && second === future);

      if (!natural) return false;
    }

    return true;
  }

  function checkAndSwap(update: Array<number>) {
    let i = 0;

    while (i < update.length - 1) {
      const current = update[i];
      const future = update[i + 1];

      const reverse = orders.some(([first, second]) => first === future && second === current);

      if (reverse) {
        // swap
        update[i] = future;
        update[i + 1] = current;

        i = 0;
      } else {
        i++;
      }
    }
  }

  for (let i = 0; i < updates.length; i++) {
    const update = updates[i];

    let invalid = !isValid(update);

    if (!!invalid) {      
      checkAndSwap(update);

      const orig = update.slice().join('|');
      console.log('', orig);

      let valid = isValid(update);

      if (valid) {
        sum += update[Math.floor(update.length / 2)];
      }
    }
  }

  // 102 valid
  // 98 invalid
  // 98 fixed
  // 200 total
  // 5479 sum

  console.log('sum: ', sum);
}

adventurDay5part2();
