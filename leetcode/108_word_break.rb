# Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

# Note that the same word in the dictionary may be reused multiple times in the segmentation.

# 文字列 s と、文字列の辞書 wordDict が与えられたとき、s を辞書の単語の1つ以上の空白で区切られた並びに分割できるなら、true を返してください。

# 同じ辞書の単語は、分割の中で何度でも使用することができます。

# Example 1:

# Input: s = "leetcode", wordDict = ["leet","code"]
# Output: true
# Explanation: Return true because "leetcode" can be segmented as "leet code".
# Example 2:

# Input: s = "applepenapple", wordDict = ["apple","pen"]
# Output: true
# Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
# Note that you are allowed to reuse a dictionary word.
# Example 3:

# Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
# Output: false
 

# Constraints:

# 1 <= s.length <= 300
# 1 <= wordDict.length <= 1000
# 1 <= wordDict[i].length <= 20
# s and wordDict[i] consist of only lowercase English letters.
# All the strings of wordDict are unique.

# DP 配列の初期化：

# dp[i] を「s[0...i] までの部分文字列が辞書の単語で分割可能かどうか」を表すブール値とします。
# 初期値として、dp[0] = true とします。これは空の文字列は分割可能と見なすためです。
# 状態遷移：

# 各位置 i までの部分文字列 s[0...i] が辞書内の単語で分割可能かを確認します。
# 具体的には、s[0...i] をさらに前の部分 s[0...j] に分割し、s[j...i] が辞書内に含まれるかを確認します。
# dp[j] = true で、かつ s[j...i] が辞書内に含まれる場合、dp[i] = true と更新します。
# 最終結果の取得：

# dp[s.length] が true であれば、文字列 s 全体を辞書の単語に分割できたことを意味します。

require 'set'

def word_break(s, wordDict)
  # DP 配列を初期化。 dp[i] は s[0...i] が辞書で分割可能かどうか
  dp = Array.new(s.length + 1, false)
  dp[0] = true  # 空文字列は分割可能

  # 辞書をセットとして保持（検索の効率化のため）
  word_set = wordDict.to_set

  # 1文字目から順に、s を部分文字列で確認
  (1..s.length).each do |i|
    (0...i).each do |j|
      # wordDictに含まれる s[j...i] が見つかった場合、dp[i] を true に更新
      if dp[j] && word_set.include?(s[j...i])
        dp[i] = true
        puts "s[#{j}...#{i}] ('#{s[j...i]}') は辞書にあるので dp[#{i}] = true"
        break  # dp[i] が true になったら他の j は不要
      end
    end
  end

  puts "最終 dp: #{dp.inspect}"
  dp[s.length]
end

# テストケース1
# puts "テストケース1: s = 'leetcode', wordDict = ['leet', 'code']"
# puts "出力: #{word_break('leetcode', ['leet', 'code'])}"  # 期待される出力: true

# テストケース2
# puts "\nテストケース2: s = 'applepenapple', wordDict = ['apple', 'pen']"
# puts "出力: #{word_break('applepenapple', ['apple', 'pen'])}"  # 期待される出力: true

# テストケース3
puts "\nテストケース3: s = 'catsandog', wordDict = ['cats', 'dog', 'sand', 'and', 'cat']"
puts "出力: #{word_break('catsandog', ['cats', 'dog', 'sand', 'and', 'cat', 'og', 'safa'])}"  # 期待される出力: false
