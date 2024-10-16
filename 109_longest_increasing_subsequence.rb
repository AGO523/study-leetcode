# Given an integer array nums, return the length of the longest strictly increasing 
# subsequence
# .

# 整数配列 nums が与えられたとき、その中で最長の厳密に増加する部分列の長さを返してください。

# 厳密に増加する部分列とは？
# 部分列とは、元の配列の要素を順番通りに選んで構成される配列のことです（必ずしも連続している必要はありません）。厳密に増加するとは、各要素が前の要素よりも大きいことを意味します。



# Example 1:

# Input: nums = [10,9,2,5,3,7,101,18]
# Output: 4
# Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
# Example 2:

# Input: nums = [0,1,0,3,2,3]
# Output: 4
# Example 3:

# Input: nums = [7,7,7,7,7,7,7]
# Output: 1
 

# Constraints:

# 1 <= nums.length <= 2500

# アプローチ
# DP 配列の初期化：

# dp[i] を「nums[i] を最後の要素として持つ最長増加部分列の長さ」と定義します。
# 初期値として、すべての dp[i] = 1 とします（すべての要素は単独で増加部分列を形成できるため、長さ1です）。
# 状態遷移：

# 各要素 nums[i] に対して、その前の要素 nums[j]（j < i）を確認し、nums[j] < nums[i] であれば、dp[i] を更新します。
# 具体的には、dp[i] = [dp[i], dp[j] + 1].max として、dp[j] + 1 が dp[i] よりも大きい場合に更新します。
# 最終結果：

# DP 配列 dp の中で最も大きい値が、最長増加部分列の長さです。

def length_of_lis(nums)
  return 0 if nums.empty?  # 空の配列の場合は0を返す

  # dp配列を初期化。すべての要素は単独で増加部分列を形成できるため、初期値は1
  dp = Array.new(nums.length, 1)

  # 各要素に対して、前の要素と比較して dp を更新
  (1...nums.length).each do |i|
    (0...i).each do |j|
      if nums[j] < nums[i]
        dp[i] = [dp[i], dp[j] + 1].max
        puts "nums[#{j}] (#{nums[j]}) < nums[#{i}] (#{nums[i]}) → dp[#{i}] = #{dp[i]}"
      end
    end
  end

  # dp配列の最大値が最長増加部分列の長さ
  dp.max
end

# テストケース1
puts "テストケース1: nums = [10, 9, 2, 5, 3, 7, 101, 18]"
puts "出力: #{length_of_lis([10, 9, 2, 5, 3, 7, 101, 18])}"  # 期待される出力: 4

# テストケース2
# puts "\nテストケース2: nums = [0, 1, 0, 3, 2, 3]"
# puts "出力: #{length_of_lis([0, 1, 0, 3, 2, 3])}"  # 期待される出力: 4

# # テストケース3
# puts "\nテストケース3: nums = [7, 7, 7, 7, 7, 7, 7]"
# puts "出力: #{length_of_lis([7, 7, 7, 7, 7, 7, 7])}"  # 期待される出力: 1
