# You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

# You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

#   n x n の2D行列 matrix が画像を表しています。この画像を時計回りに90度回転させてください。

#   この操作は「インプレース」で行う必要があるため、新たに別の2D行列を作成して回転を行ってはいけません。入力の matrix を直接変更して回転させてください。
  
  

# Example 1:


# Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
# Output: [[7,4,1],[8,5,2],[9,6,3]]
# Example 2:


# Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
# Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
 

# Constraints:

# n == matrix.length == matrix[i].length
# 1 <= n <= 20
# -1000 <= matrix[i][j] <= 1000


# アプローチと解説
# この問題はインプレースで行列を回転させる問題で、追加の行列を使わずに入力の matrix を変更します。

# アプローチ
# 行列を転置する:

# 行列を転置することで、行と列を入れ替えます。転置すると、例えば最初の行の要素が新しい列の要素になります。
# 各行を反転する:

# 行列を転置した後、各行を反転することで、90度回転した行列が得られます。

def rotate(matrix)
  n = matrix.length

  # 1. 行列を転置
  (0...n).each do |i|
    (i...n).each do |j|
      # i行j列とj行i列を入れ替え
      matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
      puts "転置: matrix[#{i}][#{j}]とmatrix[#{j}][#{i}]を入れ替え"
    end
  end

  # 2. 各行を反転
  matrix.each_with_index do |row, i|
    row.reverse!
    puts "反転: matrix[#{i}] => #{row}"
  end
end

# テストケース1
matrix1 = [[1,2,3],[4,5,6],[7,8,9]]
puts "回転前: #{matrix1.inspect}"
rotate(matrix1)
puts "回転後: #{matrix1.inspect}"  # 期待される出力: [[7,4,1],[8,5,2],[9,6,3]]

# テストケース2
matrix2 = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
puts "\n回転前: #{matrix2.inspect}"
rotate(matrix2)
puts "回転後: #{matrix2.inspect}"  # 期待される出力: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
