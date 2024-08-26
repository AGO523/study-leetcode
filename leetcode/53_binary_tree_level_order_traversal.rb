# Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

# 二分木のルートが与えられたとき、そのノードの値をレベル順に巡回した結果を返してください（つまり、左から右へ、レベルごとに巡回します）。



# Example 1:


# Input: root = [3,9,20,null,null,15,7]
# Output: [[3],[9,20],[15,7]]
# Example 2:

# Input: root = [1]
# Output: [[1]]
# Example 3:

# Input: root = []
# Output: []
 

# Constraints:

# The number of nodes in the tree is in the range [0, 2000].
# -1000 <= Node.val <= 1000

# 解答
# この問題は、二分木の各レベルのノードを順番に巡回して値を収集する、いわゆる「レベル順巡回」（BFS: Breadth-First Search）を実装する問題です。キューを使ってレベルごとにノードを探索するのが典型的な方法です。

# 実装手順
# エッジケースの処理:

# root が nil（木が空）であれば、空のリストを返します。
# キューを使ったレベル順巡回:

# キューに最初にルートノードを追加します。
# キューが空になるまで次の操作を繰り返します:
# キューのサイズを取得し、現在のレベルのノードを格納するリストを用意します。
# キューからノードを取り出し、その値を現在のレベルのリストに追加します。
# そのノードの左子ノードと右子ノードが存在すれば、それらをキューに追加します。
# レベルごとのリストを最終結果に追加:

# 各レベルのリストを結果リストに追加します

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def level_order(root)
    return [] if root.nil?

    result = []
    queue = [root]  # キューにルートノードを追加

    while !queue.empty?
      level_size = queue.size
      current_level = []

      puts "Processing level with #{level_size} nodes..."

      level_size.times do
        node = queue.shift  # キューからノードを取り出す
        current_level << node.val  # ノードの値を現在のレベルのリストに追加
        puts "Visited node with value #{node.val}"

        # 左右の子ノードをキューに追加
        queue << node.left if node.left
        queue << node.right if node.right
      end

      result << current_level  # 現在のレベルのリストを結果に追加
    end

    result
  end
end

# 使用例
root = TreeNode.new(3,
  TreeNode.new(9),
  TreeNode.new(20, TreeNode.new(15), TreeNode.new(7))
)

solution = Solution.new
result = solution.level_order(root)

puts "Level order traversal result: #{result.inspect}"
