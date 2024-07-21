# Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

# An input string is valid if:

# Open brackets must be closed by the same type of brackets.
# Open brackets must be closed in the correct order.
# Every close bracket has a corresponding open bracket of the same type.
 

# Example 1:

# Input: s = "()"
# Output: true
# Example 2:

# Input: s = "()[]{}"
# Output: true
# Example 3:

# Input: s = "(]"
# Output: false
 

# Constraints:

# 1 <= s.length <= 104
# s consists of parentheses only '()[]{}'.

# 具体例
# 入力: "()"

# ( がスタックにプッシュされる: stack = ['(']
# ) が来たときにスタックから ( をポップする: stack = []
# スタックが空なので true
# 入力: "()[]{}"

# ( がスタックにプッシュされる: stack = ['(']
# ) が来たときにスタックから ( をポップする: stack = []
# [ がスタックにプッシュされる: stack = ['[']
# ] が来たときにスタックから [ をポップする: stack = []
# { がスタックにプッシュされる: stack = ['{']
# } が来たときにスタックから { をポップする: stack = []
# スタックが空なので true
# 入力: "(]"

# ( がスタックにプッシュされる: stack = ['(']
# ] が来たときにスタックから ( をポップするが、対応する括弧でないため false


def is_valid(s)
  # 括弧の対応関係を保持するハッシュ
  matching_bracket = { ')' => '(', '}' => '{', ']' => '[' }
  # スタックを初期化
  stack = []

  # 文字列を1文字ずつチェック
  s.each_char do |char|
    if matching_bracket.values.include?(char)
      # 開く括弧の場合、スタックにプッシュ
      stack.push(char)
    elsif matching_bracket.keys.include?(char)
      # 閉じる括弧の場合
      # スタックが空か、対応する開く括弧がない場合は無効（対応する括弧がある場合はスタックからポップする）
      if stack.empty? || stack.pop != matching_bracket[char]
        return false
      end
    end
  end

  # スタックが空であれば全ての括弧が正しく閉じられている
  stack.empty?
end

# 使用例
puts is_valid("()")       # 出力: true
puts is_valid("()[]{}")   # 出力: true
puts is_valid("(]")       # 出力: false
