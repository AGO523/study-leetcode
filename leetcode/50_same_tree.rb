# Given the roots of two binary trees p and q, write a function to check if they are the same or not.

# Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

# 二分木の根 p と q が与えられたとき、それらが同じ木であるかどうかを確認する関数を書いてください。

# 二つの二分木は、構造的に同一であり、すべてのノードが同じ値を持つ場合に「同じ」とみなされます。

# Example 1:


# Input: p = [1,2,3], q = [1,2,3]
# Output: true
# Example 2:


# Input: p = [1,2], q = [1,null,2]
# Output: false
# Example 3:


# Input: p = [1,2,1], q = [1,1,2]
# Output: false
 

# Constraints:

# The number of nodes in both trees is in the range [0, 100].
# -104 <= Node.val <= 104

# 解答
# この問題では、二つの二分木が同じかどうかを判断するために、再帰的に木の構造とノードの値を比較します。再帰的なアプローチで木の各ノードを確認し、両方の木が同時に nil である場合や、ノードの値が一致するかどうかをチェックします。

# 実装手順
# ベースケース:

# どちらか一方のノードが nil で、もう一方が nil でない場合、木は同じではありません。両方が nil であれば同じです。
# ノードの値の比較:

# 現在のノードの値を比較し、異なる場合は木が同じではないことが確定します。
# 再帰的な比較:

# 左右の部分木に対して再帰的に比較を行い、それぞれの結果が true であれば木は同じと判断します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def is_same_tree(p, q)
    # 両方がnilなら同じ木とみなす
    if p.nil? && q.nil?
      puts "Both nodes are nil, they are considered the same."
      return true
    end
    
    # 片方だけがnilなら異なる木とみなす
    if p.nil? || q.nil?
      puts "One of the nodes is nil (p=#{p&.val}, q=#{q&.val}), they are not the same."
      return false
    end
    
    # 現在のノードの値が異なれば異なる木とみなす
    if p.val != q.val
      puts "Node values are different (p=#{p.val}, q=#{q.val}), they are not the same."
      return false
    end
    
    puts "Node values are the same (p=#{p.val}, q=#{q.val}), continue to check left and right subtrees."
    
    # 左右の部分木を再帰的に比較
    is_same_tree(p.left, q.left) && is_same_tree(p.right, q.right)
  end
end

# 使用例
p = TreeNode.new(1, TreeNode.new(2), TreeNode.new(3))
q = TreeNode.new(1, TreeNode.new(2), TreeNode.new(3))

solution = Solution.new
result = solution.is_same_tree(p, q)

puts "Are the two trees the same? #{result}"
