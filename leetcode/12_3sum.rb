# Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
# 日本語で
# 整数の配列 nums が与えられたとき、i ≠ j、i ≠ k、および j ≠ k であり、nums[i] + nums[j] + nums[k] = 0 となるすべてのトリプレット [nums[i], nums[j], nums[k]] を返してください。

# Notice that the solution set must not contain duplicate triplets.
# 日本語で
# 解決策セットには重複するトリプレットを含めることはできません。

# Example 1:

# Input: nums = [-1,0,1,2,-1,-4]
# Output: [[-1,-1,2],[-1,0,1]]
# Explanation: 
# nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
# nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
# nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
# The distinct triplets are [-1,0,1] and [-1,-1,2].
# Notice that the order of the output and the order of the triplets does not matter.
# Example 2:

# Input: nums = [0,1,1]
# Output: []
# Explanation: The only possible triplet does not sum up to 0.
# Example 3:

# Input: nums = [0,0,0]
# Output: [[0,0,0]]
# Explanation: The only possible triplet sums up to 0.

# Constraints:

# 3 <= nums.length <= 3000
# -105 <= nums[i] <= 105

class Solution
  def three_sum(nums)
    # 配列をソートする
    nums.sort!
    # 結果を格納するための配列を初期化
    result = []

    # 配列の長さが3未満の場合は空の結果を返す
    return result if nums.length < 3

    # 配列を0からnums.length - 2までループする
    (0...nums.length - 2).each do |i|
      # 同じ値をスキップして重複するトリプレットを避ける
      next if i > 0 && nums[i] == nums[i - 1]

      # 左ポインターと右ポインターを設定
      left = i + 1
      right = nums.length - 1

      # 左ポインターが右ポインターより小さい間ループする
      while left < right
        # 現在の3つの数の合計を計算
        sum = nums[i] + nums[left] + nums[right]

        # 合計が0の場合、結果に追加
        if sum == 0
          result << [nums[i], nums[left], nums[right]]
          left += 1
          right -= 1
          # 重複する値をスキップする
          while left < right && nums[left] == nums[left - 1]
            left += 1
          end
          while left < right && nums[right] == nums[right + 1]
            right -= 1
          end
        # 合計が0より小さい場合、左ポインターを右に移動
        elsif sum < 0
          left += 1
        # 合計が0より大きい場合、右ポインターを左に移動
        else
          right -= 1
        end
      end
    end

    # 結果を返す
    result
  end
end

nums1 = [-1,0,1,2,-1,-4]
nums2 = [0,1,1]
nums3 = [0,0,0]

sol = Solution.new
p sol.three_sum(nums1)
p sol.three_sum(nums2)
p sol.three_sum(nums3)
