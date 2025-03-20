# Given two strings s and t, return the number of distinct subsequences of s which equals t.

# The test cases are generated so that the answer fits on a 32-bit signed integer.

# 2つの文字列 s と t が与えられたとき、s の部分列のうち t に等しいものの数を返してください。

# 注: テストケースは、答えが32ビット符号付き整数の範囲に収まるように生成されています。

# Example 1:

# Input: s = "rabbbit", t = "rabbit"
# Output: 3
# Explanation:
# As shown below, there are 3 ways you can generate "rabbit" from s.
# rabbbit
# rabbbit
# rabbbit
# Example 2:

# Input: s = "babgbag", t = "bag"
# Output: 5
# Explanation:
# As shown below, there are 5 ways you can generate "bag" from s.
# babgbag
# babgbag
# babgbag
# babgbag
# babgbag
 

# Constraints:

# 1 <= s.length, t.length <= 1000
# s and t consist of English letters.

# アプローチと解説
# この問題は、s の部分列を使って t を構築する方法を数えるため、動的計画法（DP）を使用して解きます。2次元のDPテーブルを使い、各位置での部分列のカウントを追跡します。

# アプローチ
# DPテーブルの定義:

# dp[i][j] を「s の最初の i 文字を使って t の最初の j 文字を生成する方法の数」とします。
# 状態遷移:

# s[i-1] == t[j-1] のとき:
# dp[i][j] = dp[i-1][j-1] + dp[i-1][j]
# dp[i-1][j-1] は、s[i-1] を t[j-1] に対応させて部分列を作る場合です。
# dp[i-1][j] は、s[i-1] を無視して s[0...i-1] までで部分列を作る場合です。
# s[i-1] != t[j-1] のとき:
# dp[i][j] = dp[i-1][j]
# s[i-1] を無視して部分列を作る場合のみ考えます。
# 初期化:

# dp[i][0] = 1 (i は 0 以上) は、t が空文字の場合、s の任意の部分列から1通りで生成できることを表します。
# dp[0][j] = 0 (j > 0 は t が空でない場合) は、空文字列 s から t の部分列を生成する方法がないことを意味します。


def num_distinct(s, t)
  m, n = s.length, t.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }
  
  # 初期化: dp[i][0] = 1
  # t が空文字の場合、s の任意の部分列から1通りで生成できることを表します
  (0..m).each do |i|
    dp[i][0] = 1
  end

  # dp[i][j] には「s の i 番目までの文字列から t の j 番目までの部分列を作る方法の数」を記録
  (1..m).each do |i|
    (1..n).each do |j|
      if s[i - 1] == t[j - 1]
        # 条件: s[i-1] == t[j-1] のとき
        # s の現在の文字 s[i-1] を t[j-1] に対応させて部分列を作る方法と、
        # s[i-1] を無視して s[0...i-1] までで部分列を作る場合を足し合わせます。
        dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j]
      else
        # 条件: s[i-1] != t[j-1] のとき
        # s[i-1] を無視して部分列を作る場合のみ考えます。
        dp[i][j] = dp[i - 1][j]
      end
      # 状態遷移の経過表示
      puts "dp[#{i}][#{j}] = #{dp[i][j]}"
    end
  end
  
  dp[m][n]
end

# テストケース1
puts "テストケース1: s = 'rabbbit', t = 'rabbit'"
puts "結果: #{num_distinct('rabbbit', 'rabbit')}"  # 期待される出力: 3

# テストケース2
puts "\nテストケース2: s = 'babgbag', t = 'bag'"
puts "結果: #{num_distinct('babgbag', 'bag')}"  # 期待される出力: 5

# 解説:
# 条件について:
# 1. s[i-1] == t[j-1] の場合:
#    - 例えば、s = "babgbag", t = "bag" のとき、i = 5, j = 2 で s[i-1] と t[j-1] が共に "a" です。
#      この場合、s[i-1] を t[j-1] に対応させる方法 (dp[i-1][j-1]) と、s[i-1] を無視して部分列を作る方法 (dp[i-1][j]) を足し合わせます。
#    - これは、s[i-1] を t[j-1] に一致させる選択肢がある場合、その文字を使う場合と使わない場合の両方を考慮する必要があるためです。
# 2. s[i-1] != t[j-1] の場合:
#    - 例えば、s = "babgbag", t = "bag" のとき、i = 5, j = 3 で s[i-1] が "b" であり t[j-1] は "g" です。
#      この場合、s[i-1] が t[j-1] と異なるため、s[i-1] を無視して部分列を作る方法のみを考慮します (dp[i-1][j])。
#    - s[i-1] が t[j-1] と異なる場合、その文字を使用することはできないため、一致しない文字を飛ばして次に進む必要があります。
# 
# 具体例:
# テストケース1: s = "rabbbit", t = "rabbit"
# - s の 3 つの異なる位置にある "b" を使って t の "b" に対応させることができます。
# - 最終的に、3 通りの方法で "rabbit" を部分列として生成できます。
# 
# テストケース2: s = "babgbag", t = "bag"
# - s の中で "b", "a", "g" を選ぶ組み合わせが複数あります。
# - 例えば、1 文字目の "b"、3 文字目の "a"、6 文字目の "g" など、5 通りの組み合わせで "bag" を生成できます。

# 文字が一致する場合に現在の文字を使うか、使わないかの2通りの方法を足し合わせる理由は、全ての部分列の可能性を考慮するためです。

# 具体的に説明すると、`s[i-1]` と `t[j-1]` が一致する場合、その文字を使うことで `t` を作ることができる選択肢があります。同時に、その文字を使わずに他の文字から部分列を作る選択肢も存在します。この2つの選択肢のいずれも `t` を作る可能性があるため、それらを足し合わせて、`t` を生成する全ての部分列の数を求めます。

# 例えば、`s = "babgbag"` と `t = "bag"` の場合を考えます。

# - `i = 5` と `j = 2` の時、`s[i-1]` と `t[j-1]` は共に `"a"` です。この場合、`s[i-1]` を使って `t[j-1]` に対応させることができますが、他の部分列を考慮するために次の2つの選択肢があります：
#   1. 現在の `"a"` を使って部分列を作る場合 (`dp[i-1][j-1]`)。
#   2. 現在の `"a"` を使わずに部分列を作る場合 (`dp[i-1][j]`)。

# このように、文字が一致したときにはその文字を使う・使わないという選択肢が常に存在するため、両方の可能性を足し合わせて部分列の数を求めます。これにより、全ての組み合わせを考慮した結果が得られます。
