この問題は「**2 つのソート済みリンクリストをマージして 1 つのソート済みリストを作る**」という、非常に基本かつ重要な問題です。  
再帰やループの理解、ポインタ操作の練習にぴったりです。

---

## 🇯🇵 問題の概要（日本語訳）

2 つの **ソート済みの単方向リンクリスト** `list1`, `list2` が与えられます。  
これらを 1 つの **ソート済みリンクリストに結合（マージ）** して、その **先頭ノード（head）** を返してください。

---

## ✅ 解法の考え方（マージ処理）

### 💡 ポイント：

- それぞれのリストの「現在のノードの値」を比較して、小さい方をマージ先に追加。
- `list1.val < list2.val` なら `list1` をつなぐ。そうでなければ `list2`。
- どちらかが `nil` になったら、残りのリストをそのままつなげば OK。

---

## 🧠 アルゴリズム（反復法）

### ステップ：

1. ダミーの先頭ノード `dummy` を作る。
2. `tail` ポインタでマージ後のリストを作る。
3. `list1` と `list2` のノードを比較して、小さい方を `tail.next` に設定。
4. `tail` を一つ進め、比較対象も進める。
5. どちらかが終わったら、残りをつなげる。

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

def merge_two_lists(list1, list2)
  # ダミーヘッドを作って簡単に操作できるようにする
  dummy = ListNode.new
  tail = dummy

  # どちらかが nil になるまでループ
  while list1 && list2
    if list1.val < list2.val
      tail.next = list1   # list1の方が小さければそれを選ぶ
      list1 = list1.next
    else
      tail.next = list2   # list2の方が小さければそれを選ぶ
      list2 = list2.next
    end
    tail = tail.next      # 次に進める
  end

  # どちらかが残っていればつなげる
  tail.next = list1 || list2

  dummy.next  # 実際の先頭は dummy.next
end
```

---

## 🟦 TypeScript 実装

```ts
class ListNode {
  val: number;
  next: ListNode | null;
  constructor(val?: number, next?: ListNode | null) {
    this.val = val ?? 0;
    this.next = next ?? null;
  }
}

function mergeTwoLists(
  list1: ListNode | null,
  list2: ListNode | null
): ListNode | null {
  const dummy = new ListNode();
  let tail = dummy;

  while (list1 && list2) {
    if (list1.val < list2.val) {
      tail.next = list1;
      list1 = list1.next;
    } else {
      tail.next = list2;
      list2 = list2.next;
    }
    tail = tail.next;
  }

  tail.next = list1 ?? list2;
  return dummy.next;
}
```

---

## 🟨 Go 実装

```go
type ListNode struct {
    Val  int
    Next *ListNode
}

func mergeTwoLists(list1 *ListNode, list2 *ListNode) *ListNode {
    dummy := &ListNode{}
    tail := dummy

    for list1 != nil && list2 != nil {
        if list1.Val < list2.Val {
            tail.Next = list1
            list1 = list1.Next
        } else {
            tail.Next = list2
            list2 = list2.Next
        }
        tail = tail.Next
    }

    if list1 != nil {
        tail.Next = list1
    } else {
        tail.Next = list2
    }

    return dummy.Next
}
```

---

## 🧩 補足：再帰でも解ける！

```ruby
def merge_two_lists(list1, list2)
  return list2 if list1.nil?
  return list1 if list2.nil?

  if list1.val < list2.val
    list1.next = merge_two_lists(list1.next, list2)
    list1
  else
    list2.next = merge_two_lists(list1, list2.next)
    list2
  end
end
```
