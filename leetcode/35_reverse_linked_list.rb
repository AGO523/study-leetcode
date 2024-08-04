# Given the head of a singly linked list, reverse the list, and return the reversed list.

# 単方向リンクリストの先頭ノード head が与えられたとき、リストを逆順にし、逆順にしたリストを返してください。

# Example 1:


# Input: head = [1,2,3,4,5]
# Output: [5,4,3,2,1]
# Example 2:


# Input: head = [1,2]
# Output: [2,1]
# Example 3:

# Input: head = []
# Output: []
 

# Constraints:

# The number of nodes in the list is the range [0, 5000].
# -5000 <= Node.val <= 5000


# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
      @val = val
      @next = _next
  end
end

# @param {ListNode} head
# @return {ListNode}
def reverse_list(head)
previous = nil
current = head

while current
  # 現在のノードの値を出力
  puts "Reversing node with value: #{current.val}"

  next_node = current.next
  current.next = previous
  previous = current
  current = next_node

  # 逆転後のリストの先頭の値を出力
  if previous
    puts "Previous node is now: #{previous.val}"
  else
    puts "Previous node is now: nil"
  end
end

previous
end

# リストを配列から生成するヘルパー関数
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

# リストを配列に変換するヘルパー関数
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
input = [1, 2, 3, 4, 5]
head = create_linked_list(input)
puts "Original list: #{linked_list_to_array(head)}"

reversed_head = reverse_list(head)
puts "Reversed list: #{linked_list_to_array(reversed_head)}"
