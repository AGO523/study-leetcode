# Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with the same structure and node values of subRoot and false otherwise.

# A subtree of a binary tree tree is a tree that consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree of itself.

# 二つの二分木 root と subRoot の根が与えられたとき、root の中に subRoot と同じ構造とノードの値を持つ部分木が存在する場合は true を返し、それ以外の場合は false を返してください。

# 二分木 tree の部分木とは、tree の中のあるノードとそのすべての子孫から構成される木のことです。また、tree 自体もその部分木と見なすことができます。

# Example 1:


# Input: root = [3,4,5,1,2], subRoot = [4,1,2]
# Output: true
# Example 2:


# Input: root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]
# Output: false
 

# Constraints:

# The number of nodes in the root tree is in the range [1, 2000].
# The number of nodes in the subRoot tree is in the range [1, 1000].
# -104 <= root.val <= 104
# -104 <= subRoot.val <= 104

# 解答
# この問題では、二分木 root の中に、subRoot と同じ構造と値を持つ部分木が存在するかを判断します。このためには、root の各ノードを調べ、subRoot と同じ木が見つかるかどうかを確認します。再帰的に木を探索し、木の構造とノードの値が一致するかどうかを比較します。

# 実装手順
# is_subtree メソッド:

# root の部分木が subRoot と一致するかを確認します。
# root の各ノードについて、subRoot と同じ構造を持つかをチェックします。
# is_same_tree メソッド:

# 二つの木が同じかどうかをチェックします。木が同じであれば true を返し、そうでなければ false を返します。
# このメソッドは、各ノードの値と構造を比較します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def is_subtree(root, sub_root)
    # 再帰の終了条件
    return false if root.nil?

    puts "Checking subtree at node with value #{root.val}"

    # 現在のノードからの木がsub_rootと一致するか確認
    if is_same_tree(root, sub_root)
      puts "Subtree matched at node with value #{root.val}"
      return true
    end

    # 左右の部分木に対して再帰的に探索
    is_subtree(root.left, sub_root) || is_subtree(root.right, sub_root)
  end

  # ノードの値が異なるか、片方が nil であれば false を返します。
  def is_same_tree(p, q)
    # 両方がnilなら同じ木とみなす
    # 再帰の終了条件
    if p.nil? && q.nil?
      return true
    end
    
    # 片方だけがnilなら異なる木とみなす
    if p.nil? || q.nil?
      return false
    end
    
    # 現在のノードの値が異なれば異なる木とみなす
    if p.val != q.val
      return false
    end
    
    # 左右の部分木を再帰的に比較
    is_same_tree(p.left, q.left) && is_same_tree(p.right, q.right)
  end
end

# 使用例
root = TreeNode.new(3,
  TreeNode.new(4, TreeNode.new(1), TreeNode.new(2)),
  TreeNode.new(5)
)

sub_root = TreeNode.new(4, TreeNode.new(1), TreeNode.new(2))

solution = Solution.new
result = solution.is_subtree(root, sub_root)

puts "Is subRoot a subtree of root? #{result}"
