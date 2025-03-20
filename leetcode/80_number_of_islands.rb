# Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

# An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

# m × n の2次元のバイナリグリッドgridが与えられます。これは、'1'（陸地）と '0'（水）を表します。島の数を返してください。

# 島は水で囲まれており、隣接する陸地（水平または垂直に隣接しているもの）を接続して形成されます。グリッドの4つの端はすべて水で囲まれていると仮定してよいです。

# Example 1:

# Input: grid = [
#   ["1","1","1","1","0"],
#   ["1","1","0","1","0"],
#   ["1","1","0","0","0"],
#   ["0","0","0","0","0"]
# ]
# Output: 1
# Example 2:

# Input: grid = [
#   ["1","1","0","0","0"],
#   ["1","1","0","0","0"],
#   ["0","0","1","0","0"],
#   ["0","0","0","1","1"]
# ]
# Output: 3
 

# Constraints:

# m == grid.length
# n == grid[i].length
# 1 <= m, n <= 300
# grid[i][j] is '0' or '1'.

# 解説とアルゴリズム
# この問題では、島を構成する陸地の塊を数えることが目的です。島は互いに連結した '1' で構成されており、垂直または水平に隣接する陸地をDFS（深さ優先探索）やBFS（幅優先探索）で探索してカウントします。

# 解法
# 深さ優先探索（DFS） を使用して島の数をカウントします。
# グリッドを左上から右下までスキャンし、'1' を見つけたらDFSを実行し、島を構成する全ての陸地を探索してカウントします。
# 探索済みの陸地は再度カウントされないように、探索中に'1'を'0'に書き換えて無効化します。

def num_islands(grid)
  # グリッドが空の場合、島は0
  return 0 if grid.empty?
  
  # グリッドのサイズ
  rows = grid.length
  cols = grid[0].length
  island_count = 0

  # 深さ優先探索(DFS)メソッド
  def dfs(grid, i, j)
    p "Checking cell (#{i}, #{j})"
    # グリッド外、または水('0')の場合は探索を終了
    return if i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] == '0'

    # 探索済みの陸地は '0' にする
    grid[i][j] = '0'

    # 四方向へ探索（上、下、左、右）
    dfs(grid, i + 1, j)  # 下
    dfs(grid, i - 1, j)  # 上
    dfs(grid, i, j + 1)  # 右
    dfs(grid, i, j - 1)  # 左
  end

  # グリッドの全てのセルをチェック
  (0...rows).each do |i|
    (0...cols).each do |j|
      # '1'が見つかった場合、新しい島としてDFSを開始
      if grid[i][j] == '1'
        puts "New island found at (#{i}, #{j})"
        island_count += 1
        dfs(grid, i, j)
      end
    end
  end

  puts "Total islands: #{island_count}"
  island_count
end

# 実行例
grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]

island_count = num_islands(grid)
puts "Number of islands: #{island_count}"
