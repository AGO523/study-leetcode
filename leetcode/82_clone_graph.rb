# Given a reference of a node in a connected undirected graph.

# Return a deep copy (clone) of the graph.

# Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.

# class Node {
#     public int val;
#     public List<Node> neighbors;
# }
 

# Test case format:

# For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with val == 1, the second node with val == 2, and so on. The graph is represented in the test case using an adjacency list.

# An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

# The given node will always be the first node with val = 1. You must return the copy of the given node as a reference to the cloned graph.

# 無向グラフにおけるノードの参照が与えられたとき、そのグラフのディープコピー（クローン）を返してください。

# 各ノードは、整数値 (val) と隣接するノードのリスト (List[Node]) を持っています。

# Example 1:


# Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
# Output: [[2,4],[1,3],[2,4],[1,3]]
# Explanation: There are 4 nodes in the graph.
# 1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
# 2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
# 3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
# 4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
# Example 2:


# Input: adjList = [[]]
# Output: [[]]
# Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.
# Example 3:

# Input: adjList = []
# Output: []
# Explanation: This an empty graph, it does not have any nodes.

# テストケース形式:
# 単純化のため、各ノードの値はそのインデックスと同じとします（1-indexed）。たとえば、最初のノードの val == 1、2番目のノードの val == 2 という具合です。グラフはテストケースで隣接リスト（adjacency list）として表現されます。

# 隣接リストは有限グラフを表すために使用される無順序リストのコレクションです。各リストはノードの隣接ノードのセットを記述します。

# 与えられたノードは常に val = 1 の最初のノードです。クローンされたグラフの最初のノードの参照を返してください。

# Constraints:

# The number of nodes in the graph is in the range [0, 100].
# 1 <= Node.val <= 100
# Node.val is unique for each node.
# There are no repeated edges and no self-loops in the graph.
# The Graph is connected and all nodes can be visited starting from the given node.


# 解答の解説:
# この問題では、無向グラフをディープコピーする必要があります。つまり、元のグラフの構造と同じだが、異なる参照を持つ新しいグラフを作成します。
# グラフのノードは、隣接するノードへの参照を持つリストで表されており、ノードとその隣接ノードを再帰的に処理することで、ディープコピーが可能です。

# 解決方法:
# DFS (深さ優先探索) を使ってグラフをコピーします。
# すでにクローンされたノードを追跡するためにハッシュマップ（辞書）を使用します。このマップは、元のノードをキー、新しいクローンノードを値として保持します。
# DFSを再帰的に実行して、すべての隣接ノードをコピーします。


# Nodeクラスの定義
class Node
  attr_accessor :val, :neighbors
  
  def initialize(val = 0, neighbors = [])
    @val = val
    @neighbors = neighbors
  end
end

def clone_graph(node)
  return nil if node.nil?
  # すでにクローンされたノードを追跡するためのハッシュマップ
  cloned = {}

  # DFSを使ってノードを再帰的にコピー
  def dfs(node, cloned)
    # もしノードがすでにクローンされていれば、そのクローンを返す
    return cloned[node.val] if cloned[node.val]

    # ノードをクローンする（隣接ノードは後で設定する）
    clone = Node.new(node.val)
    cloned[node.val] = clone

    puts "Cloning node #{node.val}"

    # 隣接ノードをDFSで再帰的にクローンし、クローンノードのneighborsに追加
    node.neighbors.each do |neighbor|
      clone.neighbors << dfs(neighbor, cloned)
    end

    return clone
  end

  # 最初のノードからDFSを開始
  dfs(node, cloned)
end

# テストケース
# ノード1 -> ノード2, ノード4
# ノード2 -> ノード1, ノード3
# ノード3 -> ノード2, ノード4
# ノード4 -> ノード1, ノード3
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node4 = Node.new(4)

node1.neighbors = [node2, node4]
node2.neighbors = [node1, node3]
node3.neighbors = [node2, node4]
node4.neighbors = [node1, node3]

# グラフのクローンを作成
cloned_graph = clone_graph(node1)

# 結果を表示
puts "Original node neighbors: #{node1.neighbors.map(&:val)}"
puts "Cloned node neighbors: #{cloned_graph.neighbors.map(&:val)}"

# DFS（深さ優先探索）やノードに関連する概念についておさらいします。

