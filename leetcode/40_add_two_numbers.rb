# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

#   2つの非空のリンクリストが与えられ、それぞれが非負の整数を表しています。桁は逆順に格納されており、それぞれのノードには1桁の数字が含まれています。2つの数値を加算し、その合計をリンクリストとして返してください。

#   なお、2つの数には、数値 0 自体を除いて、先頭にゼロが含まれていないと仮定して構いません。

# Example 1:


# Input: l1 = [2,4,3], l2 = [5,6,4]
# Output: [7,0,8]
# Explanation: 342 + 465 = 807.
# Example 2:

# Input: l1 = [0], l2 = [0]
# Output: [0]
# Example 3:

# Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
# Output: [8,9,9,9,0,0,0,1]
 

# Constraints:

# The number of nodes in each linked list is in the range [1, 100].
# 0 <= Node.val <= 9
# It is guaranteed that the list represents a number that does not have leading zeros.

# 解答
# この問題を解決するためには、リンクリストの各ノードを順にたどり、対応する桁の数値を加算し、繰り上がりがある場合は次の桁に繰り越します。全ての桁の加算が完了したら、結果のリンクリストを返します。

# 単方向リンクリストのノードを定義
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# 2つのリンクリストの数値を加算し、結果を新しいリンクリストとして返す関数
def add_two_numbers(l1, l2)
  dummy_head = ListNode.new(0)  # 結果のリンクリストを構築するためのダミーヘッドノード
  current = dummy_head  # 現在のノードを指すポインタ
  carry = 0  # 繰り上がりを保持する変数

  # l1またはl2が存在する限りループ
  while l1 || l2
    val1 = l1 ? l1.val : 0  # l1が存在する場合はその値を取得し、存在しない場合は0とする
    val2 = l2 ? l2.val : 0  # l2が存在する場合はその値を取得し、存在しない場合は0とする

    sum = val1 + val2 + carry  # 2つの値と繰り上がりを加算
    carry = sum / 10  # 繰り上がりを計算(10以上の場合は1、それ以外は0)

    current.next = ListNode.new(sum % 10)  # 結果の桁を新しいノードとしてリンクリストに追加
    current = current.next  # 現在のノードを次に進める

    # l1とl2を次のノードに進める
    l1 = l1.next if l1
    l2 = l2.next if l2

    # 経過を出力
    puts "Adding digits: #{val1} + #{val2} + carry #{carry}, new digit: #{current.val}, next carry: #{carry}"
  end

  # 最後に繰り上がりが残っている場合、新しいノードを追加
  if carry > 0
    current.next = ListNode.new(carry)
    puts "Final carry: Adding new node with value #{carry}"
  end

  dummy_head.next  # ダミーヘッドの次のノードが結果のリストの先頭
end

# 簡単なリストの生成と出力
def print_list(head)
  current = head
  while current
    print "#{current.val} -> "
    current = current.next
  end
  puts "nil"
end

# 使用例
l1 = ListNode.new(2, ListNode.new(4, ListNode.new(3)))
l2 = ListNode.new(5, ListNode.new(6, ListNode.new(4)))

puts "List 1:"
print_list(l1)

puts "List 2:"
print_list(l2)

result = add_two_numbers(l1, l2)

puts "Result:"
print_list(result)
