# Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

# k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

# You may not alter the values in the list's nodes, only nodes themselves may be changed.

# リンクリストの先頭を表す head が与えられます。リンクリストのノードを k 個ずつ反転し、変更されたリストを返してください。

# k は正の整数であり、リンクリストの長さ以下です。ノードの数が k の倍数でない場合、残ったノードはそのままの順序で保持される必要があります。

# リンクリストのノードの値を変更してはならず、ノードそのものを変更する必要があります。

# Example 1:


# Input: head = [1,2,3,4,5], k = 2
# Output: [2,1,4,3,5]
# Example 2:


# Input: head = [1,2,3,4,5], k = 3
# Output: [3,2,1,4,5]
 

# Constraints:

# The number of nodes in the list is n.
# 1 <= k <= n <= 5000
# 0 <= Node.val <= 1000


# 解答
# この問題は、リンクリストの一部を指定されたサイズ k ごとに反転させるものです。このためには、リンクリストを走査して、k 個のグループごとにノードを反転させます。

# 実装手順
# dummy ノードを作成し、それをリンクリストの前に追加します。これにより、リストの先頭を扱いやすくなります。
# k 個のノードを反転するために、リンクリストを進めていきます。各グループの終わりに到達したら、そのグループを反転させます。
# 残りのノードが k 未満の場合は、そのままの順序で残します。


class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

class Solution
  def reverse_k_group(head, k)
    dummy = ListNode.new(0)
    dummy.next = head
    group_prev = dummy

    loop do
      # k個のノードの終わりを探す
      kth = get_kth_node(group_prev, k)
      break if kth.nil?

      group_next = kth.next

      # k個のノードを反転
      prev, curr = kth.next, group_prev.next

      puts "Reversing the group starting with #{curr.val} up to #{kth.val}"

      while curr != group_next
        tmp = curr.next
        curr.next = prev
        prev = curr
        curr = tmp
      end

      tmp = group_prev.next
      group_prev.next = kth
      group_prev = tmp

      puts "Group reversed, moving to the next group"
    end

    dummy.next
  end

  # 現在のノードから k 番目のノードを見つけます。もし k 番目のノードが存在しない場合は、nil を返します。
  def get_kth_node(curr, k)
    while curr && k > 0
      curr = curr.next
      k -= 1
    end
    curr
  end
end

# 使用例
list = ListNode.new(1, ListNode.new(2, ListNode.new(3, ListNode.new(4, ListNode.new(5)))))
k = 2

solution = Solution.new
new_head = solution.reverse_k_group(list, k)

# マージされたリストを出力
current = new_head
while current
  puts current.val
  current = current.next
end
