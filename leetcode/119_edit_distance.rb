# Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2.

# You have the following three operations permitted on a word:

# Insert a character
# Delete a character
# Replace a character
 

# Example 1:

# Input: word1 = "horse", word2 = "ros"
# Output: 3
# Explanation: 
# horse -> rorse (replace 'h' with 'r')
# rorse -> rose (remove 'r')
# rose -> ros (remove 'e')
# Example 2:

# Input: word1 = "intention", word2 = "execution"
# Output: 5
# Explanation: 
# intention -> inention (remove 't')
# inention -> enention (replace 'i' with 'e')
# enention -> exention (replace 'n' with 'x')
# exention -> exection (replace 'n' with 'c')
# exection -> execution (insert 'u')
 

# Constraints:

# 0 <= word1.length, word2.length <= 500
# word1 and word2 consist of lowercase English letters.

# 2つの文字列 word1 と word2 が与えられたとき、word1 を word2 に変換するために必要な最小の操作回数を返してください。
# 許可されている操作は以下の3つです:
# 1. 文字を挿入する
# 2. 文字を削除する
# 3. 文字を置換する

# 例1:
# 入力: word1 = "horse", word2 = "ros"
# 出力: 3
# 説明:
# horse -> rorse (h を r に置換)
# rorse -> rose (r を削除)
# rose -> ros (e を削除)

# 例2:
# 入力: word1 = "intention", word2 = "execution"
# 出力: 5
# 説明:
# intention -> inention (t を削除)
# inention -> enention (i を e に置換)
# enention -> exention (n を x に置換)
# exention -> exection (n を c に置換)
# exection -> execution (u を挿入)

# この問題は、2つの文字列 word1 と word2 が与えられたとき、word1 を word2 に変換するために必要な最小の操作回数を求めるものです。許可されている操作は「文字の挿入」、「文字の削除」、「文字の置換」の3つです。動的計画法（Dynamic Programming, DP）を使って解を導きます。

# 動的計画法の考え方
# この問題を解くために、DPテーブル dp を使います。dp[i][j] は「word1 の最初の i 文字を使って word2 の最初の j 文字に変換するための最小操作回数」を表します。

# 初期化
# dp[i][0] は、word2 が空の文字列のとき、word1 の最初の i 文字をすべて削除する操作が必要です。そのため、dp[i][0] = i です。
# dp[0][j] は、word1 が空の文字列のとき、word2 の最初の j 文字をすべて挿入する必要があるので、dp[0][j] = j です。
# 状態遷移
# word1[i-1] と word2[j-1] が同じ場合：
# 操作は不要であるため、dp[i][j] = dp[i-1][j-1] となります。これは、前の部分文字列の変換回数をそのまま利用することを意味します。
# word1[i-1] と word2[j-1] が異なる場合：
# 挿入、削除、置換の3つの操作のうち最小のものを選び、操作回数に1を加えます。
# 挿入：dp[i][j-1] + 1
# 削除：dp[i-1][j] + 1
# 置換：dp[i-1][j-1] + 1
# この中から最小のものを選んで dp[i][j] に代入します。

def min_distance(word1, word2)
  m, n = word1.length, word2.length
  dp = Array.new(m + 1) { Array.new(n + 1, 0) }

  # 初期化: 空の文字列に対しての変換回数を設定

  # dp[i][0] は、word2 が空の文字列のとき、word1 の最初の i 文字をすべて削除する操作が必要です。そのため、dp[i][0] = i です。
  (0..m).each do |i|
    dp[i][0] = i  # word1 の i 文字を全て削除する
  end
  # dp[0][j] は、word1 が空の文字列のとき、word2 の最初の j 文字をすべて挿入する必要があるので、dp[0][j] = j です。
  (0..n).each do |j|
    dp[0][j] = j  # word2 の j 文字を全て挿入する
  end

  (1..m).each do |i|
    (1..n).each do |j|
      if word1[i - 1] == word2[j - 1]
        # 文字が一致する場合、操作は不要
        dp[i][j] = dp[i - 1][j - 1]
      else
        # 文字が一致しない場合、挿入、削除、置換の最小回数を求める
        dp[i][j] = 1 + [
          dp[i - 1][j],    # 削除
          dp[i][j - 1],    # 挿入
          dp[i - 1][j - 1] # 置換
        ].min
      end
      # 状態遷移の経過表示
      puts "dp[#{i}][#{j}] = #{dp[i][j]}"
    end
  end

  dp[m][n]
