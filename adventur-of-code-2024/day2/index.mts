import { readFile } from "node:fs/promises";

async function read(name) {
  return await readFile(`./${name}`, { encoding: 'utf8' });
}

async function adventurDay2part1() {
  const contents = await read('day2/input2.txt');
  const input = contents.split(/\n/).map((line) => {
    return line.split(/\s/).map((num) => parseInt(num));
  });

  const t = input.reduce((acc, curr) => {
    let sign;
    let isSafe = false;

    for (let index = 1; index < curr.length; index++) {
      const past = curr[index - 1];
      const current = curr[index];

      const sub = current - past;

      const diff = Math.abs(sub);

      sign ||= Math.sign(sub);

      if (!(current && past && diff > 0 && diff <= 3) || sign != Math.sign(sub)) {
        isSafe = false;

        break;
      }

      sign = Math.sign(sub);

      isSafe = true;
    }

    if(isSafe) return acc += 1;

    return acc;
  }, 0);

  console.log('total:', t);
}

// Uncomment to run part 1
// adventurDay2part1();

async function adventurDay2part2() {
  const contents = await read('day2/input2.txt');
  const input = contents.split(/\n/).map((line) => {
    return line.split(/\s/).map((num) => parseInt(num));
  });
  // const input = [
  // [7, 6, 4, 2, 1],
  // [1, 2, 7, 8, 9],
  // [9, 7, 6, 2, 1],
  // [1, 3, 2, 4, 5],
  // [8, 6, 4, 4, 1],
  // [1, 3, 6, 7, 9],
  // [44, 48, 42, 40,38, 37],
  // [44, 48, 42, 42, 40,38, 37, 50],
  // new values:
  // [19, 21, 23, 27, 26],// safe
  // [78, 80, 82, 83, 84, 85, 90, 87],// safe
  // [69, 67, 70, 72, 73, 74, 76], // safe,
  // [64, 64, 65, 66, 67],// safe
  // ];

  const t = input.reduce((acc, curr) => {
    let sign;
    let safe;

    function between(diff) {
      return diff > 0 && diff <= 3;
    }

    function cond(diff, sub, sign) {
      return between(diff) && (sign === undefined || Math.sign(sub) === sign);
    }

    function find(i = -1) {
      const excluded = i >= 0 ? curr.filter((_, index) => index != i) : curr;

      for (let index = 1; index < excluded.length; index++) {
        const current = excluded[index];
        const past = excluded[index - 1];
        const sub = past - current;
        const diff = Math.abs(sub);

        if (!cond(diff, sub, sign)) {
          if (i >= curr.length) return;

          safe = false;

          sign = undefined;

          return find(i + 1);
        }

        if (cond(diff, sub, sign)) {
          sign = Math.sign(sub);
        }
      }

      safe = true;
    }

    find();

    if(safe) return acc += 1;

    return acc;
  }, 0);

  console.log('total:', t);
}

// Uncomment to run part 2
// adventurDay2part2();