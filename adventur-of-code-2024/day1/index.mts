import "core-js/actual/index.js";
import { read } from '../utils.ts';

async function adventurDay1part1() {
    const contents = await read('./day1/input1.txt');

    const lists = contents.split(/\s/).reduce((acc, curr, index) => {
        if (!/\d/.test(curr)) return acc;

        if ((index % 2) == 0) acc.left.push(parseInt(curr));
        else acc.right.push(parseInt(curr));

        return acc;
    }, { left: [], right: [] });

    lists.left.sort((a, b) => a - b);
    lists.right.sort((a, b) => a - b);

    let total = 0;

    for (let index = 0; index < lists.left.length; index++) {
        const left = lists.left[index];
        const right = lists.right[index];

        total += Math.abs(left - right);
    }

    // anwser: 2344935
    console.log(total);
}

// Uncomment to run part 1
// adventurDay1part1();

async function adventurDay1part2() {
    const contents = await read('./day1/input1.txt');

    function recurseIncludes(left, lists, items) {
        const index = lists.right.indexOf(left);

        if (index < 0) return;

        if (index >= 0) {
            items[left] ||= 0;

            items[left] = ++items[left];

            lists.right[index] = undefined;
        };

        return recurseIncludes(left, lists, items);
    }

    const lists = contents.split(/\s/).reduce((acc, curr, index) => {
        if (!/\d/.test(curr)) return acc;

        if ((index % 2) == 0) acc.left.push(parseInt(curr));
        else acc.right.push(parseInt(curr));

        return acc;
    }, { left: [], right: [] });

    const items = [];

    // Another way to solve that
    // const groupMap = Object.groupBy(lists.right, (num, _index) => lists.left.includes(num) ? num : -1);

    // const total2 = Object.entries(groupMap).reduce((acc, [number, frequencies]) => {
    //   if (number < 0) return acc;

    //   return acc += number * frequencies.length
    // }, 0);

    for (let index = 0; index < lists.left.length; index++) {
        recurseIncludes(lists.left[index], lists, items);
    }

    const total = items.reduce((acc, curr, index) => {
        if (!curr) return acc;

        return acc + (index * curr);
    }, 0);

    // answer: 27647262
    console.log(total);
}

// Uncomment to run part 2
// adventurDay1part2();
