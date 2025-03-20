# You have intercepted a secret message encoded as a string of numbers. The message is decoded via the following mapping:

# "1" -> 'A'

# "2" -> 'B'

# ...

# "25" -> 'Y'

# "26" -> 'Z'

# However, while decoding the message, you realize that there are many different ways you can decode the message because some codes are contained in other codes ("2" and "5" vs "25").

# For example, "11106" can be decoded into:

# "AAJF" with the grouping (1, 1, 10, 6)
# "KJF" with the grouping (11, 10, 6)
# The grouping (1, 11, 06) is invalid because "06" is not a valid code (only "6" is valid).
# Note: there may be strings that are impossible to decode.

# Given a string s containing only digits, return the number of ways to decode it. If the entire string cannot be decoded in any valid way, return 0.

# The test cases are generated so that the answer fits in a 32-bit integer.

# あなたは秘密のメッセージを数字の文字列として傍受しました。このメッセージは次のマッピングに従ってデコードされます。

# "1" -> 'A'
# "2" -> 'B'
# ...
# "25" -> 'Y'
# "26" -> 'Z'
# しかし、メッセージをデコードする際に、多くの異なる方法でメッセージを解読できることに気づきます。これは、いくつかのコードが他のコードに含まれているためです（例: "2" と "5" の組み合わせと "25"）。

# たとえば、 "11106" は次のようにデコードできます：

# "AAJF"（1, 1, 10, 6 のグループ分け）
# "KJF"（11, 10, 6 のグループ分け）
# (1, 11, 06) のようなグループ分けは無効です。なぜなら "06" は有効なコードではなく、 "6" のみが有効だからです。

# 文字列全体が有効な方法でデコードできない場合、0 を返してください。

# 与えられた文字列 s がどのようにデコードできるか、その方法の数を返してください。

# テストケースは、答えが 32 ビット整数に収まるように生成されています。

# Example 1:

# Input: s = "12"

# Output: 2

# Explanation:

# "12" could be decoded as "AB" (1 2) or "L" (12).

# Example 2:

# Input: s = "226"

# Output: 3

# Explanation:

# "226" could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).

# Example 3:

# Input: s = "06"

# Output: 0

# Explanation:

# "06" cannot be mapped to "F" because of the leading zero ("6" is different from "06"). In this case, the string is not a valid encoding, so return 0.

 

# Constraints:

# 1 <= s.length <= 100
# s contains only digits and may contain leading zero(s).

# この問題は、動的計画法（Dynamic Programming, DP） を使って解くことができます。与えられた文字列の各位置で、どのようにデコードできるかを計算していき、全体のデコード方法の数を求めます。

# アプローチ
# 文字列 s を1文字ずつ、もしくは2文字ずつ取り出してデコードできるかをチェックします。
# 有効なデコードができる場合、デコード方法の数を更新します。
# 2つの条件で次の文字を確認します：
# 1文字のデコード: 1 <= s[i] <= 9 の場合、s[i] は 'A' から 'I' に対応します。
# 2文字のデコード: 10 <= s[i-1..i] <= 26 の場合、s[i-1..i] は 'J' から 'Z' に対応します。
# 動的計画法の状態
# dp[i] を「i 文字目まででデコード可能な方法の数」と定義します。
# 初期化として dp[0] = 1（空文字列は1通りのデコードがある）とします。
# dp[i] は以下のように更新します：
# 1 文字分でデコードできる場合、dp[i] += dp[i-1]。
# 2 文字分でデコードできる場合、dp[i] += dp[i-2]。


def num_decodings(s)
  return 0 if s.empty? || s[0] == '0'
  
  n = s.length
  dp = Array.new(n + 1, 0)  # dp配列の初期化
  dp[0] = 1  # 空文字列の場合のデコード方法は1つ
  dp[1] = 1  # 最初の文字が有効な場合は1つ

  (2..n).each do |i|
    # 1文字分を確認（1-9の間であればデコード可能）
    if s[i-1].to_i >= 1
      dp[i] += dp[i-1]
      puts "dp[#{i}] (1文字): #{dp[i]}  ← #{s[i-1]} をデコード"
    end

    # 2文字分を確認（10-26の間であればデコード可能）
    two_digit = s[i-2..i-1].to_i
    if two_digit >= 10 && two_digit <= 26
      dp[i] += dp[i-2]
      puts "dp[#{i}] (2文字): #{dp[i]}  ← #{s[i-2..i-1]} をデコード"
    end
  end

  dp[n]
end

# テストケース1
# puts "テストケース1: s = '12'"
# puts "出力: #{num_decodings('12')}"  # 期待される出力: 2

# テストケース2
puts "\nテストケース2: s = '226'"
puts "出力: #{num_decodings('226')}"  # 期待される出力: 3

# テストケース3
# puts "\nテストケース3: s = '06'"
# puts "出力: #{num_decodings('06')}"  # 期待される出力: 0
