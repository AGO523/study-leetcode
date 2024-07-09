# Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.
# 日本語で
# 連続した要素のシーケンスの最長の長さを返す

# You must write an algorithm that runs in O(n) time.
# O(n) 時間で実行されるアルゴリズムを書く必要があります。

# Example 1:

# Input: nums = [100,4,200,1,3,2]
# Output: 4
# Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
# Example 2:

# Input: nums = [0,3,7,2,5,8,4,6,0,1]
# Output: 9

# Constraints:

# 0 <= nums.length <= 105
# -109 <= nums[i] <= 109

class Solution
  def longest_consecutive(nums)
    return 0 if nums.empty?
    
    # numsをソートする
    nums.sort!
    
    # 連続した要素のシーケンスの最長の長さを格納する変数を初期化
    max_length = 1
    # 連続した要素のシーケンスの長さを格納する変数を初期化
    current_length = 1
    
    # numsの長さ-1まで繰り返す
    (0...nums.length - 1).each do |i|
      # nums[i] は 最後を除いた数値
      # nums[i + 1]　は nums[i]の次の数値　最初だけのぞいている
      # nums[i]とnums[i + 1]はとなりあっている

      # nums[i]とnums[i + 1]が等しい場合は次の繰り返しに進む
      next if nums[i] == nums[i + 1]

      # nums[i]とnums[i + 1]が1差である場合
      if nums[i] + 1 == nums[i + 1]
        # 連続した要素のシーケンスの長さをインクリメント
        current_length += 1
        # 連続した要素のシーケンスの最長の長さを更新
        # nums[i] と nums[i + 1] が連続している場合 (nums[i] + 1 == nums[i + 1]) に、current_length をインクリメントします。その後、max_length を max_length と current_length のうち大きい方に更新します。これは、現在の連続シーケンスがこれまでの最長シーケンスよりも長い場合に、max_length を更新するためです。
        max_length = [max_length, current_length].max
      else
        # 連続した要素のシーケンスの長さをリセット
        current_length = 1
      end
    end
    
    max_length
  end
end


nums1 = [100,4,200,1,3,2]
nums2 = [0,3,7,2,5,8,4,6,0,1]

sol = Solution.new
p sol.longest_consecutive(nums1)
p sol.longest_consecutive(nums2)
