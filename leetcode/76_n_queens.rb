# The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.

# Given an integer n, return all distinct solutions to the n-queens puzzle. You may return the answer in any order.

# Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space, respectively.

# n-クイーンパズルは、n×nのチェス盤にn個のクイーンを配置する問題です。クイーン同士が互いに攻撃し合わないように配置する必要があります。

# 整数 n が与えられたとき、n-クイーンパズルのすべての異なる解を返してください。解はどの順番でも構いません。

# それぞれの解は、クイーンの配置を表す distinct なボード構成を含んでおり、'Q' はクイーンを、'.' は空のスペースをそれぞれ示します。

# Example 1:


# Input: n = 4
# Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
# Explanation: There exist two distinct solutions to the 4-queens puzzle as shown above
# Example 2:

# Input: n = 1
# Output: [["Q"]]
 

# Constraints:

# 1 <= n <= 9

# 解説と回答
# この問題は、バックトラッキングを用いた探索問題です。クイーンは縦、横、斜めのいずれかで他のクイーンを攻撃できるため、これらの条件を満たさないようにクイーンを配置する必要があります。

# 基本的な解法は次の通りです:

# 各行にクイーンを1つずつ配置します。
# クイーンの配置が成立するかどうかをチェックします（同じ列や斜めのラインに他のクイーンが存在しないか）。
# 有効な配置が見つかった場合、その配置を結果リストに追加します。
# 全ての解を探索したら結果を返します。

require 'set'

def solve_n_queens(n)
  results = []  # 結果を格納するリスト
  board = Array.new(n) { '.' * n }  # 初期状態のチェス盤

  # バックトラック関数
  def backtrack(row, cols, diagonals1, diagonals2, board, results)
    if row == board.size  # 全ての行にクイーンが配置された場合
      results << board.map(&:dup)  # 現在のボードを結果に追加
      return
    end

    (0...board.size).each do |col|
      # クイーンを配置できるかを確認
      if cols.include?(col) || diagonals1.include?(row - col) || diagonals2.include?(row + col)
        next  # 攻撃可能なので次の列を試す
      end

      # クイーンを配置
      board[row][col] = 'Q'
      puts "Placing queen at row #{row}, column #{col}"

      # 攻撃範囲をマーク
      cols.add(col)
      diagonals1.add(row - col)
      diagonals2.add(row + col)

      # 次の行を探索
      backtrack(row + 1, cols, diagonals1, diagonals2, board, results)

      # バックトラック：クイーンを取り除く
      board[row][col] = '.'
      puts "Removing queen from row #{row}, column #{col}"
      cols.delete(col)
      diagonals1.delete(row - col)
      diagonals2.delete(row + col)
    end
  end

  # 空のセットを作成し、探索を開始
  backtrack(0, Set.new, Set.new, Set.new, board, results)
  
  results  # 結果を返す
end

# 使用例
n = 4
puts "N-Queens problem for n = #{n}"
results = solve_n_queens(n)
puts "Solutions:"
results.each_with_index do |solution, index|
  puts "Solution #{index + 1}:"
  solution.each { |row| puts row }
end

# 実行の流れと解説:
# チェス盤の初期化:

# サイズ n×n の空のチェス盤を初期化し、各行は文字列 "." * n によって表現されます（すべて空白）。
# バックトラッキングによる探索:

# クイーンを1行ずつ配置していきます。
# 各行では、クイーンが他のクイーンと攻撃し合わないかどうかを確認します。具体的には、以下の3つの条件でチェックします:
# 同じ列に既にクイーンがいるかどうか (cols で管理)。
# 左上から右下への対角線にクイーンがいるかどうか (diagonals1 で管理)。
# 右上から左下への対角線にクイーンがいるかどうか (diagonals2 で管理)。
# もし条件を満たす場合、その位置にクイーンを置き、次の行へ進みます。
# すべての行にクイーンが配置できたら、現在のボード状態を results に追加します。
# バックトラック:

# 配置が失敗した場合は、クイーンを取り除き、次の列で再試行します。

# `row - col` で斜めを検証できる理由は、チェス盤上の対角線に沿って座標が特定のパターンを持つからです。詳しく説明します。

# ### 縦横の概念

# - まず、行と列はチェス盤上の位置を定義するための基本的な座標システムです。`row` は行、`col` は列に対応します。例えば、左上の位置は `(0, 0)` で、そこから右に進むと列が増え、下に進むと行が増えます。

# ### 斜めの概念

# チェスのクイーンが縦横だけでなく斜めにも動けるので、斜め方向にクイーンが他のクイーンと攻撃し合わないかどうかを検証する必要があります。

# チェス盤上には2種類の斜め方向があります：

# 1. **左上から右下に向かう対角線**（右上がりの対角線）
# 2. **右上から左下に向かう対角線**（左上がりの対角線）

# #### 左上から右下の対角線 (右上がり)

# この対角線に沿っているマスの座標には、特定のパターンがあります。それは `row - col` がすべて同じ値になることです。

# 例えば、`(2, 0)` と `(3, 1)` と `(4, 2)` の座標はすべて `row - col = 2` です。これが、同じ対角線上にあることを意味しています。

# | row | col | row - col |
# |-----|-----|-----------|
# | 2   | 0   | 2 - 0 = 2 |
# | 3   | 1   | 3 - 1 = 2 |
# | 4   | 2   | 4 - 2 = 2 |

# したがって、あるクイーンが `(r1, c1)` にいる場合、他のクイーンが `(r2, c2)` にいるときに、`row - col` が同じ値であれば、それらのクイーンは同じ左上から右下の対角線上にあることがわかります。

# #### 右上から左下の対角線 (左上がり)

# 同様に、`row + col` が同じ値であれば、クイーンは右上から左下に向かう対角線上にあります。

# 例えば、`(1, 1)`、`(2, 0)` のような座標はすべて `row + col = 2` です。

# | row | col | row + col |
# |-----|-----|-----------|
# | 1   | 1   | 1 + 1 = 2 |
# | 2   | 0   | 2 + 0 = 2 |

# ### まとめ

# - **左上から右下** の対角線上にあるかどうかを検証するためには、`row - col` が同じかどうかを確認します。
# - **右上から左下** の対角線上にあるかどうかを検証するためには、`row + col` が同じかどうかを確認します。

# これにより、クイーンが互いに攻撃し合うことなく安全に配置できるかどうかを簡単に検証できるのです。
