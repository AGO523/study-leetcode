# There are n cities connected by some number of flights. You are given an array flights where flights[i] = [fromi, toi, pricei] indicates that there is a flight from city fromi to city toi with cost pricei.

# You are also given three integers src, dst, and k, return the cheapest price from src to dst with at most k stops. If there is no such route, return -1.

# n 個の都市と、いくつかのフライト（飛行便）が存在します。flights という配列が与えられており、flights[i] = [fromi, toi, pricei] は、都市 fromi から都市 toi までのフライトが存在し、そのフライトのコストが pricei であることを表しています。

# また、3つの整数 src, dst, k が与えられます。src は出発地、dst は目的地、k は最大経由回数（ストップ数）を表しています。

# 条件:

# 出発地 src から目的地 dst に最大で k 回までの経由を含む最安値のフライトコストを求めなさい。
# もしそのようなルートが存在しない場合は -1 を返します。

# Example 1:


# Input: n = 4, flights = [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]], src = 0, dst = 3, k = 1
# Output: 700
# Explanation:
# The graph is shown above.
# The optimal path with at most 1 stop from city 0 to 3 is marked in red and has cost 100 + 600 = 700.
# Note that the path through cities [0,1,2,3] is cheaper but is invalid because it uses 2 stops.
# Example 2:


# Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 1
# Output: 200
# Explanation:
# The graph is shown above.
# The optimal path with at most 1 stop from city 0 to 2 is marked in red and has cost 100 + 100 = 200.
# Example 3:


# Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 0
# Output: 500
# Explanation:
# The graph is shown above.
# The optimal path with no stops from city 0 to 2 is marked in red and has cost 500.
 

# Constraints:

# 1 <= n <= 100
# 0 <= flights.length <= (n * (n - 1) / 2)
# flights[i].length == 3
# 0 <= fromi, toi < n
# fromi != toi
# 1 <= pricei <= 104
# There will not be any multiple flights between two cities.
# 0 <= src, dst, k < n
# src != dst

# アルゴリズム: 幅優先探索（BFS）を使用
# 幅優先探索（BFS）を用いて、最大 k 回までの経由を考慮しながら、目的地 dst までの最小コストを求める方法を使います。

# 各都市の隣接リストを用いて、現在の都市から隣接都市へ移動し、その移動のコストを記録します。
# k 回の移動まで経路をたどることで、制約内での最小コストを求めます。
# BFS の探索時に、queue で「現在の都市、累積コスト、現在の経由回数」を管理し、最安値のコストを求めます。

# 最小コストを求める関数
def find_cheapest_price(n, flights, src, dst, k)
  # 隣接リストを作成（各都市の出発地と目的地、コストを管理）
  graph = Hash.new { |h, key| h[key] = [] }
  flights.each do |from, to, price|
    graph[from] << [to, price]
  end

  # BFS 用のキューを初期化（[現在の都市, 累積コスト, 経由回数]）
  queue = [[src, 0, 0]]

  # 各都市までの最小コストを管理するハッシュ（初期値は無限大）
  min_cost = Array.new(n, Float::INFINITY)
  min_cost[src] = 0

  # 経過確認用の表示
  puts "初期グラフ: #{graph.inspect}"

  # BFS の実行
  while !queue.empty?
    city, cost, stops = queue.shift
    puts "\n現在の都市: #{city}, 累積コスト: #{cost}, 経由回数: #{stops}"

    # 経由回数が上限を超える場合はこれ以上探索しない
    next if stops > k

    # 隣接する都市への移動を確認
    graph[city].each do |next_city, price|
      new_cost = cost + price
      puts "隣接都市: #{next_city}, コスト: #{price}, 新しい累積コスト: #{new_cost}"

      # 目的地により安いコストで到達できる場合
      if new_cost < min_cost[next_city]
        min_cost[next_city] = new_cost
        queue.push([next_city, new_cost, stops + 1])
        puts "都市 #{next_city} への最小コストを更新: #{new_cost}"
      end
    end
    puts "現在の最小コスト: #{min_cost.inspect}"
  end

  # 目的地 `dst` に到達する最小コストを返す
  min_cost[dst] == Float::INFINITY ? -1 : min_cost[dst]
end

# テストケース1
puts "テストケース1: "
flights1 = [[0, 1, 100], [1, 2, 100], [2, 0, 100], [1, 3, 600], [2, 3, 200]]
puts "出力: #{find_cheapest_price(4, flights1, 0, 3, 1)}"  # 期待される出力: 700

# # テストケース2
# puts "\nテストケース2: "
# flights2 = [[0, 1, 100], [1, 2, 100], [0, 2, 500]]
# puts "出力: #{find_cheapest_price(3, flights2, 0, 2, 1)}"  # 期待される出力: 200

# # テストケース3
# puts "\nテストケース3: "
# flights3 = [[0, 1, 100], [1, 2, 100], [0, 2, 500]]
# puts "出力: #{find_cheapest_price(3, flights3, 0, 2, 0)}"  # 期待される出力: 500
