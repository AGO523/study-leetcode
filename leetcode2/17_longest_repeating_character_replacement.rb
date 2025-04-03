require 'set'

def character_replacement(s, k)
  # counts のハッシュに出現回数を記録する
  counts = Hash.new(0)
  left = 0
  max_count = 0
  max_length = 0

  s.chars.each_with_index do |char, right|
    # 例: {"A"=>1, "B"=>1}, {"A"=>2, "B"=>1}, {"A"=>2, "B"=>2}
    counts[char] += 1
    max_count = [max_count, counts[char]].max

    # ウィンドウ内で置き換えが必要な文字数が k を超えたら縮める
    # ウィンドウのサイズ - 最頻出文字の数 > k なら → ウィンドウが成立しない（変える量が多すぎる）
    # なので、「変える必要のある文字数が k 以下である最大のウィンドウ」を常に追いかける
    # 例: "AABABBA", k = 1 の場合
    # left = 0, right = 4 のときは、k = 1 で成立する
    # left = 0, right = 5 のときは、k = 1 で成立しない
    # したがって、left を右に移動してウィンドウを縮める
    if (right - left + 1) - max_count > k
      counts[s[left]] -= 1
      left += 1
    end

    max_length = [max_length, right - left + 1].max
  end

  max_length
end

# テスト
p character_replacement("ABAB", 2)      # => 4
p character_replacement("AABABBA", 1)   # => 4
