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

# イテレーションの流れ
# 範囲 (0...n) を作成:

# n は nums 配列のサイズです。
# 例えば nums = [1, 2, 3, 4] の場合、n = 4 です。
# 範囲オブジェクト 0...4 は、0, 1, 2, 3 の値を含みます。
# each メソッドで範囲を繰り返す:

# each メソッドを使って、範囲内の各値 i に対してブロックを実行します。
# ブロック内の処理:

# result[i] *= left：現在の result[i] に左積 left を掛けます。
# left *= nums[i]：左積 left を更新します。
# result[n-1-i] *= right：現在の result[n-1-i] に右積 right を掛けます。
# right *= nums[n-1-i]：右積 right を更新します。
# 具体例
# 例えば、nums = [1, 2, 3, 4] の場合：

# 初期状態：

# result = [1, 1, 1, 1]
# left = 1
# right = 1
# イテレーション1 (i = 0)：

# result[0] *= left → result[0] = 1
# left *= nums[0] → left = 1 * 1 = 1
# result[3] *= right → result[3] = 1
# right *= nums[3] → right = 1 * 4 = 4
# イテレーション2 (i = 1)：

# result[1] *= left → result[1] = 1 * 1 = 1
# left *= nums[1] → left = 1 * 2 = 2
# result[2] *= right → result[2] = 1 * 4 = 4
# right *= nums[2] → right = 4 * 3 = 12
# イテレーション3 (i = 2)：

# result[2] *= left → result[2] = 4 * 2 = 8
# left *= nums[2] → left = 2 * 3 = 6
# result[1] *= right → result[1] = 1 * 12 = 12
# right *= nums[1] → right = 12 * 2 = 24
# イテレーション4 (i = 3)：

# result[3] *= left → result[3] = 1 * 6 = 6
# left *= nums[3] → left = 6 * 4 = 24
# result[0] *= right → result[0] = 1 * 24 = 24
# right *= nums[0] → right = 24 * 1 = 24
# 最終結果は result = [24, 12, 8, 6] となります。

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
