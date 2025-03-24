## **解法：9x9 数独のバリデーション**

この問題は、部分的に埋められた **9x9 の数独盤面が有効であるかどうかを判定** するものです。

**有効な数独の条件**

1. **各行** に `1-9` が **重複なし** に含まれる。
2. **各列** に `1-9` が **重複なし** に含まれる。
3. **各 3x3 のボックス** に `1-9` が **重複なし** に含まれる。

💡 **補足**

- **盤面が解けるかどうかは不要**（途中の状態でもチェック）
- **空欄 ('.') は無視** する

---

## **解法のアプローチ**

### **1. 行・列・3x3 ボックスをチェック**

- **`row_sets[i]`** で **行ごとに数値を記録**
- **`col_sets[j]`** で **列ごとに数値を記録**
- **`box_sets[i][j]`** で **3x3 ボックスごとに数値を記録**
  - ボックスのインデックスは `(i // 3, j // 3)` で取得

---

## **実装（Ruby, TypeScript, Go）**

### **🔹 Ruby**

```ruby
def is_valid_sudoku(board)
  row_sets = Array.new(9) { Set.new }
  col_sets = Array.new(9) { Set.new }
  box_sets = Array.new(3) { Array.new(3) { Set.new } }

  (0...9).each do |i|
    (0...9).each do |j|
      num = board[i][j]
      next if num == "."

      if row_sets[i].include?(num) || col_sets[j].include?(num) || box_sets[i/3][j/3].include?(num)
        return false
      end

      row_sets[i].add(num)
      col_sets[j].add(num)
      box_sets[i/3][j/3].add(num)
    end
  end

  true
end

# テスト
board1 = [
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]

board2 = [
  ["8","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]

p is_valid_sudoku(board1) # true
p is_valid_sudoku(board2) # false
```

---

### **🔹 TypeScript**

```typescript
function isValidSudoku(board: string[][]): boolean {
  const rowSets: Set<string>[] = Array.from({ length: 9 }, () => new Set());
  const colSets: Set<string>[] = Array.from({ length: 9 }, () => new Set());
  const boxSets: Set<string>[][] = Array.from({ length: 3 }, () =>
    Array.from({ length: 3 }, () => new Set())
  );

  for (let i = 0; i < 9; i++) {
    for (let j = 0; j < 9; j++) {
      const num = board[i][j];
      if (num === ".") continue;

      if (
        rowSets[i].has(num) ||
        colSets[j].has(num) ||
        boxSets[Math.floor(i / 3)][Math.floor(j / 3)].has(num)
      ) {
        return false;
      }

      rowSets[i].add(num);
      colSets[j].add(num);
      boxSets[Math.floor(i / 3)][Math.floor(j / 3)].add(num);
    }
  }

  return true;
}

// テスト
const board1: string[][] = [
  ["5", "3", ".", ".", "7", ".", ".", ".", "."],
  ["6", ".", ".", "1", "9", "5", ".", ".", "."],
  [".", "9", "8", ".", ".", ".", ".", "6", "."],
  ["8", ".", ".", ".", "6", ".", ".", ".", "3"],
  ["4", ".", ".", "8", ".", "3", ".", ".", "1"],
  ["7", ".", ".", ".", "2", ".", ".", ".", "6"],
  [".", "6", ".", ".", ".", ".", "2", "8", "."],
  [".", ".", ".", "4", "1", "9", ".", ".", "5"],
  [".", ".", ".", ".", "8", ".", ".", "7", "9"],
];

const board2: string[][] = [
  ["8", "3", ".", ".", "7", ".", ".", ".", "."],
  ["6", ".", ".", "1", "9", "5", ".", ".", "."],
  [".", "9", "8", ".", ".", ".", ".", "6", "."],
  ["8", ".", ".", ".", "6", ".", ".", ".", "3"],
  ["4", ".", ".", "8", ".", "3", ".", ".", "1"],
  ["7", ".", ".", ".", "2", ".", ".", ".", "6"],
  [".", "6", ".", ".", ".", ".", "2", "8", "."],
  [".", ".", ".", "4", "1", "9", ".", ".", "5"],
  [".", ".", ".", ".", "8", ".", ".", "7", "9"],
];

console.log(isValidSudoku(board1)); // true
console.log(isValidSudoku(board2)); // false
```

---

### **🔹 Go**

```go
package main

import (
	"fmt"
)

func isValidSudoku(board [][]byte) bool {
	rowSets := make([]map[byte]bool, 9)
	colSets := make([]map[byte]bool, 9)
	boxSets := make([][]map[byte]bool, 3)

	for i := 0; i < 9; i++ {
		rowSets[i] = make(map[byte]bool)
		colSets[i] = make(map[byte]bool)
	}
	for i := 0; i < 3; i++ {
		boxSets[i] = make([]map[byte]bool, 3)
		for j := 0; j < 3; j++ {
			boxSets[i][j] = make(map[byte]bool)
		}
	}

	for i := 0; i < 9; i++ {
		for j := 0; j < 9; j++ {
			num := board[i][j]
			if num == '.' {
				continue
			}

			if rowSets[i][num] || colSets[j][num] || boxSets[i/3][j/3][num] {
				return false
			}

			rowSets[i][num] = true
			colSets[j][num] = true
			boxSets[i/3][j/3][num] = true
		}
	}
	return true
}

func main() {
	board1 := [][]byte{
		{'5', '3', '.', '.', '7', '.', '.', '.', '.'},
		{'6', '.', '.', '1', '9', '5', '.', '.', '.'},
		{'.', '9', '8', '.', '.', '.', '.', '6', '.'},
		{'8', '.', '.', '.', '6', '.', '.', '.', '3'},
		{'4', '.', '.', '8', '.', '3', '.', '.', '1'},
		{'7', '.', '.', '.', '2', '.', '.', '.', '6'},
		{'.', '6', '.', '.', '.', '.', '2', '8', '.'},
		{'.', '.', '.', '4', '1', '9', '.', '.', '5'},
		{'.', '.', '.', '.', '8', '.', '.', '7', '9'},
	}

	fmt.Println(isValidSudoku(board1)) // true
}
```

---

## **計算量**

- **O(9x9) = O(81) ≈ O(1)**（固定サイズのため `O(1)` とみなせる）
- **空間 O(1)**（固定サイズなので問題なし）

💡 **この方法が最適解！ 🚀**
