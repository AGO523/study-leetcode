# Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

# Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.

 

# Example 1:

# Input: num1 = "2", num2 = "3"
# Output: "6"
# Example 2:

# Input: num1 = "123", num2 = "456"
# Output: "56088"
 

# Constraints:

# 1 <= num1.length, num2.length <= 200
# num1 and num2 consist of digits only.
# Both num1 and num2 do not contain any leading zero, except the number 0 itself.

#   アプローチと解説
# この問題では、与えられた数を1桁ずつ計算して積を求める手法を用います。小学校で学ぶ筆算の方法をプログラムで実装する形になります。

# アプローチ
# 結果用の配列を準備:

# num1 の長さ 
# 𝑚
# m と num2 の長さ 
# 𝑛
# n を掛け合わせると、積の最大の桁数は 
# 𝑚
# +
# 𝑛
# m+n になります。
# 𝑚
# +
# 𝑛
# m+n の長さを持つ配列 result を用意し、すべての要素を 0 に初期化します。
# 桁ごとの積を計算:

# num1 の各桁と num2 の各桁を掛け合わせ、対応する桁位置に結果を加算します。
# 繰り上がりの処理:

# 配列内の各桁で繰り上がりを処理し、正しい桁位置に値を収めます。
# 結果を文字列に変換:

# 配列を結合し、不要な先頭の 0 を削除します。


def multiply(num1, num2)
  m, n = num1.length, num2.length
  result = Array.new(m + n, 0)  # 結果を保存するための配列

  # 各桁の積を計算し、対応する位置に加算
  (m - 1).downto(0) do |i|
    (n - 1).downto(0) do |j|
      mul = (num1[i].to_i) * (num2[j].to_i)  # 各桁の積
      sum = mul + result[i + j + 1]          # 既存の値に加算
      result[i + j + 1] = sum % 10           # 現在の位置の値
      result[i + j] += sum / 10              # 繰り上がり
    end
  end

  # 配列を文字列に変換し、先頭の '0' を削除
  while result[0] == 0 && result.length > 1
    result.shift
  end

  result.join
end

# テストケース2
puts "\nテストケース2: num1 = '123', num2 = '456'"
puts "結果: #{multiply('123', '456')}"  # 期待される出力: "56088"

# 問題の背景と目的
# 通常、Rubyの*演算子を使用すれば数値の掛け算を簡単に計算できます。しかし、以下のような理由から、直接 * を使った掛け算が禁止されています。

# 1. 大きな整数の計算の練習
# num1 と num2 が文字列として与えられる理由は、非常に大きな数値を想定しているためです。
# 例えば、num1 = "99999999999999999999"（20桁）や num2 = "88888888888888888888" の場合、通常のInteger型では計算できない場合があります。
# 問題では桁ごとに計算する筆算のアルゴリズムを実装することが求められています。
# 2. 整数型の範囲外の計算の対応
# Rubyは自動的に大きな整数を BigInteger に昇格させますが、ほとんどの言語（例: C++やJava）では固定サイズの整数型（例えば32ビットや64ビット）を使用します。その場合、大きな数値の掛け算を直接扱うとオーバーフローが発生します。
# この問題では、「桁を一つずつ処理して計算を手動で行う」ことを通じて、大きな数値に対応する方法を学ぶことが目的です。

# 桁あふれ処理（繰り上げや繰り下げ）
# 桁あふれを制御するために / と % を使うことができます。
# n = 12345
# puts "最下位桁: #{n % 10}"      # 最下位桁を取得（出力: 5）
# puts "最下位桁を削除: #{n / 10}" # 最下位桁を削除（出力: 1234）
