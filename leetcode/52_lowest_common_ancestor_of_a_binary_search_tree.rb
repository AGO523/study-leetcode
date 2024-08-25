# Given a binary search tree (BST), find the lowest common ancestor (LCA) node of two given nodes in the BST.

# According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

# 二分探索木 (BST) が与えられたとき、指定された二つのノード p と q の最小共通祖先（LCA）を見つけてください。

# Wikipediaの定義によると、「最小共通祖先（LCA）は、二つのノード p と q に対して、p と q の両方を子孫に持つ最も低いノード（p と q がそのノード自身を子孫として持つことを許す）です。」



# Example 1:


# Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
# Output: 6
# Explanation: The LCA of nodes 2 and 8 is 6.
# Example 2:


# Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
# Output: 2
# Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
# Example 3:

# Input: root = [2,1], p = 2, q = 1
# Output: 2
 

# Constraints:

# The number of nodes in the tree is in the range [2, 105].
# -109 <= Node.val <= 109
# All Node.val are unique.
# p != q
# p and q will exist in the BST.

# 解答
# 二分探索木（BST）は、左の子ノードが親ノードよりも小さく、右の子ノードが親ノードよりも大きいという特性を持っています。この特性を活用すると、最小共通祖先（LCA）を効率的に見つけることができます。

# 実装手順
# ルートノードから開始:

# p と q が現在のノードの左右に分かれている場合、そのノードが最小共通祖先（LCA）です。
# そうでない場合、両方が左にあれば左部分木を、両方が右にあれば右部分木を再帰的に探索します。
# 再帰的探索:

# 左右どちらの子ノードを再帰的に探索するかを決定するために、p と q の値と現在のノードの値を比較します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def lowest_common_ancestor(root, p, q)
    current = root

    while current
      puts "Visiting node with value #{current.val}"
      
      # pとqがともに現在のノードより小さい場合、左部分木を探索
      # この場合、p と q はともに現在のノードの左側の部分木に存在するため、LCA は左部分木にある可能性が高いです
      if p.val < current.val && q.val < current.val
        puts "Both p (#{p.val}) and q (#{q.val}) are less than #{current.val}, moving to the left child."
        current = current.left
      # pとqがともに現在のノードより大きい場合、右部分木を探索
      # 逆に、p と q の値が両方とも現在のノードの値より大きい場合、両方は右部分木に存在するため、LCA は右部分木にある可能性が高いです。
      elsif p.val > current.val && q.val > current.val
        puts "Both p (#{p.val}) and q (#{q.val}) are greater than #{current.val}, moving to the right child."
        current = current.right
      else
        # pとqが分かれている場合、またはどちらかが現在のノードに一致する場合、このノードがLCA
        # p が現在のノードより小さく、q が大きい場合。
        # p または q が現在のノードと同じ場合。
        puts "Found the lowest common ancestor: #{current.val}"
        return current
      end
    end

    nil  # ここに到達することはない
  end
end

# 使用例
root = TreeNode.new(6,
  TreeNode.new(2, TreeNode.new(0), TreeNode.new(4, TreeNode.new(3), TreeNode.new(5))),
  TreeNode.new(8, TreeNode.new(7), TreeNode.new(9))
)

p = TreeNode.new(2)
q = TreeNode.new(8)

solution = Solution.new
ancestor = solution.lowest_common_ancestor(root, p, q)

puts "Lowest Common Ancestor: #{ancestor.val}"
