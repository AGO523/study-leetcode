# Given head, the head of a linked list, determine if the linked list has a cycle in it.

# There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

# Return true if there is a cycle in the linked list. Otherwise, return false.

# リンクリストの先頭ノード head が与えられたとき、そのリンクリストにサイクル（循環）が存在するかどうかを判断しなさい。

# リンクリストにサイクルがあるというのは、リスト内のあるノードに対して、次のポインタをたどっていくと再びそのノードに戻ってこれる場合を指します。問題内で使用される pos は、テールの次のポインタが接続されているノードのインデックスを示します。ただし、pos は入力として渡されません。

# リンクリストにサイクルが存在する場合は true を、存在しない場合は false を返しなさい。

# Example 1:


# Input: head = [3,2,0,-4], pos = 1
# Output: true
# Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).
# Example 2:


# Input: head = [1,2], pos = 0
# Output: true
# Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.
# Example 3:


# Input: head = [1], pos = -1
# Output: false
# Explanation: There is no cycle in the linked list.
 

# Constraints:

# The number of the nodes in the list is in the range [0, 104].
# -105 <= Node.val <= 105
# pos is -1 or a valid index in the linked-list.
 

# Follow up: Can you solve it using O(1) (i.e. constant) memory?


# この問題を解決するために、2つのポインタを使った「フロイドのサイクル検出アルゴリズム」（別名「トータスとヘア」アルゴリズム）を使用します。このアルゴリズムでは、1つのポインタを1ステップずつ進め、もう1つのポインタを2ステップずつ進めます。もしサイクルが存在する場合、2つのポインタは最終的に同じノードで交差します。

# 単方向リンクリストのノードを定義
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# リンクリストにサイクルが存在するかを判断する関数
def has_cycle(head)
  slow = head  # 1ステップずつ進むポインタ
  fast = head  # 2ステップずつ進むポインタ

  # 2つのポインタがリンクリストを走査する
  while fast && fast.next
    slow = slow.next  # slowは1ステップ進む
    fast = fast.next.next  # fastは2ステップ進む

    puts "Slow is at node with value #{slow.val}" if slow
    puts "Fast is at node with value #{fast.val}" if fast

    # slowとfastが同じノードを指していればサイクルがある
    if slow == fast
      puts "Cycle detected at node with value #{slow.val}"
      return true
    end
  end

  # fastがリストの末尾に到達した場合、サイクルは存在しない
  puts "No cycle detected in the list"
  return false
end

# 使用例

# リストを作成
node1 = ListNode.new(3)
node2 = ListNode.new(2)
node3 = ListNode.new(0)
node4 = ListNode.new(-4)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node2  # サイクルを作成

puts "Checking for cycle in the list:"
has_cycle(node1)
