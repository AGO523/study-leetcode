# You are given an n x n integer matrix grid where each value grid[i][j] represents the elevation at that point (i, j).

# The rain starts to fall. At time t, the depth of the water everywhere is t. You can swim from a square to another 4-directionally adjacent square if and only if the elevation of both squares individually are at most t. You can swim infinite distances in zero time. Of course, you must stay within the boundaries of the grid during your swim.

# Return the least time until you can reach the bottom right square (n - 1, n - 1) if you start at the top left square (0, 0).

# n x n の整数マトリックス grid が与えられます。各セル grid[i][j] は、その地点の標高（高度）を表しています。

# 雨が降り始めます。時間 t の時点では、水の深さはどこでも t です。あなたは、あるセルから上下左右に隣接する別のセルに泳ぐことができますが、その条件は次のとおりです：

# 両方のセルの標高が、時間 t の時点での水の深さ t 以下である必要があります。
# マトリックスの範囲を超えることはできません。
# あなたは左上のセル (0, 0) からスタートし、右下のセル (n - 1, n - 1) に到達するのに必要な最小の時間 t を求めてください。

# Example 1:


# Input: grid = [[0,2],[1,3]]
# Output: 3
# Explanation:
# At time 0, you are in grid location (0, 0).
# You cannot go anywhere else because 4-directionally adjacent neighbors have a higher elevation than t = 0.
# You cannot reach point (1, 1) until time 3.
# When the depth of water is 3, we can swim anywhere inside the grid.
# Example 2:


# Input: grid = [[0,1,2,3,4],[24,23,22,21,5],[12,13,14,15,16],[11,17,18,19,20],[10,9,8,7,6]]
# Output: 16
# Explanation: The final route is shown.
# We need to wait until time 16 so that (0, 0) and (4, 4) are connected.
 

# Constraints:

# n == grid.length
# n == grid[i].length
# 1 <= n <= 50
# 0 <= grid[i][j] < n2
# Each value grid[i][j] is unique.

# アプローチと解説
# この問題は、左上から右下に行くために必要な最小の時間を求める、パス検索問題です。各セルの値（標高）が移動可能かどうかを決定するため、特定のアルゴリズムを使用して、最適なルートを見つける必要があります。

# 使用するアルゴリズム：ダイクストラ法（Dijkstra's Algorithm）
# この問題は、最短経路問題と同様の性質を持っていますが、条件として「時間 t が必要」という制約があります。そのため、最小の時間 t で到達可能かどうかを探索しながら、以下の手順で進めます：

# ダイクストラ法を使用して、左上のセル (0, 0) からスタートし、右下のセル (n-1, n-1) に到達できる最小の t を求めます。
# 各セルの標高（grid[i][j]）は、水の深さ t の時点で grid[i][j] <= t であれば移動可能です。
# 優先度付きキューを使い、探索中の最小値を管理します。
# 実装の詳細
# スタート時のセルの値 grid[0][0] を基準に、優先度付きキューを使って探索します。
# 各セル (i, j) に対し、その隣接セル（上下左右）への移動可能性をチェックし、条件を満たす場合に移動し、そのセルまでの最大値（深さ t）を更新します。
# 最後に右下のセル (n-1, n-1) に到達する時点の t を返します。


