# Implement pow(x, n), which calculates x raised to the power n (i.e., xn).

# pow(x, n) を実装してください。この関数は、x を n 乗した値（つまり 
# 𝑥
# 𝑛
# x 
# n
#  ）を計算します。

# Example 1:

# Input: x = 2.00000, n = 10
# Output: 1024.00000
# Example 2:

# Input: x = 2.10000, n = 3
# Output: 9.26100
# Example 3:

# Input: x = 2.00000, n = -2
# Output: 0.25000
# Explanation: 2-2 = 1/22 = 1/4 = 0.25
 

# Constraints:

# -100.0 < x < 100.0
# -231 <= n <= 231-1
# n is an integer.
# Either x is not zero or n > 0.
# -104 <= xn <= 104

# アプローチと解説
# この問題では、効率的に 
# 𝑥
# 𝑛
# x 
# n
#   を計算することが求められています。特に 
# 𝑛
# n が大きな整数である場合や負の整数である場合も正しく処理する必要があります。

# アプローチ
# 負の指数への対応:

# 𝑥
# −
# 𝑛
# =
# 1
# 𝑥
# 𝑛
# x 
# −n
#  = 
# x 
# n
 
# 1
# ​
#   であるため、n が負の場合、x を 
# 1
# /
# 𝑥
# 1/x に変更し、n を正にします。
# 高速累乗法（Exponentiation by Squaring）:

# 計算回数を減らすために、次のルールを利用します：
# 𝑛
# n が偶数の場合： 
# 𝑥
# 𝑛
# =
# (
# 𝑥
# 𝑛
# /
# 2
# )
# ⋅
# (
# 𝑥
# 𝑛
# /
# 2
# )
# x 
# n
#  =(x 
# n/2
#  )⋅(x 
# n/2
#  )
# 𝑛
# n が奇数の場合： 
# 𝑥
# 𝑛
# =
# 𝑥
# ⋅
# 𝑥
# 𝑛
# −
# 1
# x 
# n
#  =x⋅x 
# n−1
 
# 再帰またはループを利用:

# 再帰的またはループで計算を行い、効率的に値を求めます。

def my_pow(x, n)
  # 負の指数への対応
  if n < 0
    x = 1.0 / x
    n = -n
    p x
    p n
  end

  result = 1.0
  current_power = x

  while n > 0
    if n % 2 == 1
      result *= current_power
      puts "奇数指数により result 更新: #{result}"
    end
    current_power *= current_power
    puts "現在の current_power: #{current_power}"
    n /= 2
    puts "指数 n を半分に: #{n}"
  end

  result
end

# テストケース1
puts "テストケース1: x = 2.00000, n = 10"
puts "結果: #{my_pow(2.00000, 10)}"  # 期待される出力: 1024.00000

# テストケース2
puts "\nテストケース2: x = 2.10000, n = 3"
puts "結果: #{my_pow(2.10000, 3)}"  # 期待される出力: 9.26100

# テストケース3
puts "\nテストケース3: x = 2.00000, n = -2"
puts "結果: #{my_pow(2.00000, -2)}"  # 期待される出力: 0.25000


# n /= 2 は、高速累乗法で指数を半分にして計算量を減らすための重要なステップ
