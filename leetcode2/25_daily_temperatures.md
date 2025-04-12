### ✅ 問題の日本語訳

配列 `temperatures` は日ごとの気温を表しています。

各日 `i` に対して、「**何日後により暖かい日が来るか**」を `answer[i]` に格納して返してください。  
もしそれ以降に暖かい日が無い場合は、`answer[i] = 0` にしてください。

---

### 🔍 問題の概要と考え方

これは典型的な **「次に条件を満たす要素を探す問題」** で、  
スタック（**単調スタック**）を使って **O(n)** で解くのがポイントです。

---

### 🧠 アルゴリズムの考え方

1. **右から左へ** スキャン
2. スタックには「まだより暖かい日を見つけていないインデックス」を積んでおく
3. 今見ている `temperatures[i]` より高い日がスタックの先頭にあれば、それが答え
4. スタックから `<= temperatures[i]` をどんどん pop して、「より暖かい日」だけ残す

---

## 🌸 Ruby 実装（初心者向け解説付き）

```ruby
# temperatures = [73,74,75,71,69,72,76,73]
# answer = [1,1,4,2,1,1,0,0]

def daily_temperatures(temperatures)
  n = temperatures.length
  answer = Array.new(n, 0)
  stack = []  # インデックスを格納

  (0...n).each do |i|
    # スタックの先頭が今の気温より低いなら pop
    # そうでなければ、スタックにインデックスを積む
    while !stack.empty? && temperatures[i] > temperatures[stack[-1]]
      prev = stack.pop
      answer[prev] = i - prev
    end

    stack.push(i)
  end

  answer
end

```

### 🔰 解説：

- `stack[-1]` はスタックの一番上（次に見るべき日）
- スタックは **「より暖かい候補だけを保持」** する
- `answer[i] = 次の暖かい日 index - i`

---

## 🟦 TypeScript 実装

```ts
function dailyTemperatures(temperatures: number[]): number[] {
  const n = temperatures.length;
  const answer = new Array(n).fill(0);
  const stack: number[] = [];

  for (let i = n - 1; i >= 0; i--) {
    while (
      stack.length > 0 &&
      temperatures[stack[stack.length - 1]] <= temperatures[i]
    ) {
      stack.pop();
    }

    if (stack.length > 0) {
      answer[i] = stack[stack.length - 1] - i;
    }

    stack.push(i);
  }

  return answer;
}
```

---

## 🟩 Go 実装

```go
func dailyTemperatures(temperatures []int) []int {
    n := len(temperatures)
    answer := make([]int, n)
    stack := []int{}

    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && temperatures[stack[len(stack)-1]] <= temperatures[i] {
            stack = stack[:len(stack)-1]
        }

        if len(stack) > 0 {
            answer[i] = stack[len(stack)-1] - i
        }

        stack = append(stack, i)
    }

    return answer
}
```

---

### ✅ 実行例

```ruby
daily_temperatures([73,74,75,71,69,72,76,73])
# => [1,1,4,2,1,1,0,0]
```

---

### 🔥 補足：なぜ O(n) で済むの？

- 各要素は最大 1 回スタックに入り、1 回出るだけ → O(n)
- 無駄な探索をスタックで避けている（逆向きに見るのがコツ）
