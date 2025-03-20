# Given an m x n grid of characters board and a string word, return true if word exists in the grid.

# The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

# m × n の文字グリッド board と文字列 word が与えられたとき、word がグリッド内に存在する場合に 
# true を返してください。

# word は、隣接するセル（上下左右）から連続している文字で構成されなければなりません。同じセルは一度しか使うことができません。



# Example 1:


# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
# Output: true
# Example 2:


# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
# Output: true
# Example 3:


# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
# Output: false
 

# Constraints:

# m == board.length
# n = board[i].length
# 1 <= m, n <= 6
# 1 <= word.length <= 15
# board and word consists of only lowercase and uppercase English letters.

# アプローチ
# この問題は、グリッド上での探索問題です。バックトラッキング（再帰）を使って、グリッド上を探索しながら word が作成できるかどうかを確認します。具体的には、次の手順で解きます：

# グリッド内の探索開始: グリッドの各セルが word の最初の文字と一致する場合、そのセルをスタート地点とします。

# 隣接セルへの移動: 上下左右の隣接するセルに移動しながら、word の次の文字と一致するかを確認します。

# セルの再利用禁止: 同じセルを2回使わないように、一時的にセルを訪問済みとしてマークします（例えば、nil に設定するなど）。

# バックトラッキング: 再帰的に探索して word を見つけられなければ、前の状態に戻って他の可能性を探索します。


# def exist(board, word)
#   # 行数と列数を取得
#   m, n = board.length, board[0].length

#   # バックトラッキング関数
#   def backtrack(board, word, i, j, idx)
#     # すべての文字を見つけた場合
#     if idx == word.length
#       return true
#     end
    
#     # 範囲外または現在のセルが一致しない場合
#     if i < 0 || i >= board.length || j < 0 || j >= board[0].length || board[i][j] != word[idx]
#       return false
#     end

#     puts "Visiting board[#{i}][#{j}] = #{board[i][j]}, matching with word[#{idx}] = #{word[idx]}"

#     # 現在のセルを一時的に訪問済みとしてマーク（再利用防止のために値を保存）
#     temp = board[i][j]
#     board[i][j] = nil

#     # 上下左右のセルを再帰的に探索
#     found = backtrack(board, word, i + 1, j, idx + 1) ||  # 下
#              backtrack(board, word, i - 1, j, idx + 1) ||  # 上
#              backtrack(board, word, i, j + 1, idx + 1) ||  # 右
#              backtrack(board, word, i, j - 1, idx + 1)     # 左

#     # 探索が終わったら、元の値に戻す（バックトラック）
#     board[i][j] = temp
#     puts "Backtracking from board[#{i}][#{j}]"
    
#     found
#   end

#   # 各セルをスタート地点として探索開始
#   for i in 0...m
#     for j in 0...n
#       if backtrack(board, word, i, j, 0)
#         return true
#       end
#     end
#   end

#   # 探索失敗
#   false
# end

# # 実行例
# board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
# word = "ABCCED"
# puts "Board:"
# board.each { |row| puts row.join(" ") }
# puts "Word to search: #{word}"
# result = exist(board, word)
# puts "Result: #{result}"

# バックトラックを使う理由は、探索の途中で誤った経路をたどっても、元の状態に戻って別の可能性を試せるようにするためです。

# この問題では、グリッド上の各セルを使って単語 `word` を構成する必要がありますが、同じセルを2回以上使うことはできません。例えば、あるセルからスタートして、隣接するセルに進んだとき、その経路が最終的に正しいかどうかはわかりません。そのため、間違った方向に進んでしまった場合、途中で探索をやめて元のセルに戻り、別の方向や経路を試す必要があります。これが「バックトラッキング」の役割です。

# 具体的には、次のような流れです：

# 1. あるセルから探索を開始します。単語 `word` の最初の文字と一致するか確認します。
# 2. 次の文字を探すために、上下左右の隣接セルに進みます。
# 3. もしその先に進めない、もしくは一致しない場合、その経路は正しくないため、現在の位置から「バックトラック」して、探索を始めた元の位置に戻ります。
# 4. 戻った後に、他の隣接セルに対して新たに探索を再開します。

# ### 例を使った説明

# 次の例を考えます：

# ```plaintext
# board = [["A","B","C","E"],
#          ["S","F","C","S"],
#          ["A","D","E","E"]]
# word = "ABCCED"
# ```

# 1. `A`（`board[0][0]`）が最初の文字として一致したため、探索を開始します。
# 2. 次に `B` を探すため、隣接セルに進みます。`B` は `board[0][1]` にあります。
# 3. さらに `C` を探すため、また隣接セルに進みます。`C` は `board[0][2]` にあります。
# 4. 次にもう一度 `C` を探します。このとき、上下左右のどのセルにも条件に一致する文字がなければ、間違った方向に進んだことがわかります。この時点で、探索をやめて元の位置に戻り、別の隣接セルを探します（これが「バックトラック」）。
# 5. 最終的に正しい方向を見つけるまでこのプロセスを繰り返します。

# ### なぜバックトラックが必要か？

# バックトラックがないと、一度訪れたセルに戻ってやり直すことができません。探索中に一つの経路が失敗したときに、他の経路を試す柔軟性を持つためには、探索前の状態に戻る必要があります。これにより、間違った道筋をたどった後でも正しい道を探し続けることができ、正しい単語 `word` を構築するための全ての可能性を試すことができます。

# 最適化したコード
# 以下のコードでは、訪れたセルを効率的に管理し、無駄な探索を減らすようにしました。また、Time Limit Exceeded を防ぐために、探索が失敗したときに即座にバックトラックする処理を工夫しています。

def exist(board, word)
  m, n = board.length, board[0].length
  
  # バックトラッキング関数
  def backtrack(board, word, i, j, idx)
    # 単語全体を見つけた場合
    if idx == word.length
      return true
    end

    # 範囲外または一致しない場合はすぐに終了
    # 各条件は下記
    # 1. 範囲外: i < 0 || i >= board.length || j < 0 || j >= board[0].length
    # 2. 一致しない: board[i][j] != word[idx]
    if i < 0 || i >= board.length || j < 0 || j >= board[0].length || board[i][j] != word[idx]
      return false
    end

    # 現在のセルを一時的に保存
    temp = board[i][j]
    # 現在のセルを訪問済みにマーク
    board[i][j] = '#'

    # 上下左右に再帰的に探索
    found = backtrack(board, word, i + 1, j, idx + 1) ||  # 下
             backtrack(board, word, i - 1, j, idx + 1) ||  # 上
             backtrack(board, word, i, j + 1, idx + 1) ||  # 右
             backtrack(board, word, i, j - 1, idx + 1)     # 左

    # 探索終了後にセルの状態を元に戻す（バックトラック）
    board[i][j] = temp

    return found
  end

  # 各セルを開始点としてバックトラッキングを試す
  for i in 0...m
    for j in 0...n
      if backtrack(board, word, i, j, 0)
        return true
      end
    end
  end

  return false
end

# 実行例
board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
word = "ABCCED"
puts "Board:"
board.each { |row| puts row.join(" ") }
puts "Word to search: #{word}"
result = exist(board, word)
puts "Result: #{result}"
