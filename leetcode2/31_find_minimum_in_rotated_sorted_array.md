### 🇯🇵 問題の日本語訳

昇順にソートされた長さ `n` の配列 `nums` が、**1 回から n 回の間で回転**されたとします。  
このとき、回転された配列 `nums` が与えられるので、**最小の要素を返してください。**

❗️ ただし、**時間計算量は O(log n)** でなければなりません。

---

### 🧠 考え方：二分探索で最小値を探す

この問題は **回転されたソート済み配列から最小値を探す**問題です。

特徴をまとめると：

- 配列は元々昇順だった → 回転によって 2 つの「昇順の山」に分かれる
- 例：`[4,5,6,7,0,1,2]` → 境目の「`7 → 0`」がカギ
- **最小値がどこにあるかを二分探索**で絞っていく

---

### 🧮 アルゴリズム（ポイント）

1. `left = 0`, `right = n - 1` でスタート
2. `mid = (left + right) / 2`
3. `nums[mid] > nums[right]` なら、最小値は **右半分**にある → `left = mid + 1`
4. `nums[mid] <= nums[right]` なら、最小値は **左半分**に含まれる → `right = mid`
5. 最終的に `left == right` になったところが最小値

---

## ✅ Ruby（解説付き）

```ruby
# Input: nums = [4,5,6,7,0,1,2]
# Input: nums = [1, 2, 4,5,6,7,0]
# Input: nums = [0,1, 2, 4,5,6,7]
# Output: 0

def find_min(nums)
  left = 0
  right = nums.size - 1

  while left < right
    mid = (left + right) / 2

    # midが右側より大きいなら、最小値は右側にある
    if nums[mid] > nums[right]
      left = mid + 1
    else
      right = mid
    end
  end

  # leftとrightが一致したらそこが最小値
  nums[left]
end
```

---

### 🔍 解説（初心者向け）

#### 例: `nums = [4,5,6,7,0,1,2]`

1. `left = 0 (4)`, `right = 6 (2)`, `mid = 3 (7)`

   - `nums[mid] = 7 > nums[right] = 2` → 最小値は右にある！
   - → `left = 4`

2. `left = 4 (0)`, `right = 6 (2)`, `mid = 5 (1)`

   - `1 < 2` → 最小値は左にあるかも！
   - → `right = 5`

3. `left = 4 (0)`, `right = 5 (1)`, `mid = 4 (0)`

   - `0 < 1` → 最小値は左にあるかも！
   - → `right = 4`

4. `left == right == 4` → `nums[4] = 0`

---

## ✅ TypeScript

```ts
function findMin(nums: number[]): number {
  let left = 0;
  let right = nums.length - 1;

  while (left < right) {
    const mid = Math.floor((left + right) / 2);

    if (nums[mid] > nums[right]) {
      left = mid + 1;
    } else {
      right = mid;
    }
  }

  return nums[left];
}
```

---

## ✅ Go

```go
func findMin(nums []int) int {
    left, right := 0, len(nums)-1

    for left < right {
        mid := (left + right) / 2

        if nums[mid] > nums[right] {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return nums[left]
}
```
