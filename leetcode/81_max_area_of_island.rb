# You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

# The area of an island is the number of cells with a value 1 in the island.

# Return the maximum area of an island in grid. If there is no island, return 0.

# m × n のバイナリマトリックスgridが与えられます。島は、4方向（水平方向または垂直方向）に接続された '1' のグループ（陸地）を表します。グリッドの4つの端はすべて水で囲まれていると仮定してよいです。

# 島の面積は、その島に含まれる '1' のセルの数です。

# grid 内の島の最大面積を返してください。島がない場合は 0 を返します。

# Example 1:


# Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
# Output: 6
# Explanation: The answer is not 11, because the island must be connected 4-directionally.
# Example 2:

# Input: grid = [[0,0,0,0,0,0,0,0]]
# Output: 0
 

# Constraints:

# m == grid.length
# n == grid[i].length
# 1 <= m, n <= 50
# grid[i][j] is either 0 or 1.

# 解法
# 深さ優先探索（DFS） を使用して、島の面積を計算します。
# グリッドを全てスキャンし、'1' が見つかれば、DFSでその島全体を探索し、その面積を計算します。
# 探索済みのセルは'0'に置き換えて再探索を防ぎます。
# 全ての島の面積の中で最大の面積を返します。

def dfs(grid, i, j)
  # グリッドの境界外、または水（0）に到達した場合、面積0を返す
  return 0 if i < 0 || j < 0 || i >= grid.length || j >= grid[0].length || grid[i][j] == 0
  
  # 現在の位置の陸地を訪問済みにする（0に変える）
  grid[i][j] = 0
  
  # 現在の位置の面積は1（陸地1セル分）
  area = 1
  
  # 4方向（上下左右）にDFSを再帰的に探索して面積を加算
  area += dfs(grid, i + 1, j) # 下方向
  area += dfs(grid, i - 1, j) # 上方向
  area += dfs(grid, i, j + 1) # 右方向
  area += dfs(grid, i, j - 1) # 左方向
  
  # 合計面積を返す
  return area
end

def max_area_of_island(grid)
  max_area = 0  # 最大の島の面積を保存する変数
  
  # グリッド全体を探索するループ
  (0...grid.length).each do |i|
    (0...grid[0].length).each do |j|
      # 陸地（1）を見つけたら、その島の面積を計算
      if grid[i][j] == 1
        current_area = dfs(grid, i, j)  # DFSで島の面積を計算
        max_area = [max_area, current_area].max  # 最大面積を更新
        puts "Found island with area #{current_area} at position (#{i}, #{j})"
      end
    end
  end
  
  # 最大の島の面積を出力
  puts "Maximum island area is #{max_area}"
  
  # 最大の島の面積を返す
  return max_area
end

# テストケース
grid = [
  [0,0,1,0,0,0,0,1,0,0,0,0,0],
  [0,0,0,0,0,0,0,1,1,1,0,0,0],
  [0,1,1,0,1,0,0,0,0,0,0,0,0],
  [0,1,0,0,1,1,0,0,1,0,1,0,0],
  [0,1,0,0,1,1,0,0,1,1,1,0,0],
  [0,0,0,0,0,0,0,0,0,0,1,0,0],
  [0,0,0,0,0,0,0,1,1,1,0,0,0],
  [0,0,0,0,0,0,0,1,1,0,0,0,0]
]

puts max_area_of_island(grid)
