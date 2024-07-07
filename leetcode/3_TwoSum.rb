# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
# 日本語での説明
# 整数の配列numsと整数のtargetが与えられた場合、その2つの数値のインデックスを返します。その2つの数値は、合計がtargetになるようにします。

# You may assume that each input would have exactly one solution, and you may not use the same element twice.
# 各入力には正確に1つの解があると仮定し、同じ要素を2回使用することはできません。

# You can return the answer in any order.
# どのような順番でも答えを返すことができます。

# Example 1:

# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
# Example 2:

# Input: nums = [3,2,4], target = 6
# Output: [1,2]
# Example 3:

# Input: nums = [3,3], target = 6
# Output: [0,1]

# Constraints:

# 2 <= nums.length <= 104
# -109 <= nums[i] <= 109
# -109 <= target <= 109
# Only one valid answer exists.

class Solution
  # @param {Integer[]} nums
  # @param {Integer} target
  # @return {Integer[]}

  def two_sum(nums, target)
    hash = {}
    nums.each_with_index do |num, index|
      complement = target - num
      return [hash[complement], index] if hash[complement]
      hash[num] = index
    end
  end
end

nums1 = [2,7,11,15]
target1 = 9
nums2 = [3,2,4]
target2 = 6
nums3 = [3,3]
target3 = 6

sol = Solution.new
puts sol.two_sum(nums1, target1)
puts sol.two_sum(nums2, target2)
puts sol.two_sum(nums3, target3)
