# Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
# 日本語で
# 9 x 9 の数独盤が有効かどうかを判断します。次のルールに従って、埋められたセルのみを検証する必要があります。

# Each row must contain the digits 1-9 without repetition.
# 各行には、繰り返しのない数字 1-9 が含まれている必要があります。

# Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
# グリッドの 9 つの 3 x 3 のサブボックスのそれぞれに、繰り返しのない数字 1-9 が含まれている必要があります。
# Note:

# A Sudoku board (partially filled) could be valid but is not necessarily solvable.
# 数独盤（部分的に埋められた）は有効である可能性がありますが、必ずしも解決可能とは限りません。
# Only the filled cells need to be validated according to the mentioned rules.
# 埋められたセルのみ、上記のルールに従って検証する必要があります。


# Example 1:


# Input: board = 
# [["5","3",".",".","7",".",".",".","."]
# ,["6",".",".","1","9","5",".",".","."]
# ,[".","9","8",".",".",".",".","6","."]
# ,["8",".",".",".","6",".",".",".","3"]
# ,["4",".",".","8",".","3",".",".","1"]
# ,["7",".",".",".","2",".",".",".","6"]
# ,[".","6",".",".",".",".","2","8","."]
# ,[".",".",".","4","1","9",".",".","5"]
# ,[".",".",".",".","8",".",".","7","9"]]
# Output: true
# Example 2:

# Input: board = 
# [["8","3",".",".","7",".",".",".","."]
# ,["6",".",".","1","9","5",".",".","."]
# ,[".","9","8",".",".",".",".","6","."]
# ,["8",".",".",".","6",".",".",".","3"]
# ,["4",".",".","8",".","3",".",".","1"]
# ,["7",".",".",".","2",".",".",".","6"]
# ,[".","6",".",".",".",".","2","8","."]
# ,[".",".",".","4","1","9",".",".","5"]
# ,[".",".",".",".","8",".",".","7","9"]]
# Output: false
# Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.

# Constraints:

# board.length == 9
# board[i].length == 9
# board[i][j] is a digit 1-9 or '.'.

class Solution
  def is_valid_sudoku(board)
    rows = Array.new(9) { Hash.new(0) }
    cols = Array.new(9) { Hash.new(0) }
    boxes = Array.new(9) { Hash.new(0) }
    
    # 0から9までを繰り返しながら、さらに0から9までを繰り返す
    # つまり、0の1、0の2、0の3、...、0の9、1の1、1の2、1の3、...、1の9、...、8の9まで繰り返す
    (0...9).each do |r|
      (0...9).each do |c|

        # boradの値を1文字ずつ取得
        num = board[r][c]
        next if num == '.'
        
        # 行の検証
        # すでにその数字が存在する場合はfalseを返して、処理を終了
        return false if rows[r][num] == 1
        # 最初に作成したrows配列に、その数字をキーとして1を追加
        # rows = [
        #   {"5" => 1, "3" => 1, "7" => 1},
        # ]
        rows[r][num] += 1
        
        # 列の検証
        return false if cols[c][num] == 1
        cols[c][num] += 1
        
        # 3x3のサブボックスの検証
        box_index = (r / 3) * 3 + c / 3
        return false if boxes[box_index][num] == 1
        boxes[box_index][num] += 1
      end
    end
    
    true
  end
end
  
# 例の使用
board1 = [
  ["5", "3", ".", ".", "7", ".", ".", ".", "."],
  ["6", ".", ".", "1", "9", "5", ".", ".", "."],
  [".", "9", "8", ".", ".", ".", ".", "6", "."],
  ["8", ".", ".", ".", "6", ".", ".", ".", "3"],
  ["4", ".", ".", "8", ".", "3", ".", ".", "1"],
  ["7", ".", ".", ".", "2", ".", ".", ".", "6"],
  [".", "6", ".", ".", ".", ".", "2", "8", "."],
  [".", ".", ".", "4", "1", "9", ".", ".", "5"],
  [".", ".", ".", ".", "8", ".", ".", "7", "9"]
]

board2 = [
  ["8", "3", ".", ".", "7", ".", ".", ".", "."],
  ["6", ".", ".", "1", "9", "5", ".", ".", "."],
  [".", "9", "8", ".", ".", ".", ".", "6", "."],
  ["8", ".", ".", ".", "6", ".", ".", ".", "3"],
  ["4", ".", ".", "8", ".", "3", ".", ".", "1"],
  ["7", ".", ".", ".", "2", ".", ".", ".", "6"],
  [".", "6", ".", ".", ".", ".", "2", "8", "."],
  [".", ".", ".", "4", "1", "9", ".", ".", "5"],
  [".", ".", ".", ".", "8", ".", ".", "7", "9"]
]

sol = Solution.new
p sol.is_valid_sudoku(board1) # true
p sol.is_valid_sudoku(board2) # false
