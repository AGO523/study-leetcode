# Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
# 日本語で
# 整数の配列numsと整数kが与えられた場合、最も頻繁に発生するk個の要素を返します。どのような順番でも答えを返すことができます。

# Example 1:

# Input: nums = [1,1,1,2,2,3], k = 2
# Output: [1,2]
# Example 2:

# Input: nums = [1], k = 1
# Output: [1]

# Constraints:

# 1 <= nums.length <= 105
# -104 <= nums[i] <= 104
# k is in the range [1, the number of unique elements in the array].
# It is guaranteed that the answer is unique.

# Follow up: Your algorithm's time complexity must be better than O(n log n), where n is the array's size.

class Solution
  def top_k_frequent(nums, k)
    nums.tally.sort_by { |_, v| -v }.first(k).to_h.keys
  end
end

nums1 = [1,1,1,2,2,3]
k1 = 2
nums2 = [1]
k2 = 1

sol = Solution.new
puts sol.top_k_frequent(nums1, k1)
puts sol.top_k_frequent(nums2, k2)
