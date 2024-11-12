# ヒープを使わなきゃいけない問題なので、保留



# You are given a 2D integer array intervals, where intervals[i] = [lefti, righti] describes the ith interval starting at lefti and ending at righti (inclusive). The size of an interval is defined as the number of integers it contains, or more formally righti - lefti + 1.

# You are also given an integer array queries. The answer to the jth query is the size of the smallest interval i such that lefti <= queries[j] <= righti. If no such interval exists, the answer is -1.

# Return an array containing the answers to the queries.

# 2D 整数配列 intervals が与えられます。intervals[i] = [lefti, righti] は、i 番目の区間が lefti から righti までの整数（両端を含む）を含むことを示します。区間のサイズは、その区間に含まれる整数の数（つまり righti - lefti + 1）と定義されます。

# また、整数配列 queries も与えられます。各 queries[j] に対する答えは、lefti <= queries[j] <= righti を満たす区間の中で、サイズが最も小さいもののサイズです。該当する区間がない場合は -1 を返してください。

# すべてのクエリに対する回答を含む配列を返してください。

# 例
# 例1
# 入力:
# intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]

# 出力:
# [3,3,1,4]

# 説明:
# 各クエリについて以下のように処理します。

# クエリ 2 の場合：最小の区間は [2,4] で、そのサイズは 4 - 2 + 1 = 3 です。
# クエリ 3 の場合：最小の区間は [2,4] で、そのサイズは 4 - 2 + 1 = 3 です。
# クエリ 4 の場合：最小の区間は [4,4] で、そのサイズは 4 - 4 + 1 = 1 です。
# クエリ 5 の場合：最小の区間は [3,6] で、そのサイズは 6 - 3 + 1 = 4 です。

# Example 1:

# Input: intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]
# Output: [3,3,1,4]
# Explanation: The queries are processed as follows:
# - Query = 2: The interval [2,4] is the smallest interval containing 2. The answer is 4 - 2 + 1 = 3.
# - Query = 3: The interval [2,4] is the smallest interval containing 3. The answer is 4 - 2 + 1 = 3.
# - Query = 4: The interval [4,4] is the smallest interval containing 4. The answer is 4 - 4 + 1 = 1.
# - Query = 5: The interval [3,6] is the smallest interval containing 5. The answer is 6 - 3 + 1 = 4.
# Example 2:

# Input: intervals = [[2,3],[2,5],[1,8],[20,25]], queries = [2,19,5,22]
# Output: [2,-1,4,6]
# Explanation: The queries are processed as follows:
# - Query = 2: The interval [2,3] is the smallest interval containing 2. The answer is 3 - 2 + 1 = 2.
# - Query = 19: None of the intervals contain 19. The answer is -1.
# - Query = 5: The interval [2,5] is the smallest interval containing 5. The answer is 5 - 2 + 1 = 4.
# - Query = 22: The interval [20,25] is the smallest interval containing 22. The answer is 25 - 20 + 1 = 6.
 

# Constraints:

# 1 <= intervals.length <= 105
# 1 <= queries.length <= 105
# intervals[i].length == 2
# 1 <= lefti <= righti <= 107
# 1 <= queries[j] <= 107

# アプローチと解説
# この問題では、各クエリに対して対応する区間の最小サイズを効率的に見つけるためのアルゴリズムが求められます。以下の手順で進めます。

# アプローチ
# 区間のソート:

# 各区間をサイズが小さい順、同じサイズなら左端の位置が小さい順でソートします。これにより、特定の位置を含む最小の区間を効率的に検索できるようになります。
# クエリのソート:

# クエリを昇順に並べ替えます。
# 優先度付きキューを使った検索:

# ソートしたクエリを順に処理し、クエリが含まれる区間を優先度付きキューで管理します。クエリの値以下の区間だけをキューに保持し、クエリの範囲にないものは取り除きます。
# 優先度付きキューの先頭に最小サイズの区間が残るようにし、クエリがカバーする最小の区間を効率的に見つけます。

# require 'set'

def min_interval(intervals, queries)
  # 結果を格納するハッシュ
  result = {}

  # 区間をサイズの昇順でソート
  # 区間のサイズは、その区間に含まれる整数の数（つまり righti - lefti + 1）と定義されます。
  sorted_intervals = intervals.sort_by { |left, right| right - left + 1 }
  puts "ソートされた区間: #{sorted_intervals}"

  # クエリを昇順でソート
  sorted_queries = queries.sort
  puts "ソートされたクエリ: #{sorted_queries}"

  # 優先度キューとして機能する配列
  active_intervals = []
  interval_index = 0

  sorted_queries.each do |query|
    # クエリをカバーする区間を優先度キューに追加
    # interval_index < sorted_intervals.length: これにより、すべての区間を超えない限りループが続きます。
    # sorted_intervals[interval_index][0] <= query: 現在のクエリ query が区間の開始位置以上であれば、その区間は query を含む可能性があるため、ループに入ります。
    while interval_index < sorted_intervals.length && sorted_intervals[interval_index][0] <= query
      left, right = sorted_intervals[interval_index]
      if right >= query
        # 「区間のサイズと終了位置」を追加
        active_intervals << [right - left + 1, right]
        # active_intervals をサイズで昇順に並び替えることで、最小の区間が常に先頭に来る
        active_intervals.sort_by!(&:first)
      end
      interval_index += 1
    end

    # クエリを超える区間を除外
    # 現在のクエリ query を超えている（つまり query を含まない）区間を active_intervals から除外します。
    active_intervals.reject! { |_, right| right < query }

    # 結果を保存
    if active_intervals.empty?
      result[query] = -1
    else
      result[query] = active_intervals.first[0]
    end
    puts "クエリ #{query} に対する最小区間: #{result[query]}"
  end

  queries.map { |query| result[query] }
end

# テストケース1
puts "テストケース1: intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]"
puts "結果: #{min_interval([[1,4],[2,4],[3,6],[4,4]], [2,3,4,5])}"  # 期待される出力: [3,3,1,4]

# テストケース2
puts "\nテストケース2: intervals = [[2,3],[2,5],[1,8],[20,25]], queries = [2,19,5,22]"
puts "結果: #{min_interval([[2,3],[2,5],[1,8],[20,25]], [2,19,5,22])}"  # 期待される出力: [2,-1,4,6]
