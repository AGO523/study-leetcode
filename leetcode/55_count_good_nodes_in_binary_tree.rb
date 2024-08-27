# Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.

# Return the number of good nodes in the binary tree.

# 二分木の root が与えられたとき、木のノード X は、ルートから X までの経路に X より大きい値を持つノードが存在しない場合、「良いノード」と呼ばれます。

# 二分木における「良いノード」の数を返してください。

# Example 1:



# Input: root = [3,1,4,3,null,1,5]
# Output: 4
# Explanation: Nodes in blue are good.
# Root Node (3) is always a good node.
# Node 4 -> (3,4) is the maximum value in the path starting from the root.
# Node 5 -> (3,4,5) is the maximum value in the path
# Node 3 -> (3,1,3) is the maximum value in the path.
# Example 2:



# Input: root = [3,3,null,4,2]
# Output: 3
# Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.
# Example 3:

# Input: root = [1]
# Output: 1
# Explanation: Root is considered as good.
 

# Constraints:

# The number of nodes in the binary tree is in the range [1, 10^5].
# Each node's value is between [-10^4, 10^4].

# 解答
# この問題では、二分木の各ノードを深さ優先探索（DFS）を用いて巡回し、ルートからそのノードまでの経路においてそのノードが最大値かどうかを確認する必要があります。経路上でノードの値が最大である場合、そのノードを「良いノード」としてカウントします。

# 実装手順
# 再帰関数の設計:

# dfs(node, max_value) 関数を定義し、node に到達するまでの経路の最大値 max_value を引数として受け取ります。
# 現在のノードの値が max_value より大きければ、「良いノード」としてカウントします。
# 左右の子ノードについて同様に再帰的に探索します。
# ベースケースの処理:

# ノードが nil の場合は探索を終了し、0 を返します。
# 最大値の更新:

# 再帰的に子ノードを探索するとき、その経路の最大値を更新します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def good_nodes(root)
    def dfs(node, max_value)
      return 0 if node.nil?

      puts "Visiting node with value #{node.val}, current max value in path is #{max_value}"

      # 現在のノードが良いノードかを判定
      good = node.val >= max_value ? 1 : 0

      if good == 1
        puts "Node with value #{node.val} is a good node."
      else
        puts "Node with value #{node.val} is NOT a good node."
      end

      # 新しい経路の最大値を更新し、左右の子ノードを探索
      max_value = [max_value, node.val].max
      # 再帰でまずは左の子ノードを探索。その結果を good に加算
      # その後、右の子ノードを探索。その結果を good に加算
      good + dfs(node.left, max_value) + dfs(node.right, max_value)
    end

    dfs(root, root.val)
  end
end

# 使用例
root = TreeNode.new(3,
  TreeNode.new(1, TreeNode.new(3)),
  TreeNode.new(4, TreeNode.new(1), TreeNode.new(5))
)

solution = Solution.new
result = solution.good_nodes(root)

puts "Number of good nodes: #{result}"
