## **問題の概要**

与えられた整数配列 `height` は、`n` 本の垂直な棒の高さを表しています。それぞれの棒の **x 座標は配列のインデックス** に対応しています。

2 本の棒を選び、それらと **x 軸で囲まれる領域の面積（貯められる水の量）** を最大化する必要があります。

**制約**

- `2 <= n <= 10^5`
- `0 <= height[i] <= 10^4`
- **傾けることはできない**（つまり、選んだ 2 本の棒の間にある棒の高さは無視してよい）

---

## **考え方**

**「できるだけ広い範囲（横幅）を確保しつつ、高さをできるだけ確保する」** ことが重要です。

1. **面積の計算**

   - 2 本の棒 `height[i]` と `height[j]` を選んだときの面積は
     ```
     面積 = min(height[i], height[j]) × (j - i)
     ```
   - 高さが低い方の棒が水の高さを決めるため、**低い方の棒を基準にする**。

2. **暴力的な全探索（O(n^2)）は非効率**

   - 全ての `i, j` の組み合わせを試すと、最大 `O(n^2)` かかる。
   - `n = 10^5` なので、最大 `10^10` 回の計算となり、**間に合わない**。

3. **双方向 2 ポインター法（O(n)）**
   - **最初に左右の端を選ぶ**
   - **低い方の棒を内側に動かす**
   - **高い方を固定する理由**:
     - 高い方を動かしても、新しい面積は `min(新しい高さ, 固定した高さ) × (幅)` となるが、幅が狭くなるだけで面積が増える保証がない。
     - 低い方を動かせば、高さが増える可能性があるため、**より大きな面積を得られる可能性がある**。

---

## **実装**

### **Ruby**

```ruby
def max_area(height)
  left = 0
  right = height.length - 1
  max_area = 0

  while left < right
    h = [height[left], height[right]].min
    area = h * (right - left)
    max_area = [max_area, area].max

    # 低い方の棒を動かす
    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end

  max_area
end

# テスト
p max_area([1,8,6,2,5,4,8,3,7]) # => 49
p max_area([1,1]) # => 1
```

### **TypeScript**

```typescript
function maxArea(height: number[]): number {
  let left = 0;
  let right = height.length - 1;
  let maxArea = 0;

  while (left < right) {
    const h = Math.min(height[left], height[right]);
    const area = h * (right - left);
    maxArea = Math.max(maxArea, area);

    if (height[left] < height[right]) {
      left++;
    } else {
      right--;
    }
  }

  return maxArea;
}

// テスト
console.log(maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7])); // => 49
console.log(maxArea([1, 1])); // => 1
```

### **Go**

```go
package main

import (
	"fmt"
)

func maxArea(height []int) int {
	left, right := 0, len(height)-1
	maxArea := 0

	for left < right {
		h := min(height[left], height[right])
		area := h * (right - left)
		if area > maxArea {
			maxArea = area
		}

		if height[left] < height[right] {
			left++
		} else {
			right--
		}
	}

	return maxArea
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func main() {
	fmt.Println(maxArea([]int{1, 8, 6, 2, 5, 4, 8, 3, 7})) // => 49
	fmt.Println(maxArea([]int{1, 1}))                      // => 1
}
```

---

## **時間計算量**

- `while` ループで `left` から `right` へ向かって 1 回ずつ動かすだけ → **O(n)**
- `n = 10^5` の場合でも **十分高速** に動作する。

## **ポイントまとめ**

✅ **面積は `min(height[i], height[j]) × (j - i)` で計算**  
✅ **できるだけ「横幅」を確保しつつ、可能な限り「高さ」を増やす**  
✅ **低い方の棒を内側に動かすことで、大きな面積を探索し続ける**  
✅ **計算量 O(n) なので、大きな `n` でも高速**
