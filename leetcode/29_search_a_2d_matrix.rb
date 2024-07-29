# You are given an m x n integer matrix matrix with the following two properties:

# Each row is sorted in non-decreasing order.
# The first integer of each row is greater than the last integer of the previous row.
# Given an integer target, return true if target is in matrix or false otherwise.

# You must write a solution in O(log(m * n)) time complexity.

# m x n の整数行列 matrix が与えられます。この行列には次の2つの性質があります：

# 各行は非減少の順序でソートされています。
# 各行の最初の整数は、前の行の最後の整数よりも大きくなっています。
# 整数 target が与えられたとき、target が行列 matrix に存在する場合は true を、存在しない場合は false を返してください。

# この問題を O(log(m * n)) の時間複雑度で解決する必要があります。

# Example 1:


# Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
# Output: true
# Example 2:


# Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
# Output: false
 

# Constraints:

# m == matrix.length
# n == matrix[i].length
# 1 <= m, n <= 100
# -104 <= matrix[i][j], target <= 104

# 解答
# この問題は、行列全体を1次元配列のように扱い、二分探索を用いて O(log(m * n)) の時間複雑度で target を検索します。行列の各要素は、ソートされた状態にあるため、このアプローチが可能です。

# アルゴリズムの概要
# 行列を1次元配列として扱い、left ポインタと right ポインタを使用して探索範囲を管理します。
# 中央のインデックスを計算し、そのインデックスに対応する行列の要素を取得します。
# 取得した要素が target と一致する場合は true を返し、一致しない場合は探索範囲を調整します。
# 探索範囲がなくなった場合、target が存在しないことを意味するので false を返します。

def search_matrix(matrix, target)
  # 行と列の数を取得
  m, n = matrix.length, matrix[0].length

  # 左端と右端のインデックスを初期化
  left, right = 0, m * n - 1

  # 左端が右端以下の間、探索を続ける
  while left <= right
    # 中央のインデックスを計算
    mid = (left + right) / 2
    # 1次元のインデックスを行列の行と列に変換
    # mid / n は、1次元インデックス mid を行列の何行目に対応するかを計算します。
    # mid % n は、1次元インデックス mid を行列の何列目に対応するかを計算します。
    mid_value = matrix[mid / n][mid % n]

    # 中央の値がターゲットの場合、trueを返す
    if mid_value == target
      return true
    # 中央の値がターゲットより大きい場合、右端を移動
    elsif mid_value > target
      right = mid - 1
    # 中央の値がターゲットより小さい場合、左端を移動
    else
      left = mid + 1
    end
  end

  # ターゲットが見つからなかった場合、falseを返す
  return false
end

# 使用例
puts search_matrix([[1, 3, 5, 7], [10, 11, 16, 20], [23, 30, 34, 60]], 3)  # 出力: true
puts search_matrix([[1, 3, 5, 7], [10, 11, 16, 20], [23, 30, 34, 60]], 13) # 出力: false
