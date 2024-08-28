# Given the root of a binary tree, determine if it is a valid binary search tree (BST).

# A valid BST is defined as follows:

# The left 
# subtree
#  of a node contains only nodes with keys less than the node's key.
# The right subtree of a node contains only nodes with keys greater than the node's key.
# Both the left and right subtrees must also be binary search trees.

# 二分木の root が与えられたとき、それが有効な二分探索木 (BST: Binary Search Tree) かどうかを判断してください。

# 有効な BST の定義は次の通りです：

# ノードの左部分木には、そのノードのキーよりも小さいキーのみを持つノードが含まれます。
# ノードの右部分木には、そのノードのキーよりも大きいキーのみを持つノードが含まれます。
# 左右の部分木もそれぞれ有効な二分探索木でなければなりません。

# Example 1:


# Input: root = [2,1,3]
# Output: true
# Example 2:


# Input: root = [5,1,4,null,null,3,6]
# Output: false
# Explanation: The root node's value is 5 but its right child's value is 4.
 

# Constraints:

# The number of nodes in the tree is in the range [1, 104].
# -231 <= Node.val <= 231 - 1

# 解答
# この問題は、与えられた二分木が有効な二分探索木 (BST) かどうかを確認する問題です。これを確認するためには、二分木を巡回し、各ノードがその左部分木の最大値よりも大きく、右部分木の最小値よりも小さいことを保証する必要があります。

# 実装手順
# 再帰的な検証:

# ノードの値が指定された範囲内にあるかをチェックします。
# そのノードの左部分木に対しては、最大値の範囲をノードの値に更新し、右部分木に対しては、最小値の範囲をノードの値に更新して再帰的にチェックします。
# ベースケースの処理:

# ノードが nil の場合、その部分木は自動的に有効なBSTとみなされるので true を返します。
# 範囲外の値の検出:

# ノードの値が指定された範囲外であれば、無効なBSTであるとみなし、false を返します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def is_valid_bst(root)
    def validate(node, low, high)
      return true if node.nil?

      puts "Visiting node with value #{node.val}, expected range: (#{low}, #{high})"

      # ノードの値が範囲外の場合、無効なBST
      if node.val <= low || node.val >= high
        puts "Node with value #{node.val} is out of valid range!"
        return false
      end

      # 左右の部分木を再帰的にチェック
      validate(node.left, low, node.val) && validate(node.right, node.val, high)
    end

    validate(root, -Float::INFINITY, Float::INFINITY)
  end
end

# 使用例
root = TreeNode.new(2, TreeNode.new(1), TreeNode.new(3))
solution = Solution.new
result = solution.is_valid_bst(root)

puts "Is the tree a valid BST? #{result}"
