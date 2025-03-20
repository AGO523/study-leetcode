# Given the root of a binary search tree, and an integer k, return the kth smallest value (1-indexed) of all the values of the nodes in the tree.

# 二分探索木のルートが与えられたとき、整数 k に対して、木のノードの値の中で k 番目に小さい値を返してください（1-indexed）。

# Example 1:


# Input: root = [3,1,4,null,2], k = 1
# Output: 1
# Example 2:


# Input: root = [5,3,6,2,4,null,null,1], k = 3
# Output: 3
 

# Constraints:

# The number of nodes in the tree is n.
# 1 <= k <= n <= 104
# 0 <= Node.val <= 104

# 解答
# 二分探索木 (BST) は特性上、左部分木の値が小さく、右部分木の値が大きいという順序になっています。そのため、木の中序巡回（in-order traversal）を行うと、ノードの値が昇順に取得できます。これを利用して、k 番目に小さい値を見つけることができます。

# 実装手順
# 中序巡回:

# 再帰的に木を中序巡回し、ノードの値を昇順に取得します。
# 巡回中に k 番目のノードに到達したら、その値を返します。
# 終了条件:

# k 番目のノードに到達したら再帰を終了します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Solution
  def kth_smallest(root, k)
    @k = k
    @result = nil

    def inorder_traversal(node)
      return if node.nil? || @result

      # 左部分木を巡回
      inorder_traversal(node.left)

      # ノードの値を確認
      puts "Visiting node with value #{node.val}, remaining k: #{@k}"
      # @k は、何番目に小さいノードを探しているかをカウントダウンするための変数です。
      # 二分探索木 (BST) は特性上、中序巡回するとノードの値が昇順にソートされた順で訪問されます。
      # したがって、巡回中に @k を減らしていき、@k が 0 になったとき、ちょうど k 番目に小さいノードに到達したことを意味します。
      @k -= 1

      # k番目の要素に到達したら結果を保存
      if @k == 0
        @result = node.val
        puts "Found the #{@k}th smallest value: #{@result}"
        return
      end

      # 右部分木を巡回
      inorder_traversal(node.right)
    end

    inorder_traversal(root)
    @result
  end
end

# 使用例
root = TreeNode.new(5,
  TreeNode.new(3, TreeNode.new(2, TreeNode.new(1)), TreeNode.new(4)),
  TreeNode.new(6)
)

solution = Solution.new
k = 3
result = solution.kth_smallest(root, k)

puts "The #{k}th smallest value in the BST is: #{result}"

# 右部分木を巡回する理由は、中序巡回（in-order traversal）のプロセスにおいて、ノードの値を昇順に取得するためです。中序巡回では、次の順序でノードを訪問します：

# 左部分木: 左部分木のすべてのノードを巡回します。
# 現在のノード: 現在のノードを処理します（値をカウントダウンして k 番目か確認します）。
# 右部分木: 右部分木のすべてのノードを巡回します。
# 詳細な解説
# 二分探索木 (BST) では、左部分木のすべてのノードの値が現在のノードの値よりも小さく、右部分木のすべてのノードの値が現在のノードの値よりも大きいという特性があります。これを前提にして、中序巡回を行うと次のような順序になります：

# 左部分木 → 現在のノード → 右部分木
# つまり、中序巡回は自然と値を昇順に取り出す手法となります。

# 例
# 次のような二分探索木を考えます：

# markdown
# コードをコピーする
#     5
#    / \
#   3   7
#  / \   \
# 2   4   8
# この木を中序巡回すると次の順序でノードが訪問されます：

# 左部分木の最も左端、ノード 2
# ノード 3
# 右部分木のノード 4
# 現在のノード、ノード 5
# 右部分木のノード 7
# その右部分木のノード 8
# この順序に従うと、ノードの値は [2, 3, 4, 5, 7, 8] の順で取得され、自然と昇順に並んでいることがわかります。

# 右部分木を巡回する理由
# 中序巡回の完全性: 中序巡回は「左部分木→現在のノード→右部分木」という順序でノードを訪問します。左部分木と現在のノードを訪問した後に右部分木を巡回しなければ、木全体を正確に巡回することができません。

# 正確な順位の決定: 右部分木を巡回しなければ、現在のノードより大きい値を持つノードが何番目に位置するのかを判断できません。中序巡回の順序を守ることで、ノードが木全体で何番目に小さいかを正確に決定できます。

# まとめ
# 右部分木を巡回するのは、中序巡回によってノードを昇順に訪問するためです。中序巡回の手順に従うことで、二分探索木全体の値を昇順に並べ、その中で k 番目に小さい値を正確に特定できます。
