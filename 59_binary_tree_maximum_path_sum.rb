# A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.

# The path sum of a path is the sum of the node's values in the path.

# Given the root of a binary tree, return the maximum path sum of any non-empty path.

# 二分木におけるパスは、隣接する各ノード対にエッジが接続されたノードのシーケンスです。シーケンス内で各ノードは最大1回だけ現れることができます。パスは必ずしもルートを通る必要はありません。

# パスの合計は、そのパス内のノードの値の合計です。

# 二分木のルートが与えられたとき、任意の非空のパスの中で最大のパス合計を返してください。

# Example 1:


# Input: root = [1,2,3]
# Output: 6
# Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.
# Example 2:


# Input: root = [-10,9,20,null,null,15,7]
# Output: 42
# Explanation: The optimal path is 15 -> 20 -> 7 with a path sum of 15 + 20 + 7 = 42.
 

# Constraints:

# The number of nodes in the tree is in the range [1, 3 * 104].
# -1000 <= Node.val <= 1000

# 解答
# この問題では、二分木のパスの中で最大のパス合計を見つける必要があります。最適なパスは必ずしもルートを通る必要がなく、木の任意の部分で終わることができます。

# この問題を解くために、深さ優先探索（DFS） を使用して、各ノードに対してそのノードを含む最大のパス合計を計算します。

# 実装手順
# 再帰的にパス合計を計算:

# 各ノードに対して、その左部分木と右部分木から得られる最大のパス合計を計算します。
# ノード自体の値と、ノードを含むパスの最大合計を更新します。
# 最大パス合計の更新:

# 現在のノードをルートとした場合、左部分木と右部分木を結ぶパスの合計が最大かどうかを確認し、最大パス合計を更新します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def max_path_sum(root)
    @max_sum = -Float::INFINITY

    def max_gain(node)
      return 0 if node.nil?

      # 左部分木からの最大パス合計
      left_gain = [max_gain(node.left), 0].max
      # 右部分木からの最大パス合計
      right_gain = [max_gain(node.right), 0].max

      # 現在のノードをルートとする最大パス合計
      current_max_path = node.val + left_gain + right_gain

      # グローバルな最大パス合計を更新
      @max_sum = [@max_sum, current_max_path].max

      puts "Visiting node with value #{node.val}, left_gain: #{left_gain}, right_gain: #{right_gain}, current_max_path: #{current_max_path}, max_sum: #{@max_sum}"

      # このノードを含むパスとしての最大値を返す（このノードをルートとして左か右の部分木のみを含む）
      node.val + [left_gain, right_gain].max
    end

    max_gain(root)
    @max_sum
  end
end

# 使用例
root = TreeNode.new(-10,
  TreeNode.new(9),
  TreeNode.new(20, TreeNode.new(15), TreeNode.new(7))
)

solution = Solution.new
result = solution.max_path_sum(root)

puts "The maximum path sum is: #{result}"
