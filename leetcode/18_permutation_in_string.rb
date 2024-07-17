# Given two strings s1 and s2, return true if s2 contains a permutation of s1, or false otherwise.

# In other words, return true if one of s1's permutations is the substring of s2.


# Example 1:

# Input: s1 = "ab", s2 = "eidbaooo"
# Output: true
# Explanation: s2 contains one permutation of s1 ("ba").
# Example 2:

# Input: s1 = "ab", s2 = "eidboaoo"
# Output: false
 

# Constraints:

# 1 <= s1.length, s2.length <= 104
# s1 and s2 consist of lowercase English letters.

class Solution
  def check_inclusion(s1, s2)
    return false if s1.length > s2.length

    # s1 と同じ長さのウィンドウの文字カウントを初期化
    s1_count = Hash.new(0)
    s2_count = Hash.new(0)

    # s1 の文字カウントをセットアップ
    s1.each_char { |char| s1_count[char] += 1 }

    # 最初のウィンドウのセットアップ
    s1.length.times { |i| s2_count[s2[i]] += 1 }

    # s2 のスライディングウィンドウを使ってチェック
    (s1.length...s2.length).each do |i|
      return true if s1_count == s2_count

      # ウィンドウを右に1つスライド
      s2_count[s2[i]] += 1
      s2_count[s2[i - s1.length]] -= 1

      # カウントがゼロになったらハッシュから削除
      s2_count.delete(s2[i - s1.length]) if s2_count[s2[i - s1.length]] == 0
    end

    # 最後のウィンドウをチェック
    s1_count == s2_count
  end
end

# 使用例
solution = Solution.new
puts solution.check_inclusion("ab", "eidbaooo")  # 出力は true
puts solution.check_inclusion("ab", "eidboaoo")  # 出力は false
