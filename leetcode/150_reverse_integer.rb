# Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

# Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

# 符号付き32ビット整数 x が与えられます。この数値の桁を反転した値を返してください。ただし、反転によって値が符号付き32ビット整数の範囲 [-2^31, 2^31 - 1] を超える場合は 0 を返してください。

# なお、環境では符号付き/符号なしの64ビット整数を使用することはできないものとします。



# Example 1:

# Input: x = 123
# Output: 321
# Example 2:

# Input: x = -123
# Output: -321
# Example 3:

# Input: x = 120
# Output: 21
 

# Constraints:

# -231 <= x <= 231 - 1

# 符号の処理:

# 入力 x が負の場合、符号を取り出して変数 sign に保存します。x.abs で絶対値を取得して処理を進めます。
# 桁の反転:

# to_s で文字列に変換し、reverse メソッドで文字列を反転。その後 to_i で整数に戻します。
# 符号の適用:

# 反転後の値に元の符号を掛けて、正しい符号を復元します。
# 32ビット範囲のチェック:

# 反転した結果が符号付き32ビット整数の範囲 [-2^31, 2^31 - 1] を超える場合は、0 を返します。
# puts による経過表示:


# 桁を反転する関数
def reverse(x)
  # 符号を考慮しながら桁を反転
  sign = x < 0 ? -1 : 1
  x_abs = x.abs

  reversed = x_abs.to_s.reverse.to_i
  puts "Reversed digits (as integer): #{reversed}"

  # 符号を戻す
  result = sign * reversed
  puts "Result with sign applied: #{result}"

  # 32ビットの範囲チェック
  if result < -2**31 || result > 2**31 - 1
    puts "Result is out of 32-bit integer range. Returning 0."
    return 0
  end

  result
end

# テストケース1
puts "Test Case 1:"
reverse(123)

# テストケース2
puts "\nTest Case 2:"
reverse(-123)

# テストケース3
puts "\nTest Case 3:"
reverse(120)

# テストケース4: 範囲外の値
puts "\nTest Case 4:"
reverse(1534236469)
