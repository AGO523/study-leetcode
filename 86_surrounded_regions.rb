# You are given an m x n matrix board containing letters 'X' and 'O', capture regions that are surrounded:

# Connect: A cell is connected to adjacent cells horizontally or vertically.
# Region: To form a region connect every 'O' cell.
# Surround: The region is surrounded with 'X' cells if you can connect the region with 'X' cells and none of the region cells are on the edge of the board.
# A surrounded region is captured by replacing all 'O's with 'X's in the input matrix board.

# あなたは、文字 'X' と 'O' が含まれている m x n のマトリックス board を与えられます。囲まれている領域を「キャプチャ」してください。

# 接続（Connect）: 各セルは、隣接するセルに対して水平方向または垂直方向に接続されています。
# 領域（Region）: 'O' セルをすべて接続して領域を形成します。
# 囲む（Surround）: ある領域がボードの端に存在しない限り、すべての 'O' セルを 'X' セルで囲むことができます。
# 囲まれた領域は、入力マトリックス内のすべての 'O' を 'X' に置き換えます。

# Example 1:

# Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]

# Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]

# Explanation:


# In the above diagram, the bottom region is not captured because it is on the edge of the board and cannot be surrounded.

# Example 2:

# Input: board = [["X"]]

# Output: [["X"]]

 

# Constraints:

# m == board.length
# n == board[i].length
# 1 <= m, n <= 200
# board[i][j] is 'X' or 'O'.

# 解答の解説
# この問題の目標は、ボード内のすべての 'O' セルを調査し、それが囲まれていれば 'X' に変換することです。囲まれていない 'O' セルはそのまま残ります。境界に接している 'O' はキャプチャできないため、それらに接している 'O' も同様にキャプチャしません。

# アプローチ:
# ボードの境界に接している 'O' セルをDFSまたはBFSを使用して探し、それに接続されている全ての 'O' をマークします。
# マークされていない 'O' は囲まれているため、これを 'X' に置き換えます。
# マークされた 'O' はそのままにします。

def solve(board)
  return if board.empty? || board[0].empty?

  rows, cols = board.size, board[0].size
  puts "Initial board:"
  board.each { |row| puts row.join(' ') } # 初期状態のボードを表示

  # 境界の 'O' を DFS で探索し、マークする
  (0...rows).each do |r|
    if board[r][0] == 'O'
      puts "DFS on border cell: (#{r}, 0)"
      dfs(board, r, 0) # 左の境界
    end
    if board[r][cols - 1] == 'O'
      puts "DFS on border cell: (#{r}, #{cols - 1})"
      dfs(board, r, cols - 1) # 右の境界
    end
  end

  (0...cols).each do |c|
    if board[0][c] == 'O'
      puts "DFS on border cell: (0, #{c})"
      dfs(board, 0, c) # 上の境界
    end
    if board[rows - 1][c] == 'O'
      puts "DFS on border cell: (#{rows - 1}, #{c})"
      dfs(board, rows - 1, c) # 下の境界
    end
  end

  puts "\nBoard after marking:"
  board.each { |row| puts row.join(' ') } # マーク後のボードを表示

  # 'O' を 'X' に変え、マークされた '*' を元の 'O' に戻す
  (0...rows).each do |r|
    (0...cols).each do |c|
      if board[r][c] == 'O'
        board[r][c] = 'X' # 囲まれている 'O' を 'X' に
      elsif board[r][c] == '*'
        board[r][c] = 'O' # マークされた '*' を 'O' に戻す
      end
    end
  end

  puts "\nFinal board:"
  board.each { |row| puts row.join(' ') } # 最終状態のボードを表示
end

def dfs(board, r, c)
  return if r < 0 || c < 0 || r >= board.size || c >= board[0].size || board[r][c] != 'O'

  puts "Marking cell (#{r}, #{c}) as part of border-connected region"
  board[r][c] = '*' # マークする

  # 四方向に探索する
  dfs(board, r - 1, c) # 上
  dfs(board, r + 1, c) # 下
  dfs(board, r, c - 1) # 左
  dfs(board, r, c + 1) # 右
end

# テストケースの実行
board = [["X", "X", "X", "X"],
         ["X", "O", "O", "X"],
         ["X", "X", "O", "X"],
         ["X", "O", "X", "X"]]

solve(board)
