この問題は、**リンクリストのノード順序を特定のパターンに再配置**する問題です。

---

## 🇯🇵 問題の概要（日本語訳）

単方向リンクリスト `head` が与えられます。

```
元の順序:      L0 → L1 → L2 → … → Ln
再配置の順序:  L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …
```

### ❗ 制約

- **ノードの値（val）を変更してはいけない。**
- **ノードの参照（next）だけで再配置する必要あり。**

---

## 🧠 解法の流れ

リンクリストを 3 ステップで処理します：

### ✅ ステップ 1: リストの中央を見つける（2 ポインタ）

- `slow` と `fast` を使って中央ノードを特定（Tortoise & Hare）

### ✅ ステップ 2: 後半部分を反転

- 中央の次ノードから先を**反転**して、末尾 → 中央にする。

### ✅ ステップ 3: 前半と後半を交互にマージ

- 前半 `1 → 2 → 3` と、反転後の後半 `6 → 5 → 4` を交互に並べる。

---

## ✅ Ruby 実装（初心者向け詳しいコメント付き）

```ruby
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def reorder_list(head)
  return if head.nil? || head.next.nil?

  # === Step 1: 中間地点を探す ===
  slow = head
  fast = head

  while fast && fast.next
    slow = slow.next
    fast = fast.next.next
  end

  # === Step 2: 後半を反転 ===
  prev = nil
  curr = slow.next
  slow.next = nil  # 前半と後半を分離

  while curr
    tmp = curr.next
    curr.next = prev
    prev = curr
    curr = tmp
  end

  # === Step 3: 前後を交互にマージ ===
  first = head
  second = prev

  while second
    tmp1 = first.next
    tmp2 = second.next

    first.next = second
    second.next = tmp1

    first = tmp1
    second = tmp2
  end
end
```

---

## 🧪 実行例

```ruby
# 入力 [1,2,3,4]
n4 = ListNode.new(4)
n3 = ListNode.new(3, n4)
n2 = ListNode.new(2, n3)
n1 = ListNode.new(1, n2)

reorder_list(n1)

# 出力を確認
def to_array(head)
  result = []
  while head
    result << head.val
    head = head.next
  end
  result
end

puts to_array(n1).inspect  # => [1, 4, 2, 3]
```

---

## 🧩 補足ポイント

| ステップ   | 方法               | 時間計算量 | 空間計算量 |
| ---------- | ------------------ | ---------- | ---------- |
| 中央を探す | 2 ポインタ         | O(n)       | O(1)       |
| 後半を反転 | ポインタの操作     | O(n)       | O(1)       |
| 交互に合体 | while でつなぎ直す | O(n)       | O(1)       |

---

## 💡 応用・関連問題

- 反転系の問題（`reverse_list`）
- 回文リストの判定（`is_palindrome`）
- K 個ずつ反転する問題（`reverse_k_group`）

---

TypeScript や Go のコードも必要であれば追加できます！  
また、配列からリンクリストを作るヘルパーや、リストを表示するコードもご提供可能です。どうしましょうか？
