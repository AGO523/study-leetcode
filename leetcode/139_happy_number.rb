# Write an algorithm to determine if a number n is happy.

# A happy number is a number defined by the following process:

# Starting with any positive integer, replace the number by the sum of the squares of its digits.
# Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
# Those numbers for which this process ends in 1 are happy.
# Return true if n is a happy number, and false if not.

# n が「ハッピーナンバー」であるかを判定するアルゴリズムを作成してください。

# ハッピーナンバーは以下のプロセスで定義されます：

# 任意の正の整数から開始します。
# 数字を1桁ずつ分解し、それぞれの平方の和で元の数値を置き換えます。
# このプロセスを繰り返し、数値が 1 になるか、または 1 を含まない無限ループに陥るかを確認します。
# 数値が 1 になれば、その数は「ハッピーナンバー」です。
# 無限ループに陥れば「ハッピーナンバー」ではありません。
# n がハッピーナンバーの場合は true を、そうでない場合は false を返してください。

# Example 1:

# Input: n = 19
# Output: true
# Explanation:
# 12 + 92 = 82
# 82 + 22 = 68
# 62 + 82 = 100
# 12 + 02 + 02 = 1
# Example 2:

# Input: n = 2
# Output: false
 

# Constraints:

# 1 <= n <= 231 - 1

# アプローチと解説
# ハッピーナンバーを判定するためには、数値が1になるか、無限ループに陥るかを確認する必要があります。無限ループの判定には、set を使用して、過去に出現した数値を記録します。

# アプローチ
# 平方和を計算する関数を作成:

# 与えられた数値を桁ごとに分解し、各桁の平方の和を返す関数を作成します。
# セットを使ってループを検出:

# 数値が1に達するまでプロセスを繰り返します。
# 計算結果が以前に記録した数値と一致した場合は無限ループと判断します。
# 結果の判定:

# 数値が1に達した場合は true を返し、ループに陥った場合は false を返します。

def is_happy(n)
  # 過去の数値を記録するセット
  seen = Set.new
  
  # 数字の平方和を計算する関数
  def sum_of_squares(num)
    sum = 0
    while num > 0
      digit = num % 10
      sum += digit ** 2
      num /= 10
    end
    sum
  end

  # 数値が1になるか、無限ループになるまで繰り返す
  while n != 1
    puts "現在の数: #{n}"
    n = sum_of_squares(n)
    puts "平方和の結果: #{n}"

    # ループ検出
    if seen.include?(n)
      puts "無限ループが検出されました: #{n}"
      return false
    end

    seen.add(n)
  end

  true
end

# テストケース1
puts "テストケース1: n = 19"
puts "結果: #{is_happy(19)}"  # 期待される出力: true
