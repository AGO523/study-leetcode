# Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.

# You must write an algorithm with O(log n) runtime complexity.

# 昇順にソートされた整数の配列 nums と整数 target が与えられたとき、nums の中で target を検索する関数を作成してください。target が存在する場合はそのインデックスを返し、存在しない場合は -1 を返します。

# このアルゴリズムは O(log n) の実行時間複雑度でなければなりません。

# Example 1:

# Input: nums = [-1,0,3,5,9,12], target = 9
# Output: 4
# Explanation: 9 exists in nums and its index is 4
# Example 2:

# Input: nums = [-1,0,3,5,9,12], target = 2
# Output: -1
# Explanation: 2 does not exist in nums so return -1
 

# Constraints:

# 1 <= nums.length <= 104
# -104 < nums[i], target < 104
# All the integers in nums are unique.
# nums is sorted in ascending order.

# この問題は、ソートされた配列での二分探索を用いて O(log n) の時間複雑度で target を検索するものです。
# 二分探索アルゴリズムは、配列の中央の要素を基準にして、探している target が中央より小さいか大きいかを判断し、探索範囲を半分に絞ります。このプロセスを繰り返すことで、効率的に target を見つけることができます。

def binary_search(nums, target)
  # 左端と右端のインデックスを初期化
  left = 0
  right = nums.length - 1

  # 左端が右端以下の間、探索を続ける
  while left <= right
    # 中央のインデックスを計算
    mid = (left + right) / 2

    # 中央の要素がターゲットの場合、インデックスを返す
    if nums[mid] == target
      return mid
    # 中央の要素がターゲットより大きい場合、右端を移動
    # rightはあくまでも index であることに注意
    elsif nums[mid] > target
      right = mid - 1
    # 中央の要素がターゲットより小さい場合、左端を移動
    else
      left = mid + 1
    end
  end

  # ターゲットが見つからなかった場合、-1を返す
  return -1
end

# 使用例
puts binary_search([-1, 0, 3, 5, 9, 12], 9)  # 出力: 4
puts binary_search([-1, 0, 3, 5, 9, 12], 2)  # 出力: -1
