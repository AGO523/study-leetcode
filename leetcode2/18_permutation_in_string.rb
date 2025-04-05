def check_inclusion(s1, s2)
  return false if s1.length > s2.length

  # アルファベット 26 文字分のカウント配列
  count1 = Array.new(26, 0)
  count2 = Array.new(26, 0)

  # s1 の文字カウントを記録
  # c.ord - 'a'.ord
  # で 'a' を 0, 'b' を 1, ..., 'z' を 25 に変換
  # 例：'b' の場合、'b'.ord = 98, 'a'.ord = 97 → 98 - 97 = 1
  # index に相当する値を計算している
  # つまり、count1[1] += 1 で 'b' のカウント
  # これで count1 は 'a'〜'z' の出現回数をカウントする配列になる
  s1.each_char { |c| count1[c.ord - 'a'.ord] += 1 }

  # s2 の最初の s1.length 分だけをカウント
  s2[0...s1.length].each_char { |c| count2[c.ord - 'a'.ord] += 1 }

  # 最初のウィンドウが一致するか確認
  return true if count1 == count2

  # スライディングウィンドウを右に動かしていく
  # ウィンドウサイズは s1 の長さ（今回は 2とする）
  # s2 の中を「2文字ずつの窓」でスキャンしていく
  # 各ウィンドウ内の文字の出現数をカウントして、s1 のカウントと比較
  (s1.length...s2.length).each do |i|
    # ①ウィンドウから左端の文字を除外
    left_char = s2[i - s1.length]

    # ②カウントを記録している配列から除外（①で除外した文字のカウント減らすため）
    count2[left_char.ord - 'a'.ord] -= 1

    # ③新しく右端の文字を追加
    right_char = s2[i]
    count2[right_char.ord - 'a'.ord] += 1

    # ④一致するか確認
    return true if count1 == count2
  end

  false
end

# テスト
p check_inclusion("ab", "eidbaooo")  # => true
