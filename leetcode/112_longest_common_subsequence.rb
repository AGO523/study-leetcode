# Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.

# A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

# For example, "ace" is a subsequence of "abcde".
# A common subsequence of two strings is a subsequence that is common to both strings.

# 2つの文字列 text1 と text2 が与えられたとき、それらの最長共通部分列（Longest Common Subsequence）の長さを返してください。共通部分列が存在しない場合は 0 を返します。

# 部分列の定義：
# 部分列とは、元の文字列からいくつかの文字（ゼロ個でもよい）を削除して作られる新しい文字列です。このとき、残りの文字の相対的な順序は変わりません。

# 例えば、"ace" は "abcde" の部分列です。

# 2つの文字列に共通する部分列は、両方の文字列に含まれる部分列です。

# Example 1:

# Input: text1 = "abcde", text2 = "ace" 
# Output: 3  
# Explanation: The longest common subsequence is "ace" and its length is 3.
# Example 2:

# Input: text1 = "abc", text2 = "abc"
# Output: 3
# Explanation: The longest common subsequence is "abc" and its length is 3.
# Example 3:

# Input: text1 = "abc", text2 = "def"
# Output: 0
# Explanation: There is no such common subsequence, so the result is 0.
 

# Constraints:

# 1 <= text1.length, text2.length <= 1000
# text1 and text2 consist of only lowercase English characters.

# アプローチ
# 動的計画法の基本アイデア：

# dp[i][j] を「text1[0...i-1] と text2[0...j-1] の最長共通部分列の長さ」と定義します。
# もし text1[i-1] == text2[j-1] なら、その文字が共通の部分列に含まれるため、dp[i][j] = dp[i-1][j-1] + 1 とします。
# もし text1[i-1] != text2[j-1] なら、text1[0...i-1] または text2[0...j-1] のどちらか一方の最長共通部分列の長さを採用するため、dp[i][j] = max(dp[i-1][j], dp[i][j-1]) とします。
# 状態遷移：

# 各文字の比較に基づいて、DPテーブルを更新していきます。
# 最終結果：

# dp[text1.length][text2.length] が、text1 と text2 の最長共通部分列の長さになります。

def longest_common_subsequence(text1, text2)
  # dp配列を初期化。 (text1.length + 1) x (text2.length + 1) の2D配列
  dp = Array.new(text1.length + 1) { Array.new(text2.length + 1, 0) }

  # dpテーブルを計算
  (1..text1.length).each do |i|
    (1..text2.length).each do |j|
      p "現在検証している文字: text1[#{i-1}] = #{text1[i-1]}, text2[#{j-1}] = #{text2[j-1]}"
      if text1[i-1] == text2[j-1]
        dp[i][j] = dp[i-1][j-1] + 1
        puts "dp[#{i}][#{j}] (#{text1[i-1]} == #{text2[j-1]}) -> #{dp[i][j]}"
      else
        dp[i][j] = [dp[i-1][j], dp[i][j-1]].max
        puts "dp[#{i}][#{j}] -> #{dp[i][j]}"
      end
    end
  end

  # 最終的な最長共通部分列の長さ
  puts "最終的なDPテーブル: #{dp.inspect}"
  dp[text1.length][text2.length]
end

# テストケース1
puts "テストケース1: text1 = 'abcde', text2 = 'ace'"
puts "出力: #{longest_common_subsequence('abcde', 'ace')}"  # 期待される出力: 3

# テストケース2
# puts "\nテストケース2: text1 = 'abc', text2 = 'abc'"
# puts "出力: #{longest_common_subsequence('abc', 'abc')}"  # 期待される出力: 3

# # テストケース3
# puts "\nテストケース3: text1 = 'abc', text2 = 'def'"
# puts "出力: #{longest_common_subsequence('abc', 'def')}"  # 期待される出力: 0

# 最長共通部分列（LCS）のロジックを、より詳細に説明します。ポイントは、2つの文字列に対して**共通している部分列**の長さを計算するということです。最長共通部分列を求める問題は、2つの文字列の相対的な文字の順序を保ちながら、どれだけ多くの文字が共通しているかを見つける問題です。

# ### 問題のゴール

# 2つの文字列 `text1` と `text2` に対して、**最も長い共通部分列**の長さを見つけます。

# ### 部分列とは？

# 部分列は、文字列からいくつかの文字を取り除くことで得られる文字列です。ただし、**文字の順序は変えません**。

# 例えば：
# - `"ace"` は `"abcde"` の部分列です。
# - `"aec"` は部分列ではありません（順序が変わっているため）。

