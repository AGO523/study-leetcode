# Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.

# Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.

# Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

# Return the minimum integer k such that she can eat all the bananas within h hours.

# ココ（Koko）はバナナを食べるのが大好きです。バナナの山がn個あり、i番目の山には piles[i] 本のバナナがあります。警備員が去り、h時間後に戻ってきます。

# ココは1時間あたりの食べるバナナの数 k を決めることができます。各時間ごとに、ココはバナナの山を選び、その山から k 本のバナナを食べます。もしその山に k 本未満のバナナしかない場合、ココはその山のバナナをすべて食べ、その時間内に他のバナナを食べません。

# ココはゆっくりと食べるのが好きですが、警備員が戻ってくる前にすべてのバナナを食べ終えたいと考えています。

# すべてのバナナをh時間以内に食べ終えるための、1時間あたりの最小のバナナの数 k を返してください。


# Example 1:

# Input: piles = [3,6,7,11], h = 8
# Output: 4
# Example 2:

# Input: piles = [30,11,23,4,20], h = 5
# Output: 30
# Example 3:

# Input: piles = [30,11,23,4,20], h = 6
# Output: 23
 

# Constraints:

# 1 <= piles.length <= 104
# piles.length <= h <= 109
# 1 <= piles[i] <= 109

# この問題は、ココがすべてのバナナをh時間以内に食べ終えるために必要な最小のバナナの数 k を見つけるために、バイナリサーチ（二分探索）を用いて解決できます。バナナの山ごとに k 本のバナナを食べ、 k が少なすぎるとすべてのバナナを食べ終えるのに必要な時間が増えるため、適切な k を見つける必要があります。

# アルゴリズムの概要
# k の最小値を1（最小限1本でも食べることができるため）とし、最大値を piles の最大のバナナの数に設定します。
# k の中間値を計算し、その速度でバナナを食べるのにかかる時間を計算します。
# もしその時間が h より多い場合、 k を増やす必要があります（左端を更新）。
# もしその時間が h より少ない場合、 k を減らすことができるかもしれません（右端を更新）。
# 最終的に最小の k を返します。

# def min_eating_speed(piles, h)
#   # 最小のkは1（1時間に少なくとも1本は食べる）、最大のkはpilesの最大の山の数
#   left, right = 1, piles.max

#   # 二分探索を使って最適なkを探す
#   while left < right
#     # 中間のk（速度）を計算
#     mid = (left + right) / 2

#     # mid本ずつ食べた場合に必要な時間を計算
#     # 各山について、(pile / mid)を切り上げた値がその山を食べ終えるのに必要な時間
#     hours_needed = piles.sum { |pile| (pile.to_f / mid).ceil }

#     # 計算した時間が与えられた時間hを超える場合、k（速度）が小さすぎる
#     if hours_needed > h
#       # もっと速く食べる必要があるので、左端をmid+1に移動
#       left = mid + 1
#     else
#       # 十分な時間内に食べ終えることができるので、右端をmidに移動
#       # ただし、kをさらに小さくして試すため
#       right = mid
#     end
#   end

#   # 最終的にleftは最小のkに達する
#   left
# end

# # 使用例
# puts min_eating_speed([3,6,7,11], 8)  # 出力: 4
# puts min_eating_speed([30,11,23,4,20], 5)  # 出力: 30
# puts min_eating_speed([30,11,23,4,20], 6)  # 出力: 23

def min_eating_speed(piles, h)
  # 最小のkは1（1時間に少なくとも1本は食べる）、最大のkはpilesの最大の山の数
  left, right = 1, piles.max

  # 二分探索を使って最適なkを探す
  while left < right
    # 中間のk（速度）を計算
    mid = (left + right) / 2

    # mid本ずつ食べた場合に必要な時間を計算
    # 各山について、(pile / mid)を切り上げた値がその山を食べ終えるのに必要な時間
    hours_needed = piles.sum { |pile| (pile.to_f / mid).ceil }

    # 計算結果の出力
    puts "Checking speed: #{mid}, Hours needed: #{hours_needed}, Range: [#{left}, #{right}]"

    # 計算した時間が与えられた時間hを超える場合、k（速度）が小さすぎる
    if hours_needed > h
      puts "Need to increase speed, new range: [#{mid + 1}, #{right}]"
      # もっと速く食べる必要があるので、左端をmid+1に移動
      left = mid + 1
    else
      puts "Speed might be sufficient, trying lower speeds, new range: [#{left}, #{mid}]"
      # 十分な時間内に食べ終えることができるので、右端をmidに移動
      # ただし、kをさらに小さくして試すため
      right = mid
    end
  end

  # 最終的にleftは最小のkに達する
  puts "Minimum speed required: #{left}"
  left
end

# 使用例
puts "Result: #{min_eating_speed([3,6,7,11], 8)}"  # 出力: 4
puts "Result: #{min_eating_speed([30,11,23,4,20], 5)}"  # 出力: 30
puts "Result: #{min_eating_speed([30,11,23,4,20], 6)}"  # 出力: 23
