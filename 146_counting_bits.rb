# Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1's in the binary representation of i.

# 整数 n が与えられたとき、長さ n + 1 の配列 ans を返してください。この配列では、各インデックス i（0 <= i <= n）について、ans[i] は整数 i の 2 進数表現における 1 の数を表します。

# Example 1:

# Input: n = 2
# Output: [0,1,1]
# Explanation:
# 0 --> 0
# 1 --> 1
# 2 --> 10
# Example 2:

# Input: n = 5
# Output: [0,1,1,2,1,2]
# Explanation:
# 0 --> 0
# 1 --> 1
# 2 --> 10
# 3 --> 11
# 4 --> 100
# 5 --> 101
 

# Constraints:

# 0 <= n <= 105

def count_bits(n)
  # 結果を保存する配列
  ans = Array.new(n + 1, 0)

  # 0 から n まで各数値を計算
  (1..n).each do |i|
    # i // 2 は右に 1 ビットシフトした値
    # i & 1 は最下位ビットが 1 かどうかをチェック
    ans[i] = ans[i >> 1] + (i & 1)
    puts "i: #{i}, 2進数: #{i.to_s(2)}, 1の数: #{ans[i]}"
  end

  ans
end

# テストケース 1
puts "テストケース1: n = 2"
puts "結果: #{count_bits(2)}"  # 期待出力: [0, 1, 1]

# テストケース 2
puts "\nテストケース2: n = 5"
puts "結果: #{count_bits(5)}"  # 期待出力: [0, 1, 1, 2, 1, 2]
