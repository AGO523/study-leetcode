# You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

# Increment the large integer by one and return the resulting array of digits.

# 整数を表す配列 digits が与えられます。digits[i] は整数の各桁を表し、桁は最上位（左端）から最下位（右端）の順で並んでいます。この整数には先頭の 0 は含まれません。

# この配列が表す整数を 1 増加させ、その結果を再び配列として返してください。



# Example 1:

# Input: digits = [1,2,3]
# Output: [1,2,4]
# Explanation: The array represents the integer 123.
# Incrementing by one gives 123 + 1 = 124.
# Thus, the result should be [1,2,4].
# Example 2:

# Input: digits = [4,3,2,1]
# Output: [4,3,2,2]
# Explanation: The array represents the integer 4321.
# Incrementing by one gives 4321 + 1 = 4322.
# Thus, the result should be [4,3,2,2].
# Example 3:

# Input: digits = [9]
# Output: [1,0]
# Explanation: The array represents the integer 9.
# Incrementing by one gives 9 + 1 = 10.
# Thus, the result should be [1,0].
 

# Constraints:

# 1 <= digits.length <= 100
# 0 <= digits[i] <= 9
# digits does not contain any leading 0's.

# アプローチと解説
# この問題は「配列が表す数値を1増加する」というシンプルな操作ですが、桁あふれ（キャリー）の処理を考慮する必要があります。

# アプローチ
# 配列の末尾から始めて、1を加算します。
# 加算後、桁あふれがある場合（10以上になる場合）、次の桁にキャリーを繰り上げます。
# 配列の最上位まで桁あふれが続いた場合、配列の先頭に 1 を追加します（例: [9,9] → [1,0,0]）。

def plus_one(digits)
  n = digits.length
  carry = 1  # 1を加算するための初期キャリー

  # 末尾から開始
  (n - 1).downto(0) do |i|
    puts "現在の桁: #{digits[i]}"
    digits[i] += carry
    if digits[i] == 10
      digits[i] = 0
      carry = 1
      puts "桁あふれ発生: digits[#{i}]を0に、次の桁にキャリーを繰り上げ"
    else
      carry = 0
      puts "キャリーなし: digits[#{i}] = #{digits[i]}"
      break
    end
  end

  # 最上位桁までキャリーが残っている場合
  if carry == 1
    digits.unshift(1)
    puts "最上位桁にキャリー追加: #{digits.inspect}"
  end

  digits
end

# テストケース1
puts "テストケース1: digits = [1,2,3]"
puts "結果: #{plus_one([1,2,3]).inspect}"  # 期待される出力: [1,2,4]


# テストケース4
puts "\nテストケース4: digits = [9,9]"
puts "結果: #{plus_one([9,9]).inspect}"  # 期待される出力: [1,0,0]
