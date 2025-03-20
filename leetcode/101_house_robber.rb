# You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

# Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

# あなたはプロの泥棒で、通りに並んでいる家々を狙っています。それぞれの家には、一定の金額が隠されています。しかし、セキュリティシステムが隣接する家同士で連動しており、隣接する家を同じ夜に盗むと警察に通報されてしまいます。

# 配列 nums が与えられ、nums[i] は i 番目の家に隠されている金額を表しています。このとき、警察を呼ばずに盗むことができる最大の金額を求めてください。

# Example 1:

# Input: nums = [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
# Total amount you can rob = 1 + 3 = 4.
# Example 2:

# Input: nums = [2,7,9,3,1]
# Output: 12
# Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
# Total amount you can rob = 2 + 9 + 1 = 12.
 

# Constraints:

# 1 <= nums.length <= 100
# 0 <= nums[i] <= 400

# この問題は、隣接する要素を同時に選べないという制約があるため、動的計画法（Dynamic Programming, DP） を用いて解くことができます。

# 1. アプローチの考え方
# この問題では、家 i を盗むか盗まないかを選択することで、次の 2 つの選択肢を考慮します：

# 家 i を盗む：
# 家 i-1（前の家）は盗めないので、i-2 番目までの家々の最大金額に、i 番目の家の金額を加えます。
# 家 i を盗まない：
# 家 i-1 番目までの家々の最大金額をそのまま引き継ぎます。
# 2. 動的計画法の状態遷移
# dp[i] を「i 番目の家までに盗める最大の金額」と定義します。

# 状態遷移は以下のようになります：

# css
# コードをコピーする
# dp[i] = max(dp[i-1], dp[i-2] + nums[i])
# つまり、「i-1 番目の家までの最大金額」と「i 番目の家を盗む場合の最大金額」のうち、大きい方を選びます。
# 3. 初期条件
# dp[0] = nums[0]
# dp[1] = max(nums[0], nums[1])（最初の 2 つの家のどちらを盗むのが良いかを決定）

def rob(nums)
  n = nums.length
  return nums[0] if n == 1

  # 動的計画法用の配列を初期化
  dp = Array.new(n, 0)
  dp[0] = nums[0]
  dp[1] = [nums[0], nums[1]].max

  puts "初期状態の dp: #{dp.inspect}"
  puts "1 番目の家の金額: #{nums[0]}, 2 番目の家の金額: #{nums[1]}"
  puts "初期設定: dp[0] = #{dp[0]}, dp[1] = #{dp[1]}"

  # 3 番目以降の家に対して最大金額を計算
  (2...n).each do |i|
    dp[i] = [dp[i-1], dp[i-2] + nums[i]].max
    puts "#{i+1} 番目の家の金額: #{nums[i]}"
    puts "dp[i-1] (#{i} 番目の家までの最大金額): #{dp[i-1]}, dp[i-2] + nums[i] (#{i-1} 番目の家を盗まず、#{i+1} 番目を盗む): #{dp[i-2] + nums[i]}"
    puts "dp[#{i}] = #{dp[i]}"
  end

  # 最後の家までに盗める最大の金額を返す
  dp[n-1]
end

# テストケース1
puts "テストケース1: nums = [1, 2, 3, 1]"
puts "出力: #{rob([1, 2, 3, 1])}"  # 期待される出力: 4

# テストケース2
puts "\nテストケース2: nums = [2, 7, 9, 3, 1]"
puts "出力: #{rob([2, 7, 9, 3, 1])}"  # 期待される出力: 12
