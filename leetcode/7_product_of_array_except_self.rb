# Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
# 日本語で
# 整数の配列numsが与えられた場合、answer[i]がnums[i]以外のすべての要素の積に等しい配列answerを返します。

# The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
# numsの接頭辞または接尾辞の積は、32ビット整数に収まることが保証されています。

# You must write an algorithm that runs in O(n) time and without using the division operation.
# O(n)の時間で実行され、除算操作を使用しないアルゴリズムを書く必要があります。

# Example 1:

# Input: nums = [1,2,3,4]
# Output: [24,12,8,6]
# Example 2:

# Input: nums = [-1,1,0,-3,3]
# Output: [0,0,9,0,0]

# Constraints:

# 2 <= nums.length <= 105
# -30 <= nums[i] <= 30
# The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

# Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)

class Solution
  def product_except_self(nums)
    n = nums.size
    result = Array.new(n, 1)
    
    left = 1
    right = 1
    
    (0...n).each do |i|
      # 左積を計算して結果配列に格納
      result[i] *= left
      left *= nums[i]
      
      # 右積を計算して結果配列に格納
      result[n-1-i] *= right
      right *= nums[n-1-i]
    end
    
    result
  end
end

nums1 = [1,2,3,4]
nums2 = [-1,1,0,-3,3]

sol = Solution.new
puts sol.product_except_self(nums1)
puts sol.product_except_self(nums2)
