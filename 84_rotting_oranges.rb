# You are given an m x n grid where each cell can have one of three values:

# 0 representing an empty cell,
# 1 representing a fresh orange, or
# 2 representing a rotten orange.
# Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.

# Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return -1.

# あなたは、m x n グリッドを与えられ、その各セルは次の3つの値のいずれかを持つことができます：

# 0: 空のセルを表します。
# 1: 新鮮なオレンジを表します。
# 2: 腐ったオレンジを表します。
# 毎分、腐ったオレンジに隣接する（上下左右の4方向）新鮮なオレンジは腐ります。

# すべての新鮮なオレンジが腐るまでにかかる最小の分数を返してください。もしすべての新鮮なオレンジを腐らせることが不可能な場合、-1を返してください。

# Example 1:


# Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
# Output: 4
# Example 2:

# Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
# Output: -1
# Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.
# Example 3:

# Input: grid = [[0,2]]
# Output: 0
# Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.
 

# Constraints:

# m == grid.length
# n == grid[i].length
# 1 <= m, n <= 10
# grid[i][j] is 0, 1, or 2.



# 解説
# この問題は、**幅優先探索（BFS）**を使って解決するのが効率的です。なぜなら、腐ったオレンジが隣接する新鮮なオレンジを徐々に腐らせる様子は、グラフ探索のように処理できるからです。

# アプローチ
# 初期状態の収集:

# まず、グリッド内のすべての腐ったオレンジの位置をキューに入れます。また、新鮮なオレンジの数もカウントします。
# BFSを使って腐るプロセスをシミュレーション:

# 腐ったオレンジをキューから取り出し、隣接する新鮮なオレンジを腐らせます。その新しく腐ったオレンジを次の探索用にキューに追加します。
# 終了条件:

# 新鮮なオレンジがすべて腐ったら、腐らせるのにかかった分数を返します。もし腐らせることができない新鮮なオレンジが残っていたら -1 を返します。

def oranges_rotting(grid)
  rows = grid.length
  cols = grid[0].length
  queue = []
  fresh_count = 0
  
  # 初期状態で腐ったオレンジをキューに追加し、新鮮なオレンジの数をカウント
  (0...rows).each do |i|
    (0...cols).each do |j|
      if grid[i][j] == 2
        queue << [i, j]
      elsif grid[i][j] == 1
        fresh_count += 1
      end
    end
  end
  
  return 0 if fresh_count == 0 # 新鮮なオレンジがない場合、すぐに0を返す

  # 方向を示す配列（上、下、左、右）
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  minutes_passed = 0
  
  # BFSスタート
  while !queue.empty?
    size = queue.size
    minutes_passed += 1
    puts "Minute #{minutes_passed}, rotting oranges: #{queue.size}"
    
    size.times do
      x, y = queue.shift
      p "Processing orange at [#{x}, #{y}]"
      
      directions.each do |dx, dy|
        new_x, new_y = x + dx, y + dy
        if new_x >= 0 && new_x < rows && new_y >= 0 && new_y < cols && grid[new_x][new_y] == 1
          grid[new_x][new_y] = 2 # 新鮮なオレンジを腐らせる
          fresh_count -= 1
          queue << [new_x, new_y] # 新しく腐ったオレンジをキューに追加
          puts "Orange at [#{new_x}, #{new_y}] is now rotten."
        end
      end
    end
  end
  
  puts "Fresh oranges remaining: #{fresh_count}"
  
  # 新鮮なオレンジが残っていたら -1 を返す
  fresh_count == 0 ? minutes_passed - 1 : -1
end

# テストケースの実行
grid = [[2,1,1],[1,1,0],[0,1,1]]
puts "Grid before rotting: #{grid.map(&:inspect)}"
result = oranges_rotting(grid)
puts "Result: #{result}"
