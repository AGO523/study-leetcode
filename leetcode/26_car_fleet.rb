# There are n cars at given miles away from the starting mile 0, traveling to reach the mile target.

# You are given two integer array position and speed, both of length n, where position[i] is the starting mile of the ith car and speed[i] is the speed of the ith car in miles per hour.

# A car cannot pass another car, but it can catch up and then travel next to it at the speed of the slower car.

# A car fleet is a car or cars driving next to each other. The speed of the car fleet is the minimum speed of any car in the fleet.

# If a car catches up to a car fleet at the mile target, it will still be considered as part of the car fleet.

# Return the number of car fleets that will arrive at the destination.

# n台の車が、出発地点0マイルから目標地点まで向かっています。各車の現在の位置と速度が与えられます。

# 2つの整数配列 position と speed があり、共に長さ n です。position[i] はi番目の車の出発地点を、speed[i] はその車の速度（マイル/時）を表しています。

# 車は他の車を追い越すことはできませんが、追いついた場合、より遅い車の速度でその車の隣に並んで走行します。

# 「車の隊列」とは、隣り合って走行する車の集まりです。隊列の速度は、その隊列内のどの車の速度よりも遅い車の速度になります。

# 車が目標地点で車の隊列に追いついた場合、それはその隊列の一部と見なされます。

# 目的地に到着する車の隊列の数を返してください。


# Example 1:

# Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]

# Output: 3

# Explanation:

# The cars starting at 10 (speed 2) and 8 (speed 4) become a fleet, meeting each other at 12. The fleet forms at target.
# The car starting at 0 (speed 1) does not catch up to any other car, so it is a fleet by itself.
# The cars starting at 5 (speed 1) and 3 (speed 3) become a fleet, meeting each other at 6. The fleet moves at speed 1 until it reaches target.
# Example 2:

# Input: target = 10, position = [3], speed = [3]

# Output: 1

# Explanation:

# There is only one car, hence there is only one fleet.
# Example 3:

# Input: target = 100, position = [0,2,4], speed = [4,2,1]

# Output: 1

# Explanation:

# The cars starting at 0 (speed 4) and 2 (speed 2) become a fleet, meeting each other at 4. The car starting at 4 (speed 1) travels to 5.
# Then, the fleet at 4 (speed 2) and the car at position 5 (speed 1) become one fleet, meeting each other at 6. The fleet moves at speed 1 until it reaches target.
 

# Constraints:

# n == position.length == speed.length
# 1 <= n <= 105
# 0 < target <= 106
# 0 <= position[i] < target
# All the values of position are unique.
# 0 < speed[i] <= 106


# 解答
# 問題を解くために、各車が目標地点に到達するまでにかかる時間を計算し、その時間を基に車の隊列を数えます。車は位置が遠い順に（つまり目標地点に近い順に）処理し、より早く到達する車が存在する場合、その車は追いつけないため新しい隊列と見なします。

# アルゴリズム
# 車を position に基づいて降順にソートします。
# 各車について、目標地点に到達する時間を計算します。
# 後続の車が前方の車に追いつけるかを確認し、追いつける場合は同じ隊列にし、追いつけない場合は新しい隊列としてカウントします。


def car_fleet(target, position, speed)
  # 車の数を取得
  n = position.length
  
  # 車の位置と速度のペアを作成し、位置(position)が降順になるようにソート
  cars = position.zip(speed).sort_by { |pos, _| -pos }
  
  # 隊列の数をカウントするための変数
  fleets = 0
  
  # 現在の隊列の到達時間（これより遅い車は同じ隊列になる）
  current_time = 0.0
  
  # 各車を処理
  cars.each do |pos, spd|
    # 目標地点に到達するまでの時間を計算
    time_to_target = (target - pos).to_f / spd
    
    # 現在の車が新しい隊列を形成するか確認
    if time_to_target > current_time
      # 新しい隊列を形成するのでカウントを増やす
      fleets += 1
      # current_timeを更新して次の隊列の基準とする
      current_time = time_to_target
    end
  end
  
  # 最終的な隊列の数を返す
  fleets
end

# 使用例
puts car_fleet(12, [10, 8, 0, 5, 3], [2, 4, 1, 1, 3])  # 出力: 3
puts car_fleet(10, [3], [3])                          # 出力: 1
puts car_fleet(100, [0, 2, 4], [4, 2, 1])             # 出力: 1


# 具体例1
# 入力: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]

# この配列は、各車の現在の位置と速度を示しています。目標地点 target = 12 に到達するまでの各車の経路と、最終的に形成される隊列の数を計算します。

# 期待される出力: 3

# これは、目標地点に到達する車の隊列の数です。

# ステップごとの処理
# 初期化:

# 車の数 n = 5
# 車の位置と速度をペアにして、位置が降順になるようにソート:
# cars = [[10, 2], [8, 4], [5, 1], [3, 3], [0, 1]]
# fleets = 0
# current_time = 0.0
# 各車の処理:

# 1台目（位置10、速度2）:
# 目標地点までの時間: (12 - 10) / 2 = 1.0
# current_time より大きいので、新しい隊列としてカウント:
# fleets = 1
# current_time = 1.0
# 2台目（位置8、速度4）:
# 目標地点までの時間: (12 - 8) / 4 = 1.0
# current_time と同じなので、新しい隊列にはならず、既存の隊列に含まれる。
# 3台目（位置5、速度1）:
# 目標地点までの時間: (12 - 5) / 1 = 7.0
# current_time より大きいので、新しい隊列としてカウント:
# fleets = 2
# current_time = 7.0
# 4台目（位置3、速度3）:
# 目標地点までの時間: (12 - 3) / 3 = 3.0
# current_time より小さいので、新しい隊列にはならず、既存の隊列に含まれる。
# 5台目（位置0、速度1）:
# 目標地点までの時間: (12 - 0) / 1 = 12.0
# current_time より大きいので、新しい隊列としてカウント:
# fleets = 3
# current_time = 12.0
# 最終結果
# 隊列の数 fleets = 3
# 結果の説明:

# 最初の隊列は、位置10と位置8の車で形成され、位置10の車が隊列の速度を決定します（速度2）。
# 2番目の隊列は、位置5の車が単独で形成します（速度1）。
# 3番目の隊列は、位置0の車が単独で形成します（速度1）。
# このように、各車の到達時間を計算し、より遅い車が既に到達している隊列に追いつくかどうかを判断します。追いつかない場合、その車は新しい隊列を形成します。
