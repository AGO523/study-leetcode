この問題を **Ruby, TypeScript, Go** で解決しました！ 🚀

---

## **問題の日本語訳**

整数の配列 `nums` と整数 `k` が与えられたとき、**最も頻度が高い `k` 個の要素** を返してください。  
順番は **任意** で OK です。

**例 1**

```plaintext
入力: nums = [1,1,1,2,2,3], k = 2
出力: [1,2]
```

**例 2**

```plaintext
入力: nums = [1], k = 1
出力: [1]
```

---

## **解法**

この問題は **頻度の高い `k` 個の要素を見つける** ことがポイントです。  
効率的に解くために、以下の方法を使います。

### **1. ハッシュマップ（辞書）で出現回数をカウント**（O(n)）

- `nums` の各要素の **出現回数** を `Hash` に記録。

### **2. ヒープまたはソートを利用して上位 `k` 個を取得**

- **ソートを使う方法 (O(n log n))** → シンプルで実装しやすい。
- **ヒープを使う方法 (O(n log k))** → より高速。（`k` が小さいときに有利）

---

## **実装**

### **Ruby**

```ruby
def top_k_frequent(nums, k)
  freq = nums.tally # 出現回数をカウント
  freq.keys.sort_by { |num| -freq[num] }.first(k) # 出現回数が多い順にソート
end

# テスト
p top_k_frequent([1,1,1,2,2,3], 2) # [1, 2]
p top_k_frequent([1], 1) # [1]
```

#### **解説**

- `nums.tally` で各要素の **出現回数を数える**（`tally` は Ruby 3.0+）。
- `sort_by { |num| -freq[num] }` で **降順ソート**。
- `.first(k)` で **上位 `k` 個を取得**。

---

### **TypeScript**

```typescript
function topKFrequent(nums: number[], k: number): number[] {
  const freqMap = new Map<number, number>();

  // 出現回数をカウント
  for (const num of nums) {
    freqMap.set(num, (freqMap.get(num) || 0) + 1);
  }

  // 出現回数が多い順にソートし、上位 k 個を取得
  return Array.from(freqMap.keys())
    .sort((a, b) => freqMap.get(b)! - freqMap.get(a)!)
    .slice(0, k);
}

// テスト
console.log(topKFrequent([1, 1, 1, 2, 2, 3], 2)); // [1, 2]
console.log(topKFrequent([1], 1)); // [1]
```

#### **解説**

- `Map` で **出現回数をカウント**。
- `.sort((a, b) => freqMap.get(b)! - freqMap.get(a)!)` で **降順ソート**。
- `.slice(0, k)` で **上位 `k` 個を取得**。

---

### **Go**

```go
package main

import (
	"fmt"
	"sort"
)

func topKFrequent(nums []int, k int) []int {
	freq := make(map[int]int)

	// 出現回数をカウント
	for _, num := range nums {
		freq[num]++
	}

	// キーをスライスに取得
	keys := make([]int, 0, len(freq))
	for key := range freq {
		keys = append(keys, key)
	}

	// 出現回数が多い順にソート
	sort.Slice(keys, func(i, j int) bool {
		return freq[keys[i]] > freq[keys[j]]
	})

	// 上位 k 個を取得
	return keys[:k]
}

func main() {
	fmt.Println(topKFrequent([]int{1,1,1,2,2,3}, 2)) // [1, 2]
	fmt.Println(topKFrequent([]int{1}, 1))           // [1]
}
```

#### **解説**

- `map[int]int` で **出現回数をカウント**。
- `sort.Slice` で **出現回数が多い順にソート**。
- `keys[:k]` で **上位 `k` 個を取得**。

---

## **時間計算量**

| 方法                                           | 計算量         | メリット   | デメリット |
| ---------------------------------------------- | -------------- | ---------- | ---------- |
| **ソート (`sort_by` / `sort` / `sort.Slice`)** | **O(n log n)** | 実装が簡単 | 遅め       |
| **ヒープ (`priority queue`)**                  | **O(n log k)** | より高速   | 実装が複雑 |

### **✅ 最適な選択**

- **シンプルなコード → ソート方式（O(n log n)）**
- **速度重視 → ヒープを使う（O(n log k)）**

💡 **実装の簡単さを考えると、ソート方式で十分！** 🚀
