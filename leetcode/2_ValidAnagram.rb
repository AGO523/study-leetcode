# Given two strings s and t, return true if t is an anagram of s, and false otherwise.

# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

# Example 1:

# Input: s = "anagram", t = "nagaram"
# Output: true
# Example 2:

# Input: s = "rat", t = "car"
# Output: false

# Constraints:

# 1 <= s.length, t.length <= 5 * 104
# s and t consist of lowercase English letters.

class Solution
  def is_anagram(s, t)
    s.chars.sort == t.chars.sort
  end
end

s1 = "anagram"
t1 = "nagaram"
s2 = "rat"
t2 = "car"

sol = Solution.new
puts sol.is_anagram(s1, t1)
puts sol.is_anagram(s2, t2)
