# 二分木の根を表す root が与えられます。二分木の最大深度を返してください。

# 二分木の最大深度とは、根ノードから最も遠い葉ノードまでの最長経路に沿ったノードの数のことです。
# Given the root of a binary tree, return its maximum depth.

# A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

 

# Example 1:


# Input: root = [3,9,20,null,null,15,7]
# Output: 3
# Example 2:

# Input: root = [1,null,2]
# Output: 2
 

# Constraints:

# The number of nodes in the tree is in the range [0, 104].
# -100 <= Node.val <= 100

# 解答
# この問題では、二分木の最大深度を求める必要があります。最大深度は、再帰的に各ノードを探索し、左右の子ノードの深さを比較することで求められます。

# 実装手順
# ベースケース:

# 現在のノードが nil（空）であれば、深さは 0 です。
# 再帰的に子ノードの深さを求める:

# 現在のノードの左の子ノードと右の子ノードの深さを再帰的に求め、それらのうち大きい方に 1 を加えたものが現在のノードの深さになります。
# 再帰の終了条件:

# 木の葉ノードに達したとき、再帰が終了し、それまでの最大深度を返します。

# 再帰がどのように進行するか
# 再帰関数が呼び出されると、以下のように進行します：

# ノードが nil でない場合:

# 左の子ノードに対して再帰的に max_depth を呼び出します。
# 右の子ノードに対して再帰的に max_depth を呼び出します。
# 左右の子ノードの深さのうち、より大きい方に 1 を加えて、その値を返します。
# ノードが nil である場合:

# その時点での再帰呼び出しは 0 を返します。これが再帰を終了させる条件です。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def max_depth(root)
    # ベースケース: 現在のノードがnilであれば、深さは0
    return 0 if root.nil?

    puts "Visiting node with value #{root.val}"

    # 左右の子ノードの深さを再帰的に求める
    left_depth = max_depth(root.left)
    right_depth = max_depth(root.right)

    # 左右の深さの大きい方に1を足したものが現在のノードの深さ
    current_depth = [left_depth, right_depth].max + 1

    puts "Node with value #{root.val} has depth #{current_depth}"

    current_depth  # 現在のノードの深さを返す
  end
end

# 使用例
root = TreeNode.new(3,
  TreeNode.new(9),
  TreeNode.new(20, TreeNode.new(15), TreeNode.new(7))
)

solution = Solution.new
depth = solution.max_depth(root)

puts "Maximum depth of the tree: #{depth}"
