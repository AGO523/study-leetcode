# Given an array of strings strs, group the anagrams together. You can return the answer in any order.
# 日本語で
# 文字列の配列strsが与えられた場合、アナグラムをグループ化します。どのような順番でも答えを返すことができます。

# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
# アナグラムは、通常、すべての元の文字を1回だけ使用して、異なる単語またはフレーズの文字を並べ替えて形成される単語またはフレーズです。


# Example 1:

# Input: strs = ["eat","tea","tan","ate","nat","bat"]
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
# Example 2:

# Input: strs = [""]
# Output: [[""]]
# Example 3:

# Input: strs = ["a"]
# Output: [["a"]]

# Constraints:

# 1 <= strs.length <= 104
# 0 <= strs[i].length <= 100
# strs[i] consists of lowercase English letters.

class Solution
  def group_anagrams(strs)
    strs.group_by { |str| str.chars.sort }.values
  end
end

# ruby group_byメソッド
# https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/group_by.html
# ブロックを評価した結果をキー、対応する要素の配列を値とするハッシュを返します。

strs1 = ["eat","tea","tan","ate","nat","bat"]
strs2 = [""]
strs3 = ["a"]

sol = Solution.new
puts sol.group_anagrams(strs1)
puts sol.group_anagrams(strs2)
puts sol.group_anagrams(strs3)
