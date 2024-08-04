# Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

# The overall run time complexity should be O(log (m+n)).

# 2つのソートされた配列 nums1 と nums2（サイズはそれぞれ m と n）が与えられたとき、これら2つのソートされた配列の中央値を返してください。

# 全体の実行時間の複雑度は O(log(m+n)) でなければなりません。



# Example 1:

# Input: nums1 = [1,3], nums2 = [2]
# Output: 2.00000
# Explanation: merged array = [1,2,3] and median is 2.
# Example 2:

# Input: nums1 = [1,2], nums2 = [3,4]
# Output: 2.50000
# Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 

# Constraints:

# nums1.length == m
# nums2.length == n
# 0 <= m <= 1000
# 0 <= n <= 1000
# 1 <= m + n <= 2000
# -106 <= nums1[i], nums2[i] <= 106

# この問題を解決するために、2つのソートされた配列を効率的に結合し、中央値を見つけるためのバイナリサーチアルゴリズムを使用します。このアルゴリズムの目的は、nums1 と nums2 をバランスの取れた方法で分割し、中央値を見つけることです。

# def find_median_sorted_arrays(nums1, nums2)
#   # nums1が常に短い配列になるようにする
#   if nums1.length > nums2.length
#     # nums1とnums2を入れ替える
#     nums1, nums2 = nums2, nums1
#   end

#   m, n = nums1.length, nums2.length
#   imin, imax, half_len = 0, m, (m + n + 1) / 2

#   while imin <= imax
#     i = (imin + imax) / 2
#     j = half_len - i

#     puts "Checking i: #{i}, j: #{j}, imin: #{imin}, imax: #{imax}"

#     if i < m && nums2[j-1] > nums1[i]
#       puts "nums1[#{i}] (#{nums1[i]}) is too small, increasing imin"
#       imin = i + 1
#     elsif i > 0 && nums1[i-1] > nums2[j]
#       puts "nums1[#{i-1}] (#{nums1[i-1]}) is too large, decreasing imax"
#       imax = i - 1
#     else
#       # 正しいiが見つかった
#       max_of_left = if i == 0
#                       nums2[j-1]
#                     elsif j == 0
#                       nums1[i-1]
#                     else
#                       [nums1[i-1], nums2[j-1]].max
#                     end

#       if (m + n).odd?
#         puts "Median found (odd total length): #{max_of_left}"
#         return max_of_left
#       end

#       min_of_right = if i == m
#                        nums2[j]
#                      elsif j == n
#                        nums1[i]
#                      else
#                        [nums1[i], nums2[j]].min
#                      end

#       median = (max_of_left + min_of_right) / 2.0
#       puts "Median found (even total length): #{median}"
#       return median
#     end
#   end

#   raise "No median found"
# end

# # 使用例
# puts find_median_sorted_arrays([1, 3], [2])        # 出力: 2.0
# puts find_median_sorted_arrays([1, 2], [3, 4])     # 出力: 2.5

def find_median_sorted_arrays(nums1, nums2)
  # nums1が常に短い配列になるようにする
  if nums1.length > nums2.length
    nums1, nums2 = nums2, nums1
  end

  # 配列の長さを取得
  length1, length2 = nums1.length, nums2.length

  # バイナリサーチの初期範囲を設定
  left_index, right_index = 0, length1
  # right_indexは nums1 と nums2 の合計要素数の分岐点を示す

  # 半分の長さを計算
  half_length = (length1 + length2 + 1) / 2

  # バイナリサーチ開始
  while left_index <= right_index
    # nums1の中間インデックス
    # バイナリサーチの中間点の計算
    partition1 = (left_index + right_index) / 2

    # nums2の中間インデックス
    partition2 = half_length - partition1

    puts "Checking partition1: #{partition1}, partition2: #{partition2}, left_index: #{left_index}, right_index: #{right_index}"

    # nums1の左側最大値
    max_left1 = (partition1 == 0) ? -Float::INFINITY : nums1[partition1 - 1]
    # nums1の右側最小値
    min_right1 = (partition1 == length1) ? Float::INFINITY : nums1[partition1]

    # nums2の左側最大値
    max_left2 = (partition2 == 0) ? -Float::INFINITY : nums2[partition2 - 1]
    # nums2の右側最小値
    min_right2 = (partition2 == length2) ? Float::INFINITY : nums2[partition2]

    if max_left1 <= min_right2 && max_left2 <= min_right1
      # 正しい分割が見つかった
      if (length1 + length2).odd?
        # 総要素数が奇数の場合、左側の最大値が中央値
        median = [max_left1, max_left2].max
        puts "Median found (odd total length): #{median}"
        return median
      else
        # 総要素数が偶数の場合、左右の最大値と最小値の平均が中央値
        median = ([max_left1, max_left2].max + [min_right1, min_right2].min) / 2.0
        puts "Median found (even total length): #{median}"
        return median
      end
    elsif max_left1 > min_right2
      puts "max_left1 (#{max_left1}) is greater than min_right2 (#{min_right2}), moving right_index"
      right_index = partition1 - 1
    else
      puts "max_left2 (#{max_left2}) is greater than min_right1 (#{min_right1}), moving left_index"
      left_index = partition1 + 1
    end
  end

  raise "No median found"
end

# 使用例
# puts find_median_sorted_arrays([1, 3], [2])        # 出力: 2.0
# puts find_median_sorted_arrays([1, 2], [3, 4])     # 出力: 2.5
puts find_median_sorted_arrays([1, 2, 5, 7, 10, 200], [3, 4, 7, 9, 12, 14, 24, 78, 232])
