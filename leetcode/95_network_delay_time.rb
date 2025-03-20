# You are given a network of n nodes, labeled from 1 to n. You are also given times, a list of travel times as directed edges times[i] = (ui, vi, wi), where ui is the source node, vi is the target node, and wi is the time it takes for a signal to travel from source to target.

# We will send a signal from a given node k. Return the minimum time it takes for all the n nodes to receive the signal. If it is impossible for all the n nodes to receive the signal, return -1.

# n 個のノード（ラベルは 1 から n）からなるネットワークが与えられます。また、times というリストが与えられ、各要素 times[i] = (ui, vi, wi) は有向エッジを表します。ここで、ui は始点ノード、vi は終点ノード、wi は ui から vi へ信号が届くまでの**時間（重み）**を表します。

# 指定されたノード k から信号を送信するとき、すべてのノードが信号を受信するのにかかる最短時間を求めてください。もしすべてのノードが信号を受信できない場合は -1 を返します。

# Example 1:


# Input: times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
# Output: 2
# Example 2:

# Input: times = [[1,2,1]], n = 2, k = 1
# Output: 1
# Example 3:

# Input: times = [[1,2,1]], n = 2, k = 2
# Output: -1
 

# Constraints:

# 1 <= k <= n <= 100
# 1 <= times.length <= 6000
# times[i].length == 3
# 1 <= ui, vi <= n
# ui != vi
# 0 <= wi <= 100
# All the pairs (ui, vi) are unique. (i.e., no multiple edges.)

# コードの解説と実装
# network_delay_time 関数は、指定されたノード k からスタートし、すべてのノードが信号を受信するのにかかる最短時間を求めるものです。

# アルゴリズムの流れ
# 隣接リストの作成：
# times を使ってグラフの隣接リスト adj を構築し、各ノードがどのノードにどのコストで接続されているかを格納します。
# コストの初期化：
# 各ノードまでのコスト（最短距離）を cost 配列で管理します。
# 開始ノード k のコストは 0 に設定し、その他のノードは nil（未到達）で初期化します。
# 未訪問ノードの管理：
# 未訪問ノードの集合 unvisited を用意し、すべてのノードが未訪問であることを示します。
# 最小コストのノードを選択：
# 未訪問ノードの中から、現在の cost が最小のノード nxt を選択し、訪問済みにします。
# 隣接ノードのコスト更新：
# 現在のノードから、隣接ノードに向かうエッジの重みを考慮し、新しいコストが現在のコストより小さい場合、隣接ノードのコストを更新します。
# すべてのノードが到達可能かを確認：
# cost 配列を確認し、未到達ノード（nil が含まれる）場合は -1 を返します。
# すべてのノードが到達可能な場合は、cost の最大値を返します。

# require 'set'

# def network_delay_time(times, n, k)
#   # 1. 隣接リストの初期化
#   adj = Hash.new { |h, k| h[k] = [] }
  
#   # 各エッジを隣接リストに追加
#   times.each do |s, d, w|
#     adj[s] << [d, w]
#     puts "エッジを追加: #{s} -> #{d} (コスト: #{w})"
#   end

#   # 2. 各ノードまでの最短コストを初期化
#   cost = [nil] * (n + 1)  # ノード番号を 1-index に合わせるために n + 1 サイズを用意
#   cost[k] = 0             # 開始ノード k のコストは 0 とする
#   puts "初期化されたコスト配列: #{cost.inspect}"

#   # 3. 未訪問ノードの集合を初期化
#   unvisited = (1..n).to_set  # 1 から n までのノードを未訪問としてセット
#   puts "未訪問ノードの集合: #{unvisited.to_a}"

#   # 4. ダイクストラ法に基づく最短経路探索
#   while !unvisited.empty?
#     # 現在の未訪問ノードの中から、最小コストのノードを選択
#     nxt = unvisited.select { |pt| cost[pt] }.min_by { |pt| cost[pt] }
#     puts "選択された次のノード: #{nxt.inspect} (最小コスト: #{cost[nxt]})"
    
#     # すべての到達可能なノードを探索し終えたら終了
#     break if nxt.nil?
    
