## 問題の概要

この問題は、**ソート済みの整数配列** `numbers` が与えられたときに、**合計が `target` となる 2 つの数のインデックスを求める** というものです。

**制約条件**

1. `numbers` は **1-indexed**（つまり、配列の最初の要素のインデックスは 1）。
2. **ちょうど 1 つの解が存在** することが保証されている。
3. **定数の追加メモリ**（O(1)の補助記憶）しか使用できない。
4. **配列は非減少順にソート済み**。

## 解法の考え方

この問題では、**配列がソート済み** であるため、最適なアプローチは **2 ポインター法** です。

### **2 ポインター法の手順**

1. **2 つのポインターを設定**：
   - `left` を **配列の最初の要素** に設定（`index1 = 1`）。
   - `right` を **配列の最後の要素** に設定（`index2 = numbers.length`）。
2. **合計値をチェック**：
   - `numbers[left] + numbers[right]` が `target` より小さければ、`left` を右に移動（`left += 1`）。
   - `numbers[left] + numbers[right]` が `target` より大きければ、`right` を左に移動（`right -= 1`）。
   - もし `numbers[left] + numbers[right] == target` なら、`[left+1, right+1]` を返す。

この方法では、**一度の走査（O(n)）で解が見つかる** ため、非常に効率的です。

---

## **実装**

### **Ruby**

```ruby
def two_sum(numbers, target)
  left = 0
  right = numbers.length - 1

  while left < right
    sum = numbers[left] + numbers[right]
    if sum == target
      return [left + 1, right + 1] # 1-indexed のため +1
    elsif sum < target
      left += 1
    else
      right -= 1
    end
  end
end

# テストケース
puts two_sum([2, 7, 11, 15], 9).inspect  # => [1, 2]
puts two_sum([2, 3, 4], 6).inspect       # => [1, 3]
puts two_sum([-1, 0], -1).inspect        # => [1, 2]
```

### **TypeScript**

```typescript
function twoSum(numbers: number[], target: number): number[] {
  let left = 0,
    right = numbers.length - 1;

  while (left < right) {
    let sum = numbers[left] + numbers[right];

    if (sum === target) {
      return [left + 1, right + 1]; // 1-indexed のため +1
    } else if (sum < target) {
      left++;
    } else {
      right--;
    }
  }
  return [];
}

// テストケース
console.log(twoSum([2, 7, 11, 15], 9)); // => [1, 2]
console.log(twoSum([2, 3, 4], 6)); // => [1, 3]
console.log(twoSum([-1, 0], -1)); // => [1, 2]
```

### **Go**

```go
package main

import (
	"fmt"
)

func twoSum(numbers []int, target int) []int {
	left, right := 0, len(numbers)-1

	for left < right {
		sum := numbers[left] + numbers[right]
		if sum == target {
			return []int{left + 1, right + 1} // 1-indexed のため +1
		} else if sum < target {
			left++
		} else {
			right--
		}
	}
	return []int{}
}

func main() {
	fmt.Println(twoSum([]int{2, 7, 11, 15}, 9))  // => [1, 2]
	fmt.Println(twoSum([]int{2, 3, 4}, 6))       // => [1, 3]
	fmt.Println(twoSum([]int{-1, 0}, -1))        // => [1, 2]
}
```

---

## **計算量**

- **時間計算量：O(n)**
  - 左右のポインターを 1 回ずつ動かすだけなので、配列を 1 回走査するだけで済む。
- **空間計算量：O(1)**
  - **ポインター 2 つだけを使用するため、追加メモリをほぼ使わない**（問題の条件を満たす）。

---

## **まとめ**

| 解法               | 時間計算量 | 空間計算量 | メリット                                   |
| ------------------ | ---------- | ---------- | ------------------------------------------ |
| **2 ポインター法** | O(n)       | O(1)       | 追加メモリ不要、ソート済みの性質を活かせる |

この問題では**ソート済みの配列**を利用して効率よく探索するのがポイントでした。  
そのため、**二分探索を使わずに、線形探索（2 ポインター）で解くのが最適**です！
