## **解法: 最長連続要素の長さを求める（O(n)）**

### **1. 問題の概要**

与えられた **整数配列 `nums`** から、**連続した数の最長の長さを求める**。

### **2. 例**

#### **Example 1**

```plaintext
Input: nums = [100,4,200,1,3,2]
Output: 4
Explanation: 1, 2, 3, 4 の連続する部分列が最大。
```

#### **Example 2**

```plaintext
Input: nums = [0,3,7,2,5,8,4,6,0,1]
Output: 9
Explanation: 0, 1, 2, 3, 4, 5, 6, 7, 8 が最大。
```

#### **Example 3**

```plaintext
Input: nums = [1,0,1,2]
Output: 3
Explanation: 0, 1, 2 の連続部分列が最大。
```

---

## **解法のアイデア**

### **1. ソートして探索する方法（O(n log n）)**

- 配列を **ソート** し、連続しているかを 1 つずつチェックする。
- ただし、**O(n log n) なので不適**。

---

### **2. `Set` を使った O(n) 解法**

この問題の最適解は **`Set` を使う方法で O(n) で解く** こと。

**アプローチ**

1. **`Set` を使って全ての数値を格納する**（検索が O(1) になる）
2. **連続する数列の「スタート地点」だけ調べる**
   - `num - 1` が `Set` に存在しない場合、`num` は新しい数列の開始点。
   - そこから `num+1, num+2, ...` を `Set` にある限り探索する。

✅ **こうすることで、各数列を 1 回ずつ探索するだけで済むため O(n) になる！**

---

## **Ruby の実装**

```ruby
def longest_consecutive(nums)
  return 0 if nums.empty?

  num_set = nums.to_set
  max_length = 0

  nums.each do |num|
    # num - 1 が存在しない場合のみ、新しい連続列のスタート地点
    if !num_set.include?(num - 1)
      length = 1
      current = num

      # 連続する数値を探索
      while num_set.include?(current + 1)
        current += 1
        length += 1
      end

      max_length = [max_length, length].max
    end
  end

  max_length
end

# テスト
p longest_consecutive([100,4,200,1,3,2])  # 4
p longest_consecutive([0,3,7,2,5,8,4,6,0,1])  # 9
p longest_consecutive([1,0,1,2])  # 3
```

---

## **TypeScript の実装**

```typescript
function longestConsecutive(nums: number[]): number {
  if (nums.length === 0) return 0;

  const numSet = new Set(nums);
  let maxLength = 0;

  for (const num of nums) {
    // num - 1 がないなら、新しい数列の開始点
    if (!numSet.has(num - 1)) {
      let length = 1;
      let current = num;

      // 連続する数を探索
      while (numSet.has(current + 1)) {
        current += 1;
        length += 1;
      }

      maxLength = Math.max(maxLength, length);
    }
  }

  return maxLength;
}

// テスト
console.log(longestConsecutive([100, 4, 200, 1, 3, 2])); // 4
console.log(longestConsecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1])); // 9
console.log(longestConsecutive([1, 0, 1, 2])); // 3
```

---

## **Go の実装**

```go
package main

import (
	"fmt"
)

func longestConsecutive(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	numSet := make(map[int]bool)
	for _, num := range nums {
		numSet[num] = true
	}

	maxLength := 0

	for _, num := range nums {
		// num - 1 がないなら、新しい数列の開始点
		if !numSet[num-1] {
			length := 1
			current := num

			// 連続する数を探索
			for numSet[current+1] {
				current += 1
				length += 1
			}

			if length > maxLength {
				maxLength = length
			}
		}
	}

	return maxLength
}

func main() {
	fmt.Println(longestConsecutive([]int{100, 4, 200, 1, 3, 2}))  // 4
	fmt.Println(longestConsecutive([]int{0, 3, 7, 2, 5, 8, 4, 6, 0, 1})) // 9
	fmt.Println(longestConsecutive([]int{1, 0, 1, 2})) // 3
}
```

---

## **計算量解析**

| 方法                 | 計算量         | 説明                                        |
| -------------------- | -------------- | ------------------------------------------- |
| **ソートして探索**   | **O(n log n)** | `sort()` の計算量が `O(n log n)` なので遅い |
| **`Set` を使う方法** | **O(n)**       | 各要素を 1 回だけチェックする               |

✅ **最適解は `Set` を使った O(n) の方法！** 🚀