# ### 1. ノードとは？

# **ノード**は、データ構造において基本的な要素のことを指します。たとえば、ツリーやグラフの構造では、それぞれの点や接点が「ノード」として表現されます。ノードは以下のような属性を持つことがあります：
# - **値 (val)**：ノードに保存されるデータや値。
# - **隣接ノード (neighbors)**：グラフ構造の場合、ノードが接続している他のノード。これにより、ノード間の関係や接続が表現されます。

# たとえば、以下のような `Node` クラスがあります。

# ```ruby
# class Node
#   attr_accessor :val, :neighbors
  
#   def initialize(val = 0, neighbors = [])
#     @val = val
#     @neighbors = neighbors
#   end
# end
# ```

# - `val` はそのノードが持つデータ。
# - `neighbors` は、他のノードへのリンクや接続を表す配列です。

# #### ノードの例:
# もし `Node` オブジェクトが以下のように作られていた場合：
# ```ruby
# node1 = Node.new(1)
# node2 = Node.new(2)
# node1.neighbors = [node2]
# ```
# これは、ノード1がノード2に接続していることを意味します。

# ---

# ### 2. DFS（深さ優先探索）とは？

# **DFS（Depth-First Search、深さ優先探索）**は、グラフやツリーの探索アルゴリズムの一つです。DFSでは、可能な限り深くノードを探索してから、他の分岐に戻って探索します。  
# DFSは再帰を用いて実装されることが一般的です。再帰的に次のノードを探索し、最後のノードまで到達した後に、バックトラックして他の未探索のノードに移動します。

# #### DFS の一般的な手順:
# 1. 現在のノードを訪問する。
# 2. そのノードの隣接ノードを次々に探索する。
# 3. 再帰的に次のノードを探索する。
# 4. すべてのノードを訪問したら、バックトラックして戻り、他の道を探索する。

# #### DFSの実装（再帰）:
# 以下は簡単なDFSの再帰的な実装例です。

# ```ruby
# def dfs(node, visited)
#   return if visited.include?(node)  # すでに訪問したノードはスキップ

#   puts "Visiting node #{node.val}"  # 現在のノードを訪問
#   visited << node                   # 訪問済みとしてマーク
  
#   # 隣接ノードを再帰的に訪問
#   node.neighbors.each do |neighbor|
#     dfs(neighbor, visited)
#   end
# end

# # 使い方:
# visited = []
# dfs(start_node, visited)  # start_nodeから探索を開始
# ```

# - **`visited.include?(node)`**：すでに訪問したノードは二度訪問しないようにします。
# - **`node.neighbors.each`**：隣接ノードに対して再帰的にDFSを実行します。

# #### DFS の特徴:
# - グラフの探索を行う際に、可能な限り深いところまで行ってからバックトラックして別のルートを探索する。
# - グラフやツリーの全ノードを訪問するのに使われる。

# ---

# ### 3. DFSを使用したノードのクローン（グラフコピー）

# 上記の知識を使って、DFSを利用してグラフのノードをクローン（ディープコピー）することが可能です。再帰的にノードを訪問し、それぞれのノードをコピーし、隣接ノードもコピーしていくという手法です。

# ```ruby
# def clone_graph(node)
#   return nil if node.nil?  # グラフが空の場合

#   cloned = {}  # すでにクローンされたノードを追跡するためのハッシュ

#   # DFSを用いたクローン作成
#   def dfs(node, cloned)
#     return cloned[node.val] if cloned[node.val]  # すでにクローンされている場合はそれを返す

#     # ノードをクローンし、クローンされたことを記録
#     clone = Node.new(node.val)
#     cloned[node.val] = clone

#     # 隣接ノードを再帰的にクローン
#     node.neighbors.each do |neighbor|
#       clone.neighbors << dfs(neighbor, cloned)
#     end

#     return clone
#   end

#   dfs(node, cloned)  # ノードのクローンを再帰的に実行
# end
# ```

# ### 4. DFSを使用する理由

# DFSを使うことで、1つのノードからスタートして全ての隣接ノードにアクセスし、それを再帰的に繰り返してグラフ全体を探索することが可能です。また、DFSを使用すると、ノードのクローン作成時にバックトラックしながらコピーが容易に行えます。
