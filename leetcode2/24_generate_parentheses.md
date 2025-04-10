### ✅ 問題の日本語訳

`n` 個の括弧のペアが与えられたとき、**正しく対応が取れた全ての括弧の組み合わせ**を生成してください。

---

### 🔍 問題の概要と考え方

#### ❓「正しく対応が取れた」とは？

- 開き括弧 `(` は、対応する閉じ括弧 `)` とペアになっている必要がある
- 途中で閉じすぎてはいけない（例: `())(` は NG）

#### 💡 解法：**バックトラッキング（再帰）**

`(left, right)` の残りの数を持ちながら、再帰的に文字列を構築していきます。

- `left` > 0 のとき → `(` を追加
- `right` > `left` のとき → `)` を追加（開き括弧の数より多く閉じないようにする）

---

## 🧠 Ruby 実装（初心者向け解説付き）

```ruby
def generate_parenthesis(n)
  result = []

  def backtrack(current, left, right, result)
    if left == 0 && right == 0
      result << current
      return
    end

    if left > 0
      backtrack(current + "(", left - 1, right, result)
    end

    if right > left
      backtrack(current + ")", left, right - 1, result)
    end
  end

  backtrack("", n, n, result)
  result
end

backtrack("", 3, 3)
└── "(" → backtrack("(", 2, 3)
    └── "(" → backtrack("((", 1, 3)
        └── "(" → backtrack("(((", 0, 3)
            └── ")" → backtrack("((()", 0, 2)
                └── ")" → backtrack("((())", 0, 1)
                    └── ")" → backtrack("((()))", 0, 0) ✅ 完成！

        └── ")" → backtrack("(()", 1, 2)
            └── "(" → backtrack("(()(", 0, 2)
                └── ")" → backtrack("(()()", 0, 1)
                    └── ")" → backtrack("(()())", 0, 0) ✅ 完成！

            └── ")" → backtrack("(())", 1, 1)
                └── ")" → backtrack("(())(", 0, 1)
                    └── ")" → backtrack("(())()", 0, 0) ✅ 完成！

    └── ")" → backtrack("()", 2, 2)
        └── "(" → backtrack("()(", 1, 2)
            └── "(" → backtrack("()((", 0, 2)
                └── ")" → backtrack("()(()", 0, 1)
                    └── ")" → backtrack("()(())", 0, 0) ✅ 完成！

            └── ")" → backtrack("()()", 1, 1)
                └── ")" → backtrack("()()(", 0, 1)
                    └── ")" → backtrack("()()()", 0, 0) ✅ 完成！

```

### 📘 初心者向けの解説：

- `current`: 今作っている括弧の文字列
- `left`, `right`: 残っている `(`, `)` の数
- `left > 0` のとき → 開き括弧 `(` を追加して再帰
- `right > left` のとき → 閉じ括弧 `)` を追加して再帰
- 最後に `left == 0 && right == 0` になったら完成 → 結果に追加

---

## 🟦 TypeScript 実装

```ts
function generateParenthesis(n: number): string[] {
  const result: string[] = [];

  function backtrack(current: string, left: number, right: number) {
    if (left === 0 && right === 0) {
      result.push(current);
      return;
    }

    if (left > 0) {
      backtrack(current + "(", left - 1, right);
    }

    if (right > left) {
      backtrack(current + ")", left, right - 1);
    }
  }

  backtrack("", n, n);
  return result;
}
```

---

## 🟩 Go 実装

```go
func generateParenthesis(n int) []string {
    var result []string

    var backtrack func(current string, left int, right int)
    backtrack = func(current string, left int, right int) {
        if left == 0 && right == 0 {
            result = append(result, current)
            return
        }

        if left > 0 {
            backtrack(current + "(", left-1, right)
        }

        if right > left {
            backtrack(current + ")", left, right-1)
        }
    }

    backtrack("", n, n)
    return result
}
```

---

### ✅ テスト例

```ruby
generate_parenthesis(3)
# => ["((()))", "(()())", "(())()", "()(())", "()()()"]
```
