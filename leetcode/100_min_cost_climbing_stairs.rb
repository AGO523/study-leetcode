# You are given an integer array cost where cost[i] is the cost of ith step on a staircase. Once you pay the cost, you can either climb one or two steps.

# You can either start from the step with index 0, or the step with index 1.

# Return the minimum cost to reach the top of the floor.

# 整数配列 cost が与えられています。この配列では、cost[i] が階段の i 番目のステップを登るのにかかるコストを表しています。コストを支払うことで、1 段または 2 段ずつ登ることができます。

# 出発は、index 0 または index 1 のどちらかから始めることができます。
# 階段の最上部（配列の最後のインデックスを超えた位置）に到達するまでの最小コストを求めてください。


# Example 1:

# Input: cost = [10,15,20]
# Output: 15
# Explanation: You will start at index 1.
# - Pay 15 and climb two steps to reach the top.
# The total cost is 15.
# Example 2:

# Input: cost = [1,100,1,1,1,100,1,1,100,1]
# Output: 6
# Explanation: You will start at index 0.
# - Pay 1 and climb two steps to reach index 2.
# - Pay 1 and climb two steps to reach index 4.
# - Pay 1 and climb two steps to reach index 6.
# - Pay 1 and climb one step to reach index 7.
# - Pay 1 and climb two steps to reach index 9.
# - Pay 1 and climb one step to reach the top.
# The total cost is 6.
 

# Constraints:

# 2 <= cost.length <= 1000
# 0 <= cost[i] <= 999

# この問題は、動的計画法（Dynamic Programming, DP） を用いると効果的に解くことができます。最小コストを求めるために、各ステップで「現在のステップに到達するのにかかる最小コスト」を計算していきます。

# アプローチ：動的計画法
# 最小コストの考え方：

# 各ステップ i に到達するための最小コストを dp[i] として表す。
# dp[i] は、1 段前（i-1）または 2 段前（i-2）のどちらかから到達できる。
# そのため、dp[i] の計算は次のようになります：
# css
# コードをコピーする
# dp[i] = min(dp[i-1] + cost[i-1], dp[i-2] + cost[i-2])
# 初期条件：

# dp[0] は 0（出発点のコストを支払わずにスタートできる）。
# dp[1] も 0 で同じ理由です。
# 到達する最上部の位置：

# 最上部は、cost.length 番目（配列を超えた位置）なので、最終的に dp[n] の値を返します。

def min_cost_climbing_stairs(cost)
  n = cost.length  # 配列の長さを取得

  # 各段数までの最小コストを管理する配列
  dp = Array.new(n + 1, 0)  # 最上階を表す n まで格納するため、サイズは n + 1

  puts "初期状態の dp: #{dp.inspect}"

  # 各段までの最小コストを計算していく
  (2..n).each do |i|
    # i 番目のステップまでの最小コストを計算
    dp[i] = [dp[i - 1] + cost[i - 1], dp[i - 2] + cost[i - 2]].min
    puts "ステップ #{i}: dp[i-1] + cost[i-1] = #{dp[i - 1]} + #{cost[i - 1]}, dp[i-2] + cost[i-2] = #{dp[i - 2]} + #{cost[i - 2]}"
    puts "  dp[#{i}] = #{dp[i]}"
  end

  # 最上階までの最小コストを返す
  dp[n]
end

# テストケース1
# puts "テストケース1 (cost = [10, 15, 20]): 出力 = #{min_cost_climbing_stairs([10, 15, 20])}"  # 期待される出力: 15

# テストケース2
puts "\nテストケース2 (cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]): 出力 = #{min_cost_climbing_stairs([1, 100, 1, 1, 1, 100, 1, 1, 100, 1])}"  # 期待される出力: 6
