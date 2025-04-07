### 📝 問題文の日本語訳

括弧 `'('`, `')'`, `'{'`, `'}'`, `'['`, `']'` のみからなる文字列 `s` が与えられます。

この文字列が「**正しいか**（valid）」どうかを判定してください。

### ✅ 正しい括弧の定義

1. 開き括弧は、**対応する閉じ括弧**で閉じられていること。
2. 括弧は**正しい順序で閉じられている**こと。
3. **各閉じ括弧には正しい開き括弧が 1 つだけ対応**していること。

---

## 🧠 考え方（初心者向け）

この問題は「**スタック（Stack）**」というデータ構造を使って解くのが定番です。

### Stack とは？

- **後から入れたものを先に取り出す（LIFO）** 形式
- 括弧の開き → 閉じに対応させるのにピッタリ！

---

## 💡 アルゴリズムの流れ（初心者向け）

1. 開き括弧 `'('`, `'['`, `'{'` が来たら、**スタックに入れる**
2. 閉じ括弧 `')'`, `']'`, `'}'` が来たら：

   - スタックが空だったら `false`（対応する開き括弧がない）
   - スタックの一番上の要素と**対応しているか確認**
   - 合っていなければ `false`
   - 合っていればポップ（スタックから削除）

3. 最後にスタックが空であれば `true`、残っていたら `false`

---

## ✅ Ruby の実装とやさしい解説

```ruby
def is_valid(s)
  stack = []
  pairs = {
    ')' => '(',
    ']' => '[',
    '}' => '{'
  }

  s.each_char do |char|
    if pairs.values.include?(char)
      stack.push(char)  # 開き括弧なら積む
    else
      return false if stack.empty? || stack.pop != pairs[char]
    end
  end

  stack.empty?
end
```

### 🔍 解説

- `pairs` で閉じ括弧に対応する開き括弧をマップで定義。
- スタックで開き括弧を記録。
- 閉じ括弧が出たとき、スタックの一番上とマッチしているか確認。
- 最後に `stack.empty?` で、すべて正しく対応していたか判断。

---

## 🧪 TypeScript 版

```ts
function isValid(s: string): boolean {
  const stack: string[] = [];
  const pairs: { [key: string]: string } = {
    ")": "(",
    "]": "[",
    "}": "{",
  };

  for (const char of s) {
    if (Object.values(pairs).includes(char)) {
      stack.push(char);
    } else {
      if (stack.length === 0 || stack.pop() !== pairs[char]) {
        return false;
      }
    }
  }

  return stack.length === 0;
}
```

---

## 🧰 Go 版

```go
func isValid(s string) bool {
    stack := []rune{}
    pairs := map[rune]rune{
        ')': '(',
        ']': '[',
        '}': '{',
    }

    for _, char := range s {
        if char == '(' || char == '[' || char == '{' {
            stack = append(stack, char)
        } else {
            if len(stack) == 0 || stack[len(stack)-1] != pairs[char] {
                return false
            }
            stack = stack[:len(stack)-1] // pop
        }
    }

    return len(stack) == 0
}
```

---

## 🎯 例を通して理解

| 入力      | スタックの動き                 | 出力    |
| --------- | ------------------------------ | ------- |
| `()`      | `(` → pop with `)`             | `true`  |
| `()[]{} ` | `(` → pop, `[` → pop...        | `true`  |
| `(]`      | `(` → `]` で不一致             | `false` |
| `([)]`    | `(` → `[` → `)` → `]` mismatch | `false` |
| `([])`    | `(` → `[` → pop `]` → pop `)`  | `true`  |
