# You are given n balloons, indexed from 0 to n - 1. Each balloon is painted with a number on it represented by an array nums. You are asked to burst all the balloons.

# If you burst the ith balloon, you will get nums[i - 1] * nums[i] * nums[i + 1] coins. If i - 1 or i + 1 goes out of bounds of the array, then treat it as if there is a balloon with a 1 painted on it.

# Return the maximum coins you can collect by bursting the balloons wisely.

 

# Example 1:

# Input: nums = [3,1,5,8]
# Output: 167
# Explanation:
# nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
# coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167
# Example 2:

# Input: nums = [1,5]
# Output: 10
 

# Constraints:

# n == nums.length
# 1 <= n <= 300
# 0 <= nums[i] <= 100

# 問題の概要
# あなたには n 個の風船が与えられており、それぞれには nums という配列で数字が描かれています。
# 風船を割ると、その風船と隣接する風船の数字を掛け合わせたコインを得られます。
# 具体的に、i 番目の風船を割ると得られるコインの数は nums[i-1] * nums[i] * nums[i+1] です。
# ただし、i-1 または i+1 が範囲外の場合、それらは 1 として扱います。
# 風船を賢く割ることで、得られる最大のコイン数を求めます。
# 動的計画法のアプローチ
# この問題を解くために、区間ごとの風船の割り方を考える「動的計画法」を用います。具体的には、次のような手順で解を求めます。

# 拡張した配列:

# 配列 nums の両端に 1 を追加することで、境界の処理を簡単にします。これにより、風船がない場合も 1 として扱えるので、実装が簡単になります。
# DPテーブル dp[i][j]:

# dp[i][j] は「区間 (i, j) の間にある風船をすべて割ったときに得られる最大のコイン数」を表します。
# 例えば、dp[0][n-1] は、すべての風船を割ったときの最大コイン数になります。
# 区間ごとの計算:

# 区間の長さを順に増やしていきながら、各区間 (i, j) の最適解を求めます。
# 区間 (i, j) において、k 番目の風船を最後に割ると仮定した場合、dp[i][j] の値は次のように計算されます：
# dp[i][k] + nums[i] * nums[k] * nums[j] + dp[k][j]
# つまり、k 番目の風船を最後に割ったときに得られるコイン数に、左右の部分区間のコイン数を加えたものです。
# これをすべての k について試行し、最適なものを選択します。
# 結果の取得:

# 最終的に dp[0][n-1] に全ての風船を割ったときの最大コイン数が格納されているため、それを返します。

# あなたには n 個の風船が与えられています。それらは 0 から n - 1 のインデックスで示されています。
# 各風船には nums という配列で表される数字が描かれています。
# あなたはすべての風船を割る必要があります。
#
# i 番目の風船を割ると、nums[i - 1] * nums[i] * nums[i + 1] コインを獲得できます。
# ただし、i - 1 または i + 1 が配列の範囲外になる場合、それらは 1 として扱います。
# すべての風船を賢く割って得られる最大のコイン数を返してください。

# 例1:
# 入力: nums = [3,1,5,8]
# 出力: 167
# 説明:
# nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
# コイン = 3*1*5 + 3*5*8 + 1*3*8 + 1*8*1 = 167

# 例2:
# 入力: nums = [1,5]
# 出力: 10

def max_coins(nums)
  # 配列の両端に 1 を追加することで、境界条件を簡単に扱えるようにします。
  nums = [1] + nums + [1]
  n = nums.length
  dp = Array.new(n) { Array.new(n, 0) }

  # 最外側のループ (2...n).each do |l| は区間の長さを示し、風船を割る区間の範囲を順に増やして部分問題を解いています。
  # 中のループ (0...(n - l)).each do |i| は各区間の開始位置 i を決めています。
  # 内側のループ (i + 1...j).each do |k| は最後に割る風船 k を決定するために使用され、各区間の最大コイン数を試行しています。
  (2...n).each do |l|
    (0...(n - l)).each do |i|
      # j は区間の終端を示します。i が区間の開始位置であり、l が区間の長さであるため、j = i + l によって区間の終了位置が計算されます。
      j = i + l
      (i + 1...j).each do |k|
        # dp[i][j] は区間 (i, j) の風船をすべて割るときの最大コイン数
        # k は区間 (i, j) の間にあるインデックスで、k 番目の風船を最後に割ると仮定します。その場合、得られるコイン数は以下のように計算されます：
        # dp[i][k]：区間 (i, k) の風船をすべて割った後の最大コイン数
        # nums[i] * nums[k] * nums[j]：風船 k を割ったときに得られるコイン数
        # dp[k][j]：区間 (k, j) の風船をすべて割った後の最大コイン数
        dp[i][j] = [
          dp[i][j],
          dp[i][k] + nums[i] * nums[k] * nums[j] + dp[k][j]
        ].max
      end
    end
  end

  dp[0][n - 1]
end

# テストケース1
puts "テストケース1: nums = [3,1,5,8]"
puts "結果: #{max_coins([3,1,5,8])}"  # 期待される出力: 167

# # テストケース2
# puts "\nテストケース2: nums = [1,5]"
# puts "結果: #{max_coins([1,5])}"  # 期待される出力: 10

# 解説:
# この問題は、動的計画法（DP）を使用して解きます。
# DP テーブル dp[i][j] は、区間 (i, j) の風船をすべて割ったときに得られる最大のコイン数を表します。
# 配列の両端に 1 を追加することで、境界の処理を簡単にしています。
# 各区間 (i, j) について、どの風船 k を最後に割るかを試行し、最適な解を見つけます。
# dp[i][k] + nums[i] * nums[k] * nums[j] + dp[k][j] で状態遷移を行い、最小の区間から順に解を積み上げていきます。
# これにより、最終的に dp[0][n-1] に全ての風船を割ったときの最大コイン数が得られます。