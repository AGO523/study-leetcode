# You are given an array prices where prices[i] is the price of a given stock on the ith day.

# Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

# After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).
# Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

# 配列 prices が与えられ、その要素 prices[i] は i 日目の株価を表しています。

# あなたは、次の制約に従いながら株式取引を行い、達成できる最大の利益を計算する必要があります：

# 取引は何回でも行えます（株を1株買って売ることを繰り返せます）。
# ただし、株を売却した次の日には株を買えません（クールダウン期間が1日あります）。
# 同時に複数の取引を行うことはできません（株を売却する前に別の株を購入することはできません）。

# Example 1:

# Input: prices = [1,2,3,0,2]
# Output: 3
# Explanation: transactions = [buy, sell, cooldown, buy, sell]
# Example 2:

# Input: prices = [1]
# Output: 0
 

# Constraints:

# 1 <= prices.length <= 5000
# 0 <= prices[i] <= 1000


# アプローチと解説
# この問題を解決するには、動的計画法（DP） を使用します。取引を行う際に、次の3つの状態を追跡する必要があります：

# 持っている状態 (holding)：株を持っているときの利益。
# 売却した状態 (sold)：株を売った直後の状態で、その日の利益。
# クールダウン中の状態 (cooldown)：クールダウン中の状態。
# 状態遷移
# 買う場合：クールダウン中の状態から株を買うことができます。
# 売る場合：持っている状態から株を売却して利益を得ることができます。
# 何もしない場合：クールダウン状態にあるか、株を持ったままでいるかを選択します。
# DP配列
# holding[i]: i 日目に株を持っている場合の最大利益。
# sold[i]: i 日目に株を売却した場合の最大利益。
# cooldown[i]: i 日目に何もしない（クールダウン中）の場合の最大利益。
# 初期化
# 初日に株を買う場合は holding[0] = -prices[0] です（初期投資としてマイナス）。
# 初日に株を売ることはできないので sold[0] = 0。
# 初日はクールダウンできないので cooldown[0] = 0。
# 状態遷移の式
# holding[i] = [holding[i-1], cooldown[i-1] - prices[i]].max
# → 株を持つか、クールダウンから新たに株を買う場合。

# sold[i] = holding[i-1] + prices[i]
# → 前の日に持っていた株を売る場合。

# cooldown[i] = [cooldown[i-1], sold[i-1]].max
# → クールダウンを続けるか、株を売却した後のクールダウンに入る場合。

# 最終結果
# prices の最後の日での利益は、売却しているかクールダウン中の状態です。したがって、sold[prices.length - 1] または cooldown[prices.length - 1] が最終的な利益となります。

def max_profit(prices)
  return 0 if prices.empty?

  n = prices.length

  # 各状態の初期化
  holding = Array.new(n, 0)
  sold = Array.new(n, 0)
  cooldown = Array.new(n, 0)

  # 初日の初期化
  holding[0] = -prices[0]
  sold[0] = 0
  cooldown[0] = 0

  # DPで利益を計算
  (1...n).each do |i|
    holding[i] = [holding[i - 1], cooldown[i - 1] - prices[i]].max
    sold[i] = holding[i - 1] + prices[i]
    cooldown[i] = [cooldown[i - 1], sold[i - 1]].max

    puts "Day #{i}:"
    puts "  holding[#{i}] = #{holding[i]}"
    puts "  sold[#{i}] = #{sold[i]}"
    puts "  cooldown[#{i}] = #{cooldown[i]}"
  end

  # 最後の日の売却かクールダウン時の最大利益
  [sold[n - 1], cooldown[n - 1]].max
end

# テストケース1
puts "テストケース1: prices = [1, 2, 3, 0, 2]"
puts "最大利益: #{max_profit([1, 2, 3, 0, 2])}"  # 期待される出力: 3

# 動的計画法（DP）が有効な理由は、**重複する部分問題**が存在し、それらを効率的に解決できる構造があるからです。この問題では、株を「持つ」「売る」「クールダウンする」という状態が連続的に変化していきますが、その変化の中で同じ部分問題が繰り返し発生します。動的計画法を使うことで、これらの部分問題を一度解決すれば再計算する必要がなくなるため、効率的に解を求めることができます。

# ### なぜDPが有効なのか？（具体例を通して）

# 問題を解く際に、次のような特徴があります：

# 1. **部分問題の再利用**：
#    各日 (`i` 日目) の状態（株を持っている、売っている、クールダウンしている）における最大利益は、前日 (`i-1` 日目) の状態に依存しています。つまり、1日目から順に利益を計算していくことで、後の日の状態を効率的に決定できる構造を持っています。

#    - **例えば**：ある日株を持つかどうかは、前日に株を持っていたか、クールダウンしていたかに依存します。
#    - このように、同じ「前日の状態」を何度も参照するため、一度計算した結果を再利用することで計算量を削減できます。

# 2. **最適部分構造**：
#    動的計画法が有効なもう一つの理由は、「最適部分構造」が存在するからです。最適部分構造とは、「全体の最適解が、その部分問題の最適解に依存している」という性質です。

#    - **例えば**：`i` 日目の「株を持っている状態」の最適解は、前日までの「株を持っていた場合の最適解」と「クールダウンしていた場合の最適解」のどちらかを選ぶことによって決定できます。
#    - 同様に、株を売る場合も、前日の株を持っている状態に依存して決まります。

# 3. **重複計算を避ける**：
#    各日の「持つ」「売る」「クールダウン」の状態は、過去の日の状態に依存しており、1つの状態を計算するために同じ部分問題を何度も解くことになる場合があります。動的計画法では、この重複する計算を避け、1度計算した結果を保存して再利用します。

#    - **例えば**：3日目の「クールダウン状態」は2日目の「売却状態」から導き出されますが、この2日目の状態は何度も計算する必要はありません。一度計算したら結果を保存しておき、後で再利用することで効率を高めます。

# ---

# ### DPが有効な理由をまとめると：

# 1. **部分問題の再利用**: 各日ごとの「持つ」「売る」「クールダウン」の状態は前日の状態に依存しているため、過去の計算結果を再利用することで、計算量を大幅に削減できる。
   
# 2. **最適部分構造**: 各状態の最適解は、それまでの部分問題の最適解に基づいて決定される。これにより、最適な利益を効率的に計算できる。

# 3. **重複計算の回避**: 動的計画法を使うことで、一度計算した部分問題の解を再利用でき、同じ計算を何度も行う必要がなくなる。

# これらの特性により、DPを使用することで、効率的に最大の利益を計算することが可能です。

