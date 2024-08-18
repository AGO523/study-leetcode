# Given the root of a binary tree, invert the tree, and return its root.

# 二分木の根を表す root が与えられます。木を反転（左右の子ノードを入れ替える）し、その反転された木の根を返してください。



# Example 1:


# Input: root = [4,2,7,1,3,6,9]
# Output: [4,7,2,9,6,3,1]
# Example 2:


# Input: root = [2,1,3]
# Output: [2,3,1]
# Example 3:

# Input: root = []
# Output: []
 

# Constraints:

# The number of nodes in the tree is in the range [0, 100].
# -100 <= Node.val <= 100

# 解答
# この問題では、二分木を反転する必要があります。反転とは、木の各ノードの左の子ノードと右の子ノードを入れ替えることです。この操作は再帰的に行うことができます。

# 実装手順
# ベースケース:

# 現在のノードが nil（空）であれば、nil を返します。
# 再帰的に子ノードを反転:

# 現在のノードの左右の子ノードを再帰的に反転させます。
# 左右の子ノードを入れ替える:

# 再帰呼び出しの結果を使って、現在のノードの左の子ノードと右の子ノードを入れ替えます。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def invert_tree(root)
    # ベースケース: 現在のノードがnilであればそのまま返す
    return nil if root.nil?

    puts "Inverting node with value #{root.val}"

    # 再帰的に左と右の子ノードを反転
    left_inverted = invert_tree(root.left)
    right_inverted = invert_tree(root.right)

    # 左右の子ノードを入れ替える
    root.left = right_inverted
    root.right = left_inverted

    puts "Node with value #{root.val} inverted"

    root  # 反転された現在のノードを返す
  end
end

# 使用例
root = TreeNode.new(4,
  TreeNode.new(2, TreeNode.new(1), TreeNode.new(3)),
  TreeNode.new(7, TreeNode.new(6), TreeNode.new(9))
)

solution = Solution.new
new_root = solution.invert_tree(root)

# 反転された木を出力（中間順走査）
def inorder_traversal(node)
  return if node.nil?
  inorder_traversal(node.left)
  puts node.val
  inorder_traversal(node.right)
end

puts "Inverted tree in-order traversal:"
inorder_traversal(new_root)
