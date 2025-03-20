# There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].

# You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from the ith station to its next (i + 1)th station. You begin the journey with an empty tank at one of the gas stations.

# Given two integer arrays gas and cost, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1. If there exists a solution, it is guaranteed to be unique.

 

# Example 1:

# Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
# Output: 3
# Explanation:
# Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
# Travel to station 4. Your tank = 4 - 1 + 5 = 8
# Travel to station 0. Your tank = 8 - 2 + 1 = 7
# Travel to station 1. Your tank = 7 - 3 + 2 = 6
# Travel to station 2. Your tank = 6 - 4 + 3 = 5
# Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
# Therefore, return 3 as the starting index.
# Example 2:

# Input: gas = [2,3,4], cost = [3,4,3]
# Output: -1
# Explanation:
# You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
# Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
# Travel to station 0. Your tank = 4 - 3 + 2 = 3
# Travel to station 1. Your tank = 3 - 3 + 3 = 3
# You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
# Therefore, you can't travel around the circuit once no matter where you start.
 

# Constraints:

# n == gas.length == cost.length
# 1 <= n <= 105
# 0 <= gas[i], cost[i] <= 104

# ### 詳細な解説

# この問題は、円形に配置されたガソリンスタンドを巡回し、すべてのスタンドを通過して出発点に戻ることができるかどうかを判断するものです。与えられた各スタンドにはガソリン `gas[i]` があり、次のスタンドまで移動するためには `cost[i]` のガソリンが必要です。貪欲法を使用して、どのスタンドからスタートすれば一周できるかを効率的に見つけ出します。

# ### アルゴリズムの説明

# #### 1. 全体のガソリンのバランスを考える
# - 配列 `gas` と `cost` が与えられたとき、全体でガソリンが必要量を超えていれば必ず一周することができます。一方で、全体のガソリンが不足している場合、どの地点から始めても一周できません。
# - このため、まず全体のガソリンの差（`total_tank`）を計算し、それが負であれば `-1` を返します。

# #### 2. 出発地点を決定する
# - もう一つの重要な変数 `current_tank` を使って、特定の位置からスタートして一周できるかどうかを逐次追跡します。
# - `current_tank` は現在のガソリン量を追跡するために使用します。もし、ある地点で `current_tank` が負になった場合、今の出発地点からでは一周できないことがわかるため、新しい出発地点に移動します。

# #### 3. 出発地点の決定方法
# - 現在のガソリン量 `current_tank` が負になるたびに、次のスタンドを新たな出発地点に設定し、`current_tank` をリセットします。
# - 最終的に、全てのスタンドを通過した後に `total_tank` が非負であれば、一周できる出発地点が存在することが保証されます。

# ### アルゴリズムの流れ

# 1. **初期化**:
#    - `total_tank` を `0` に初期化し、すべてのガソリンとコストの差を追跡します。
#    - `current_tank` を `0` に初期化し、現在のガソリン量を追跡します。
#    - `start_index` を `0` に初期化し、出発地点の候補を追跡します。

# 2. **各スタンドをループで処理**:
#    - 各スタンド `i` について、`total_tank` と `current_tank` をそれぞれ更新します。
#    - `current_tank` が負になった場合、現在の位置からは一周できないため、次のスタンド `i + 1` を新たな出発地点に設定し、`current_tank` をリセットします。

# 3. **結果の判断**:
#    - 全てのスタンドを走査し終わった後で、`total_tank` が非負であれば `start_index` を返します。そうでなければ、`-1` を返します。

# ### 具体例での解説

# #### 例1: `gas = [1,2,3,4,5]`, `cost = [3,4,5,1,2]`
# 1. **初期化**:
#    - `total_tank = 0`
#    - `current_tank = 0`
#    - `start_index = 0`
# 2. **各スタンドでの処理**:
#    - インデックス `0` の時、`current_tank = 1 - 3 = -2` となるため、次のスタンド（インデックス `1`）を新たな出発地点にします。
#    - インデックス `1` でも `current_tank` が負になるため、次のスタンド（インデックス `2`）に移動します。
#    - このように進み、インデックス `3` で初めて `current_tank` が正のまま維持されます。
# 3. **結果**:
#    - `total_tank` は最終的に `3` であり、非負なのでインデックス `3` が出発地点となります。

