# You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.

# Return the length of the longest substring containing the same letter you can get after performing the above operations.

# 文字列 s と整数 k が与えられます。文字列の任意の文字を選び、別の任意の大文字の英字に変更することができます。この操作は最大で k 回まで行うことができます。

# 上記の操作を行った後、同じ文字を含む最長の部分文字列の長さを返してください。

# Example 1:

# Input: s = "ABAB", k = 2
# Output: 4
# Explanation: Replace the two 'A's with two 'B's or vice versa.
# Example 2:

# Input: s = "AABABBA", k = 1
# Output: 4
# Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
# The substring "BBBB" has the longest repeating letters, which is 4.
# There may exists other ways to achieve this answer too.
 

# Constraints:

# 1 <= s.length <= 105
# s consists of only uppercase English letters.
# 0 <= k <= s.length

# スライディングウィンドウを使って現在のウィンドウ内の文字の頻度を追跡し、最大の頻度を持つ文字を見つけます。
# ウィンドウの長さから最大の頻度を引いた数が k 以下であれば、現在のウィンドウは条件を満たしています。
# そうでなければ、左端を移動させてウィンドウを縮小します。

class Solution
  def character_replacement(s, k)
    # 文字の頻度を追跡するためのハッシュ
    count = Hash.new(0)
    left = 0
    max_count = 0
    max_length = 0

    (0...s.length).each do |right|
      # 右端の文字をカウントに追加
      count[s[right]] += 1
      # 現在のウィンドウ内の最大頻度の文字数を更新
      max_count = [max_count, count[s[right]]].max

      # ウィンドウの長さから最大頻度の文字数を引いた数が k を超える場合
      if (right - left + 1) - max_count > k
        # 左端の文字をカウントから減らし、左端を移動
        count[s[left]] -= 1
        left += 1
      end

      # 最大長を更新
      max_length = [max_length, right - left + 1].max
    end

    max_length
  end
end

# 使用例
solution = Solution.new
puts solution.character_replacement("ABAB", 2)  # 出力は4
puts solution.character_replacement("AABABBA", 1)  # 出力は4



