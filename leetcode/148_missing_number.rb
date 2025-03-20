# Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.

# 与えられた配列numsには、範囲[0, n]に含まれるn個の異なる数値が入っています。この範囲内で配列に存在しない1つの数値を返してください。



# Example 1:

# Input: nums = [3,0,1]
# Output: 2
# Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
# Example 2:

# Input: nums = [0,1]
# Output: 2
# Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
# Example 3:

# Input: nums = [9,6,4,2,3,5,7,0,1]
# Output: 8
# Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
 

# Constraints:

# n == nums.length
# 1 <= n <= 104
# 0 <= nums[i] <= n
# All the numbers of nums are unique.

# 範囲内で欠けている数値を見つける関数
def missing_number(nums)
  # 配列の長さnを計算
  n = nums.length
  
  # 理論上の合計値（0からnまでの合計）
  # 配列の長さnを取得します。範囲は[0, n]なので、配列にはn + 1個の要素が存在すべきです。
  # 数列0からnまでの合計は、等差数列の和の公式を用いて計算します。
  expected_sum = (n * (n + 1)) / 2
  puts "Expected Sum (0 to #{n}): #{expected_sum}"
  
  # 実際の配列の合計値
  actual_sum = nums.sum
  puts "Actual Sum of nums: #{actual_sum}"
  
  # 欠けている値は expected_sum - actual_sum
  missing = expected_sum - actual_sum
  puts "Missing Number: #{missing}"
  
  missing
end


# テストケース2
puts "\nTest Case 2:"
nums = [0, 1]
missing_number(nums)

# テストケース3
puts "\nTest Case 3:"
nums = [9, 6, 4, 2, 3, 5, 7, 0, 1]
missing_number(nums)
