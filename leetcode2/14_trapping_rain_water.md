## **問題の概要**

与えられた `height` の配列は、地形の高さを表しています。  
**各インデックスの棒の間に溜まる水の量を計算する** のが目的です。

### **考え方**

水が溜まる条件：

- **左右に自分より高い棒がある** と、その間に水が溜まる。
- 水の高さは **左右の最大高さのうち、小さい方** に制限される。
- **水の量 = min(左側の最大高さ, 右側の最大高さ) - 自分の高さ**

---

## **解法**

### **方法 1: 左右の最大値を事前計算（O(n)）**

1. **各インデックス `i` の左側の最大値 `left_max[i]` を求める**
2. **各インデックス `i` の右側の最大値 `right_max[i]` を求める**
3. **水の量は `min(left_max[i], right_max[i]) - height[i]` の合計**

**時間計算量** → `O(n)`（3 回の配列走査）  
**空間計算量** → `O(n)`（`left_max` と `right_max` を保存）

---

### **Ruby 実装**

```ruby
def trap(height)
  return 0 if height.empty?

  n = height.length
  left_max = Array.new(n, 0)
  right_max = Array.new(n, 0)

  # 左からの最大値
  left_max[0] = height[0]
  (1...n).each do |i|
    left_max[i] = [left_max[i - 1], height[i]].max
  end

  # 右からの最大値
  right_max[n - 1] = height[n - 1]
  (n - 2).downto(0) do |i|
    right_max[i] = [right_max[i + 1], height[i]].max
  end

  # 水の量を計算
  water = 0
  (0...n).each do |i|
    water += [left_max[i], right_max[i]].min - height[i]
  end

  water
end

# テスト
p trap([0,1,0,2,1,0,1,3,2,1,2,1]) # => 6
p trap([4,2,0,3,2,5])             # => 9
```

---

### **方法 2: 2 ポインター（O(n), O(1) 空間）**

**ポイント**

- `left` と `right` を両端からスタート
- **`left_max` と `right_max` を 1 つずつ更新しながら処理**
- `left_max < right_max` なら、`left` を動かす（逆なら `right` を動かす）

**時間計算量** → `O(n)`（1 回の走査）  
**空間計算量** → `O(1)`

---

### **Ruby 実装**

```ruby
def trap(height)
  return 0 if height.empty?

  left, right = 0, height.length - 1
  left_max, right_max = 0, 0
  water = 0

  while left < right
    # 水は低い方の棒の高さによって決まる ので、高さが低い方を動かす
    if height[left] < height[right]
      # 水の高さは、その位置 i で最も低い側の壁の高さ によって制限されます

      # left_max → height[left] の左側にある棒の最大高さ
      left_max = [left_max, height[left]].max
      water += left_max - height[left]
      left += 1
    else
      # right_max → height[right] の右側にある棒の最大高さ
      right_max = [right_max, height[right]].max
      water += right_max - height[right]
      right -= 1
    end
  end

  water
end

# テスト
p trap([0,1,0,2,1,0,1,3,2,1,2,1]) # => 6
p trap([4,2,0,3,2,5])             # => 9
```

---

## **他の言語の実装**

### **TypeScript**

```typescript
function trap(height: number[]): number {
  if (height.length === 0) return 0;

  let left = 0,
    right = height.length - 1;
  let leftMax = 0,
    rightMax = 0,
    water = 0;

  while (left < right) {
    if (height[left] < height[right]) {
      leftMax = Math.max(leftMax, height[left]);
      water += leftMax - height[left];
      left++;
    } else {
      rightMax = Math.max(rightMax, height[right]);
      water += rightMax - height[right];
      right--;
    }
  }

  return water;
}

// テスト
console.log(trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1])); // => 6
console.log(trap([4, 2, 0, 3, 2, 5])); // => 9
```

---

### **Go**

```go
package main

import (
	"fmt"
)

func trap(height []int) int {
	if len(height) == 0 {
		return 0
	}

	left, right := 0, len(height)-1
	leftMax, rightMax, water := 0, 0, 0

	for left < right {
		if height[left] < height[right] {
			leftMax = max(leftMax, height[left])
			water += leftMax - height[left]
			left++
		} else {
			rightMax = max(rightMax, height[right])
			water += rightMax - height[right]
			right--
		}
	}

	return water
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {
	fmt.Println(trap([]int{0,1,0,2,1,0,1,3,2,1,2,1})) // => 6
	fmt.Println(trap([]int{4,2,0,3,2,5}))             // => 9
}
```

---

## **まとめ**

### **アプローチ比較**

| 方法                       | 時間計算量 | 空間計算量 | 特徴                 |
| -------------------------- | ---------- | ---------- | -------------------- |
| **左右の最大値を事前計算** | O(n)       | O(n)       | 直感的で分かりやすい |
| **2 ポインター法**         | O(n)       | O(1)       | メモリ効率が良い     |

- **実装が簡単なのは** `左右の最大値を事前計算`
- **最適な解法は** `2ポインター法`（メモリを節約できる）

**最終的な結論**

- **面接やアルゴリズム問題では** `2ポインター法` を推奨（O(n), O(1)）。
- **初心者には** `左右の最大値を事前計算する方法` が分かりやすい。

---
