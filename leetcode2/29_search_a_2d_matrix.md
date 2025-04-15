### 🔍 問題の概要（日本語訳）

m×n の整数行列 `matrix` が与えられます。この行列は以下の 2 つの性質を持っています：

1. 各行は昇順（非減少）にソートされています。
2. 各行の先頭の要素は、前の行の最後の要素より大きいです。

この条件下で、指定された整数 `target` がこの行列の中に存在するかどうかを判定しなさい。時間計算量は **O(log(m \* n))** である必要があります。

---

### 🧠 考え方

この行列の構造は、実質的に一次元の昇順配列に見なすことができます。

```
matrix = [[ 1,  3,  5,  7],
          [10, 11, 16, 20],
          [23, 30, 34, 60]]
```

を一次元配列と考えると：

```
[1, 3, 5, 7, 10, 11, 16, 20, 23, 30, 34, 60]
```

このように扱えば、**二分探索（Binary Search）** を使うことで、**O(log(m \* n))** の時間で探索できます。

**要点**:

- 仮想的に `0` から `m * n - 1` までのインデックスを持つ一次元配列と見なす。
- そのインデックス `idx` から `matrix[idx / n][idx % n]` のように元の 2 次元配列の要素に変換する。

---

## ✅ Ruby 実装（初心者向けコメント付き）

```ruby
# Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
# Output: true

def search_matrix(matrix, target)
  # 行数と列数を取得
  m = matrix.length
  n = matrix[0].length

  # 二分探索の範囲（仮想的な一次元配列として扱う）
  left = 0
  right = m * n - 1

  while left <= right
    mid = (left + right) / 2
    # mid を 2次元のインデックスに変換
    row = mid / n
    col = mid % n
    value = matrix[row][col]

    if value == target
      return true
    elsif value < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  # 見つからなかった場合
  false
end
```

---

## ✅ TypeScript 実装

```ts
function searchMatrix(matrix: number[][], target: number): boolean {
  const m = matrix.length;
  const n = matrix[0].length;

  let left = 0;
  let right = m * n - 1;

  while (left <= right) {
    const mid = Math.floor((left + right) / 2);
    const row = Math.floor(mid / n);
    const col = mid % n;
    const value = matrix[row][col];

    if (value === target) {
      return true;
    } else if (value < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return false;
}
```

---

## ✅ Go 実装

```go
func searchMatrix(matrix [][]int, target int) bool {
    m := len(matrix)
    n := len(matrix[0])

    left := 0
    right := m*n - 1

    for left <= right {
        mid := (left + right) / 2
        row := mid / n
        col := mid % n
        value := matrix[row][col]

        if value == target {
            return true
        } else if value < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return false
}
```

---

必要であれば、テストコードや可視化、デモ付きの説明もできます！お気軽にどうぞ。
