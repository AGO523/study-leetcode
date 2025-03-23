## **問題の要約**

整数配列 `nums` が与えられたとき、各 `i` について、**`nums[i]` を除いたすべての要素の積** を `answer[i]` に格納した配列を返す。  
**制約**

- **O(n) 時間で解くこと**（ループ 1 回または 2 回で解く）
- **割り算 (`/`) を使わない**
- **追加の配列を使わずに解く方法も考える**

---

## **解法**

### **🔹 1. 前後の積を使う方法（O(n) 解）**

この問題を **2 回のループ** で解く方法を考える。

1. **左から右へ走査し、左側の積を求める**
2. **右から左へ走査し、右側の積をかける**

例えば `nums = [1,2,3,4]` の場合:

1. **左積 (prefix product)**
   ```plaintext
   [1, 1, 2, 6]  // 左から積を計算（左端は1）
   ```
2. **右積 (suffix product) をかける**
   ```plaintext
   [24, 12, 8, 6]  // 右から積をかける（右端は1）
   ```
   これで `O(n)` 時間で解ける。

---

## **実装（Ruby, TypeScript, Go）**

### **🔹 Ruby**

```ruby
def product_except_self(nums)
  n = nums.length
  answer = Array.new(n, 1)

  # 左積の計算
  left = 1
  (0...n).each do |i|
    answer[i] = left
    left *= nums[i]
  end

  # 右積をかける
  right = 1
  (n-1).downto(0) do |i|
    answer[i] *= right
    right *= nums[i]
  end

  answer
end

# テスト
p product_except_self([1,2,3,4])  # [24, 12, 8, 6]
p product_except_self([-1,1,0,-3,3])  # [0, 0, 9, 0, 0]
```

**🔹 解説**

1. **`answer` を `1` で初期化**（後で `*= right` するときに影響を避ける）
2. **`left` で左側の積を計算**（前から）
3. **`right` で右側の積をかける**（後ろから）

---

### **🔹 TypeScript**

```typescript
function productExceptSelf(nums: number[]): number[] {
  const n = nums.length;
  const answer: number[] = new Array(n).fill(1);

  let left = 1;
  for (let i = 0; i < n; i++) {
    answer[i] = left;
    left *= nums[i];
  }

  let right = 1;
  for (let i = n - 1; i >= 0; i--) {
    answer[i] *= right;
    right *= nums[i];
  }

  return answer;
}

// テスト
console.log(productExceptSelf([1, 2, 3, 4])); // [24, 12, 8, 6]
console.log(productExceptSelf([-1, 1, 0, -3, 3])); // [0, 0, 9, 0, 0]
```

**🔹 解説**

- Ruby と同じロジック
- `new Array(n).fill(1)` で配列を初期化

---

### **🔹 Go**

```go
package main

import (
	"fmt"
)

func productExceptSelf(nums []int) []int {
	n := len(nums)
	answer := make([]int, n)

	// 初期化
	for i := range answer {
		answer[i] = 1
	}

	// 左積
	left := 1
	for i := 0; i < n; i++ {
		answer[i] = left
		left *= nums[i]
	}

	// 右積
	right := 1
	for i := n - 1; i >= 0; i-- {
		answer[i] *= right
		right *= nums[i]
	}

	return answer
}

func main() {
	fmt.Println(productExceptSelf([]int{1, 2, 3, 4}))  // [24, 12, 8, 6]
	fmt.Println(productExceptSelf([]int{-1, 1, 0, -3, 3}))  // [0, 0, 9, 0, 0]
}
```

**🔹 解説**

- `make([]int, n)` でスライスを作成
- `for i := range answer { answer[i] = 1 }` で初期化

---

## **時間 & 空間計算量**

| 方法                       | 計算量   | 空間計算量              |
| -------------------------- | -------- | ----------------------- |
| **2 回のループ (O(n) 解)** | **O(n)** | **O(1) (出力配列のみ)** |

💡 **最適な解法: O(n) 時間 & O(1) 空間で解ける！** 🚀