# 最小ヒープのクラスを定義（優先度付きキューとして使用）
class MinHeap
  def initialize
    @heap = []  # ヒープを管理する配列
  end

  # ノードをヒープに挿入
  def push(node, cost)
    @heap << [cost, node]  # [優先度（コスト）, ノード] のペアとして挿入
    bubble_up(@heap.size - 1)  # 上向きにヒープ特性を修正
  end

  # 最小値を取り出して削除
  def pop
    return if @heap.empty?  # ヒープが空の場合は何も返さない

    swap(0, @heap.size - 1)  # ルートと末尾のノードを交換
    min = @heap.pop  # 最小値を取得し、削除
    bubble_down(0)   # ヒープ特性を下向きに修正
    min[1]  # [cost, node] の node 部分を返す
  end

  # ヒープが空かどうかを確認
  def empty?
    @heap.empty?
  end

  private

  # ノードを上向きに移動し、ヒープ特性を修正
  def bubble_up(index)
    parent_index = (index - 1) / 2  # 親ノードのインデックスを計算
    return if index <= 0 || @heap[parent_index][0] <= @heap[index][0]

    swap(index, parent_index)  # 親ノードと交換
    bubble_up(parent_index)    # 再帰的に修正
  end

  # ノードを下向きに移動し、ヒープ特性を修正
  def bubble_down(index)
    child_index = (index * 2) + 1  # 左の子ノードのインデックスを計算
    return if child_index >= @heap.size

    right_child = child_index + 1
    # 右の子の方が小さい場合は右の子を選択
    child_index = right_child if right_child < @heap.size && @heap[right_child][0] < @heap[child_index][0]

    return if @heap[index][0] <= @heap[child_index][0]

    swap(index, child_index)  # 子ノードと交換
    bubble_down(child_index)  # 再帰的に修正
  end

  # 2つのノードを入れ替える
  def swap(i, j)
    @heap[i], @heap[j] = @heap[j], @heap[i]
  end
end

# 移動方向を定義（上下左右）
DIRECTIONS = [[0, 1], [1, 0], [-1, 0], [0, -1]]

# 最小時間を求めるメイン関数
def swim_in_water(grid)
  n = grid.size  # グリッドのサイズ（n x n）

  # 最小ヒープ（優先度付きキュー）を初期化
  pq = MinHeap.new
  pq.push([0, 0], grid[0][0])  # スタート地点（0,0）の標高をキューに追加
  visited = Array.new(n) { Array.new(n, false) }  # 訪問フラグを管理
  visited[0][0] = true  # スタート地点を訪問済みとする
  time = 0  # 到達するために必要な最小時間を管理

  puts "初期状態:"
  puts "グリッドサイズ: #{n} x #{n}"
  puts "優先度付きキュー: #{@heap.inspect}"

  # キューが空になるまで探索
  while !pq.empty?
    # 現在の最小値のノードを取り出す
    x, y = pq.pop
    puts "現在位置: (#{x}, #{y}), 現在の標高: #{grid[x][y]}"

    # 現在のルートの最大標高を更新
    # 一度通過した経路上で最も高い標高を求め、その時間 t まで待たなければならない
    time = [time, grid[x][y]].max
    puts "現在の最大標高（到達可能な時間）: #{time}"

    # 右下のセルに到達したら、そのときの時間を返す
    return time if x == n - 1 && y == n - 1

    # 4方向に隣接するセルを確認
    DIRECTIONS.each do |dx, dy|
      # nx は次の x 座標、ny は次の y 座標
      nx, ny = x + dx, y + dy

      # 範囲内で、かつ未訪問のセルならヒープに追加
      if nx.between?(0, n - 1) && ny.between?(0, n - 1) && !visited[nx][ny]
        visited[nx][ny] = true  # 訪問済みとしてマーク
        pq.push([nx, ny], grid[nx][ny])  # 隣接セルをヒープに追加
        puts "新しいセルを追加: (#{nx}, #{ny}), 標高: #{grid[nx][ny]}"
      end
    end
    puts "現在のヒープの状態: #{pq.inspect}"
  end
end

# テストケース1
# puts "テストケース1: "
# grid1 = [[0, 2], [1, 3]]
# puts "出力: #{swim_in_water(grid1)}"  # 期待される出力: 3

# テストケース2
puts "\nテストケース2: "
grid2 = [[0, 1, 2, 3, 4], [24, 23, 22, 21, 5], [12, 13, 14, 15, 16], [11, 17, 18, 19, 20], [10, 9, 8, 7, 6]]
puts "出力: #{swim_in_water(grid2)}"  # 期待される出力: 16
