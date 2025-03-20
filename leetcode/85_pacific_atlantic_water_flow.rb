# There is an m x n rectangular island that borders both the Pacific Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left and top edges, and the Atlantic Ocean touches the island's right and bottom edges.

# The island is partitioned into a grid of square cells. You are given an m x n integer matrix heights where heights[r][c] represents the height above sea level of the cell at coordinate (r, c).

# The island receives a lot of rain, and the rain water can flow to neighboring cells directly north, south, east, and west if the neighboring cell's height is less than or equal to the current cell's height. Water can flow from any cell adjacent to an ocean into the ocean.

# Return a 2D list of grid coordinates result where result[i] = [ri, ci] denotes that rain water can flow from cell (ri, ci) to both the Pacific and Atlantic oceans.

 

# Example 1:


# Input: heights = [[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]
# Output: [[0,4],[1,3],[1,4],[2,2],[3,0],[3,1],[4,0]]
# Explanation: The following cells can flow to the Pacific and Atlantic oceans, as shown below:
# [0,4]: [0,4] -> Pacific Ocean 
#        [0,4] -> Atlantic Ocean
# [1,3]: [1,3] -> [0,3] -> Pacific Ocean 
#        [1,3] -> [1,4] -> Atlantic Ocean
# [1,4]: [1,4] -> [1,3] -> [0,3] -> Pacific Ocean 
#        [1,4] -> Atlantic Ocean
# [2,2]: [2,2] -> [1,2] -> [0,2] -> Pacific Ocean 
#        [2,2] -> [2,3] -> [2,4] -> Atlantic Ocean
# [3,0]: [3,0] -> Pacific Ocean 
#        [3,0] -> [4,0] -> Atlantic Ocean
# [3,1]: [3,1] -> [3,0] -> Pacific Ocean 
#        [3,1] -> [4,1] -> Atlantic Ocean
# [4,0]: [4,0] -> Pacific Ocean 
#        [4,0] -> Atlantic Ocean
# Note that there are other possible paths for these cells to flow to the Pacific and Atlantic oceans.
# Example 2:

# Input: heights = [[1]]
# Output: [[0,0]]
# Explanation: The water can flow from the only cell to the Pacific and Atlantic oceans.
 

# Constraints:

# m == heights.length
# n == heights[r].length
# 1 <= m, n <= 200
# 0 <= heights[r][c] <= 105

# 解説
# この問題では、セルが2つの海（太平洋と大西洋）の両方に到達できるかどうかを判断するために、逆方向から水が流れるかをシミュレーションします。具体的には、**深さ優先探索（DFS）**を使って各セルからどちらの海にも水が流れられるかどうかを確認します。

# アプローチ
# スタート地点の設定:

# 太平洋に水が流れ込む可能性のあるセルは、島の上端および左端のセルです。
# 大西洋に水が流れ込む可能性のあるセルは、島の右端および下端のセルです。
# DFSを使って、各セルから水が太平洋や大西洋に流れられるかどうかを探索します。

# 両方の海に水が到達できるセルのリストを返します。


def pacific_atlantic(heights)
  return [] if heights.nil? || heights.empty?

  rows = heights.length
  cols = heights[0].length
  pacific = Array.new(rows) { Array.new(cols, false) }
  atlantic = Array.new(rows) { Array.new(cols, false) }
  
  # 方向を示す配列
  directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]

  # DFSメソッド: セル(r, c)から水が流れるかを確認
  def dfs(heights, visited, r, c, directions)
    visited[r][c] = true
    directions.each do |dr, dc|
      new_r, new_c = r + dr, c + dc
      if new_r >= 0 && new_r < heights.length && new_c >= 0 && new_c < heights[0].length && 
         !visited[new_r][new_c] && heights[new_r][new_c] >= heights[r][c]
        dfs(heights, visited, new_r, new_c, directions)
      end
    end
  end

  # 太平洋と大西洋の境界からDFSを行う
  (0...rows).each do |i|
    dfs(heights, pacific, i, 0, directions)    # 左端 (太平洋)
    dfs(heights, atlantic, i, cols - 1, directions) # 右端 (大西洋)
  end

  (0...cols).each do |i|
    dfs(heights, pacific, 0, i, directions)    # 上端 (太平洋)
    dfs(heights, atlantic, rows - 1, i, directions) # 下端 (大西洋)
  end

  # 両方に到達できるセルを結果に追加
  result = []
  (0...rows).each do |r|
    (0...cols).each do |c|
      if pacific[r][c] && atlantic[r][c]
        result << [r, c]
      end
    end
  end
  
  puts "Cells where water flows to both oceans: #{result}"
  result
end

# テストケースの実行
heights = [
  [1, 2, 2, 3, 5],
  [3, 2, 3, 4, 4],
  [2, 4, 5, 3, 1],
  [6, 7, 1, 4, 5],
  [5, 1, 1, 2, 4]
]
puts "Grid heights: #{heights.map(&:inspect)}"
result = pacific_atlantic(heights)
puts "Result: #{result}"

# この部分は、**DFS（深さ優先探索）**の中で、次に探索するセル（`new_r`, `new_c`）が有効な範囲内にあり、そのセルにまだ訪れていないかどうか、そして水が流れる条件を満たしているかどうかをチェックするための条件式です。1行ずつ説明します。

# ```ruby
# if new_r >= 0 && new_r < heights.length && new_c >= 0 && new_c < heights[0].length &&
#          !visited[new_r][new_c] && heights[new_r][new_c] >= heights[r][c]
# ```

# ### 1. `new_r >= 0 && new_r < heights.length`
# この部分では、新しく計算された行 `new_r` がグリッドの範囲内かどうかをチェックしています。
# - `new_r >= 0` では、`new_r` が負にならないことを確認し、上の境界を超えないことを保証します。
# - `new_r < heights.length` では、`new_r` が行数 (`heights.length`) の範囲内であることを確認し、下の境界を超えないことを保証します。

# ### 2. `new_c >= 0 && new_c < heights[0].length`
# 次に、新しく計算された列 `new_c` がグリッドの範囲内かどうかをチェックしています。
# - `new_c >= 0` では、`new_c` が負にならないことを確認し、左の境界を超えないことを保証します。
# - `new_c < heights[0].length` では、`new_c` が列数の範囲内であることを確認し、右の境界を超えないことを保証します。

# ### 3. `!visited[new_r][new_c]`
# この部分では、新しく移動しようとしているセル `(new_r, new_c)` にまだ訪れていないかどうかを確認しています。
# - `visited[new_r][new_c]` は、このセルがすでに訪問されたかどうかをチェックします。`!visited[new_r][new_c]` は、それが **まだ訪問されていない場合** に `true` になります。

# ### 4. `heights[new_r][new_c] >= heights[r][c]`
# 最後に、移動先のセル `(new_r, new_c)` の高さが、現在のセル `(r, c)` の高さよりも **同じか高い** かどうかを確認しています。水は高いところから低いところには流れられますが、逆に低いところから高いところには流れられないので、移動先のセルの高さが現在のセルよりも低い場合にはその方向には進めません。

# ### 結論
# この条件は、新しいセル `(new_r, new_c)` が有効な範囲にあり、まだ訪問されておらず、かつ水が流れることができる（高さが現在のセルよりも同じか高い）場合にのみ、DFSを続けてそのセルを探索するための条件です。
