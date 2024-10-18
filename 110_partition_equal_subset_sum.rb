# Given an integer array nums, return true if you can partition the array into two subsets such that the sum of the elements in both subsets is equal or false otherwise.

# 整数配列 nums が与えられたとき、その配列を2つの部分集合に分割し、両方の部分集合の要素の和が等しくなる場合に true を返し、それ以外の場合は false を返してください。

# Example 1:

# Input: nums = [1,5,11,5]
# Output: true
# Explanation: The array can be partitioned as [1, 5, 5] and [11].
# Example 2:

# Input: nums = [1,2,3,5]
# Output: false
# Explanation: The array cannot be partitioned into equal sum subsets.
 

# Constraints:

# 1 <= nums.length <= 200
# 1 <= nums[i] <= 100

# アプローチと解説
# この問題は、配列 nums を2つの部分集合に分割し、それらの部分集合の和が等しくなるかどうかを判定する問題です。この問題は、部分和問題（Subset Sum Problem） と呼ばれる動的計画法の問題に帰着します。

# アプローチ
# 配列の総和を確認：

# 配列全体の和を求め、それが 奇数 であれば即座に false を返します。なぜなら、奇数を2つの等しい部分に分割することは不可能だからです。
# 総和が 偶数 であれば、その半分の和を持つ部分集合を見つけられるかどうかを調べます。
# 部分和問題の解法：

# 配列 nums の要素を使って、total_sum / 2 という部分和を作ることができるかどうかを、動的計画法（DP） を使って判定します。
# 状態遷移の考え方
# dp[i] を「和が i になる部分集合が存在するかどうか」を表すブール値とします。
# dp[0] = true とします（和が0になる部分集合は常に存在するので）。
# 各要素 num を使って、dp[i] を更新していきます。もし dp[i - num] が true であれば、dp[i] も true になります（i - num の和が作れるなら、num を追加して i の和も作れる）。

def can_partition(nums)
  # 配列全体の和を計算
  total_sum = nums.sum
  # 和が奇数なら分割は不可能
  return false if total_sum.odd?
  target_sum = total_sum / 2

  # dp 配列を初期化
  dp = Array.new(target_sum + 1, false)
  dp[0] = true  # 和が 0 の部分集合は常に存在する

  # 各要素で dp を更新
  nums.each do |num|
    puts "現在の要素: #{num}"
    # 逆順に確認するのは、重複した更新を避けるためです（小さい i から更新すると、同じ num が複数回使われる可能性があるためです）。
    target_sum.downto(num) do |i|
      if dp[i - num] # dp[i - num] が 1 なら true となる
        dp[i] = true
        puts "dp[#{i}] = true （dp[#{i - num}] が true なので）"
      end
    end
  end

  dp[target_sum]
end

# テストケース1
puts "テストケース1: nums = [1, 5, 11, 5]"
puts "出力: #{can_partition([1, 5, 11, 5])}"  # 期待される出力: true

# テストケース2
# puts "\nテストケース2: nums = [1, 2, 3, 5]"
# puts "出力: #{can_partition([1, 2, 3, 5])}"  # 期待される出力: false
