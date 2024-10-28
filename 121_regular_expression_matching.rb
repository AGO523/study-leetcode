# Given an input string s and a pattern p, implement regular expression matching with support for '.' and '*' where:

# '.' Matches any single character.​​​​
# '*' Matches zero or more of the preceding element.
# The matching should cover the entire input string (not partial).

 

# Example 1:

# Input: s = "aa", p = "a"
# Output: false
# Explanation: "a" does not match the entire string "aa".
# Example 2:

# Input: s = "aa", p = "a*"
# Output: true
# Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
# Example 3:

# Input: s = "ab", p = ".*"
# Output: true
# Explanation: ".*" means "zero or more (*) of any character (.)".
 

# Constraints:

# 1 <= s.length <= 20
# 1 <= p.length <= 20
# s contains only lowercase English letters.
# p contains only lowercase English letters, '.', and '*'.
# It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.

# 詳細な解説
# この問題は「与えられた文字列 s とパターン p が完全にマッチするかどうかを判定する」ものです。パターン p には特殊文字 . と * が含まれる可能性があり、それぞれ次のように動作します：

# . は任意の1文字にマッチします。
# * は直前の文字が0回以上繰り返されることにマッチします。
# 動的計画法のアプローチ
# この問題は部分問題に分解し、動的計画法（DP）で解を求めます。具体的には、次のようにDPテーブル dp を用いて解を構築します。

# dp[i][j] の定義：

# dp[i][j] は「文字列 s の最初の i 文字とパターン p の最初の j 文字がマッチするかどうか」を表します。
# 初期化：

# dp[0][0] = true：空文字同士はマッチします。
# パターン p のみがある場合、* を使ってマッチするかを初期化します。例えば、パターンが a* などの場合、空文字ともマッチするために dp[0][j] を設定します。
# 状態遷移：

# パターンの文字が . もしくは s[i-1] と一致する場合：
# dp[i][j] = dp[i-1][j-1]
# この場合、現在の文字が一致するため、前の状態を引き継ぎます。
# パターンの文字が * の場合：
# * は直前の文字を0回またはそれ以上繰り返すことができます。以下の2つを確認します：
# dp[i][j-2]：直前の文字を0回使用する場合
# dp[i-1][j] && (s[i-1] == p[j-2] || p[j-2] == '.')：直前の文字を1回以上使用する場合
# これらのいずれかが true であれば、dp[i][j] も true になります。

# 入力文字列 s とパターン p が与えられたとき、'.' と '*' をサポートした正規表現マッチングを実装してください。
# '.' は任意の1文字にマッチします。
# '*' は直前の要素が0回以上繰り返されることにマッチします。
# マッチングは入力文字列全体をカバーする必要があります（一部ではなく）。

# 例1:
# 入力: s = "aa", p = "a"
# 出力: false
# 説明: "a" は文字列 "aa" 全体にはマッチしません。

# 例2:
# 入力: s = "aa", p = "a*"
# 出力: true
# 説明: '*' は直前の要素 'a' が0回以上繰り返されることを意味します。したがって、'a' を1回繰り返すことで "aa" になります。

# 例3:
# 入力: s = "ab", p = ".*"
# 出力: true
# 説明: '.*' は任意の文字が0回以上繰り返されることを意味します。

