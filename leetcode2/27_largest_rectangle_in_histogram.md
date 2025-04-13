この問題は「ヒストグラム中で、**最大の長方形の面積**」を求める問題です。

---

## ✅ 問題の日本語訳

整数配列 `heights` が与えられます。これは横幅 1 の棒グラフ（ヒストグラム）の高さを表しています。  
このとき、**連続した棒の中で最大の長方形の面積**を返してください。

---

## 🧠 考え方：**単調スタック法（O(n)）**

### 📌 ポイント：

- 各棒を「高さ」として、その高さを **最小値とする最大幅の矩形** を求める
- スタックを使って、**左端と右端**を効率よく見つける

---

## 🧮 アルゴリズムの流れ

1. `heights` に `0` を末尾に追加（全ての棒を処理するため）
2. スタックに「インデックス」を保持（高さが**単調増加**になるようにする）
3. 現在の高さがスタックの上よりも小さくなったら：
   - 上の棒を取り出して「その棒を最小とする長方形の面積」を計算
   - 面積 = 高さ × 幅（幅は、今のインデックスとスタックの次の上との差）

---

思考を切り替えるコツ：「今すぐ計算せず、条件がそろうまで待つ」
高さが増える → 「まだ面積を広げるチャンスがある」からスタックに積むだけ

高さが下がる → 「もう広げられない」から、いままで積んでた棒の面積を計算

## 💎 Ruby（希望の形式で解説付き）

```ruby
# Input: heights = [2,1,5,6,2,3]
# Output: 10

def largest_rectangle_area(heights)
  # 末尾に0を追加して、すべてのバーを処理できるようにする
  heights << 0
  stack = []  # インデックスを格納するスタック
  max_area = 0

  heights.each_with_index do |h, i|
    # スタックの一番上より小さな高さが現れたら処理する
    while !stack.empty? && heights[stack[-1]] > h
      height = heights[stack.pop]  # 最小の高さ
      # 幅の計算：スタックが空なら 0 から i まで、それ以外は間の幅
      width = stack.empty? ? i : i - stack[-1] - 1
      area = height * width
      max_area = [max_area, area].max
    end
    # 高さが増える → 「まだ面積を広げるチャンスがある」からスタックに積むだけ
    stack.push(i)  # インデックスを積む
  end

  max_area
end
```

---

## 🟦 TypeScript

```ts
function largestRectangleArea(heights: number[]): number {
  heights.push(0);
  const stack: number[] = [];
  let maxArea = 0;

  for (let i = 0; i < heights.length; i++) {
    while (stack.length > 0 && heights[stack[stack.length - 1]] > heights[i]) {
      const height = heights[stack.pop()!];
      const width = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;
      maxArea = Math.max(maxArea, height * width);
    }
    stack.push(i);
  }

  return maxArea;
}
```

---

## 🟩 Go

```go
func largestRectangleArea(heights []int) int {
    heights = append(heights, 0)
    stack := []int{}
    maxArea := 0

    for i, h := range heights {
        for len(stack) > 0 && heights[stack[len(stack)-1]] > h {
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            height := heights[top]
            width := i
            if len(stack) > 0 {
                width = i - stack[len(stack)-1] - 1
            }
            area := height * width
            if area > maxArea {
                maxArea = area
            }
        }
        stack = append(stack, i)
    }

    return maxArea
}
```

---

## ✅ 実行例の確認

```ruby
largest_rectangle_area([2,1,5,6,2,3])
# => 10
```

> `5`と`6`の部分で高さ 5、幅 2 の長方形 → 面積 10

---
