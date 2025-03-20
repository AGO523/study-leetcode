# Given a string s containing only three types of characters: '(', ')' and '*', return true if s is valid.

# The following rules define a valid string:

# Any left parenthesis '(' must have a corresponding right parenthesis ')'.
# Any right parenthesis ')' must have a corresponding left parenthesis '('.
# Left parenthesis '(' must go before the corresponding right parenthesis ')'.
# '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string "".

# 文字列 s が与えられ、この文字列には3種類の文字 '(', ')', '*' だけが含まれています。文字列が有効であれば true を返し、そうでなければ false を返してください。

# 以下のルールに基づいて、有効な文字列の定義が与えられています：

# 任意の左カッコ '(' には対応する右カッコ ')' が必要です。
# 任意の右カッコ ')' には対応する左カッコ '(' が必要です。
# 左カッコ '(' は対応する右カッコ ')' より前に出現しなければなりません。
# アスタリスク '*' は、')', '(', または空文字 "" のいずれかとして扱うことができます。

# Example 1:

# Input: s = "()"
# Output: true
# Example 2:

# Input: s = "(*)"
# Output: true
# Example 3:

# Input: s = "(*))"
# Output: true
 

# Constraints:

# 1 <= s.length <= 100
# s[i] is '(', ')' or '*'.


# アプローチと解説
# この問題では、アスタリスク '*' を ( または ) として扱うことで、すべてのカッコが対応しているかどうかを判定する必要があります。複雑な条件を考慮するために、以下のアプローチを使います。

# アプローチ
# 最小および最大の左カッコの数を追跡:

# left_min: 最小の左カッコ数を追跡します。
# left_max: 最大の左カッコ数を追跡します。
# 文字列を左から右にスキャンしながら、以下のルールに従って left_min と left_max を更新します。

# 各文字の処理:

# '('： left_min と left_max をそれぞれ1ずつ増やします。
# ')'： left_min と left_max をそれぞれ1ずつ減らします。
# '*'： left_min を1減らし、left_max を1増やします（'*' が (, ) または空文字として機能できるため）。
# 条件の確認:

# left_max が0未満になった場合、対応する ( よりも ) が多く、false を返します。
# スキャンが終わった時点で left_min が0であれば、全てのカッコが対応しており true を返します。

def check_valid_string(s)
  left_min = 0  # 最小の左カッコの数
  left_max = 0  # 最大の左カッコの数
  
  # s をスキャンして、考えうる ( の最低数と最大数を計算
  s.chars.each do |char|
    if char == '('
      left_min += 1
      left_max += 1
    elsif char == ')'
      left_min -= 1 if left_min > 0
      left_max -= 1
    else # char == '*'
      left_min -= 1 if left_min > 0
      left_max += 1
    end
    
    puts "現在の文字: #{char}, left_min: #{left_min}, left_max: #{left_max}"

    # 右カッコが多すぎる場合
    return false if left_max < 0
  end
  
  # left_min が 0 であれば有効な文字列
  left_min == 0
end

# # テストケース1
# puts "テストケース1: s = '()'"
# puts "結果: #{check_valid_string('()')}"  # 期待される出力: true

# # テストケース2
# puts "\nテストケース2: s = '(*)'"
# puts "結果: #{check_valid_string('(*)')}"  # 期待される出力: true

# テストケース3
puts "\nテストケース3: s = '(*))'"
puts "結果: #{check_valid_string('(*))')}"  # 期待される出力: true
