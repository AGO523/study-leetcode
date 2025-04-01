122. Best Time to Buy and Sell Stock II
     Medium
     Topics
     Companies
     You are given an integer array prices where prices[i] is the price of a given stock on the ith day.

On each day, you may decide to buy and/or sell the stock. You can only hold at most one share of the stock at any time. However, you can buy it then immediately sell it on the same day.

Find and return the maximum profit you can achieve.

Example 1:

Input: prices = [7,1,5,3,6,4]
Output: 7
Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
Total profit is 4 + 3 = 7.
Example 2:

Input: prices = [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
Total profit is 4.
Example 3:

Input: prices = [7,6,4,3,1]
Output: 0
Explanation: There is no way to make a positive profit, so we never buy the stock to achieve the maximum profit of 0.

Constraints:

1 <= prices.length <= 3 \* 104
0 <= prices[i] <= 104

## ✅ 問題の概要（売買自由：複数回売買 OK）

- `prices[i]` は `i` 日目の株価。
- 1 日に **複数回の操作（買ってすぐ売る）も OK**。
- ただし、**同時に複数株は持てない（持ってる間は買えない）**。
- 何回でも売買していいので、**合計利益を最大にする**。

---

## 🎯 目的

- 「**利益が出るたびに売る**」ことで、合計利益を最大化する。

---

## 🧠 アルゴリズムの考え方（グリーディ：貪欲法）

### 💡 ポイントは「**上がった分は全部取る**」！

- 価格が上がる日があれば、その分だけ利益を得られる。
- つまり、`prices[i+1] > prices[i]` のとき、**買って次の日に売ると利益が出る**。
- この操作をすべての上昇部分で行えば、**最大の利益**が得られる。

---

## 🔢 実装イメージ

```text
total_profit = 0

for i in 1...n:
    if prices[i] > prices[i-1]:
        total_profit += prices[i] - prices[i-1]
```

---

## 💎 Ruby 実装

```ruby
def max_profit(prices)
  profit = 0

  (1...prices.length).each do |i|
    if prices[i] > prices[i - 1]
      profit += prices[i] - prices[i - 1]
    end
  end

  profit
end

# テスト
p max_profit([7,1,5,3,6,4])  # => 7
p max_profit([1,2,3,4,5])    # => 4
p max_profit([7,6,4,3,1])    # => 0
```

---

## 💻 TypeScript 実装

```typescript
function maxProfit(prices: number[]): number {
  let profit = 0;

  for (let i = 1; i < prices.length; i++) {
    if (prices[i] > prices[i - 1]) {
      profit += prices[i] - prices[i - 1];
    }
  }

  return profit;
}

// テスト
console.log(maxProfit([7, 1, 5, 3, 6, 4])); // => 7
console.log(maxProfit([1, 2, 3, 4, 5])); // => 4
console.log(maxProfit([7, 6, 4, 3, 1])); // => 0
```

---

## 🐹 Go 実装

```go
package main

import "fmt"

func maxProfit(prices []int) int {
	profit := 0
	for i := 1; i < len(prices); i++ {
		if prices[i] > prices[i-1] {
			profit += prices[i] - prices[i-1]
		}
	}
	return profit
}

func main() {
	fmt.Println(maxProfit([]int{7,1,5,3,6,4})) // => 7
	fmt.Println(maxProfit([]int{1,2,3,4,5}))   // => 4
	fmt.Println(maxProfit([]int{7,6,4,3,1}))   // => 0
}
```

---

## 📌 ポイントまとめ

| 条件                      | 結論                                     |
| ------------------------- | ---------------------------------------- |
| 一度だけ買って売る        | → 前の問題（最大 1 回売買）              |
| 何回でも売買できる        | → **上がるたびに売る（貪欲法）**         |
| 同時に複数は持てない      | → 1 回買ったら売るまで買えない           |
| 同じ日に買って売るのも OK | → `prices[i+1] > prices[i]` で即利益確定 |