# ### ロジックの概要

# この問題を解くために、**動的計画法（DP）** を使います。2つの文字列 `text1` と `text2` のすべての組み合わせについて、その部分までの最長共通部分列を計算し、その結果を再利用しながら最終的な解を得ます。

# #### 1. DPテーブルとは？

# DPテーブル `dp[i][j]` を次のように定義します：

# - **`dp[i][j]`**: `text1` の最初の `i` 文字と `text2` の最初の `j` 文字に対しての**最長共通部分列の長さ**を表します。

# ### 具体的なステップ

# #### 1. テーブルの初期化

# 最初に、`text1` と `text2` の長さに基づいて、`(text1.length + 1) x (text2.length + 1)` の2次元配列 `dp` をすべて `0` で初期化します。

# - `dp[0][*]` や `dp[*][0]` は空の文字列を比較しているため、共通部分列の長さは `0` です。

# #### 2. 状態遷移

# 2つの文字列の各文字を順番に比較して、次のルールに従って `dp` テーブルを更新します：

# 1. **文字が一致する場合** (`text1[i-1] == text2[j-1]`)：
#    - `dp[i][j] = dp[i-1][j-1] + 1`  
#      文字が一致するので、最長共通部分列にこの文字を追加し、前の状態 `dp[i-1][j-1]` に `1` を足します。

# 2. **文字が一致しない場合** (`text1[i-1] != text2[j-1]`)：
#    - `dp[i][j] = max(dp[i-1][j], dp[i][j-1])`  
#      文字が一致しない場合、今までの部分文字列から文字を追加できないため、上 (`dp[i-1][j]`) または左 (`dp[i][j-1]`) のどちらか大きい方を引き継ぎます。

# #### 3. 最終結果

# 最長共通部分列の長さは、テーブルの最後のセル `dp[text1.length][text2.length]` に格納されます。

# ### 例の流れで説明：`text1 = "abcde"`, `text2 = "ace"`

# 1. DPテーブルを初期化：

#    ```
#        t2[ ]  t2[a]  t2[c]  t2[e]
#    t1[ ]   0      0      0      0
#    t1[a]   0      0      0      0
#    t1[b]   0      0      0      0
#    t1[c]   0      0      0      0
#    t1[d]   0      0      0      0
#    t1[e]   0      0      0      0
#    ```

# 2. `text1[0] == text2[0]` （両方の最初の文字が `'a'` なので一致）：

#    - `dp[1][1] = dp[0][0] + 1 = 1`

#    ```
#        t2[ ]  t2[a]  t2[c]  t2[e]
#    t1[ ]   0      0      0      0
#    t1[a]   0      1      0      0
#    t1[b]   0      0      0      0
#    t1[c]   0      0      0      0
#    t1[d]   0      0      0      0
#    t1[e]   0      0      0      0
#    ```

# 3. `text1[1] != text2[0]`（`'b'` と `'a'` は一致しないので、最大値を引き継ぐ）：

#    - `dp[2][1] = max(dp[1][1], dp[2][0]) = 1`

#    ```
#        t2[ ]  t2[a]  t2[c]  t2[e]
#    t1[ ]   0      0      0      0
#    t1[a]   0      1      0      0
#    t1[b]   0      1      0      0
#    t1[c]   0      0      0      0
#    t1[d]   0      0      0      0
#    t1[e]   0      0      0      0
#    ```

# 4. `text1[2] == text2[1]` （両方の文字が `'c'` なので一致）：

#    - `dp[3][2] = dp[2][1] + 1 = 2`

#    ```
#        t2[ ]  t2[a]  t2[c]  t2[e]
#    t1[ ]   0      0      0      0
#    t1[a]   0      1      0      0
#    t1[b]   0      1      0      0
#    t1[c]   0      1      2      0
#    t1[d]   0      0      0      0
#    t1[e]   0      0      0      0
#    ```

# 5. 最終的に `dp[5][3] = 3` となり、最長共通部分列の長さは `3` です。

# ---

# ### ロジックのポイント

# 1. **文字が一致した場合**：  
#    文字が共通しているので、直前の部分列に1を足して、長さが増えます。

# 2. **文字が一致しない場合**：  
#    その文字を無視して、これまでの最長共通部分列の最大値を引き継ぎます。

# ### 結果

# DPテーブルの右下にある値が、最長共通部分列の長さを示しています。もし共通部分列が全くなければ、この値は `0` になります。

# ---

# このロジックで、2つの文字列の共通部分列を効率的に求めることができます。