def is_match(s, p)
  m, n = s.length, p.length
  dp = Array.new(m + 1) { Array.new(n + 1, false) }
  dp[0][0] = true  # 空文字同士はマッチ
  p dp

  # パターン p の初期化（'*' がある場合）
  # "a*" のパターンは空文字 "" にもマッチする可能性があります。なぜなら、'*' によって "a" が 0回 繰り返されると解釈できるからです。
  (1..n).each do |j|
    if p[j - 1] == '*'
      dp[0][j] = dp[0][j - 2]
    end
  end

  # 動的計画法でマッチングを解決
  (1..m).each do |i|
    (1..n).each do |j|
      if p[j - 1] == s[i - 1] || p[j - 1] == '.'
        # 文字が一致する場合、または '.' の場合
        dp[i][j] = dp[i - 1][j - 1]
      elsif p[j - 1] == '*'
        # '*' の場合、直前の文字を0回以上繰り返す
        # dp[i][j-2]：直前の文字を0回使用する場合
        # dp[i-1][j] && (s[i-1] == p[j-2] || p[j-2] == '.')：直前の文字を1回以上使用する場合
        # これらのいずれかが true であれば、dp[i][j] も true になります。
        dp[i][j] = dp[i][j - 2] || (dp[i - 1][j] && (s[i - 1] == p[j - 2] || p[j - 2] == '.'))
      end
      # 状態遷移の経過表示
      puts "dp[#{i}][#{j}] = #{dp[i][j]} (s[#{i - 1}] = '#{s[i - 1] if i > 0}', p[#{j - 1}] = '#{p[j - 1]}')"
    end
  end

  dp[m][n]
end

# テストケース1
puts "テストケース1: s = 'aa', p = 'a'"
puts "結果: #{is_match('aa', 'a')}"  # 期待される出力: false

# テストケース2
puts "\nテストケース2: s = 'aa', p = 'a*'"
puts "結果: #{is_match('aa', 'a*')}"  # 期待される出力: true

# # テストケース3
# puts "\nテストケース3: s = 'ab', p = '.*'"
# puts "結果: #{is_match('ab', '.*')}"  # 期待される出力: true

# 解説:
# この問題は、動的計画法（DP）を使用して解決します。
# DP テーブル dp[i][j] は、入力文字列 s の最初の i 文字とパターン p の最初の j 文字がマッチするかどうかを表します。
# 初期化として、空文字同士はマッチするため dp[0][0] = true です。
# また、パターンに '*' が含まれる場合、その影響を適切に反映するために dp[0][j] を設定します。
# 各文字が一致する場合、または '.' がある場合、dp[i][j] は dp[i-1][j-1] の値を引き継ぎます。
# '*' の場合は、直前の文字を0回使う場合（dp[i][j-2]）か、直前の文字を1回以上使う場合（dp[i-1][j]）のどちらかでマッチするかを確認します。

# なぜ前の状態を引き継ぐのか
# dp[i][j] は「文字列 s の最初の i 文字とパターン p の最初の j 文字がマッチするかどうか」を表しています。
# パターンの文字が . もしくは s[i-1] と一致するということは、「現在の文字が一致している」または「任意の文字としてマッチする」ことを意味します。
# ここで重要なのは、現在の文字が一致している場合、それ以前の部分も一致していれば、全体としても一致するということです。そのため、dp[i][j] は dp[i-1][j-1] の値を引き継ぎます。

# 例
# s = "abc", p = "a.c" の場合を考えます。
# i = 3、j = 3 のとき、s[2]（"c"）と p[2]（"c"）が一致しているため、前の状態（dp[i-1][j-1]）がマッチしていれば、現在の状態（dp[i][j]）もマッチすると考えられます。
# また、もしパターンが "a.c" で p[1] が "." の場合でも、任意の文字としてマッチするため、同様に dp[i][j] は dp[i-1][j-1] の値を引き継ぎます。
# 状態遷移の考え方
# 前の部分がマッチしている場合：
# 現在の文字がマッチするかどうかが重要で、p[j-1] が . もしくは s[i-1] と一致していれば、現在の文字も含めてマッチすることがわかります。
# つまり、dp[i-1][j-1] が true であれば、dp[i][j] も true になります。
# 結論
# 現在の文字がパターンと一致する場合、または . の場合は、前の状態がそのまま次の状態に影響を与えます。したがって、dp[i][j] = dp[i-1][j-1] として、前の状態を引き継ぐことで正しくマッチングの結果を保持できるのです。
