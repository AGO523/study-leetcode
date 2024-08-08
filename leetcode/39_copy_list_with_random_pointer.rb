# A linked list of length n is given such that each node contains an additional random pointer, which could point to any node in the list, or null.

# Construct a deep copy of the list. The deep copy should consist of exactly n brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the next and random pointer of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. None of the pointers in the new list should point to nodes in the original list.

# For example, if there are two nodes X and Y in the original list, where X.random --> Y, then for the corresponding two nodes x and y in the copied list, x.random --> y.

# Return the head of the copied linked list.

# The linked list is represented in the input/output as a list of n nodes. Each node is represented as a pair of [val, random_index] where:

# val: an integer representing Node.val
# random_index: the index of the node (range from 0 to n-1) that the random pointer points to, or null if it does not point to any node.
# Your code will only be given the head of the original linked list.

# 長さ n のリンクリストが与えられます。このリンクリストの各ノードには、任意のノード（もしくは null）を指す追加のランダムポインタがあります。

# このリンクリストのディープコピー（深いコピー）を構築しなさい。ディープコピーは、元のリンクリストに対応するちょうど n 個の新しいノードで構成されるべきです。各新しいノードは、元のノードに対応する値を持ち、かつ次ポインタとランダムポインタは、コピーされたリスト内の新しいノードを指すように設定される必要があります。新しいリスト内のポインタのいずれも、元のリストのノードを指してはいけません。

# 例えば、元のリストに X と Y という2つのノードがあり、X.random が Y を指している場合、コピーされたリストにおいて対応する x と y という2つのノードがあり、x.random は y を指している必要があります。

# コピーされたリンクリストの先頭ノードを返しなさい。

# リンクリストは入力/出力で n 個のノードのリストとして表現されます。各ノードは [val, random_index] のペアとして表現され、val は Node.val を表し、random_index はランダムポインタが指すノードのインデックス（0から n-1 の範囲）を表します。ランダムポインタがどのノードも指していない場合は null とします。

# Example 1:


# Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
# Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
# Example 2:


# Input: head = [[1,1],[2,1]]
# Output: [[1,1],[2,1]]
# Example 3:



# Input: head = [[3,null],[3,0],[3,null]]
# Output: [[3,null],[3,0],[3,null]]
 

# Constraints:

# 0 <= n <= 1000
# -104 <= Node.val <= 104
# Node.random is null or is pointing to some node in the linked list.

# 解答
# この問題を解決するために、以下の手順を取ります：

# 各ノードのコピーを作成して元のノードの隣に挿入する：

# まず、元のリストを一度走査し、各ノードのコピーを作成して元のノードの隣に挿入します。この段階で、元のリストとコピーされたノードが交互に配置されます。
# ランダムポインタを設定する：

# 元のノードが指しているランダムポインタを使用して、コピーされたノードのランダムポインタを設定します。
# 新しいリストを分離する：

# 元のリストからコピーされたリストを分離します。元のリストを元通りにしつつ、コピーされたリストを生成します。

# 単方向リンクリストのノードを定義
class Node
  attr_accessor :val, :next, :random

  def initialize(val = 0, _next = nil, random = nil)
    @val = val
    @next = _next
    @random = random
  end
end

# リストのディープコピーを作成する関数
def copy_random_list(head)
  # もしリストが空（headがnil）なら、nilを返して処理を終了
  return nil if head.nil?

  # ステップ1: 各ノードのコピーを作成して元のノードの隣に挿入
  current = head  # 現在のノードを指すポインタをheadに設定
  while current  # 現在のノードが存在する限りループ
    new_node = Node.new(current.val)  # 現在のノードの値を持つ新しいノードを作成
    new_node.next = current.next  # 新しいノードの次を現在のノードの次に設定
    current.next = new_node  # 現在のノードの次を新しいノードに設定
    current = new_node.next  # 現在のノードを更新（次の元のノードに移動）
    puts "Inserted new node with value #{new_node.val} after original node with value #{current&.val}"
  end

  # ステップ2: ランダムポインタを設定
  current = head  # 現在のノードを再度リストの先頭に戻す
  while current  # 現在のノードが存在する限りループ
    if current.random  # 現在のノードのランダムポインタが存在する場合
      current.next.random = current.random.next  # 新しいノードのランダムポインタを元のノードのランダムポインタの次のノードに設定
      puts "Setting random pointer of node with value #{current.next.val} to #{current.next.random.val}"
    end
    current = current.next.next  # 2つ先の元のノードに移動（コピーされたノードを飛ばす）
  end

  # ステップ3: 新しいリストを分離
  current = head  # 現在のノードを再度リストの先頭に戻す
  new_head = head.next  # 新しいリストの先頭を設定（最初の新しいノード）
  while current  # 現在のノードが存在する限りループ
    new_node = current.next  # 新しいノードを取得
    current.next = new_node.next  # 元のノードの次を更新して新しいリストを分離
    new_node.next = new_node.next&.next  # 新しいノードの次を更新して新しいリストを形成
    current = current.next  # 次の元のノードに移動
    puts "Separating new node with value #{new_node.val}, next set to #{new_node.next&.val}"
  end

  new_head  # 新しいリストの先頭を返す
end

# 使用例
def print_list(head)
  current = head
  while current
    random_val = current.random ? current.random.val : 'null'
    puts "Node val: #{current.val}, Random points to: #{random_val}"
    current = current.next
  end
end

# リストの生成
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)
node5 = Node.new(5)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5

node1.random = node3
node2.random = node1
node3.random = node5
node4.random = node3
node5.random = node2

puts "Original list:"
print_list(node1)

copied_head = copy_random_list(node1)
puts "\nCopied list:"
print_list(copied_head)
