# Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

# Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

# Clarification: The input/output format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

#   シリアライズ（Serialization）とは、データ構造やオブジェクトを一連のビットに変換するプロセスのことです。これにより、ファイルやメモリバッファに保存したり、ネットワークを介して別のコンピュータ環境に送信して後で再構築したりすることができます。

#   二分木をシリアライズおよびデシリアライズするアルゴリズムを設計してください。シリアライズ/デシリアライズのアルゴリズムの動作に関しては特に制限はありません。二分木を文字列にシリアライズし、その文字列を元の木構造にデシリアライズできることだけを保証すれば十分です。
  
#   注釈: 入力/出力の形式は、LeetCode が二分木をシリアライズする方法と同じです。この形式に従う必要はありませんので、独自のアプローチを考えてください。

# Example 1:


# Input: root = [1,2,3,null,null,4,5]
# Output: [1,2,3,null,null,4,5]
# Example 2:

# Input: root = []
# Output: []
 

# Constraints:

# The number of nodes in the tree is in the range [0, 104].
# -1000 <= Node.val <= 1000

# 解答
# この問題では、二分木をシリアライズして文字列に変換し、その文字列をデシリアライズして元の木構造に戻す必要があります。

# シリアライズとは、木の構造を保存するためにノードの値を順番に並べて1つの文字列に変換するプロセスです。

# デシリアライズとは、その文字列を解析して元の二分木を再構築するプロセスです。

# 実装手順
# シリアライズ:

# レベル順（BFS）で木を巡回し、ノードの値をリストに保存します。
# null を使って、子ノードがない部分を表現します。
# リストをカンマで結合し、1つの文字列にします。
# デシリアライズ:

# 文字列を分割してリストに変換し、ルートノードを作成します。
# BFSを使って子ノードを順番に作成し、木を構築します。

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

class Codec
  # シリアライズ: 木を文字列に変換する
  def serialize(root)
    return "" if root.nil?

    result = []
    queue = [root]

    while !queue.empty?
      node = queue.shift
      if node
        result << node.val.to_s
        queue << node.left
        queue << node.right
        p queue
      else
        result << "null"
      end
    end

    serialized_data = result.join(",")
    puts "Serialized tree: #{serialized_data}"
    serialized_data
  end

  # デシリアライズ: 文字列を木に変換する
  def deserialize(data)
    return nil if data == ""

    values = data.split(",")
    root = TreeNode.new(values.shift.to_i)
    queue = [root]

    while !queue.empty?
      node = queue.shift
      left_val = values.shift
      right_val = values.shift

      if left_val != "null"
        node.left = TreeNode.new(left_val.to_i)
        queue << node.left
      end

      if right_val != "null"
        node.right = TreeNode.new(right_val.to_i)
        queue << node.right
      end
    end

    puts "Deserialized tree root value: #{root.val}"
    root
  end
end

# 使用例
codec = Codec.new
root = TreeNode.new(1, TreeNode.new(2), TreeNode.new(3, TreeNode.new(4), TreeNode.new(5)))

# シリアライズ
serialized_data = codec.serialize(root)

# デシリアライズ
deserialized_root = codec.deserialize(serialized_data)
