# Given an array of integers preorder, which represents the preorder traversal of a BST (i.e., binary search tree), construct the tree and return its root.

# It is guaranteed that there is always possible to find a binary search tree with the given requirements for the given test cases.

# A binary search tree is a binary tree where for every node, any descendant of Node.left has a value strictly less than Node.val, and any descendant of Node.right has a value strictly greater than Node.val.

# A preorder traversal of a binary tree displays the value of the node first, then traverses Node.left, then traverses Node.right.

# 整数の配列 preorder が与えられています。これは二分探索木（BST: Binary Search Tree）の先行順（preorder）巡回を表しています。この配列に基づいて木を構築し、そのルートを返してください。

# 与えられたテストケースに対して、指定された条件で二分探索木を見つけることが常に可能であることが保証されています。

# 二分探索木は、すべてのノードに対して以下の条件を満たす二分木です：

# ノードの左部分木に属するすべての子孫の値は、そのノードの値よりも小さいです。
# ノードの右部分木に属するすべての子孫の値は、そのノードの値よりも大きいです。
# 二分木の先行順（preorder）巡回は、ノードの値を最初に表示し、その後に左部分木を巡回し、次に右部分木を巡回します。



# Example 1:


# Input: preorder = [8,5,1,7,10,12]
# Output: [8,5,10,1,7,null,12]
# Example 2:

# Input: preorder = [1,3]
# Output: [1,null,3]
 

# Constraints:

# 1 <= preorder.length <= 100
# 1 <= preorder[i] <= 1000
# All the values of preorder are unique.

# 解答
# この問題では、与えられた先行順巡回（preorder traversal）に基づいて二分探索木を構築します。先行順巡回では、木のルートを最初に訪問し、その後に左部分木、右部分木の順に訪問します。この順序を利用して、木を再構築します。

# 実装手順
# 再帰的な構築:

# 先行順巡回の最初の値がルートになります。
# 残りの値から、左部分木と右部分木を再帰的に構築します。
# 左部分木にはルートより小さい値が入り、右部分木にはルートより大きい値が入ります。
# 部分木の分割:

# ルートの値より小さい部分を左部分木、大きい部分を右部分木として分けます。
# それぞれに対して再帰的に木を構築します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def bst_from_preorder(preorder)
    return nil if preorder.empty?

    root_val = preorder.first
    root = TreeNode.new(root_val)
    puts "Creating root with value #{root_val}"

    left_subtree = preorder[1..-1].select { |val| val < root_val }
    right_subtree = preorder[1..-1].select { |val| val > root_val }

    puts "Left subtree values: #{left_subtree.inspect}"
    puts "Right subtree values: #{right_subtree.inspect}"

    root.left = bst_from_preorder(left_subtree)
    root.right = bst_from_preorder(right_subtree)

    root
  end
end

# 使用例
preorder = [8, 5, 1, 7, 10, 12]
solution = Solution.new
result = solution.bst_from_preorder(preorder)

def print_tree(root)
  return [] if root.nil?
  queue = [root]
  result = []
  while !queue.empty?
    node = queue.shift
    result << (node.nil? ? nil : node.val)
    queue << node.left if node && node.left
    queue << node.right if node && node.right
  end
  result
end

puts "Constructed BST (level order): #{print_tree(result).inspect}"
