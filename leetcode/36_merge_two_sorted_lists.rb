# You are given the heads of two sorted linked lists list1 and list2.

# Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.

# Return the head of the merged linked list.

# 2つのソートされたリンクリスト list1 と list2 の先頭ノードが与えられます。

# この2つのリストを1つのソートされたリストにマージしなさい。このリストは、最初の2つのリストのノードをつなげて作られるべきです。

# マージされたリンクリストの先頭ノードを返しなさい。
 

# Example 1:


# Input: list1 = [1,2,4], list2 = [1,3,4]
# Output: [1,1,2,3,4,4]
# Example 2:

# Input: list1 = [], list2 = []
# Output: []
# Example 3:

# Input: list1 = [], list2 = [0]
# Output: [0]
 

# Constraints:

# The number of nodes in both lists is in the range [0, 50].
# -100 <= Node.val <= 100
# Both list1 and list2 are sorted in non-decreasing order.

# 2つのソートされたリンクリストをマージするために、以下の手順を取ります：

# 新しいリンクリストのダミーヘッドを作成します。
# ダミーヘッドを使用して、新しいリンクリストのノードを順番に追加していきます。
# list1 と list2 のどちらかが nil になるまで、各ノードを比較し、小さい方のノードを新しいリストに追加します。
# list1 または list2 のいずれかに残ったノードを新しいリストに追加します。


# 単方向リンクリストのノードを定義
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# 2つのソートされたリンクリストをマージする関数
def merge_two_lists(list1, list2)
  # ダミーヘッドを作成
  dummy_head = ListNode.new(0)
  current = dummy_head

  # list1とlist2のノードを比較しながら新しいリストを作成
  while list1 && list2
    if list1.val <= list2.val
      current.next = list1
      list1 = list1.next
    else
      current.next = list2
      list2 = list2.next
    end
    current = current.next
    puts "Current merged list: #{linked_list_to_array(dummy_head.next)}"
  end

  # list1またはlist2に残ったノードを追加
  current.next = list1 ? list1 : list2

  # 最終的なマージされたリストの状態を出力
  puts "Final merged list: #{linked_list_to_array(dummy_head.next)}"

  # ダミーヘッドの次のノードを返す
  dummy_head.next
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
list1 = create_linked_list([1, 2, 4])
list2 = create_linked_list([1, 3, 4])
puts "Original list1: #{linked_list_to_array(list1)}"
puts "Original list2: #{linked_list_to_array(list2)}"

merged_head = merge_two_lists(list1, list2)
puts "Merged list: #{linked_list_to_array(merged_head)}"

# merge_two_lists 関数:

# dummy_head を作成して、新しいリンクリストの先頭を簡単に操作できるようにします。
# list1 と list2 のノードを順番に比較し、小さい方のノードを新しいリストに追加します。
# 各ステップで現在のマージされたリストの状態を puts で出力します。
# list1 または list2 に残ったノードを新しいリストに追加します。
# 最終的なマージされたリストの状態を puts で出力します。
