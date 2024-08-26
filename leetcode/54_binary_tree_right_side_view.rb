# Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

# 二分木のルートが与えられたとき、木の右側に立っていると仮定して、上から下まで見えるノードの値を返してください。

# Example 1:


# Input: root = [1,2,3,null,5,null,4]
# Output: [1,3,4]
# Example 2:

# Input: root = [1,null,3]
# Output: [1,3]
# Example 3:

# Input: root = []
# Output: []
 

# Constraints:

# The number of nodes in the tree is in the range [0, 100].
# -100 <= Node.val <= 100

# 解答
# この問題は、二分木の右側から見た場合に見えるノードをレベル順に収集する問題です。このためには、レベル順巡回（BFS）を行い、各レベルで最後に訪問したノードを記録するのが典型的な方法です。

# 実装手順
# エッジケースの処理:

# root が nil（木が空）であれば、空のリストを返します。
# キューを使ったレベル順巡回:

# キューに最初にルートノードを追加します。
# キューが空になるまで次の操作を繰り返します:
# キューのサイズを取得し、現在のレベルのノードを格納するリストを用意します。
# 各レベルのノードの中で、最後に訪問したノードを記録します。
# そのノードの左子ノードと右子ノードが存在すれば、それらをキューに追加します。
# 最終的に記録したノードを結果リストに追加:

# 各レベルで最後に訪問したノードを結果リストに追加します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def right_side_view(root)
    return [] if root.nil?

    result = []
    queue = [root]  # キューにルートノードを追加

    while !queue.empty?
      level_size = queue.size

      puts "Processing level with #{level_size} nodes..."

      level_size.times do |i|
        node = queue.shift  # キューからノードを取り出す
        puts "Visited node with value #{node.val}"

        # 最後のノードを記録
        # level_size - 1 は、現在のレベルの最後のノードを表す
        # i は、現在のノードのインデックスを表す
        result << node.val if i == level_size - 1

        # 左右の子ノードをキューに追加
        # これをすることで、次のレベルのノードを処理するときに、queue には次のレベルのノードだけが残る
        queue << node.left if node.left
        queue << node.right if node.right
      end
    end

    result
  end
end

# 使用例
root = TreeNode.new(1,
  TreeNode.new(2, nil, TreeNode.new(5)),
  TreeNode.new(3, nil, TreeNode.new(4))
)

solution = Solution.new
result = solution.right_side_view(root)

puts "Right side view: #{result.inspect}"
