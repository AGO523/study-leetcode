### ✅ 問題の日本語訳

`tokens` は **逆ポーランド記法（Reverse Polish Notation: RPN）** の算術式を表す文字列の配列です。

この式を評価して、**整数値** を返してください。

---

### 🔍 問題の概要と考え方

#### 🔢 逆ポーランド記法（RPN）とは？

逆ポーランド記法では **演算子が後に来る** 形式です。スタック（LIFO）を使って処理するのが基本です。

たとえば:

```
["2", "1", "+", "3", "*"]
→ ((2 + 1) * 3) = 9
```

#### 💡 解法のステップ（スタック使用）：

1. スタックを初期化
2. tokens を左から順に処理
   - 数字ならスタックに積む
   - 演算子なら、スタックから 2 つ値を取り出し、計算し、結果をスタックに戻す
3. 最後にスタックに残るのが答え

#### ⚠️ 割り算の注意点：

整数同士の割り算では **ゼロ方向への切り捨て（truncation toward zero）** を行う必要があります。

---

### 🧠 Ruby での実装 + 初心者向け解説付き

```ruby
def eval_rpn(tokens)
  stack = []

  tokens.each do |token|
    if %w[+ - * /].include?(token)
      b = stack.pop
      a = stack.pop

      result = case token
               when "+" then a + b
               when "-" then a - b
               when "*" then a * b
               when "/" then (a.to_f / b).truncate  # 小数→整数、ゼロ方向切り捨て
               end

      stack.push(result)
    else
      stack.push(token.to_i)
    end
  end

  stack.pop
end
```

#### 📝 初心者向け解説

- `stack` は数字を一時的に保持する配列です。
- `token` が演算子なら、2 つ取り出して計算
- `token` が数字なら、整数に変換して `stack` に保存
- `/` は `to_f` で小数にしてから `truncate` でゼロ方向切り捨て（`-1.9` → `-1`）

---

### 🟦 TypeScript での実装

```ts
function evalRPN(tokens: string[]): number {
  const stack: number[] = [];

  for (const token of tokens) {
    if (["+", "-", "*", "/"].includes(token)) {
      const b = stack.pop()!;
      const a = stack.pop()!;

      let result: number;
      switch (token) {
        case "+":
          result = a + b;
          break;
        case "-":
          result = a - b;
          break;
        case "*":
          result = a * b;
          break;
        case "/":
          result = Math.trunc(a / b);
          break; // ゼロ方向切り捨て
      }

      stack.push(result);
    } else {
      stack.push(parseInt(token, 10));
    }
  }

  return stack.pop()!;
}
```

---

### 🟩 Go での実装

```go
import "strconv"

func evalRPN(tokens []string) int {
    stack := []int{}

    for _, token := range tokens {
        switch token {
        case "+", "-", "*", "/":
            b := stack[len(stack)-1]
            a := stack[len(stack)-2]
            stack = stack[:len(stack)-2]

            var result int
            switch token {
            case "+": result = a + b
            case "-": result = a - b
            case "*": result = a * b
            case "/": result = a / b  // Goの整数除算は自動的にゼロ方向に切り捨て
            }

            stack = append(stack, result)
        default:
            num, _ := strconv.Atoi(token)
            stack = append(stack, num)
        }
    }

    return stack[0]
}
```
