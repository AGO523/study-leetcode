# A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.
# 日本語で
# すべての大文字を小文字に変換し、すべての非英数字文字を削除した後、フレーズが前方と後方で同じに読める場合、フレーズは回文です。英数字文字には文字と数字が含まれます。

# Given a string s, return true if it is a palindrome, or false otherwise.
# 日本語で
# 文字列sが与えられた場合、それが回文である場合はtrueを返し、それ以外の場合はfalseを返します。

# Example 1:

# Input: s = "A man, a plan, a canal: Panama"
# Output: true
# Explanation: "amanaplanacanalpanama" is a palindrome.
# Example 2:

# Input: s = "race a car"
# Output: false
# Explanation: "raceacar" is not a palindrome.
# Example 3:

# Input: s = " "
# Output: true
# Explanation: s is an empty string "" after removing non-alphanumeric characters.
# Since an empty string reads the same forward and backward, it is a palindrome.
 

# Constraints:

# 1 <= s.length <= 2 * 105
# s consists only of printable ASCII characters.

class Solution
  def is_palindrome(s)
    s = s.downcase.gsub(/[^a-z0-9]/, '')
    # sを逆順にして、sと同じかどうかを返す
    s == s.reverse
  end
end

s1 = "A man, a plan, a canal: Panama"
s2 = "race a car"

sol = Solution.new
p sol.is_palindrome(s1)
p sol.is_palindrome(s2)
