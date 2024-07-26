# Given an array of integers temperatures represents the daily temperatures, return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep answer[i] == 0 instead.
# 整数の配列 temperatures が与えられ、これは日々の気温を表しています。配列 answer を返し、answer[i] には、i日目の後により暖かい気温になるまで何日待つ必要があるかを示します。もし将来のどの日でもより暖かい気温にならない場合は、answer[i] を0のままにします。

# Example 1:

# Input: temperatures = [73,74,75,71,69,72,76,73]
# Output: [1,1,4,2,1,1,0,0]
# Example 2:

# Input: temperatures = [30,40,50,60]
# Output: [1,1,1,0]
# Example 3:

# Input: temperatures = [30,60,90]
# Output: [1,1,0]
 

# Constraints:

# 1 <= temperatures.length <= 105
# 30 <= temperatures[i] <= 100

# この問題は、各日について将来のより暖かい日の最初の出現を見つけるためのものです。スタックを使用して効率的に解くことができます。スタックには、処理済みの日のインデックスを保持し、スタックを使って温度が上昇する日を見つけます。

# アルゴリズム
# 配列 answer をすべて0で初期化します。
# スタックを空で初期化します。
# 各日について、スタックの上にある日の温度が現在の日の温度より低い場合、その日のインデックスをスタックからポップし、その日に対応する answer の値を計算します。
# 現在の日のインデックスをスタックにプッシュします。
# 最後に、answer を返します。

def daily_temperatures(temperatures)
  # 結果を格納する配列を初期化、すべての要素を0に設定
  answer = Array.new(temperatures.length, 0)
  # インデックスを保持するためのスタックを初期化
  stack = []

  # temperatures配列を各要素とそのインデックスでループ
  temperatures.each_with_index do |current_temp, i|
    # スタックが空でない場合、かつ現在の温度がスタックのトップのインデックスにある温度よりも高い場合
    while stack.any? && temperatures[stack.last] < current_temp
      # スタックのトップをポップし、そのインデックスを取得
      j = stack.pop
      # 現在の日と、スタックからポップした日との差をanswer配列に保存
      answer[j] = i - j
    end
    # 現在の日のインデックスをスタックにプッシュ
    stack.push(i)
  end

  # 最終的な結果を返す
  answer
end

# 使用例
puts daily_temperatures([73, 74, 75, 71, 69, 72, 76, 73]).inspect
# 出力: [1, 1, 4, 2, 1, 1, 0, 0]

puts daily_temperatures([30, 40, 50, 60]).inspect
# 出力: [1, 1, 1, 0]

puts daily_temperatures([30, 60, 90]).inspect
# 出力: [1, 1, 0]


# ステップごとの処理
# 初期化:

# answer = [0, 0, 0, 0, 0, 0, 0, 0]
# stack = []
# 各日の処理:

# i = 0 (current_temp = 73):

# スタックは空なので何もポップしない。
# インデックス 0 をスタックにプッシュ → stack = [0]
# i = 1 (current_temp = 74):

# スタックトップのインデックス 0（温度 73）は current_temp = 74 より低いのでポップ。
# answer[0] = 1 - 0 = 1 → answer = [1, 0, 0, 0, 0, 0, 0, 0]
# インデックス 1 をスタックにプッシュ → stack = [1]
# i = 2 (current_temp = 75):

# スタックトップのインデックス 1（温度 74）は current_temp = 75 より低いのでポップ。
# answer[1] = 2 - 1 = 1 → answer = [1, 1, 0, 0, 0, 0, 0, 0]
# インデックス 2 をスタックにプッシュ → stack = [2]
# i = 3 (current_temp = 71):

# スタックトップのインデックス 2（温度 75）は current_temp = 71 より高いので、ポップしない。
# インデックス 3 をスタックにプッシュ → stack = [2, 3]
# i = 4 (current_temp = 69):

# スタックトップのインデックス 3（温度 71）は current_temp = 69 より高いので、ポップしない。
# インデックス 4 をスタックにプッシュ → stack = [2, 3, 4]
# i = 5 (current_temp = 72):

# スタックトップのインデックス 4（温度 69）は current_temp = 72 より低いのでポップ。
# answer[4] = 5 - 4 = 1 → answer = [1, 1, 0, 0, 1, 0, 0, 0]
# 次にスタックトップのインデックス 3（温度 71）もポップ。
# answer[3] = 5 - 3 = 2 → answer = [1, 1, 0, 2, 1, 0, 0, 0]
# インデックス 5 をスタックにプッシュ → stack = [2, 5]
# i = 6 (current_temp = 76):

# スタックトップのインデックス 5（温度 72）は current_temp = 76 より低いのでポップ。
# answer[5] = 6 - 5 = 1 → answer = [1, 1, 0, 2, 1, 1, 0, 0]
# 次にスタックトップのインデックス 2（温度 75）もポップ。
# answer[2] = 6 - 2 = 4 → answer = [1, 1, 4, 2, 1, 1, 0, 0]
# インデックス 6 をスタックにプッシュ → stack = [6]
# i = 7 (current_temp = 73):

# スタックトップのインデックス 6（温度 76）は current_temp = 73 より高いので、ポップしない。
# インデックス 7 をスタックにプッシュ → stack = [6, 7]
# 最終結果:

# answer = [1, 1, 4, 2, 1, 1, 0, 0]
