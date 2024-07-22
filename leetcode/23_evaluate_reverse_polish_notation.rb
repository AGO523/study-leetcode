# You are given an array of strings tokens that represents an arithmetic expression in a Reverse Polish Notation.

# Evaluate the expression. Return an integer that represents the value of the expression.

# Note that:

# The valid operators are '+', '-', '*', and '/'.
# Each operand may be an integer or another expression.
# The division between two integers always truncates toward zero.
# There will not be any division by zero.
# The input represents a valid arithmetic expression in a reverse polish notation.
# The answer and all the intermediate calculations can be represented in a 32-bit integer.
 
# 文字列の配列 tokens が与えられます。この配列は逆ポーランド記法で表現された算術式を表します。

# この式を評価し、その値を整数として返してください。

# 注意点:

# 有効な演算子は +, -, *, / です。
# 各オペランドは整数または別の式になります。
# 2つの整数間の除算は常にゼロに向かって切り捨てられます。
# ゼロによる除算は発生しません。
# 入力は有効な逆ポーランド記法の算術式を表します。
# 答えとすべての中間計算は32ビット整数で表現できます。

# Example 1:

# Input: tokens = ["2","1","+","3","*"]
# Output: 9
# Explanation: ((2 + 1) * 3) = 9
# Example 2:

# Input: tokens = ["4","13","5","/","+"]
# Output: 6
# Explanation: (4 + (13 / 5)) = 6
# Example 3:

# Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
# Output: 22
# Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
# = ((10 * (6 / (12 * -11))) + 17) + 5
# = ((10 * (6 / -132)) + 17) + 5
# = ((10 * 0) + 17) + 5
# = (0 + 17) + 5
# = 17 + 5
# = 22
 

# Constraints:

# 1 <= tokens.length <= 104
# tokens[i] is either an operator: "+", "-", "*", or "/", or an integer in the range [-200, 200].

def eval_rpn(tokens)
  stack = []

  tokens.each do |token|
    if ["+", "-", "*", "/"].include?(token)
      # 演算子の場合
      # b = stack.pop および a = stack.pop は、スタックから2つのオペランドを取り出している操作です。逆ポーランド記法（RPN）の評価では、演算子が現れたときにスタックからオペランドを取り出して計算を行います。
      b = stack.pop
      a = stack.pop
      case token
      when "+"
        stack.push(a + b)
      when "-"
        stack.push(a - b)
      when "*"
        stack.push(a * b)
      when "/"
        # Rubyの整数の除算はゼロに向かって切り捨てられないため、明示的に行う
        stack.push((a.to_f / b).to_i)
      end
    else
      # オペランドの場合
      stack.push(token.to_i)
    end
  end

  stack.pop
end

# 使用例
puts eval_rpn(["2","1","+","3","*"])               # 出力: 9
puts eval_rpn(["4","13","5","/","+"])              # 出力: 6
puts eval_rpn(["10","6","9","3","+","-11","*","/","*","17","+","5","+"])  # 出力: 22


# 例: tokens = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
# この例を通して、逆ポーランド記法の評価プロセスを具体的に説明します。

# スタック操作の流れ
# トークン処理の準備

# tokens = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
# stack = []
# トークンを左から右に処理します

# トークンが 10 のとき:

# スタック: [10]
# トークンが 6 のとき:

# スタック: [10, 6]
# トークンが 9 のとき:

# スタック: [10, 6, 9]
# トークンが 3 のとき:

# スタック: [10, 6, 9, 3]
# トークンが + のとき（演算子）:

# スタックから 3 をポップ（b = 3）
# スタックから 9 をポップ（a = 9）
# a + b = 9 + 3 = 12 を計算
# 計算結果 12 をスタックにプッシュ
# スタック: [10, 6, 12]
# トークンが -11 のとき:

# スタック: [10, 6, 12, -11]
# トークンが * のとき（演算子）:

# スタックから -11 をポップ（b = -11）
# スタックから 12 をポップ（a = 12）
# a * b = 12 * -11 = -132 を計算
# 計算結果 -132 をスタックにプッシュ
# スタック: [10, 6, -132]
# トークンが / のとき（演算子）:

# スタックから -132 をポップ（b = -132）
# スタックから 6 をポップ（a = 6）
# a / b = 6 / -132 = 0 を計算（整数除算のためゼロに向かって切り捨て）
# 計算結果 0 をスタックにプッシュ
# スタック: [10, 0]
# トークンが * のとき（演算子）:

# スタックから 0 をポップ（b = 0）
# スタックから 10 をポップ（a = 10）
# a * b = 10 * 0 = 0 を計算
# 計算結果 0 をスタックにプッシュ
# スタック: [0]
# トークンが 17 のとき:

# スタック: [0, 17]
# トークンが + のとき（演算子）:

# スタックから 17 をポップ（b = 17）
# スタックから 0 をポップ（a = 0）
# a + b = 0 + 17 = 17 を計算
# 計算結果 17 をスタックにプッシュ
# スタック: [17]
# トークンが 5 のとき:

# スタック: [17, 5]
# トークンが + のとき（演算子）:

# スタックから 5 をポップ（b = 5）
# スタックから 17 をポップ（a = 17）
# a + b = 17 + 5 = 22 を計算
# 計算結果 22 をスタックにプッシュ
# スタック: [22]
# 最終結果

# スタックの中に残った唯一の値 22 が、逆ポーランド記法の評価結果です。
