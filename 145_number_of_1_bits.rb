# Given a positive integer n, write a function that returns the number of 
# set bits
#  in its binary representation (also known as the Hamming weight).

#  正の整数 n が与えられたとき、その 2 進数表現における セットビット の数（ビットが 1 の部分の数）を返す関数を作成してください（この数は「ハミング重み」とも呼ばれます）。

# Example 1:

# Input: n = 11

# Output: 3

# Explanation:

# The input binary string 1011 has a total of three set bits.

# Example 2:

# Input: n = 128

# Output: 1

# Explanation:

# The input binary string 10000000 has a total of one set bit.

# Example 3:

# Input: n = 2147483645

# Output: 30

# Explanation:

# The input binary string 1111111111111111111111111111101 has a total of thirty set bits.

 

# Constraints:

# 1 <= n <= 231 - 1
 

# Follow up: If this function is called many times, how would you optimize it?


def hamming_weight(n)
  count = 0
  
  while n > 0
    # 現在のビットの状態を出力
    puts "現在の n: #{n}（2進数: #{n.to_s(2)})"
    # n の最下位ビットが 1 かどうかを確認
    # & はビット単位の AND 演算を行います
    count += 1 if n & 1 == 1

    # 右に1ビットシフトして次のビットを確認
    n >>= 1
  end
  
  count
end

# テストケース 1
puts "テストケース1: n = 11"
puts "結果: #{hamming_weight(11)}"  # 期待出力: 3

# テストケース 2
puts "\nテストケース2: n = 128"
puts "結果: #{hamming_weight(128)}"  # 期待出力: 1

# テストケース 3
puts "\nテストケース3: n = 2147483645"
puts "結果: #{hamming_weight(2147483645)}"  # 期待出力: 30
