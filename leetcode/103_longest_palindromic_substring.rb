# Given a string s, return the longest 
# palindromic
 
# substring
#  in s.

#  文字列 s が与えられたとき、その中で最も長い回文の部分文字列を返してください。

#  回文とは？
#  回文とは、前から読んでも後ろから読んでも同じ文字列のことを指します。
#  例: "aba", "racecar", "madam"

# Example 1:

# Input: s = "babad"
# Output: "bab"
# Explanation: "aba" is also a valid answer.
# Example 2:

# Input: s = "cbbd"
# Output: "bb"
 

# Constraints:

# 1 <= s.length <= 1000
# s consist of only digits and English letters.

# DP を用いて回文を見つける方法は、以下のように進めます。

# 回文の特徴を確認:

# 部分文字列が回文であるためには、次の条件が満たされる必要があります：
# s[i] == s[j] で、かつ、s[i+1..j-1] が回文であること。
# 動的計画法の配列 dp を定義:

# dp[i][j] を「文字列 s の i 番目から j 番目までの部分文字列が回文かどうか（true または false）」を示す値とします。
# 条件:
# s[i] == s[j] のとき、dp[i][j] が true になるためには、内部の部分文字列 s[i+1..j-1] も回文である必要があります。
# DP 配列を初期化する:

# 1 文字の部分文字列（s[i]）は必ず回文なので、dp[i][i] = true とします。
# 各部分文字列の回文判定を行う:

# 長さ 2 以上の部分文字列に対して、dp 配列を更新していきます。
# j（終了位置）を i（開始位置）より右側に設定し、s[i] == s[j] かを確認します。
# j - i <= 2 のとき、i と j の間に 1 文字以下しかないので、それが一致していれば dp[i][j] = true。
# j - i > 2 のとき、dp[i+1][j-1] が true であれば、dp[i][j] も true。
# 最も長い回文を保持する:

# 各ステップで dp[i][j] が true になったときに、最大の回文長を更新し、開始位置 start と長さ max_length を保持します。
# 最も長い回文部分文字列を返す:

# s[start, max_length] を返します。

# def longest_palindrome(s)
#   n = s.length
#   return s if n <= 1
#   # DP 配列の初期化（全て false に設定）
#   dp = Array.new(n) { Array.new(n, false) }
  
#   # 最長回文の開始位置と最大長さを初期化
#   start = 0
#   max_length = 1

#   # 1文字の部分文字列は全て回文
#   (0...n).each do |i|
#     dp[i][i] = true
#   end

#   puts "1文字の部分文字列は全て回文: #{dp.inspect}"

#   # 部分文字列の長さを2以上にして判定
#   (1...n).each do |length|
#     (0...n-length).each do |i|
#       j = i + length  # 部分文字列 s[i...j] の終端インデックス

#       # s[i] と s[j] が等しいか判定
#       if s[i] == s[j]
#         # 長さが2または3のとき（間に1文字以下しかない場合）
#         if j - i <= 2
#           dp[i][j] = true
#         else
#           # 内部の部分文字列が回文かどうか確認
#           dp[i][j] = dp[i + 1][j - 1]
#         end

#         # 新しい回文が見つかった場合、最長回文の長さを更新
#         if dp[i][j] && (j - i + 1) > max_length
#           start = i
#           max_length = j - i + 1
#           puts "新しい最長回文: #{s[i..j]} (開始位置: #{start}, 長さ: #{max_length})"
#         end
#       end
#     end
#   end

#   # 最も長い回文部分文字列を返す
#   s[start, max_length]
# end

# # テストケース1
# puts "テストケース1: s = 'babad'"
# puts "出力: #{longest_palindrome("babad")}"  # 期待される出力: "bab" または "aba"

# # テストケース3
# puts "\nテストケース3: s = 'racecar'"
# puts "出力: #{longest_palindrome("racecar")}"  # 期待される出力: "racecar"


# 中心拡張法のアプローチ
# 各文字を中心として、左右に拡張しながら最大の回文を見つけます。
# 「奇数長の回文」と「偶数長の回文」をそれぞれ中心を変えて調べます。
# 各中心に対して、最大の回文長を更新し、最も長い回文を記録します。

def longest_palindrome(s)
  return "" if s.nil? || s.empty?

  # 最長回文の開始位置と最大長さ
  start_index = 0
  max_length = 1

  # 各文字を中心として回文を探す
  (0...s.length).each do |i|
    # 奇数長の回文を探す（例: "aba"）
    puts "\n中心（奇数長）: #{i}"
    len1 = expand_around_center(s, i, i)

    # 偶数長の回文を探す（例: "bb"）
    puts "\n中心（偶数長）: #{i}, #{i + 1}"
    len2 = expand_around_center(s, i, i + 1)

    # 最大の回文の長さを取得
    max_len = [len1, len2].max

    # より長い回文が見つかった場合、開始位置と長さを更新
    if max_len > max_length
      max_length = max_len
      start_index = i - (max_len - 1) / 2
      puts "  新しい最長回文の長さ: #{max_length}, 開始位置: #{start_index}"
    end
  end

  # 最長回文の部分文字列を返す
  s[start_index, max_length]
end

# 中心を指定して回文を拡張するヘルパー関数
# expand_around_center(s, left, right) 関数では、与えられた left と right の位置を「中心」として、左右に拡張しながら回文部分文字列を探します。
def expand_around_center(s, left, right)
  # 左右に拡張しながら回文を確認
  # s[left] と s[right] が等しい間、left を左に（left -= 1）、right を右に（right += 1）進めることで、回文の範囲を広げていきます。
  # left または right が文字列の境界を超えたとき、または s[left] と s[right] が異なる文字になったとき、この拡張を停止します。
  while left >= 0 && right < s.length && s[left] == s[right]
    puts "  拡張中: 左 = #{left}, 右 = #{right}, s[#{left}] = #{s[left]}, s[#{right}] = #{s[right]}"
    left -= 1
    right += 1
  end

  # 左右のインデックスが一致しなくなる直前までが回文の範囲
  # left と right が一致しなくなった時点で、left は回文の範囲の左端を 1 つ超えた位置を指し、right は回文の範囲の右端を 1 つ超えた位置を指しています。
  right - left - 1  # 回文の長さを返す
end

# テストケース1
puts "テストケース1: s = 'babad'"
puts "出力: #{longest_palindrome("babad")}"  # 期待される出力: "bab" または "aba"

# テストケース2
puts "\nテストケース2: s = 'cbbd'"
puts "出力: #{longest_palindrome("cbbd")}"  # 期待される出力: "bb"

# テストケース3
puts "\nテストケース3: s = 'a'"
puts "出力: #{longest_palindrome("a")}"  # 期待される出力: "a"

# テストケース4
puts "\nテストケース4: s = 'ac'"
puts "出力: #{longest_palindrome("ac")}"  # 期待される出力: "a" または "c"
