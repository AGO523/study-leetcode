## ✅ 問題の概要

配列 `prices` が与えられ、`prices[i]` は **i 日目の株価** を表します。

あなたは **1 回だけ株を買い**、**将来の別の日に 1 回だけ売る** ことができます。

### 🎯 **目的**

「**最大の利益**」を出すように、**いつ買って、いつ売るか** を決めて、利益を返す。

- ただし、**買う日 < 売る日** でなければならない。
- 利益が出ない場合（ずっと下がり続ける場合）は **0** を返す。

---

## 🧠 考え方（最適解: O(n)）

- すべての「買い日」と「売り日」の組み合わせを調べると O(n²) になってしまい、`n = 10^5` では間に合わない。

### 🪄 最適な方法（1 回のループ）：

1. **これまで見た中で最も安い価格（最安値）を覚える**。
2. **今の価格から最安値で買ったときの利益を計算する**。
3. **利益が最大になるように更新していく**。

---

## 🔢 アルゴリズム手順

```text
1. min_price = Infinity
2. max_profit = 0

3. for price in prices:
     min_price = min(min_price, price)
     profit = price - min_price
     max_profit = max(max_profit, profit)

4. return max_profit
```

---

## 💎 Ruby 実装

```ruby
def max_profit(prices)
  min_price = Float::INFINITY
  max_profit = 0

  prices.each do |price|
    min_price = [min_price, price].min
    profit = price - min_price
    max_profit = [max_profit, profit].max
  end

  max_profit
end

# テスト
p max_profit([7,1,5,3,6,4])  # => 5
p max_profit([7,6,4,3,1])    # => 0
```

---

## 💻 TypeScript 実装

```typescript
function maxProfit(prices: number[]): number {
  let minPrice = Infinity;
  let maxProfit = 0;

  for (const price of prices) {
    minPrice = Math.min(minPrice, price);
    const profit = price - minPrice;
    maxProfit = Math.max(maxProfit, profit);
  }

  return maxProfit;
}

// テスト
console.log(maxProfit([7, 1, 5, 3, 6, 4])); // => 5
console.log(maxProfit([7, 6, 4, 3, 1])); // => 0
```

---

## 🐹 Go 実装

```go
package main

import (
	"fmt"
	"math"
)

func maxProfit(prices []int) int {
	minPrice := math.MaxInt32
	maxProfit := 0

	for _, price := range prices {
		if price < minPrice {
			minPrice = price
		}
		profit := price - minPrice
		if profit > maxProfit {
			maxProfit = profit
		}
	}

	return maxProfit
}

func main() {
	fmt.Println(maxProfit([]int{7,1,5,3,6,4})) // => 5
	fmt.Println(maxProfit([]int{7,6,4,3,1}))   // => 0
}
```

---

## 📌 ポイントまとめ

| ポイント     | 説明                                       |
| ------------ | ------------------------------------------ |
| `min_price`  | 今まで見た中で最も安い株価                 |
| `max_profit` | 今まで出た最大の利益                       |
| ループ内で   | 各日の利益を求めて、最大利益を更新するだけ |
| 計算量       | O(n), 空間 O(1) なのでとても効率的         |
