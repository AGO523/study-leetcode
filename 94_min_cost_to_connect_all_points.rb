# You are given an array points representing integer coordinates of some points on a 2D-plane, where points[i] = [xi, yi].

# The cost of connecting two points [xi, yi] and [xj, yj] is the manhattan distance between them: |xi - xj| + |yi - yj|, where |val| denotes the absolute value of val.

# Return the minimum cost to make all points connected. All points are connected if there is exactly one simple path between any two points.

# 2D平面上にいくつかの点が与えられます。points[i] = [xi, yi] は、点の座標を表しています。

# 2つの点 [xi, yi] と [xj, yj] を接続するコストは、マンハッタン距離で計算されます。マンハッタン距離は次の式で表されます：

# |xi - xj| + |yi - yj|
# （ここで、|val| は val の絶対値を示します）

# すべての点を接続するのに必要な最小コストを返してください。すべての点が接続されているとは、どの2つの点の間にもちょうど1つの単純パスが存在することを意味します（グラフが木構造であることを指します）。

# Example 1:


# Input: points = [[0,0],[2,2],[3,10],[5,2],[7,0]]
# Output: 20
# Explanation: 

# We can connect the points as shown above to get the minimum cost of 20.
# Notice that there is a unique path between every pair of points.
# Example 2:

# Input: points = [[3,12],[-2,5],[-4,1]]
# Output: 18
 

# Constraints:

# 1 <= points.length <= 1000
# -106 <= xi, yi <= 106
# All pairs (xi, yi) are distinct.

# プログラム解説と実装
# この問題は、最小全域木（Minimum Spanning Tree: MST） の典型的な問題です。与えられた点の集合を「頂点」と見なし、マンハッタン距離を「エッジのコスト」として考え、すべての点を最小のコストで接続することを求めています。

# アルゴリズムの選択
# 最小全域木を求めるには、次の2つのアルゴリズムが一般的に使用されます：

# クラスカル法（Kruskal's Algorithm）:

# エッジをコストの昇順にソートし、重みの小さい順に選択していき、サイクルを形成しないように木を構築します。
# Union-Find データ構造を使用して、サイクルを検出し、各頂点を管理します。
# プリム法（Prim's Algorithm）:

# 1つの点から始め、最小コストのエッジを順次追加して木を拡張します。
# 最小ヒープ（優先度付きキュー）を用いることで、探索を効率化します。
# ここでは、クラスカル法を使用して最小全域木を構築します。

# Union-Find クラスを定義（クラスカル法で使用）
class UnionFind
  def initialize(size)
    @parent = (0...size).to_a  # 各ノードの親を自分自身に初期化
    @rank = Array.new(size, 1) # ランクを1に初期化
  end

  # ルートノードを見つける（経路圧縮を行う）
  def find(x)
    # この条件は、x がルートノードでないときに true となります。
    if x != @parent[x]
      # 再帰的に親ノード（@parent[x]）の find を行い、ルートノードを取得します。
      # そのルートノードを @parent[x] に代入することにより、要素 x の親を直接的にルートノードに変更しています。
      # 下記で@parent[x]にその時点のルートノードを代入することで、経路圧縮を行っている
      @parent[x] = find(@parent[x])
    end
    @parent[x]
  end

  # 2つのノードを結合する（ランクを考慮して結合）
  def union(x, y)
    rootX = find(x)
    rootY = find(y)
    return if rootX == rootY

    # ランクの高い方を親とする
    if @rank[rootX] > @rank[rootY]
      @parent[rootY] = rootX
    elsif @rank[rootX] < @rank[rootY]
      @parent[rootX] = rootY
    else
      @parent[rootY] = rootX
      @rank[rootX] += 1
    end
  end

  # 同じグループ（親が同じ）かを確認
  # 同じだった場合は、サイクルを形成するため、エッジを追加しない
  def connected?(x, y)
    find(x) == find(y)
  end
end

# 最小コストで点を接続する関数
def min_cost_connect_points(points)
  puts "入力された点: #{points}"

  # 点の総数
  n = points.length
  edges = []

  # すべての点のペアについて、エッジとそのコストを計算
  (0...n).each do |i|
    (i+1...n).each do |j|
      xi, yi = points[i]
      xj, yj = points[j]
      cost = (xi - xj).abs + (yi - yj).abs  # マンハッタン距離を計算
      edges << [cost, i, j]  # [コスト, 点i, 点j] の形式でエッジを保存
      puts "エッジを追加: 点#{i} -> 点#{j}, コスト: #{cost}"
      # ここでの点は、例えば、[0,0] などの座標を表す
      # [0,0] と [2,2] のマンハッタン距離は、|0-2| + |0-2| = 4 となる
    end
  end

  # コストの昇順にエッジをソート
  edges.sort!
  puts "ソートされたエッジ: #{edges}"

  # Union-Find を初期化
  uf = UnionFind.new(n)

  # 最小全域木を構築し、最小コストを求める
  min_cost = 0
  edge_count = 0

  edges.each do |cost, i, j|
    # サイクルを形成しないエッジを追加する
    unless uf.connected?(i, j)
      uf.union(i, j)  # ノード i と j を結合
      min_cost += cost  # コストを追加
      edge_count += 1
      puts "エッジを選択: 点#{i} -> 点#{j}, コスト: #{cost}, 現在の合計コスト: #{min_cost}"

      # n - 1 エッジを追加したら終了（すべての点が繋がる）
      break if edge_count == n - 1
    end
  end

  puts "最小コスト: #{min_cost}"
  min_cost
end

# テストケース1
puts "テストケース1: "
points1 = [[0,0],[2,2],[3,10],[5,2],[7,0]]
result1 = min_cost_connect_points(points1)
puts "出力: #{result1}"  # 期待される出力: 20

# テストケース2
puts "\nテストケース2: "
points2 = [[3,12],[-2,5],[-4,1]]
result2 = min_cost_connect_points(points2)
puts "出力: #{result2}"  # 期待される出力: 18
