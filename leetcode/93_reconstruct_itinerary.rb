# You are given a list of airline tickets where tickets[i] = [fromi, toi] represent the departure and the arrival airports of one flight. Reconstruct the itinerary in order and return it.

# All of the tickets belong to a man who departs from "JFK", thus, the itinerary must begin with "JFK". If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string.

# For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
# You may assume all tickets form at least one valid itinerary. You must use all the tickets once and only once.

# 与えられた航空券リスト tickets には、tickets[i] = [出発空港, 到着空港] の形式でフライトの出発地と到着地のペアが格納されています。この航空券をすべて使って、元の旅行プラン（経路）を復元し、順序に従って返してください。

# すべての航空券は「JFK」から出発する男性に属しています。そのため、旅行プランの最初は必ず「JFK」から始める必要があります。
# もし、同じ出発空港からのフライトが複数ある場合は、**辞書順（アルファベット順）**が小さい順に並ぶ経路を選択してください。
# 例えば、経路 ["JFK", "LGA"] は、経路 ["JFK", "LGB"] よりも小さい辞書順です。
# すべての航空券を一度だけ使用し、有効な旅行プランを必ず復元できると仮定します。


# Example 1:


# Input: tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
# Output: ["JFK","MUC","LHR","SFO","SJC"]
# Example 2:


# Input: tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
# Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
# Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"] but it is larger in lexical order.
 

# Constraints:

# 1 <= tickets.length <= 300
# tickets[i].length == 2
# fromi.length == 3
# toi.length == 3
# fromi and toi consist of uppercase English letters.
# fromi != toi

# プログラム解説と実装
# この問題は、グラフ探索と辞書順制約を組み合わせたものです。フライト情報を有向グラフとして表し、すべての航空券を使って「JFK」から始まる経路を復元する必要があります。

# アルゴリズムの選択
# この問題では、ヒエラルホルツァーのアルゴリズム（Hierholzer's Algorithm）を使うことで、すべてのエッジを1回ずつ通る経路（オイラー経路）を見つけることができます。具体的には、以下の手順で解きます。

# グラフの構築:

# 航空券リストをもとに、有向グラフを構築します。出発空港をキー、到着空港のリストを値として持つハッシュを使います。
# 各出発空港からの到着空港リストを辞書順でソートしておき、辞書順に基づいた経路復元ができるようにします。
# 経路の復元:

# DFS（深さ優先探索）を用いて、各空港からのすべてのフライトを1回ずつ辿りながら経路を構築します。
# 最終的に構築された経路を逆順にすることで、正しい順序の経路が得られます。

# 旅行プランを復元する関数
def find_itinerary(tickets)
  puts "入力された航空券: #{tickets}"

  # グラフをハッシュで初期化
  graph = Hash.new { |hash, key| hash[key] = [] }

  # 航空券リストからグラフを構築
  tickets.each do |from, to|
    graph[from] << to
  end

  # 各空港の到着地リストを辞書順にソート
  graph.each_value(&:sort!)
  puts "構築されたグラフ（辞書順にソート後）: #{graph}"
  # 以下のような形で構築されます：
  # {
  #   "JFK" => ["ATL", "SFO"],
  #   "SFO" => ["ATL"],
  #   "ATL" => ["JFK", "SFO"]
  # }

  # DFS 用の経路とスタックを初期化
  route = []  # 経路を保存するスタック
  stack = ["JFK"]  # 開始空港は必ず "JFK"

  puts "DFS を開始します。"
  # DFS のメインループ
  while !stack.empty?
    # 現在の空港（スタックのトップ）
    current_airport = stack[-1]
    puts "現在の空港: #{current_airport}"

    # 次に移動できる空港があるか確認
    if graph[current_airport].empty?
      # もし次の空港がなければ、経路に追加（戻る地点）
      puts "移動先がないので、経路に追加: #{current_airport}"
      route << stack.pop
    else
      # 移動先があれば、辞書順で最初の空港を選び、スタックに追加
      next_airport = graph[current_airport].shift
      puts "移動先: #{next_airport} をスタックに追加"
      stack << next_airport
    end
  end

  # 経路は逆順で構築されているので、逆順にして返す
  puts "復元された経路（逆順）: #{route.reverse}"
  route.reverse
end

# テストケース1
puts "テストケース1: "
tickets1 = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
result1 = find_itinerary(tickets1)
puts "出力: #{result1}"  # 期待される出力: ["JFK", "MUC", "LHR", "SFO", "SJC"]

# テストケース2
puts "\nテストケース2: "
tickets2 = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
result2 = find_itinerary(tickets2)
puts "出力: #{result2}"  # 期待される出力: ["JFK", "ATL", "JFK", "SFO", "ATL", "SFO"]

# 「次の移動先がない場合は、その空港を経路に追加する」という操作は、ヒエラルホルツァーのアルゴリズム（Hierholzer's Algorithm）に基づくものです。このアルゴリズムを使うと、すべてのエッジを1度だけ通る経路（オイラー経路またはオイラー閉路）を見つけることができます。

# この操作は少し直感的でないかもしれませんが、以下の理由によって、経路復元を正しく行うことができます。

# 1. アルゴリズムの背景
# ヒエラルホルツァーのアルゴリズムは、オイラー経路やオイラー閉路（すべてのエッジをちょうど1回ずつ通る経路）を求めるためのアルゴリズムです。
# すべてのフライト（航空券）を使い切る必要があるため、すべてのエッジを1回ずつ訪問しながら経路を構築しなければなりません。
# このアルゴリズムの考え方は、「行き止まりになった場所から戻っていくことで経路を確定させる」というアプローチを取っています。

# 2. 次の移動先がない場合の処理の意味
# 次の移動先がない場合、その空港を経路に追加するのは、「行き止まりに到達したので、それを経路の末尾に確定させる」ことを意味します。

# スタックを使って現在の経路を保持しているとき、スタックのトップ（現在位置）からもうこれ以上移動できない（すべてのフライトを使い切っている）と判断したら、その場所を経路に追加し、「そこに戻る」動作を行います。
# この操作は、DFS でのバックトラッキングに相当し、経路を「逆順で確定」していきます。
# 3. 経路を逆順にしている理由
# 次の移動先がない場合に経路に追加していくと、実際には経路の順序が逆順になってしまいます。そこで、最終的に経路を逆順にして戻すことで、正しい順序の経路を得ることができます。

# 経路の確定順序を正しくする理由
# ヒエラルホルツァーのアルゴリズムでは、DFS の途中で「行き止まり」に達した時点で、その空港から他の空港への移動はできないことが確定します。したがって、その空港は「最終的な経路の末尾に配置されるべき空港」として、確定されます。

# 最初に C を確定し、その後 A, B と確定していくと、正しい順序で経路が構築されます。DFS を逆順でたどることによって、正しい順序の経路が得られるため、最終的に route.reverse を使って元に戻します。

# 6. まとめ
# 次の移動先がない場合にスタックから取り出して経路に追加する理由は、「行き止まりの地点を確定」して、最終経路の末尾に配置するためです。この操作により、最短経路やオイラー経路を効率的に構築でき、すべてのフライトを正しく消費して有効な経路を見つけることができます。
