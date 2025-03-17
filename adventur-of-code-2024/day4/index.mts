async function adventurDay4Part1() {
  // TODO: import from real file
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

// Very hard to do
// adventurDay4Part1();
