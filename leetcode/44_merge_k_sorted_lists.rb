# You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

# Merge all the linked-lists into one sorted linked-list and return it.

# 複数のリンクリスト lists が与えられます。各リンクリストは昇順にソートされています。これらのリンクリストをすべてマージして1つのソートされたリンクリストにし、それを返してください。



# Example 1:

# Input: lists = [[1,4,5],[1,3,4],[2,6]]
# Output: [1,1,2,3,4,4,5,6]
# Explanation: The linked-lists are:
# [
#   1->4->5,
#   1->3->4,
#   2->6
# ]
# merging them into one sorted list:
# 1->1->2->3->4->4->5->6
# Example 2:

# Input: lists = []
# Output: []
# Example 3:

# Input: lists = [[]]
# Output: []
 

# Constraints:

# k == lists.length
# 0 <= k <= 104
# 0 <= lists[i].length <= 500
# -104 <= lists[i][j] <= 104
# lists[i] is sorted in ascending order.
# The sum of lists[i].length will not exceed 104.

# 逐次比較によるマージを行います。この方法では、各リストの先頭を逐次比較し、最小の要素を持つノードを結果のリンクリストに追加していきます。

# 解法の概要
# 各リンクリストの先頭ノードを比較し、最小のノードを選びます。
# 選ばれたノードを結果のリンクリストに追加します。
# 選ばれたノードの次のノードを比較の対象に含め、再び最小のノードを選びます。
# すべてのリンクリストが空になるまでこれを繰り返します。

# ListNodeクラスの定義
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

class LRUCache
  def merge_k_lists(lists)
    # ダミーのヘッドノードを作成
    dummy = ListNode.new
    current = dummy

    # リストが空でない限りループ
    while lists.any? { |node| !node.nil? }
      # 最小値を持つノードを見つける
      min_node_index = nil
      min_value = Float::INFINITY

      lists.each_with_index do |node, index|
        if node && node.val < min_value
          min_value = node.val
          min_node_index = index
        end
      end

      # 最小値を持つノードを結果リストに追加
      min_node = lists[min_node_index]
      current.next = min_node
      current = current.next

      puts "Added node with value #{min_node.val} to merged list"

      # 最小値のノードの次のノードを指すように更新
      lists[min_node_index] = min_node.next
    end

    dummy.next  # マージされたリストのヘッドを返す
  end
end

# 使用例
lists = [
  ListNode.new(1, ListNode.new(4, ListNode.new(5))),
  ListNode.new(1, ListNode.new(3, ListNode.new(4))),
  ListNode.new(2, ListNode.new(6))
]

cache = LRUCache.new
merged_head = cache.merge_k_lists(lists)

# マージされたリストを出力
current = merged_head
while current
  puts current.val
  current = current.next
end


# def merge_k_lists(lists)
#   # Prepare answer list
#   head = ListNode.new
#   tail = head
  
#   # Remove empty list first
#   lists.delete_if { |list| list.nil? }
  
#   # Sort list from min to max
#   lists.sort_by! { |list| list.val }
  
#   while !lists.empty?
#     # Get min node from left of array
#     min_node = lists.shift
    
#     # Add to answer list
#     tail.next = min_node
#     tail = tail.next
    
#     # Prepare next node
#     new_list = min_node.next
#     next if new_list.nil?

#     # Want to insert next node into sorted array at correct index to keep it still a sorted array
#     # Then we can still shift min node from left in next run
#     # Using bsearch on a sorted array is very fast
#     insert_at = lists.bsearch_index { |list| list.val >= new_list.val }
#     if insert_at.nil?
#       lists.push(new_list)
#     else
#       lists.insert(insert_at, new_list)
#     end
#   end
  
#   head.next
# end
