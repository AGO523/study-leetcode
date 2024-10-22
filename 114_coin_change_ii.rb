# You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

# Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return 0.

# You may assume that you have an infinite number of each kind of coin.

# The answer is guaranteed to fit into a signed 32-bit integer.

# 整数配列 coins が与えられ、それぞれが異なるコインの額面を表しています。また、整数 amount が与えられ、これは合計金額を表しています。

# この amount を作るために、異なる組み合わせの数を返してください。もし、どの組み合わせでも amount を作れない場合は 0 を返してください。

# コインの種類には無限の枚数があると仮定します。

# 答えは、32ビット符号付き整数に収まることが保証されています。

# Example 1:

# Input: amount = 5, coins = [1,2,5]
# Output: 4
# Explanation: there are four ways to make up the amount:
# 5=5
# 5=2+2+1
# 5=2+1+1+1
# 5=1+1+1+1+1
# Example 2:

# Input: amount = 3, coins = [2]
# Output: 0
# Explanation: the amount of 3 cannot be made up just with coins of 2.
# Example 3:

# Input: amount = 10, coins = [10]
# Output: 1
 

# Constraints:

# 1 <= coins.length <= 300
# 1 <= coins[i] <= 5000
# All the values of coins are unique.
# 0 <= amount <= 5000

# アプローチと解説
# この問題は、動的計画法（DP） を使って解くことができます。具体的には、「ナップサック問題」に似た問題です。目的は、与えられた amount に対して、コインの組み合わせをどれだけ使えるかを計算することです。

# アプローチ
# 動的計画法の基本アイデア：

# dp[i] を「金額 i を作るためのコインの組み合わせの数」と定義します。
# 初期値として、dp[0] = 1（これは、金額0を作るための方法が1つある、つまり何も使わない方法）。
# DPテーブルの更新：

# 各コインの値を使って、dp 配列を更新していきます。
# あるコイン coin を使って、金額 i を作るための組み合わせの数は、dp[i - coin] に基づきます。
# よって、dp[i] += dp[i - coin] で更新していきます。

def change(amount, coins)
  # dp配列を初期化し、dp[0]を1に設定（何も使わない方法が1つある）
  dp = Array.new(amount + 1, 0)
  dp[0] = 1

  # コインごとにdp配列を更新していく
  coins.each do |coin|
    (coin..amount).each do |i|
      dp[i] += dp[i - coin]
      puts "dp[#{i}] = #{dp[i]} (using coin: #{coin})"
    end
  end

  # 最終的なdp[amount]が、amountを作るための組み合わせの数
  dp[amount]
end

# テストケース1
puts "テストケース1: amount = 5, coins = [1, 2, 5]"
puts "出力: #{change(5, [1, 2, 5])}"  # 期待される出力: 4
