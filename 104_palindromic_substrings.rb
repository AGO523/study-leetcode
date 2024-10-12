# Given a string s, return the number of palindromic substrings in it.

# A string is a palindrome when it reads the same backward as forward.

# A substring is a contiguous sequence of characters within the string.

# 文字列 s が与えられたとき、その中にある回文部分文字列の数を返してください。

# 回文とは？
# 回文とは、前から読んでも後ろから読んでも同じ文字列を指します。
# 部分文字列とは？
# 部分文字列とは、文字列の中の連続した文字列の一部です

# Example 1:

# Input: s = "abc"
# Output: 3
# Explanation: Three palindromic strings: "a", "b", "c".
# Example 2:

# Input: s = "aaa"
# Output: 6
# Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".
 

# Constraints:

# 1 <= s.length <= 1000
# s consists of lowercase English letters.

# 1. 中心拡張法（Expand Around Center）
# 中心拡張法は、各文字を「中心」として、左右に拡張しながら回文を探索する手法です。回文には次の 2 種類があります：

# 奇数長の回文: 中心に1つの文字があり、左右対称に広がる回文（例: "aba"）。
# 偶数長の回文: 2つの同じ文字を中心に、左右対称に広がる回文（例: "aa"）。
# この方法では、各文字を中心に、左右に拡張して回文部分文字列をカウントします。

# 2. アプローチの流れ
# 各文字を中心として、回文の数をカウントします。
# 奇数長の回文を中心にする場合と、偶数長の回文を中心にする場合の両方を確認します。
# 各回文が見つかったら、その都度カウントを更新します。

def count_substrings(s)
  count = 0  # 回文部分文字列の数を記録

  # 各文字を中心にして回文を数える
  (0...s.length).each do |i|
    # 奇数長の回文を探す（例: "aba"）
    "\n中心（奇数長）: #{i}"
    count += expand_around_center(s, i, i)

    # 偶数長の回文を探す（例: "aa"）
    "\n中心（偶数長）: #{i}, #{i + 1}"
    count += expand_around_center(s, i, i + 1)
  end

  # 最終的な回文部分文字列の数を返す
  "総回文数: #{count}"
  count
end

# 中心を指定して回文を拡張するヘルパー関数
def expand_around_center(s, left, right)
  count = 0

  # 左右に拡張しながら回文を確認
  # left >= 0: 左側が文字列の範囲内であることを確認しています。文字列の範囲外に出ないようにします。
  # right < s.length: 右側が文字列の範囲内であることを確認しています。こちらも文字列の範囲外に出ないようにします。
  # s[left] == s[right]: 左側の文字と右側の文字が同じかどうかを確認しています。これが一致している場合、左右が同じ文字であるため、その範囲は回文であると判断します。
  while left >= 0 && right < s.length && s[left] == s[right]
    # 回文が見つかったらカウントを増やす
    "  回文を発見: #{s[left..right]}"
    count += 1

    # 左に拡張、右に拡張
    left -= 1
    right += 1
  end

  # 発見した回文の数を返す
  count
end

# テストケース1
"テストケース1: s = 'abcffcv'"
"出力: #{count_substrings("abcffcv")}"  # 期待される出力: 3

# テストケース2
# "\nテストケース2: s = 'aaa'"
# "出力: #{count_substrings("aaa")}"  # 期待される出力: 6
