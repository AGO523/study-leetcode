# Given an m x n integer matrix matrix, if an element is 0, set its entire row and column to 0's.

# You must do it in place.

# 与えられた m x n の整数行列 matrix において、要素が 0 の場合、その要素の属する行と列全体を 0 に設定してください。

# この操作はインプレースで行わなければなりません（新しい行列を作成せずに、与えられた行列を直接変更する必要があります）。

# Example 1:


# Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
# Output: [[1,0,1],[0,0,0],[1,0,1]]
# Example 2:


# Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
# Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
 

# Constraints:

# m == matrix.length
# n == matrix[0].length
# 1 <= m, n <= 200
# -231 <= matrix[i][j] <= 231 - 1

# アプローチと解説
# この問題では、0 を含む要素が見つかったときに、その行全体と列全体を 0 に設定する必要があります。ただし、行列全体を効率的に操作し、追加の空間を使いすぎないように工夫が必要です。

# アプローチ
# 最初に影響範囲を記録:

# 最初に行列全体を走査し、0 を見つけたらその行と列を記録します。
# 影響範囲を 0 に設定:

# 記録した行と列を基に、対応する行と列を 0 に設定します。
# インプレースの工夫:

# 行列の最初の行と列を記録用として使用し、追加のメモリを極力使用しないようにします。

def set_zeroes(matrix)
  m, n = matrix.length, matrix[0].length

  # フラグ変数
  first_row_zero = matrix[0].include?(0)
  first_col_zero = matrix.any? { |row| row[0] == 0 }

  # 1. 行列の最初の行と列を記録用に使用
  (1...m).each do |i|
    (1...n).each do |j|
      if matrix[i][j] == 0
        matrix[i][0] = 0
        matrix[0][j] = 0
      end
    end
  end

  # 2. 記録された情報を基に行と列を 0 に設定
  (1...m).each do |i|
    (1...n).each do |j|
      if matrix[i][0] == 0 || matrix[0][j] == 0
        matrix[i][j] = 0
      end
    end
  end

  # 3. 最初の行を 0 に設定
  if first_row_zero
    (0...n).each do |j|
      matrix[0][j] = 0
    end
  end

  # 4. 最初の列を 0 に設定
  if first_col_zero
    (0...m).each do |i|
      matrix[i][0] = 0
    end
  end

  # デバッグ用の出力
  puts "最終行列: #{matrix.inspect}"
end

# テストケース1
matrix1 = [[1,1,1],[1,0,1],[1,1,1]]
puts "入力: #{matrix1.inspect}"
set_zeroes(matrix1)
puts "出力: #{matrix1.inspect}"  # 期待される出力: [[1,0,1],[0,0,0],[1,0,1]]

# # テストケース2
# matrix2 = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
# puts "\n入力: #{matrix2.inspect}"
# set_zeroes(matrix2)
# puts "出力: #{matrix2.inspect}"  # 期待される出力: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
