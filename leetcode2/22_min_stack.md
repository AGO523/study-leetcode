この問題は「**最小値を O(1)で取り出せる Stack**」を設計するというアルゴリズムの定番問題です。  
普通のスタックに `getMin` 機能を追加すると、**一番小さい値を探すのに O(n)** かかってしまいます。

---

## 🧠 解法のアイデア（初心者向け）

### 💡 ポイント：

**最小値を追跡する用のスタック（補助スタック）を別に用意する！**

### 🎯 2 つのスタックを使う：

| スタック    | 内容                   |
| ----------- | ---------------------- |
| `stack`     | 通常の値を管理         |
| `min_stack` | 現在の最小値を常に管理 |

---

### ✅ 操作の動き：

- `push(x)`：
  - 通常の `stack` に `x` を追加
  - `min_stack` の一番上の値と `x` を比較して、**小さい方を `min_stack` にも追加**
- `pop()`：
  - `stack` と `min_stack` の両方から `pop`
- `top()`：
  - `stack[-1]` を返す
- `getMin()`：
  - `min_stack[-1]` を返す（今の最小値）

---

## ✅ Ruby 実装（初心者向け解説つき）

```ruby
class MinStack
  def initialize
    @stack = []
    @min_stack = []
  end

  def push(val)
    @stack << val
    min = @min_stack.empty? ? val : [val, @min_stack.last].min
    @min_stack << min
  end

  def pop
    @stack.pop
    @min_stack.pop
  end

  def top
    @stack.last
  end

  def get_min
    @min_stack.last
  end
end
```

---

## ✅ TypeScript 実装

```ts
class MinStack {
  private stack: number[] = [];
  private minStack: number[] = [];

  push(val: number): void {
    this.stack.push(val);
    const min =
      this.minStack.length === 0
        ? val
        : Math.min(val, this.minStack[this.minStack.length - 1]);
    this.minStack.push(min);
  }

  pop(): void {
    this.stack.pop();
    this.minStack.pop();
  }

  top(): number {
    return this.stack[this.stack.length - 1];
  }

  getMin(): number {
    return this.minStack[this.minStack.length - 1];
  }
}
```

---

## ✅ Go 実装

```go
type MinStack struct {
    stack    []int
    minStack []int
}

func Constructor() MinStack {
    return MinStack{
        stack:    []int{},
        minStack: []int{},
    }
}

func (this *MinStack) Push(val int) {
    this.stack = append(this.stack, val)
    min := val
    if len(this.minStack) > 0 && this.minStack[len(this.minStack)-1] < val {
        min = this.minStack[len(this.minStack)-1]
    }
    this.minStack = append(this.minStack, min)
}

func (this *MinStack) Pop() {
    this.stack = this.stack[:len(this.stack)-1]
    this.minStack = this.minStack[:len(this.minStack)-1]
}

func (this *MinStack) Top() int {
    return this.stack[len(this.stack)-1]
}

func (this *MinStack) GetMin() int {
    return this.minStack[len(this.minStack)-1]
}
```

---

## 🧪 操作の手順シミュレーション

```text
push(-2) → stack: [-2]       min_stack: [-2]
push(0)  → stack: [-2, 0]    min_stack: [-2, -2]
push(-3) → stack: [-2, 0, -3] min_stack: [-2, -2, -3]

getMin() → -3

pop() → stack: [-2, 0]       min_stack: [-2, -2]

top() → 0

getMin() → -2
```

---

## 📘 まとめ

| 操作     | 時間計算量 |
| -------- | ---------- |
| `push`   | O(1)       |
| `pop`    | O(1)       |
| `top`    | O(1)       |
| `getMin` | O(1)       |

---
