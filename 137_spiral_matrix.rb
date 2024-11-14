# Given an m x n matrix, return all elements of the matrix in spiral order.

# m x n の行列 matrix が与えられたとき、行列のすべての要素をスパイラル（螺旋）順に返してください。



# Example 1:


# Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
# Output: [1,2,3,6,9,8,7,4,5]
# Example 2:


# Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
# Output: [1,2,3,4,8,12,11,10,9,5,6,7]
 

# Constraints:

# m == matrix.length
# n == matrix[i].length
# 1 <= m, n <= 10
# -100 <= matrix[i][j] <= 100

# アプローチと解説
# この問題では、行列の要素を「外側から内側に向かってスパイラル状に」収集するため、特定の境界を管理しながら順次移動していきます。具体的には、上、右、下、左の順に要素を収集して境界を縮めていきます。

# アプローチ
# 境界の設定:
# top（上端）、bottom（下端）、left（左端）、right（右端）で初期境界を設定し、これらを適宜縮めていきます。
# 方向ごとの処理:
# 各境界に対して、右、下、左、上の順でループを進めて、対応する要素を収集します。
# 各境界を1つずつ内側に移動しながらスパイラル状に収集していきます。
# 収集の停止条件:
# top が bottom より大きくなったり、left が right より大きくなるまで繰り返します。


def spiral_order(matrix)
  result = []
  
  # 境界の初期設定
  top = 0
  bottom = matrix.length - 1
  left = 0
  right = matrix[0].length - 1

  # スパイラル順に要素を収集
  while top <= bottom && left <= right
    # 上の行を左から右へ
    (left..right).each do |i|
      result << matrix[top][i]
      puts "上の行から追加: #{matrix[top][i]}"
    end
    top += 1
    
    # 右の列を上から下へ
    (top..bottom).each do |i|
      result << matrix[i][right]
      puts "右の列から追加: #{matrix[i][right]}"
    end
    right -= 1
    
    # 下の行を右から左へ（境界が有効な場合のみ）
    if top <= bottom
      (right).downto(left).each do |i|
        result << matrix[bottom][i]
        puts "下の行から追加: #{matrix[bottom][i]}"
      end
      bottom -= 1
    end
    
    # 左の列を下から上へ（境界が有効な場合のみ）
    if left <= right
      (bottom).downto(top).each do |i|
        result << matrix[i][left]
        puts "左の列から追加: #{matrix[i][left]}"
      end
      left += 1
    end
  end
  
  result
end

# テストケース1
matrix1 = [[1,2,3],[4,5,6],[7,8,9]]
puts "入力: #{matrix1.inspect}"
puts "スパイラル順: #{spiral_order(matrix1).inspect}"  # 期待される出力: [1,2,3,6,9,8,7,4,5]

# テストケース2
matrix2 = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
puts "\n入力: #{matrix2.inspect}"
puts "スパイラル順: #{spiral_order(matrix2).inspect}"  # 期待される出力: [1,2,3,4,8,12,11,10,9,5,6,7]
