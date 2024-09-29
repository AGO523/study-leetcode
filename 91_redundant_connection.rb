# In this problem, a tree is an undirected graph that is connected and has no cycles.

# You are given a graph that started as a tree with n nodes labeled from 1 to n, with one additional edge added. The added edge has two different vertices chosen from 1 to n, and was not an edge that already existed. The graph is represented as an array edges of length n where edges[i] = [ai, bi] indicates that there is an edge between nodes ai and bi in the graph.

# Return an edge that can be removed so that the resulting graph is a tree of n nodes. If there are multiple answers, return the answer that occurs last in the input.

# この問題では、木とは、すべてのノードが接続されており、サイクル（閉路）が存在しない無向グラフのことを指します。

# あなたは、ノードが 1 から n まで番号付けされた n 個のノードを持つ木のグラフを与えられます。
# この木には、1本の追加された余分なエッジが存在しています。
# この余分なエッジは、元々木であったグラフを変更し、1本だけ余分なエッジを持つサイクルが含まれたグラフになっています。
# 与えられたグラフは edges 配列として表され、edges[i] = [ai, bi] は、ノード ai と bi の間にエッジがあることを意味します。

# このグラフから1本のエッジを取り除いて、元の木に戻す必要があります。結果として、取り除くべきエッジを返してください。

# もし取り除くことができるエッジが複数ある場合は、入力配列で最後に登場するエッジを選んでください。


# Example 1:


# Input: edges = [[1,2],[1,3],[2,3]]
# Output: [2,3]
# Example 2:


# Input: edges = [[1,2],[2,3],[3,4],[1,4],[1,5]]
# Output: [1,4]
 

# Constraints:

# n == edges.length
# 3 <= n <= 1000
# edges[i].length == 2
# 1 <= ai < bi <= edges.length
# ai != bi
# There are no repeated edges.
# The given graph is connected.

# 解説とコメント付きプログラム
# この問題を解くには、Union-Find（またはDisjoint Set）というデータ構造を使います。このデータ構造は、ノード間のグループ（連結成分）を管理し、サイクルを検出するのに適しています。

# Union-Find (Disjoint Set) を用いることでサイクル検出を行います
class UnionFind
  # 初期化
  def initialize(size)
    @parent = (0..size).to_a    # 各ノードの親を自分自身に初期化
    @rank = Array.new(size + 1, 1) # 各ノードのランクを1に初期化
  end

  # ノードの根を見つける (経路圧縮を行い、検索を高速化)
  def find(x)
    if x != @parent[x]
      @parent[x] = find(@parent[x]) # 親を直接根に繋ぎ直す
    end
    return @parent[x]
  end

  #   Union-Findにおけるランクの使い方
  # Union-Find の各ノードは以下のような属性を持ちます：

  # 親ノード（parent）: そのノードが指している親ノード（通常は自分自身を指すことで初期化されます）。
  # ランク（rank）: 木の高さを表す指標（初期値は1）。
  # ランクの考え方を使った結合（union）操作
  # 2つのノードを統合する際には、まずそれぞれの根（親ノード）を見つけます。
  # ランクが高い方を親にすることで、木の高さを最小限に抑えます。
  # 結合後に、ランクが同じ場合は、親となった木のランクを1つ増加させます。
  # 二つのノードを統合する (ランクを考慮して効率よく結合)
  def union(x, y)
    rootX = find(x)
    rootY = find(y)
    if rootX != rootY
      # ランクの高い方を親とする（ランクが同じ場合はランクを増やす）
      if @rank[rootX] > @rank[rootY]
        @parent[rootY] = rootX
      elsif @rank[rootX] < @rank[rootY]
        @parent[rootX] = rootY
      else
        @parent[rootY] = rootX
        @rank[rootX] += 1
      end
    end
  end

  # 同じグループ（親が同じ）かを確認
  def connected?(x, y)
    find(x) == find(y)
  end
end

# メインの関数
def find_redundant_connection(edges)
  puts "Union-Find を初期化します"
  n = edges.length
  uf = UnionFind.new(n) # Union-Find を n 個のノードで初期化


  puts "エッジを順番に確認します"
  # 各エッジを確認
  edges.each do |edge|
    u, v = edge
    puts "エッジ #{edge} を確認しています..."
    if uf.connected?(u, v)
      # もし u と v がすでに同じグループ（サイクル）なら、このエッジを返す
      puts "エッジ #{edge} はサイクルを作るので、このエッジを削除します"
      return edge
    else
      # そうでなければ、エッジを追加（結合）する
      uf.union(u, v)
      puts "エッジ #{edge} を追加しました。現在のグラフにはサイクルはありません。"
    end
  end
end

# テスト例
# edges1 = [[1, 2], [1, 3], [2, 3]]
# puts "入力: #{edges1}"
# puts "出力: #{find_redundant_connection(edges1)}" # 期待される出力: [2, 3]

edges2 = [[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]
puts "入力: #{edges2}"
puts "出力: #{find_redundant_connection(edges2)}" # 期待される出力: [1, 4]
