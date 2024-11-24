# Reverse bits of a given 32 bits unsigned integer.

# Note:

# Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
# In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 2 above, the input represents the signed integer -3 and the output represents the signed integer -1073741825.

# 32ビットの符号なし整数のビットを反転させるプログラムを作成してください。

# 注意:

# Javaのように符号なし整数型がない言語では、入力と出力は符号付き整数型として扱われます。この場合でも、整数の内部バイナリ表現は符号の有無に関わらず同じです。
# Javaでは符号付き整数が2の補数表記を用いて表現されるため、符号付きでも結果に影響しません。
# 例1:
# 入力: n = 00000010100101000001111010011100
# 出力: 964176192 (バイナリ: 00111001011110000010100101000000)
# 説明: 入力は符号なし整数 43261596 を表し、出力はそのビット反転結果である 964176192 を表します。

# Example 1:

# Input: n = 00000010100101000001111010011100
# Output:    964176192 (00111001011110000010100101000000)
# Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.
# Example 2:

# Input: n = 11111111111111111111111111111101
# Output:   3221225471 (10111111111111111111111111111111)
# Explanation: The input binary string 11111111111111111111111111111101 represents the unsigned integer 4294967293, so return 3221225471 which its binary representation is 10111111111111111111111111111111.
 

# Constraints:

# The input must be a binary string of length 32

# 「n & 1」と「result << 1」の関係
# 「n & 1」: 現在の入力nの最下位ビットを取得します。
# 「result << 1」: 反転結果resultを1ビット左にシフトして、空いた右端に新しいビットを加える準備をします。
# 反転処理の流れ
# 例えば、n = 13 (2進数: 00000000000000000000000000001101) の場合：

# 初期状態: result = 0 (2進数: 00000000000000000000000000000000)
# 1回目のループ:
# n & 1で最下位ビット（1）を取得。
# result << 1でresultを左にシフト → 00000000000000000000000000000000
# result | 1でresultの右端に1を追加 → 00000000000000000000000000000001
# 次のループでnを右にシフト（n >>= 1）し、次の最下位ビットを取得。
# 上記を32回繰り返し、最終的にすべてのビットが反転されたresultを得る。

# ビットを反転する関数
def reverse_bits(n)
  # 反転結果を格納する変数
  result = 0
  # 32ビットの処理を行う
  32.times do |i|
    # 最下位ビットを取り出してresultに左シフトで追加
    bit = n & 1
    result = (result << 1) | bit
    
    # 処理の経過を出力
    puts "Step #{i + 1}: bit=#{bit}, result=#{result.to_s(2).rjust(32, '0')}"
    
    # 入力値を右シフトして次のビットへ
    n >>= 1
  end
  # 結果を返す
  result
end

# テストケース1
puts "Test Case 1:"
input = 0b00000010100101000001111010011100
output = reverse_bits(input)
puts "Output: #{output} (Binary: #{output.to_s(2).rjust(32, '0')})"
