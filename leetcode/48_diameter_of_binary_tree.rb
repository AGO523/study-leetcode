# Given the root of a binary tree, return the length of the diameter of the tree.

# The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

# The length of a path between two nodes is represented by the number of edges between them.

# 二分木の根が与えられたとき、木の直径の長さを返してください。

# 二分木の直径とは、木の中の任意の2つのノード間の最長経路の長さのことです。この経路は根を通過する場合と通過しない場合があります。

# 2つのノード間の経路の長さは、ノード間のエッジの数で表されます。

# Example 1:


# Input: root = [1,2,3,4,5]
# Output: 3
# Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].
# Example 2:

# Input: root = [1,2]
# Output: 1
 

# Constraints:

# The number of nodes in the tree is in the range [1, 104].
# -100 <= Node.val <= 100

# 解答
# この問題では、二分木の直径、すなわち最長経路の長さを求める必要があります。直径を求めるには、木の各ノードに対してその左部分木と右部分木の深さを計算し、その和の最大値を求めます。再帰的に木の深さを計算しながら、直径を更新していきます。

# 実装手順
# 再帰的に深さを計算:

# 各ノードに対して、その左部分木と右部分木の深さを再帰的に計算します。
# 直径を更新:

# 各ノードについて、その左部分木の深さと右部分木の深さの和を計算し、これが現在の直径より大きければ直径を更新します。
# 深さの計算:

# 左右の部分木の深さのうち大きい方に 1 を加えて、そのノードの深さを返します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def diameter_of_binary_tree(root)
    @diameter = 0

    def depth(node)
      return 0 if node.nil?

      puts "Visiting node with value #{node.val}"

      # 左右の部分木の深さを再帰的に計算
      # depth の返り値は、`[left_depth, right_depth].max + 1` で求められる
      left_depth = depth(node.left)
      right_depth = depth(node.right)

      # 直径の更新
      current_diameter = left_depth + right_depth
      @diameter = [@diameter, current_diameter].max

      puts "Node with value #{node.val} has left depth #{left_depth}, right depth #{right_depth}, and current diameter #{current_diameter}"

      # ノードの深さを返す
      # +1 をするのは、現在のノードの深さを返すため
      # 現在のノード自体の深さを考慮に入れるため
      [left_depth, right_depth].max + 1
    end

    depth(root)
    @diameter
  end
end

# 使用例
root = TreeNode.new(1,
  TreeNode.new(2, TreeNode.new(4), TreeNode.new(5)),
  TreeNode.new(3)
)

solution = Solution.new
diameter = solution.diameter_of_binary_tree(root)

puts "Diameter of the tree: #{diameter}"