# #### 例2: `gas = [2,3,4]`, `cost = [3,4,3]`
# 1. **初期化**:
#    - `total_tank = 0`
#    - `current_tank = 0`
#    - `start_index = 0`
# 2. **各スタンドでの処理**:
#    - インデックス `0` の時、`current_tank = 2 - 3 = -1` となるため、次のスタンド（インデックス `1`）を新たな出発地点にします。
#    - インデックス `1` でも `current_tank` が負になるため、次のスタンド（インデックス `2`）に移動します。
#    - インデックス `2` に到達しても `current_tank` が最終的に足りず、一周できないことがわかります。
# 3. **結果**:
#    - `total_tank` が負であるため、`-1` を返します。

# ### 計算量
# - **時間計算量**: `O(n)`。配列を1回だけ走査するため非常に効率的です。
# - **空間計算量**: `O(1)`。追加の空間を使用せず、定数サイズの変数のみを使用します。

# ### 貪欲法の適用理由
# 貪欲法を使用している理由は、各スタンドで可能な限りガソリンを効率よく使い、一周するための最適な出発地点を見つけるためです。局所的にガソリンの量が足りなくなったら次のスタート地点を選ぶことで、最小限の計算で正しい答えを見つけることができます。

# n 個のガソリンスタンドが円形に配置されており、各スタンドには gas[i] のガソリンがあります。
# 車には無制限のガスタンクがあり、i 番目のスタンドから次のスタンド (i + 1 番目) まで行くには cost[i] のガソリンが必要です。
# あなたはどこかのガソリンスタンドから空のタンクで出発します。
# 二つの整数配列 gas と cost が与えられたとき、時計回りに一周することができるスタート地点のガソリンスタンドのインデックスを返してください。
# 一周できない場合は -1 を返します。解が存在する場合、それは一つだけであることが保証されています。

# 例1:
# 入力: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
# 出力: 3
# 説明:
# スタンド 3 (インデックス 3) から開始し、4 単位のガソリンを満タンにします。タンク = 0 + 4 = 4
# 次にスタンド 4 へ移動。タンク = 4 - 1 + 5 = 8
# スタンド 0 へ移動。タンク = 8 - 2 + 1 = 7
# スタンド 1 へ移動。タンク = 7 - 3 + 2 = 6
# スタンド 2 へ移動。タンク = 6 - 4 + 3 = 5
# 最後にスタンド 3 に戻るのに必要なガソリンは 5 であり、ちょうど戻れます。
# したがって、出発地点として 3 を返します。

# 例2:
# 入力: gas = [2,3,4], cost = [3,4,3]
# 出力: -1
# 説明:
# どのスタンドから開始しても一周することはできません。

def can_complete_circuit(gas, cost)
  n = gas.length
  total_tank = 0  # 全体のガソリン量の差
  current_tank = 0  # 現在のガソリン量
  start_index = 0  # 出発地点

  (0...n).each do |i|
    total_tank += gas[i] - cost[i]
    current_tank += gas[i] - cost[i]

    # 現在のガソリン量が負になった場合、出発地点を次に移動
    if current_tank < 0
      puts "インデックス #{i} でガソリン不足: current_tank=#{current_tank}。次のスタンドを新たな出発地点にします。"
      start_index = i + 1
      current_tank = 0
    end
  end

  # 全体のガソリン量が足りない場合は一周できない
  if total_tank < 0
    puts "全体のガソリン量が不足しているため、一周することはできません。"
    return -1
  end

  puts "出発地点としてインデックス #{start_index} を選択します。"
  start_index
end

# テストケース1
puts "テストケース1: gas = [1,2,3,4,5], cost = [3,4,5,1,2]"
puts "結果: #{can_complete_circuit([1,2,3,4,5], [3,4,5,1,2])}"  # 期待される出力: 3

# # テストケース2
# puts "\nテストケース2: gas = [2,3,4], cost = [3,4,3]"
# puts "結果: #{can_complete_circuit([2,3,4], [3,4,3])}"  # 期待される出力: -1

# 解説:
# この問題では、ガソリンの差を追跡するために2つの変数 `total_tank` と `current_tank` を使用します。
# `total_tank` は全体のガソリンの差を示し、これが負であればどのスタンドから開始しても一周できないことがわかります。
# `current_tank` は現在のガソリン量を追跡し、負になった時点で出発地点を次に移動し、`current_tank` をリセットします。
# 最終的に、`total_tank` が非負であれば一周できることが保証されているため、`start_index` を返します。
