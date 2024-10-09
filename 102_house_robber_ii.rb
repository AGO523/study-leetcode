# You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

# Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

# あなたはプロの泥棒で、通りに並んでいる家々を狙っています。各家には一定の金額が隠されています。しかし、今回の家々は円形に配置されており、最初の家と最後の家が隣接しています。

# 隣接する家にはセキュリティシステムが連動しているため、隣接する家を同じ夜に盗むと警察に通報されてしまいます。家の円環状の配置のため、最初の家と最後の家も隣接していると見なされる点に注意してください。

# 配列 nums が与えられ、nums[i] は i 番目の家に隠されている金額を表しています。このとき、警察を呼ばずに盗むことができる最大の金額を求めてください。

# Example 1:

# Input: nums = [2,3,2]
# Output: 3
# Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
# Example 2:

# Input: nums = [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
# Total amount you can rob = 1 + 3 = 4.
# Example 3:

# Input: nums = [1,2,3]
# Output: 3
 

# Constraints:

# 1 <= nums.length <= 100
# 0 <= nums[i] <= 1000

# 隣接する家を同時に盗むことができないため、特に「最初の家」と「最後の家」を同時に盗むことができないという制約に注意する必要があります。

# 1. 解法のポイント
# 円環状の家において、隣接する家がセキュリティシステムで繋がっているため、最初の家を盗んだ場合は最後の家を盗めないことに注意します。

# 通常の家の並びと異なる点は、最初と最後の家が連動していることです。そのため、この問題を2 つの異なる場合に分けて考えます：

# ケース 1: 最初の家を含むが、最後の家は含まない。
# ケース 2: 最初の家を含まず、最後の家を含む。
# 2. アプローチの流れ
# 円環状の問題を解くために、次のように問題を 2 つに分解します：
# ケース 1（最初の家を盗む）：

# nums[0] から nums[n-2] までの家々を対象に考え、最大金額を求める。
# ケース 2（最初の家を盗まない）：

# nums[1] から nums[n-1] までの家々を対象に考え、最大金額を求める。
# 上記の 2 つのケースのうち、最大の金額を返すのがこの問題の解となります。

# 3. 実装方法
# 各ケースに対して、前回の「通常の家の並びの最大金額を求めるアルゴリズム（House Robber）」を使用します。
# 「通常の家の並びの最大金額を求める」ロジックを別関数 rob_helper として定義し、分割した配列に対して rob_helper を適用します。

def rob(nums)
  n = nums.length
  return nums[0] if n == 1

  # 通常の家の並びに対して最大金額を求める補助関数
  def rob_helper(nums)
    n = nums.length
    return 0 if n == 0
    return nums[0] if n == 1

    # DP 配列の初期化
    dp = Array.new(n, 0)
    dp[0] = nums[0]
    dp[1] = [nums[0], nums[1]].max

    # 2番目以降の家に対して、最大金額を計算
    (2...n).each do |i|
      dp[i] = [dp[i - 1], dp[i - 2] + nums[i]].max
      puts "#{i+1} 番目の家の金額: #{nums[i]}"
      puts "dp[i-1] (#{i} 番目の家までの最大金額): #{dp[i - 1]}, dp[i-2] + nums[i] (#{i-1} 番目の家を盗まず、#{i+1} 番目を盗む): #{dp[i - 2] + nums[i]}"
      puts "dp[#{i}] = #{dp[i]}"
    end

    # 最後の家までの最大金額を返す
    dp[n - 1]
  end

  # ケース 1: 最初の家を盗む (最後の家は盗まない)
  max1 = rob_helper(nums[0...n - 1])
  # ケース 2: 最初の家を盗まない (最後の家を含む)
  max2 = rob_helper(nums[1...n])
  [max1, max2].max
end

# テストケース1
puts "テストケース1: nums = [2, 3, 2]"
puts "出力: #{rob([2, 3, 2])}"  # 期待される出力: 3

# テストケース2
puts "\nテストケース2: nums = [1, 2, 3, 1]"
puts "出力: #{rob([1, 2, 3, 1])}"  # 期待される出力: 4

# テストケース3
puts "\nテストケース3: nums = [1, 2, 3]"
puts "出力: #{rob([1, 2, 3])}"  # 期待される出力: 3
