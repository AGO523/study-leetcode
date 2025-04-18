この問題は、**s2 の中に s1 の順列（permutation）と一致する部分文字列が存在するかどうか**を判定するものです。

---

## ✅ 問題の要点

- `s1` の順列 = `s1` の文字を並び替えた文字列
- `s2` に `s1` の順列のいずれかが**部分文字列として含まれているか？**

---

### 🔍 例で確認

- `s1 = "ab"` の順列 → `"ab"`, `"ba"`
- `s2 = "eidbaooo"`  
  → `"ba"` が含まれているので **`true`**

---

## 🧠 アルゴリズムの考え方：**スライディングウィンドウ + ハッシュ（カウント比較）**

### 直感的な流れ：

1. `s1` の文字カウントを記録（`count1`）
2. `s2` に対して、長さ `s1.length` のウィンドウを滑らせながら、
   - その部分文字列の文字カウントを記録（`count2`）
   - `count1 == count2` なら → 一致する順列が見つかった！

---

## 🔢 計算量

- 時間：O(n)（`n = s2.length`）  
  なぜなら、アルファベットは 26 文字しかないので、カウント比較は O(1)
- 空間：O(1)（固定サイズの配列 26 個）

---

## 💎 Ruby 実装（丁寧なコメントつき）

```ruby
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
  (s1.length...s2.length).each do |i|
    p "i: #{i}"
    # ウィンドウから左端の文字を除外
    left_index = i - s1.length
    p "left_index: #{left_index}"
    left_char = s2[left_index]
    # left_char = s2[i - s1.length]

    count2_index = left_char.ord - 'a'.ord
    count2[count2_index] -= 1
    # count2[left_char.ord - 'a'.ord] -= 1

    # 新しく右端の文字を追加
    right_char = s2[i]
    count2[right_char.ord - 'a'.ord] += 1

    # 一致するか確認
    return true if count1 == count2
  end

  false
end

# テスト
p check_inclusion("ab", "eidbaooo")  # => true
p check_inclusion("ab", "eidboaoo")  # => false
```

---

## 📌 ポイントまとめ

| ポイント                  | 内容                                 |
| ------------------------- | ------------------------------------ |
| `s1` の順列は何通りもある | でも文字数カウントで一括比較できる   |
| スライディングウィンドウ  | `s1.length` の範囲で `s2` をスキャン |
| カウント配列（26 文字）   | 定数サイズなので比較も高速           |

---

とても良い質問です。  
この式 `count1[c.ord - 'a'.ord] += 1` は、**文字を「a〜z の 0〜25 のインデックス」に変換してカウントするためのテクニック**です。

---

## 🧠 背景：なぜこんなことをするのか？

Ruby には配列（`Array`）とハッシュ（`Hash`）がありますが、  
ここではパフォーマンスを考えて **長さ 26 の配列（`Array.new(26, 0)`）** を使っています。

- `"a"` を 0 番目
- `"b"` を 1 番目
- ...
- `"z"` を 25 番目

に割り当てて、アルファベットごとの出現回数をカウントするためです。

---

## 🔍 `c.ord` の意味

- `c` は文字（たとえば `'b'`）
- `c.ord` は、その文字の **Unicode コードポイント** を返します  
  例：
  ```ruby
  'a'.ord #=> 97
  'b'.ord #=> 98
  'z'.ord #=> 122
  ```

---

## ✨ `c.ord - 'a'.ord` で何が起きてるか？

```ruby
'c'.ord        #=> 99
'a'.ord        #=> 97
'c'.ord - 'a'.ord #=> 2
```

つまり、`"c"` という文字を **「0〜25 のインデックス」に変換**しています。

---

## 🎯 使い道：カウント用の配列インデックスに変換

```ruby
count = Array.new(26, 0)  # a〜z までの26個のスロット

# たとえば 'b' を見つけたら
index = 'b'.ord - 'a'.ord  #=> 1
count[index] += 1          # 'b' の出現回数をカウント
```

---

## 💡 なぜハッシュじゃなくて配列なの？

- `count['a'] += 1` のようにハッシュでも書けますが、
- **配列の方が高速**（固定長・メモリ連続）で、比較も簡単（`==` で OK）

ハッシュは「文字列キーで比較」になるため `O(n)` ですが、配列の `==` は「インデックスごとの値を直接比較」するだけなので `O(1)` に近く、高速です。

---

## ✅ まとめ

| 式                 | 意味                                     |
| ------------------ | ---------------------------------------- |
| `c.ord`            | 文字の Unicode 番号を取得                |
| `'a'.ord`          | 常に 97                                  |
| `c.ord - 'a'.ord`  | `"a"〜"z"` を `0〜25` に変換する         |
| `count1[...] += 1` | アルファベットの出現回数を配列でカウント |

---
