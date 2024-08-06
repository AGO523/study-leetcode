# You are given the head of a singly linked-list. The list can be represented as:

# L0 → L1 → … → Ln - 1 → Ln
# Reorder the list to be on the following form:

# L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
# You may not modify the values in the list's nodes. Only nodes themselves may be changed.

#  単方向リンクリストの先頭ノード head が与えられます。このリストは次のように表現できます：

# コードをコピーする
# L0 → L1 → … → Ln-1 → Ln
# リストを次の形式に並べ替えてください：

# コードをコピーする
# L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …
# リストのノードの値を変更することはできません。ノード自体のみを変更することが許されています。

# Example 1:


# Input: head = [1,2,3,4]
# Output: [1,4,2,3]
# Example 2:


# Input: head = [1,2,3,4,5]
# Output: [1,5,2,4,3]
 

# Constraints:

# The number of nodes in the list is in the range [1, 5 * 104].
# 1 <= Node.val <= 1000

# 解答
# この問題を解決するために、次の手順を取ります：

# リストの中間点を見つける：

# 2つのポインタを使用してリストの中間点を見つけます。
# リストを2つに分割する：

# 中間点でリストを2つに分割します。
# 後半部分を逆順にする：

# 後半部分のリンクリストを逆順にします。
# 2つのリストを交互にマージする：

# 2つのリストを交互にノードを取り出してマージします。

# 単方向リンクリストのノードを定義
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# リストを再配置する関数
def reorder_list(head)
  return if head.nil? || head.next.nil?

  # ステップ1: リストの中間点を見つける
  slow, fast = head, head
  # fast が nil になるまで進める（リンクリストの最後の値を fast.next がこえるまで）
  # while fast && fast.next という条件は、リンクリストの中間点を見つけるために使用されるもので、2つのポインタを使った手法（通称「2ポインタ法」または「タートル＆ヘアー法」）を実装しています。この条件は次のような理由から設定されています：

  #   目的
  #   リンクリストの中間点を見つけることが目的です。slow ポインタは1ステップずつ進み、fast ポインタは2ステップずつ進みます。fast ポインタがリストの終端に達する頃には、slow ポインタはリストの中間点に達しています。
  while fast && fast.next
    slow = slow.next
    fast = fast.next.next
  end
  puts "Middle node found at value: #{slow.val}"

  # ステップ2: リストを2つに分割する
  second_half = slow.next
  # node なので↑でノードリストが取得できる
  # second_half: #<ListNode:0x00007f8a58897b48>

  slow.next = nil

  # ステップ3: 後半部分を逆順にする
  prev, current = nil, second_half
  while current
    next_node = current.next
    current.next = prev
    prev = current
    current = next_node
  end
  second_half = prev

  # 現在の状態を出力
  puts "First half: #{linked_list_to_array(head)}"
  puts "Reversed second half: #{linked_list_to_array(second_half)}"

  # ステップ4: 2つのリストを交互にマージする
  first, second = head, second_half
  while second
    temp1, temp2 = first.next, second.next
    first.next = second
    second.next = temp1
    first, second = temp1, temp2

    # 現在のマージ状況を出力
    puts "Current reordered list: #{linked_list_to_array(head)}"
  end
end

# 配列からリンクリストを生成するヘルパー関数
def create_linked_list(array)
  return nil if array.empty?

  head = ListNode.new(array[0])
  current = head

  array[1..-1].each do |value|
    current.next = ListNode.new(value)
    current = current.next
  end

  head
end

# リンクリストを配列に変換するヘルパー関数
def linked_list_to_array(head)
  array = []
  current = head

  while current
    array << current.val
    current = current.next
  end

  array
end

# 使用例
list = create_linked_list([1, 2, 3, 4, 5, 6, 7])
puts "Original list: #{linked_list_to_array(list)}"

reorder_list(list)
puts "Reordered list: #{linked_list_to_array(list)}"
