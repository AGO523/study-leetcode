# Given two integers a and b, return the sum of the two integers without using the operators + and -.

# 2つの整数 a と b が与えられます。+ や - 演算子を使用せずに、この2つの整数の合計を返してください。



# Example 1:

# Input: a = 1, b = 2
# Output: 3
# Example 2:

# Input: a = 2, b = 3
# Output: 5
 

# Constraints:

# -1000 <= a, b <= 1000

# コードの仕組み
# 基本概念: ビット演算で足し算を再現する
# a ^ b:

# XOR演算は、キャリーを無視してビットごとの和を計算します。
# 例: a = 1 (01) と b = 2 (10) の場合：
# scss
# コードをコピーする
# 01 XOR 10 = 11 (3)
# a & b:

# AND演算は、キャリー（繰り上がり）を計算します。
# 例: a = 1 (01) と b = 2 (10) の場合：
# scss
# コードをコピーする
# 01 AND 10 = 00 (0) （キャリーなし）
# carry << 1:

# キャリーを左に1ビットシフトし、次の桁に加算します。
# これらの操作を b（キャリー）が 0 になるまで繰り返すと、合計値が a に格納されます。



# 2つの整数を+/-を使わずに合計する関数
def get_sum(a, b)
  while b != 0
    # ビットごとのキャリー計算
    carry = a & b
    puts "Carry (a & b): #{carry.to_s(2)}"
    
    # キャリーなしの合計
    a = a ^ b
    puts "Intermediate sum (a ^ b): #{a.to_s(2)}"
    
    # キャリーを左に1ビットシフト
    b = carry << 1
    puts "Shifted carry: #{b.to_s(2)}"
  end
  
  # 最終結果
  puts "Final result: #{a}"
  a
end

# テストケース2
puts "\nTest Case 2:"
get_sum(2, 11)

# テストケース3
puts "\nTest Case 3:"
get_sum(-5, 3)
