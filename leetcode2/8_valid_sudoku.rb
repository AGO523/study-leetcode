def is_valid_sudoku(board)
  row_sets = Array.new(9) { Set.new }
  col_sets = Array.new(9) { Set.new }
  box_sets = Array.new(3) { Array.new(3) { Set.new } }

  (0...9).each do |i|
    (0...9).each do |j|
      # 二重ループを使用すると、
      # [0, 0], [0, 1], [0, 2], ... 
      # [1, 0], [1, 1], [1, 2], ...
      # [2, 0], [2, 1], [2, 2], ...
      #  の順に処理される
      num = board[i][j]
      next if num == "."


      # box_sets で /3 しているのは、
      # i/3 と j/3 を計算すると、各 3×3 ボックスのインデックスが分かる
      # i / 3 → 縦の 3×3 ボックスの位置
      # j / 3 → 横の 3×3 ボックスの位置

      # 例: (i, j) = (4, 7) の場合
      # i = 4 → i / 3 = 4 / 3 = 1（1 番目の 3×3 ボックス）
      # j = 7 → j / 3 = 7 / 3 = 2（2 番目の 3×3 ボックス）
      # 🔹 したがって (4, 7) のセルは box_sets[1][2] に属する。
      if row_sets[i].include?(num) || col_sets[j].include?(num) || box_sets[i/3][j/3].include?(num)
        # すでに同じ数字がある場合はfalseを返す
        return false
      end

      # set に現在走査している数字を追加することで、
      # 次回の走査で同じ数字があるかどうかを判定する
      row_sets[i].add(num)
      col_sets[j].add(num)
      box_sets[i/3][j/3].add(num)
    end
  end

  true
end