#     # 未訪問集合からこのノードを削除
#     unvisited.delete(nxt)
#     puts "ノード #{nxt} を訪問済みにします。未訪問ノード: #{unvisited.to_a}"

#     # 隣接ノードのコストを更新
#     adj[nxt].each do |neighbor, c|
#       new_cost = cost[nxt] + c  # 現在のコストに隣接ノードへの移動コストを加算
#       # より小さいコストが見つかった場合、隣接ノードのコストを更新
#       if cost[neighbor].nil? || new_cost < cost[neighbor]
#         puts "ノード #{neighbor} のコストを更新: #{cost[neighbor]} -> #{new_cost}"
#         cost[neighbor] = new_cost
#       end
#     end
#     puts "現在のコスト配列: #{cost.inspect}"
#   end

#   # 5. 結果の確認と返却
#   cost = cost[1..]  # 1-index のため 1 からの範囲を取り出す
#   puts "最終的なコスト配列: #{cost.inspect}"

#   # すべてのノードが到達可能かどうかを確認
#   if cost.include?(nil)
#     puts "到達できないノードが存在します。"
#     -1
#   else
#     max_time = cost.max
#     puts "すべてのノードに到達するのにかかった最大時間: #{max_time}"
#     max_time
#   end
# end

# # テストケース1
# puts "テストケース1: "
# times1 = [[2,1,1],[2,3,1],[3,4,1]]
# n1 = 4
# k1 = 2
# result1 = network_delay_time(times1, n1, k1)
# puts "出力: #{result1}"  # 期待される出力: 2

# # テストケース2
# puts "\nテストケース2: "
# times2 = [[1,2,1]]
# n2 = 2
# k2 = 1
# result2 = network_delay_time(times2, n2, k2)
# puts "出力: #{result2}"  # 期待される出力: 1

# # テストケース3
# puts "\nテストケース3: "
# times3 = [[1,2,1]]
# n3 = 2
# k3 = 2
# result3 = network_delay_time(times3, n3, k3)
# puts "出力: #{result3}"  # 期待される出力: -1

require 'set'

def network_delay_time(times, n, k)
  # 隣接リストの初期化
  graph = Hash.new { |hash, key| hash[key] = [] }
  times.each { |u, v, w| graph[u] << [v, w] }  # エッジを追加

  # 各ノードまでのコストを初期化
  # 初期のコストを無限大に設定しておき、探索中に最短距離が見つかったときに値を更新するために使用
  cost = Array.new(n + 1, Float::INFINITY)
  cost[k] = 0  # スタート地点のコストは0

  # 優先度付きキューとして使う配列
  queue = [[0, k]]  # [現在の距離, ノード]

  # ダイクストラ法の実行
  until queue.empty?
    current_cost, node = queue.shift
    p "current_cost: #{current_cost}, node: #{node}"
    next unless current_cost <= cost[node]

    # 隣接ノードのコストを更新
    graph[node].each do |neighbor, weight|
      new_cost = current_cost + weight
      if new_cost < cost[neighbor]
        cost[neighbor] = new_cost
        queue.push([new_cost, neighbor])  # 更新されたノードをキューに追加
        queue.sort_by! { |c, n| c }  # コストでキューをソート（優先度付きキュー）
      end
    end
  end

  # 結果を確認して返す
  max_cost = cost[1..].max  # 1-index で管理しているので 1..n の範囲を確認
  max_cost == Float::INFINITY ? -1 : max_cost
end

# テストケース1
times1 = [[2,1,1],[2,3,1],[3,4,1]]
n1 = 4
k1 = 2
result1 = network_delay_time(times1, n1, k1)
puts "出力: #{result1}"  # 期待される出力: 2

# # テストケース2
# puts "\nテストケース2: "
# times2 = [[1,2,1]]
# n2 = 2
# k2 = 1
# result2 = network_delay_time(times2, n2, k2)
# puts "出力: #{result2}"  # 期待される出力: 1

# # テストケース3
# puts "\nテストケース3: "
# times3 = [[1,2,1]]
# n3 = 2
# k3 = 2
# result3 = network_delay_time(times3, n3, k3)
# puts "出力: #{result3}"  # 期待される出力: -1
