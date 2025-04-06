### 📝 問題文の日本語訳

整数配列 `nums` と整数 `k` が与えられます。  
長さ `k` のスライディングウィンドウを左端から右端まで動かしていくとき、各ウィンドウ内での **最大値** を配列として返してください。

---

### 🔍 問題の概要

- 各ウィンドウサイズは `k`
- 各ウィンドウごとに `max` を求めて、配列として返す
- 例えば、`nums = [1,3,-1,-3,5,3,6,7], k = 3` なら出力は `[3,3,5,5,6,7]`

---

## 💡 アルゴリズムの考え方（キューを使う）

### なぜ毎回 `max` を取り直すのはダメ？

- 各ウィンドウごとに `max(nums[i:i+k])` を取ると、**O(nk)** 時間がかかる → 時間制限に引っかかる

---

### 解決策：**単調減少のキュー（Deque）を使う**

キュー（両端キュー、`deque`）を使って、**常に最大値が先頭に来るように管理**する。

#### 基本アイデア：

- 新しい値をキューに入れるとき：

  - **後ろの値が小さければ全部捨てる**
  - 自分より小さい値は保持しても意味がないから！

- 各ステップで：
  - 最大値はキューの先頭（最初の要素）

---

## 🧠 Ruby の実装と解説（初心者向け）

```ruby
def max_sliding_window(nums, k)
  return [] if nums.empty?
  return nums if k == 1

  deque = []  # インデックスを保存
  result = []

  nums.each_with_index do |num, i|
    # キューの先頭がウィンドウから外れてたら削除
    deque.shift if !deque.empty? && deque[0] <= i - k

    # キューの末尾から、自分より小さいものを削除（単調減少を維持）
    while !deque.empty? && nums[deque[-1]] < num
      deque.pop
    end

    deque << i  # 自分のインデックスを追加

    # k個以上見たら最大値（キューの先頭）を結果に追加
    result << nums[deque[0]] if i >= k - 1
  end

  result
end
```

---

### ✅ このコードの動き（例: `[1,3,-1,-3,5,3,6,7]`, `k = 3`）

1. キューには、**値ではなくインデックス**を入れる。
2. インデックスで「古くなったもの（範囲外）」を外す。
3. 「自分より小さい」ものはキューから外して、自分を追加。
4. `k` 個目から結果に `nums[deque[0]]` を追加していく。

---

## 🧪 TypeScript 版

```ts
function maxSlidingWindow(nums: number[], k: number): number[] {
  const deque: number[] = [];
  const result: number[] = [];

  for (let i = 0; i < nums.length; i++) {
    // 範囲外のインデックスを削除
    if (deque.length && deque[0] <= i - k) {
      deque.shift();
    }

    // 小さい値を後ろから削除
    while (deque.length && nums[deque[deque.length - 1]] < nums[i]) {
      deque.pop();
    }

    deque.push(i);

    if (i >= k - 1) {
      result.push(nums[deque[0]]);
    }
  }

  return result;
}
```

---

## 🧰 Go 版

```go
func maxSlidingWindow(nums []int, k int) []int {
    deque := []int{}
    result := []int{}

    for i := 0; i < len(nums); i++ {
        // 範囲外のインデックスを削除
        if len(deque) > 0 && deque[0] <= i - k {
            deque = deque[1:]
        }

        // 自分より小さい値を削除（末尾から）
        for len(deque) > 0 && nums[deque[len(deque)-1]] < nums[i] {
            deque = deque[:len(deque)-1]
        }

        deque = append(deque, i)

        if i >= k - 1 {
            result = append(result, nums[deque[0]])
        }
    }

    return result
}
```
