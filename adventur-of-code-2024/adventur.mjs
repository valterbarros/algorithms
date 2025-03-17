import "core-js/actual/index.js";
import { readFile } from "node:fs/promises";

async function read(name) {
  return await readFile(`./${name}`, { encoding: 'utf8' });
}

async function adventurDay1part1() {
  const contents = await readFile('./input1.txt', { encoding: 'utf8' });
  
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

// adventurDay1part1();

async function adventurDay1part2() {
  const contents = await readFile('./input1.txt', { encoding: 'utf8' });

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

// adventurDay1part2();

async function adventurDay2part1() {
  const contents = await read('input2.txt');
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

// adventurDay2part1();

async function adventurDay2part2() {
  const contents = await read('input2.txt');
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

// adventurDay2part2();

async function adventurDay3Part1 () {
  let sum = 0;

  const contents = await read('input3.txt');
  const re = /mul\([\d{1,3}]+\)/gi;

  const res = contents.matchAll(re);

  for (let match of res) {
    sum += eval(match[0].replaceAll(/(,)|[^\d]+/gi, '$1').replace(',', '*'));
  }

  console.log('total:', sum);
}

// adventurDay3Part1();

async function adventurDay3Part2 () {
  const contents = await read('input4.txt');
  // const contents = "+mul(900,640)%*{why()?from()mul(750,181)]{%;]mul(771,902)<>$]how());,mul(646,610)why()mul(644,958)[/{<*)mul(490,14)/where()why()::where()${+?mul(524,278)when()mul(609,995){*(,how()(where(18,555)-who()mul(456,815)do()[$:~(}@mul(987,108)<select()who(),>}@>when()<mul(561,928)}$how(984,377)+:what(){ %]mul(242,236)mul(401,270)mul(144@who(){from()-[mul(850,190)& #where()@^/'>mul(511,942)select()$(/<mul(404,904)<^when()'how()[when()$}}mul(891,878)mul(381,288)<+[[<from()who()-mul(282,737),who(){what()-!>mul(60,709)(mul(291?}where(670,848)who()@from()',mul(890,902)[){,&%}%mul(539,945)%$~what()do()#what()how(931,606)!,',what()mul(175,630)]@-&when(98,693)$when()when()mul(850,996~;:@who()<^}/'mul(103,549)how(482,381);when()mul(408,760)where()!mul(796,714)&^]}mul(557,352)how()+{+]select()mul(135,816)?##@<mul(812,707)(^^what()%&$]mul(305,996) ?what()[mul(19,420)~{;mul(451<who()mul(678,132)!:]select();'select(414,538)-what()@mul(775,858)+'{ :[mul(151,737)*mul(305,447)?+<mul(773,348)*% ~}!>+do()@;from()%(mul(571,910)don't()?)%^+%mul(738,321)who()>&-?what()don't(){[?why()who()mul(558,221)}${!'(+*who()do())how();#<>?<mul(824where()mul(351,367)#/ :how()mul(212,77)}<]]mul(769,809)#when(303,117)select()(<':!%(mul(126,148)]why()%[^why()where()]mul(288,573)~@]>%'why()>)mul(850,160);~[select() why()why()~;mul(276,634) +{mul(615,507):when()++#:mul(817,325??(mul(748,223)^<!&^] &/mul(755,745)&:!&who()]-#;,mul(674,378)why()&}-how(667,459)( mul(688,272)'<who()~do()mul(608,206)~$^:'*)?*mul(47,323)mul(612,590)({how()mul(966,673)'(from()where()who()mul(802,18)mul(8,840))how()'^#[}(mul(588,513)(<[;when())) how()don't())who(97,403)mul(642,367)where()when()who(),why()from()'mul(333,247)+[where()-]+*mul(7,926)^!where()%#where(109,801)mul(247,920)+}-&]select()select(878,420)#mul'{::what()how() mul(281,809)~/,from()/+^how()@>mul(67,325)mul(10,782)@";
  // const contents = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

  const re = /do\(\)|mul\([\d{1,3}]+\)|don't\(\)/gi;

  const mulRegex = /(,)|[^\d]+/gi;

  const custom = `do()${contents}`
  const res = custom.matchAll(re);

  let enabled = false;
  let sum = 0;

  for (let match of res) {
    if (match[0] === 'do()') enabled = true
    else if (match[0] === 'don\'t()') enabled = false;
    else if (enabled) {
      sum += eval(match[0].replaceAll(mulRegex, '$1').replace(',', '*'));
    }
  }

  // 74361272
  console.log('total:', sum);
}

// adventurDay3Part2();

async function adventurDay4Part1() {
  const contents = `MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
  `;
  const items = contents.split(/\n/);
  const rows = items.length;
  const cols = items[0].length;

  const STRAIGHT = 0;
  const RIGHT = 1;       
  const LEFT = -1;
  const UP = -1;
  const DOWN = 1;

  function check(row, col, dirRow, dirCol) {
    const keyword = 'XMAS';

    for (let i = 0; i < keyword.length; i++) {
      if (row < 0 || row >= rows) return 0;
      if (col < 0 || col >= cols) return 0;

      console.log(items[row], row, col);
      

      // Check for the keyword
      if (items[row][col] != keyword[i]) return 0;

      row += dirRow;
      col += dirCol;
    }

    return 1;
  }

  let count = 0;
  
  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < cols; j++) {
      count += check(i, j, RIGHT,    STRAIGHT);
      count += check(i, j, LEFT,     STRAIGHT);
      count += check(i, j, STRAIGHT, UP      );
      count += check(i, j, STRAIGHT, DOWN    );
      count += check(i, j, RIGHT,    DOWN    );
      count += check(i, j, RIGHT,    UP      );
      count += check(i, j, LEFT,     DOWN    );
      count += check(i, j, LEFT,     UP      );
    }
  }

  console.log('total: ', count);
}

// Fuck you!
// adventurDay4Part1();
