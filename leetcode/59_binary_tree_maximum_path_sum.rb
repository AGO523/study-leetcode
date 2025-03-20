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

# おっしゃる通り、この出力は一見するとパスの説明と矛盾しているように見えるかもしれません。これを理解するために、もう一度パスの定義とコードの動作について確認してみましょう。

# ### パスの再確認

# **パス**とは、木の中でエッジでつながった一連のノードのことを指します。このパスの合計は、そのパス内に含まれるノードの値の合計です。

# **最大パス合計**は、その木の中でパスの合計が最も大きいものを指します。ここでいうパスは、必ずしもルートから葉までのパスを意味するわけではなく、木の中の任意のノードを起点とした部分木のパスも含まれます。

# ### 例における矛盾の原因

# 次に、問題文で説明した `max_path_sum` メソッドの出力について詳細に検討します。

# 1. **`Visiting node with value -10`**:
#    - `left_gain: 9`：ノード `-10` の左部分木から得られる最大パス合計は `9`（ノード `9` の値のみ）。
#    - `right_gain: 35`：ノード `-10` の右部分木から得られる最大パス合計は `35`。これは、ノード `20` からスタートし、その右部分木（`15 -> 20 -> 7`）で得られる合計です。
#    - `current_max_path: 34`：これは、ノード `-10` を起点としたパスの合計で、`-10 + 9 + 35 = 34` となります。

# 2. **矛盾の原因**:
#    - 出力された `current_max_path: 34` は、確かにパス `-10 -> 9` と `-10 -> 20 -> 15 -> 7` を合計したものです。しかし、ここで気を付けなければならないのは、**現在のノード（この場合は `-10`）を中心としたパスの合計**は、左右の部分木の合計とそのノードの値を足したものだということです。
#    - このときの `max_sum` は、ノード `20` を中心とするパス（`15 -> 20 -> 7` の合計で `42`）が最大であり、そのため `max_sum` は `42` のままです。

# ### コードの動作

# 以下の点を再度確認します：

# - `max_gain` 関数は、各ノードに対して左部分木と右部分木からの最大値を計算し、そのノードをルートとするパスの最大値を算出します。
# - その後、`max_sum` を更新し、最大のパス合計を保持します。
# - 最終的に、木全体の最大パス合計が `max_sum` に保存され、それが結果として返されます。

# ### 具体的な説明

# - ノード `-10` に関しては、左部分木の `9` と右部分木の `35` から得られる合計で `34` となります。
# - しかし、ノード `20` を中心としたパスの合計 `42` がより大きいため、`max_sum` は `42` のまま更新されません。

# ### 結論

# この出力が矛盾していると感じるのは、**「パスの最大合計がそのノードを起点にした場合の最大合計ではなく、木全体で最大になるかどうか」**という点に焦点を合わせているためです。つまり、`-10` を起点とするパスは `34` が最大ですが、木全体で最大のパスは `42` であり、そのため `max_sum` が `42` のままとなっています。

# この点が最大パス合計のアルゴリズムの重要な部分であり、理解するためには、この最大パスがどのように計算されるかを注意深く考える必要があります。
