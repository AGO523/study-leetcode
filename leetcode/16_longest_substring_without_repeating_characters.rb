# Given a string s, find the length of the longest 
# substring
#  without repeating characters.

 

# Example 1:

# Input: s = "abcabcbb"
# Output: 3
# Explanation: The answer is "abc", with the length of 3.
# Example 2:

# Input: s = "bbbbb"
# Output: 1
# Explanation: The answer is "b", with the length of 1.
# Example 3:

# Input: s = "pwwkew"
# Output: 3
# Explanation: The answer is "wke", with the length of 3.
# Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

class Solution
  def length_of_longest_substring(s)
    # 文字の出現を追跡するセットを初期化
    char_set = Set.new
    # 2つのポインタと最大長を初期化
    left = 0
    max_length = 0

    # 文字列を右ポインタでスライド
    (0...s.length).each do |right|
      # 重複がある場合、左ポインタを移動してセットから削除
      while char_set.include?(s[right])
        char_set.delete(s[left])
        left += 1
      end
      # 現在の文字をセットに追加
      char_set.add(s[right])
      # 最大長を更新
      # right - left + 1 は現在のウィンドウの長さを表す
      max_length = [max_length, right - left + 1].max
    end

    max_length
  end
end