end

# テストケース1
puts "テストケース1: word1 = 'horse', word2 = 'ros'"
puts "結果: #{min_distance('horse', 'ros')}"  # 期待される出力: 3

# テストケース2
puts "\nテストケース2: word1 = 'intention', word2 = 'execution'"
puts "結果: #{min_distance('intention', 'execution')}"  # 期待される出力: 5

# 解説:
# 各位置 (i, j) で、word1 の i 番目までの部分文字列を word2 の j 番目までの部分文字列に変換するための最小の操作回数を dp[i][j] に記録します。
# 文字が一致する場合は操作は不要で、dp[i-1][j-1] の値をそのまま使用します。
# 文字が一致しない場合は、挿入、削除、置換の3つの操作を考慮し、それぞれの操作を行った後の回数に 1 を足した値の中で最小のものを選びます。

# 以下の行の仕組みについて詳しく説明します：

# ```ruby
# dp[i][j] = 1 + [
#   dp[i - 1][j],    # 削除
#   dp[i][j - 1],    # 挿入
#   dp[i - 1][j - 1] # 置換
# ].min
# ```

# この行は、`word1[i-1]` と `word2[j-1]` が異なる場合に、`word1` の部分文字列を `word2` に変換するための最小操作回数を計算しています。この部分は3つの異なる操作を考慮し、それらの中で最小の操作回数を求めるものです。具体的には次の3つの操作が可能です：

# 1. **削除** (`dp[i - 1][j]`)
#    - `word1` の `i` 番目の文字を削除します。
#    - これにより、`word1` の最初の `i - 1` 文字と `word2` の最初の `j` 文字を一致させる問題になります。
#    - この場合、`dp[i-1][j]` には、`word1` の `i - 1` 文字を `word2` の `j` 文字に変換するための操作回数が格納されています。

# 2. **挿入** (`dp[i][j - 1]`)
#    - `word2` の `j` 番目の文字を `word1` に挿入します。
#    - これにより、`word1` の最初の `i` 文字と `word2` の最初の `j - 1` 文字を一致させる問題になります。
#    - この場合、`dp[i][j-1]` には、`word1` の `i` 文字を `word2` の `j - 1` 文字に変換するための操作回数が格納されています。

# 3. **置換** (`dp[i - 1][j - 1]`)
#    - `word1` の `i` 番目の文字を `word2` の `j` 番目の文字に置き換えます。
#    - これにより、`word1` の最初の `i - 1` 文字と `word2` の最初の `j - 1` 文字を一致させる問題になります。
#    - この場合、`dp[i-1][j-1]` には、`word1` の `i - 1` 文字を `word2` の `j - 1` 文字に変換するための操作回数が格納されています。

# これら3つの操作の中で、どの操作を行うべきかは最小の操作回数によって決まります。そのため、`1 + [...] .min` で最小の操作回数を選び、それに1を足すことで、現在の位置での操作回数を求めています。

# ### 例
# 例えば、`word1 = "horse"` と `word2 = "ros"` の場合を考えます。

# - `i = 3`、`j = 2` のとき、`word1[i-1]` は `"r"`、`word2[j-1]` は `"o"` です。文字が一致しないため、以下の3つの操作を考慮します：
#   1. `"r"` を削除する（`dp[i-1][j]`）
#   2. `"o"` を挿入する（`dp[i][j-1]`）
#   3. `"r"` を `"o"` に置き換える（`dp[i-1][j-1]`）

# このうち最小の操作回数を選び、それに1を足して `dp[i][j]` を更新します。

# このように、各ステップで最小の操作を選択しながらDPテーブルを更新していくことで、`word1` から `word2` への変換の最小操作回数を求めることができます。
