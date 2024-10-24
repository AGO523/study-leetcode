# Given an m x n integers matrix, return the length of the longest increasing path in matrix.

# From each cell, you can either move in four directions: left, right, up, or down. You may not move diagonally or move outside the boundary (i.e., wrap-around is not allowed).

# m x n の整数行列 matrix が与えられます。この行列内で、最も長い増加パスの長さを返してください。

# 各セルから、次の4つの方向に移動することができます：左、右、上、下。斜めの移動や、境界を越える移動は許可されていません（つまり、行列をラップアラウンドすることはできません）。

# Example 1:


# Input: matrix = [[9,9,4],[6,6,8],[2,1,1]]
# Output: 4
# Explanation: The longest increasing path is [1, 2, 6, 9].
# Example 2:


# Input: matrix = [[3,4,5],[3,2,6],[2,2,1]]
# Output: 4
# Explanation: The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.
# Example 3:

# Input: matrix = [[1]]
# Output: 1
 

# Constraints:

# m == matrix.length
# n == matrix[i].length
# 1 <= m, n <= 200
# 0 <= matrix[i][j] <= 231 - 1

# この問題は「深さ優先探索（DFS）」と「メモ化（動的計画法）」を組み合わせた方法で解くことができます。各セルから出発し、そのセルが次に移動できる方向（上下左右）を探索しながら、最も長い増加パスを記録していきます。

# アプローチ
# DFSとメモ化:

# 各セルごとに再帰的に深さ優先探索を行い、そのセルを起点にできる最も長い増加パスの長さを計算します。
# 計算した結果はメモ化（cache に保存）し、同じセルに再度アクセスしたときに再計算しなくて済むようにします。
# 四方向への移動:

# 上、下、左、右の4方向に対して、隣接するセルが現在のセルよりも大きい場合にのみ移動します。

def longest_increasing_path(matrix)
  m, n = matrix.length, matrix[0].length
  cache = Array.new(m) { Array.new(n, 0) }
  # 4方向への移動を定義（上、下、左、右）
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  
  # 深さ優先探索 (DFS) を定義
  def dfs(matrix, i, j, cache, directions)
    # キャッシュに結果がある場合、それを返す
    return cache[i][j] if cache[i][j] != 0

    puts "探索開始: matrix[#{i}][#{j}] = #{matrix[i][j]}"
    
    # 現在の位置からの最大の経路の長さ
    max_length = 1
    
    # 4方向へ移動
    directions.each do |dir|
      ni, nj = i + dir[0], j + dir[1]
      # 行と列のインデックスが行列の範囲内に収まっているか
      # 次に移動しようとしているセルの値が、現在のセルの値よりも大きいか
      if ni >= 0 && ni < matrix.length && nj >= 0 && nj < matrix[0].length && matrix[ni][nj] > matrix[i][j]
        # 隣接するセルが大きい場合、再帰的に探索
        # 第一引数には matrix 自体を渡して、第3引数に cache を渡すことで、メモ化している
        len = 1 + dfs(matrix, ni, nj, cache, directions)
        max_length = [max_length, len].max
        puts "matrix[#{i}][#{j}] -> matrix[#{ni}][#{nj}] 経路長: #{len}"
      end
    end
    
    # キャッシュに結果を保存
    cache[i][j] = max_length
    puts "キャッシュ更新: cache[#{i}][#{j}] = #{max_length}"
    max_length
  end

  # 全てのセルについて DFS を実行して最も長い経路を求める
  result = 0
  (0...m).each do |i|
    (0...n).each do |j|
      result = [result, dfs(matrix, i, j, cache, directions)].max
    end
  end
  
  result
end

# テストケース1
matrix1 = [[9,9,4],[6,6,8],[2,1,1]]
puts "テストケース1: matrix = [[9,9,4],[6,6,8],[2,1,1]]"
puts "結果: #{longest_increasing_path(matrix1)}"  # 期待される出力: 4

# テストケース2
# matrix2 = [[3,4,5],[3,2,6],[2,2,1]]
# puts "\nテストケース2: matrix = [[3,4,5],[3,2,6],[2,2,1]]"
# puts "結果: #{longest_increasing_path(matrix2)}"  # 期待される出力: 4

# 条件文の詳細
# 1. ni >= 0
# ni は現在のセル (i, j) から縦方向に移動した後の新しい行のインデックスです。
# この条件は、「新しい行インデックス ni が行列の範囲内に収まっているか（行が負の値になっていないか）」を確認しています。
# もし ni < 0 であれば、行列の上端から外に出てしまうため、この方向に移動できません。
# 2. ni < matrix.length
# これも ni が有効な範囲にあるかを確認する条件です。matrix.length は行列の行の数を示します。
# この条件は、「新しい行インデックス ni が行列の行数を超えていないか」を確認しています。
# 例えば、行列が 3x3 であれば、行インデックス ni は 0, 1, 2 のいずれかでなければなりません。
# 3. nj >= 0
# nj は現在のセル (i, j) から横方向に移動した後の新しい列のインデックスです。
# この条件は、「新しい列インデックス nj が行列の範囲内に収まっているか（列が負の値になっていないか）」を確認しています。
# もし nj < 0 であれば、行列の左端から外に出てしまうため、この方向に移動できません。
# 4. nj < matrix[0].length
# これも nj が有効な範囲にあるかを確認する条件です。matrix[0].length は行列の列の数を示します。
# この条件は、「新しい列インデックス nj が行列の列数を超えていないか」を確認しています。
# 例えば、行列が 3x3 であれば、列インデックス nj は 0, 1, 2 のいずれかでなければなりません。
# 5. matrix[ni][nj] > matrix[i][j]
# この条件は、「次に移動しようとしているセルの値（matrix[ni][nj]）が、現在のセルの値（matrix[i][j]）よりも大きいかどうか」を確認しています。
# このチェックは、「移動する方向に対して、行列内で増加するパスを見つけるための条件」です。
# matrix[ni][nj] > matrix[i][j] が成り立つ場合、次のセルに進むことができます。逆に、この条件を満たさない場合は、その方向には進めません。
# 全体の流れ
# まとめると、この条件式は次のようなチェックを行っています：

# 行と列のインデックスが行列の範囲内に収まっているかを確認します。これにより、行列の外に出てしまう不正な移動を防ぎます。
# 次に移動しようとしているセルの値が、現在のセルの値よりも大きいかを確認します。これにより、移動先が「増加するパス」であることを保証します。
