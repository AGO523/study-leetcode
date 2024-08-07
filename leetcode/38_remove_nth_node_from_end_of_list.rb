# Given the head of a linked list, remove the nth node from the end of the list and return its head.

# リンクリストの先頭ノード head が与えられたとき、リストの末尾から数えて n 番目のノードを削除し、その先頭ノードを返しなさい。

# Example 1:


# Input: head = [1,2,3,4,5], n = 2
# Output: [1,2,3,5]
# Example 2:

# Input: head = [1], n = 1
# Output: []
# Example 3:

# Input: head = [1,2], n = 1
# Output: [1]
 

# Constraints:

# The number of nodes in the list is sz.
# 1 <= sz <= 30
# 0 <= Node.val <= 100
# 1 <= n <= sz

# 解答
# この問題を解決するために、以下の手順を取ります：

# ダミーノードを作成:

# 先頭ノードを扱いやすくするために、ダミーノードを作成します。
# 先行ポインタと後行ポインタを設定:

# fast と slow の2つのポインタを設定し、fast ポインタをリストの先頭から n ステップ進めます。
# ポインタを進める:

# fast と slow ポインタを同時に進め、fast がリストの末尾に達したときに slow が削除すべきノードの直前のノードを指すようにします。
# ノードを削除:

# slow.next を更新し、指定されたノードを削除します。

# 単方向リンクリストのノードを定義
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# リストの末尾からn番目のノードを削除する関数
def remove_nth_from_end(head, n)
  # ステップ1: ダミーノードを作成
  # [0, 1, 2, 3, 4, 5] が作成される
  dummy = ListNode.new(0, head)
  # ダミーノードの値は重要ではない:
  # ダミーノードの値は、操作を簡素化するためのものであり、リストの値には影響しません。
  # 一般的に 0 を使うことが多いですが、任意の値を使用しても構いません。

  fast = dummy
  slow = dummy

  # ステップ2: fastポインタをリストの先頭からnステップ進める
  n.times do
    fast = fast.next
  end
  puts "Fast pointer moved #{n} steps ahead: #{fast.val}"

  # ステップ3: fastとslowポインタを同時に進める
  while fast.next
    fast = fast.next
    slow = slow.next
    puts "Fast pointer at: #{fast.val}, Slow pointer at: #{slow.val}"
  end

  # ステップ4: ノードを削除
  # slow.next = slow.next.next でノードを削除できるのは、リンクリストのノードを直接削除するのではなく、ノード間のリンクを変更することによって削除を実現しているためです。これにより、削除対象のノードがリストから除外され、その前後のノードが直接つながるようになります。
  puts "Node to be removed: #{slow.next.val}"
  slow.next = slow.next.next

  # 最終的なリストの状態を出力
  puts "Updated list: #{linked_list_to_array(dummy.next)}"

  # ダミーノードの次のノードを返す
  dummy.next
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
list = create_linked_list([1, 2, 3, 4, 5])
puts "Original list: #{linked_list_to_array(list)}"

head = remove_nth_from_end(list, 2)
puts "List after removing 2nd from end: #{linked_list_to_array(head)}"
