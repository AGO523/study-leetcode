# Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:

# [4,5,6,7,0,1,2] if it was rotated 4 times.
# [0,1,2,4,5,6,7] if it was rotated 7 times.
# Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].

# Given the sorted rotated array nums of unique elements, return the minimum element of this array.

# You must write an algorithm that runs in O(log n) time.

# 長さ n の配列が昇順にソートされ、1回から n 回の間で回転されています。例えば、配列 nums = [0,1,2,4,5,6,7] が次のように回転される可能性があります：

# 4回回転されると [4,5,6,7,0,1,2] になります。
# 7回回転されると [0,1,2,4,5,6,7] に戻ります。
# 配列が1回回転されると、元の配列 [a[0], a[1], a[2], ..., a[n-1]] は [a[n-1], a[0], a[1], a[2], ..., a[n-2]] になります。

# ユニークな要素で構成される、回転されたソート済み配列 nums が与えられたとき、この配列の最小要素を返してください。

# Example 1:

# Input: nums = [3,4,5,1,2]
# Output: 1
# Explanation: The original array was [1,2,3,4,5] rotated 3 times.
# Example 2:

# Input: nums = [4,5,6,7,0,1,2]
# Output: 0
# Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
# Example 3:

# Input: nums = [11,13,15,17]
# Output: 11
# Explanation: The original array was [11,13,15,17] and it was rotated 4 times. 
 

# Constraints:

# n == nums.length
# 1 <= n <= 5000
# -5000 <= nums[i] <= 5000
# All the integers of nums are unique.
# nums is sorted and rotated between 1 and n times.

# この問題は、二分探索を用いて効率的に解決できます。配列が回転されているため、配列の中には「回転点」が存在し、最小値がその近くにあります。この回転点を見つけることで、配列の最小値を見つけることができます。

# アルゴリズムの概要
# 探索範囲の設定:

# 配列の左端を left、右端を right として設定します。
# 二分探索のループ:

# left が right より小さい間、ループを続けます。
# 中間のインデックス mid を計算し、 nums[mid] と nums[right] を比較します。
# nums[mid] が nums[right] より大きい場合、最小値は mid より右側にあるため、 left = mid + 1 として探索範囲を右に移動します。
# nums[mid] が nums[right] 以下の場合、最小値は mid またはその左側にあるため、 right = mid として探索範囲を左に移動します。
# 結果の返却:

# ループが終了した時点で、 left が最小値のインデックスを指します。

def find_min(nums)
  # 初期の探索範囲を設定
  left, right = 0, nums.length - 1

  # 二分探索のループ
  while left < right
    mid = (left + right) / 2

    # puts "Current Range: [#{left}, #{right}]"

    # 中央の要素と右端の要素を比較
    if nums[mid] > nums[right]
      # puts "nums[mid] > nums[right]: Moving left to mid + 1"
      left = mid + 1
    else
      # puts "nums[mid] <= nums[right]: Moving right to mid"
      right = mid
    end
    # puts "Current Range: [#{left}, #{right}]"
  end

  # 最小値のインデックスを指すleftを返す
  # puts "Minimum value found at index: #{left}, Value: #{nums[left]}"
  nums[left]
end

# 使用例
puts "Result: #{find_min([3,4,5,1,2])}"  # 出力: 1
puts "Result: #{find_min([4,5,6,7,0,1,2])}"  # 出力: 0
puts "Result: #{find_min([11,13,15,17])}"  # 出力: 11
