# Given a binary tree, determine if it is 
# height-balanced
# .

# 二分木が与えられたとき、その木が高さのバランスが取れているかどうかを判断してください。

# 高さバランスが取れているとは？
# 高さバランスが取れている二分木とは、任意のノードについて、その左右の部分木の高さの差が1以下である場合を指します。



# Example 1:


# Input: root = [3,9,20,null,null,15,7]
# Output: true
# Example 2:


# Input: root = [1,2,2,3,3,null,null,4,4]
# Output: false
# Example 3:

# Input: root = []
# Output: true
 

# Constraints:

# The number of nodes in the tree is in the range [0, 5000].
# -104 <= Node.val <= 104

# 解答
# この問題では、二分木の各ノードに対して、その左右の部分木の高さを比較し、差が1以下であるかどうかを確認します。再帰的に木の高さを計算しながら、各ノードで高さバランスが取れているかどうかをチェックします。

# 実装手順
# ベースケース:

# 現在のノードが nil であれば、その高さは 0 とし、高さバランスも取れているとします。
# 再帰的に左右の部分木の高さを計算:

# 左右の部分木の高さを再帰的に計算します。
# 高さバランスのチェック:

# 各ノードに対して、左右の部分木の高さの差が1以下であることを確認します。もし差が2以上であれば、その木は高さバランスが取れていないと判断します。
# 高さバランスが取れているかの判定:

# 全てのノードで高さバランスが取れている場合、true を返します。そうでない場合、false を返します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def is_balanced(root)
    def check_height(node)
      return 0 if node.nil?

      puts "Visiting node with value #{node.val}"

      left_height = check_height(node.left)
      right_height = check_height(node.right)

      if left_height == -1 || right_height == -1 || (left_height - right_height).abs > 1
        puts "Tree is unbalanced at node with value #{node.val}"
        return -1
      end

      current_height = [left_height, right_height].max + 1
      puts "Node with value #{node.val} has height #{current_height}"
      # 計算された current_height は、その親ノードの呼び出し元（さらに上位の親ノード）に返されます。このようにして、木の高さ情報がルートに向かって伝搬していきます。
      current_height
    end

    check_height(root) != -1
  end
end

# 使用例
root = TreeNode.new(1,
  TreeNode.new(2, TreeNode.new(3, TreeNode.new(4), TreeNode.new(4)), TreeNode.new(3)),
  TreeNode.new(2)
)

solution = Solution.new
is_balanced = solution.is_balanced(root)

puts "Is the tree balanced? #{is_balanced}"
