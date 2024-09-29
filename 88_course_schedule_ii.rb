# https://qiita.com/Morifolium/items/6c8f0a188af2f9620db2

# There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

# For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
# Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

# 受講する必要がある numCourses 個のコースがあり、各コースは 0 から numCourses - 1 までラベル付けされています。prerequisites 配列が与えられており、prerequisites[i] = [ai, bi] の形式で前提条件が記載されています。これは、コース ai を受講するためには、まずコース bi を修了する必要があることを意味します。

# 例えば、[0, 1] のペアは、「コース 0 を受講する前にコース 1 を修了する必要がある」ことを示しています。

# すべてのコースを修了するための順番を返してください。もし複数の正しい解答がある場合は、どれを返しても構いません。全コースを修了することが不可能であれば、空の配列 [] を返してください。

# Example 1:

# Input: numCourses = 2, prerequisites = [[1,0]]
# Output: [0,1]
# Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
# Example 2:

# Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
# Output: [0,2,1,3]
# Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
# So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
# Example 3:

# Input: numCourses = 1, prerequisites = []
# Output: [0]
 

# Constraints:

# 1 <= numCourses <= 2000
# 0 <= prerequisites.length <= numCourses * (numCourses - 1)
# prerequisites[i].length == 2
# 0 <= ai, bi < numCourses
# ai != bi
# All the pairs [ai, bi] are distinct.

# 解法の概要
# この問題はトポロジカルソートを使って解決できます。トポロジカルソートは、有向グラフにおける順序付けを求めるアルゴリズムで、コースの依存関係を解決するために使用します。

# グラフと入次数の作成:

# コースを頂点とし、前提条件をエッジとしてグラフを作成します。
# 各コースの「入次数」（依存しているコースの数）をカウントします。
# BFS を用いてトポロジカルソートを実行:

# 入次数が 0 のコースをキューに追加します。
# キューから順番にコースを取り出し、そのコースの依存先（次に受講できるコース）の入次数を減らしていき、入次数が 0 になったコースを再度キューに追加します。
# これを繰り返し、全コースを訪問できたか確認します。
# 結果の出力:

# すべてのコースを訪問できた場合、コースの順序を返します。
# 訪問できないコースが残っている場合は、空の配列 [] を返します。

def find_order(num_courses, prerequisites)
  # ステップ1: グラフと入次数の初期化
  graph = Array.new(num_courses) { [] }  # コース間の依存関係を示すグラフ
  # indegree は、各コースの入次数（他のコースが先に修了する必要がある数）を保持します。
  # 入次数が 0 のノードはどのコースからも依存されていないので、まず処理することができます。
  indegree = Array.new(num_courses, 0)   # 各コースの入次数

  # ステップ2: グラフと入次数の設定
  prerequisites.each do |course, prereq|
    graph[prereq] << course  # 前提条件が prereq のとき、course へ向かうエッジを追加
    indegree[course] += 1    # 入次数を増加
  end

  # ステップ3: 入次数が 0 のコースをキューに追加
  queue = []
  (0...num_courses).each do |i|
    if indegree[i] == 0
      queue << i
    end
  end

  puts "Initial queue: #{queue}"  # 最初のキューの状態を表示

  # ステップ4: BFS によるトポロジカルソート
  order = []  # コースの順序を保存する配列
  while !queue.empty?
    course = queue.shift
    order << course
    puts "Processing course #{course}, current order: #{order}"

    # このコースから依存しているコースの入次数を 1 減らす
    graph[course].each do |next_course|
      indegree[next_course] -= 1
      puts "Reduced indegree of course #{next_course} to #{indegree[next_course]}"

      # 入次数が 0 になったコースをキューに追加
      if indegree[next_course] == 0
        queue << next_course
        puts "Course #{next_course} added to queue"
      end
    end
  end

  # ステップ5: 全コースを訪問できた場合、order を返す
  if order.size == num_courses
    puts "Final course order: #{order}"
    return order
  else
    puts "Cannot complete all courses, returning empty array"
    return []
  end
end

# テストケース
num_courses = 4
prerequisites = [[1, 0], [2, 0], [3, 1], [3, 2]]
puts "Input: numCourses = #{num_courses}, prerequisites = #{prerequisites}"
result = find_order(num_courses, prerequisites)
puts "Output: #{result}"

# 具体例を用いて説明します。以下の例を使いながら、どのようにコースの順序を求めているのかを詳しく見ていきます。

# ### 例
# - **入力**:
#   ```ruby
#   num_courses = 4
#   prerequisites = [[1, 0], [2, 0], [3, 1], [3, 2]]
#   ```
#   - コース数：4
#   - 前提条件：[[1, 0], [2, 0], [3, 1], [3, 2]]
  
#   **意味**:
#   - コース 1 を受講するには、まずコース 0 を修了しなければならない。
#   - コース 2 を受講するには、まずコース 0 を修了しなければならない。
#   - コース 3 を受講するには、まずコース 1 とコース 2 を修了しなければならない。

# ### ステップ1: グラフと入次数の初期化
# - グラフを構築し、各コースの前提条件（依存関係）を記録します。
#   ```ruby
#   graph = Array.new(num_courses) { [] }
#   indegree = Array.new(num_courses, 0)
#   ```
#   - `graph` は、各コースに対して、依存しているコースを保持する配列です。
#   - `indegree` は、各コースの入次数（他のコースが先に修了する必要がある数）を保持します。

# ### ステップ2: グラフと入次数の設定
# - `prerequisites` を元に、`graph` と `indegree` を更新します。

#   - `prerequisites = [[1, 0], [2, 0], [3, 1], [3, 2]]`
#   - これを順番に処理します。

#   1. `[1, 0]` を処理:
#      - コース 1 を受講するには、コース 0 が必要。
#      - `graph[0] << 1`  → `graph = [[1], [], [], []]`
#      - `indegree[1] += 1` → `indegree = [0, 1, 0, 0]`

#   2. `[2, 0]` を処理:
#      - コース 2 を受講するには、コース 0 が必要。
#      - `graph[0] << 2` → `graph = [[1, 2], [], [], []]`
#      - `indegree[2] += 1` → `indegree = [0, 1, 1, 0]`

#   3. `[3, 1]` を処理:
#      - コース 3 を受講するには、コース 1 が必要。
#      - `graph[1] << 3` → `graph = [[1, 2], [3], [], []]`
#      - `indegree[3] += 1` → `indegree = [0, 1, 1, 1]`

#   4. `[3, 2]` を処理:
#      - コース 3 を受講するには、コース 2 が必要。
#      - `graph[2] << 3` → `graph = [[1, 2], [3], [3], []]`
#      - `indegree[3] += 1` → `indegree = [0, 1, 1, 2]`

# - 最終的なグラフの状態:
#   - `graph = [[1, 2], [3], [3], []]`
#   - 各コースの入次数:
#   - `indegree = [0, 1, 1, 2]`
  
# ### ステップ3: 入次数が 0 のコースをキューに追加
# - `indegree` をチェックし、入次数が 0 のコース（どのコースからも依存されていないコース）をキューに追加します。

#   - 入次数が 0 のコース:
#     - コース 0 の入次数は 0 → キューに追加
#     - `queue = [0]`
  
#   ```ruby
#   puts "Initial queue: #{queue}"  # 出力: "Initial queue: [0]"
#   ```

# ### ステップ4: BFS によるトポロジカルソート
# - キューからコースを順番に取り出し、そのコースを修了すると受講可能になるコースの入次数を減らしていきます。

# 1. **コース 0** を修了:
#    - `queue = [0]`
#    - `order = []`
#    - コース 0 の依存コース → コース 1, コース 2
#    - コース 1 の入次数を 1 から 0 に減らす → `indegree = [0, 0, 1, 2]`
#    - コース 2 の入次数を 1 から 0 に減らす → `indegree = [0, 0, 0, 2]`
#    - 入次数が 0 になったコース 1 と 2 をキューに追加 → `queue = [1, 2]`
#    - `order = [0]`

#    ```ruby
#    puts "Processing course 0, current order: [0]"
#    puts "Reduced indegree of course 1 to 0"
#    puts "Course 1 added to queue"
#    puts "Reduced indegree of course 2 to 0"
#    puts "Course 2 added to queue"
#    ```

# 2. **コース 1** を修了:
#    - `queue = [1, 2]`
#    - `order = [0]`
#    - コース 1 の依存コース → コース 3
#    - コース 3 の入次数を 2 から 1 に減らす → `indegree = [0, 0, 0, 1]`
#    - `queue = [2]`
#    - `order = [0, 1]`

#    ```ruby
#    puts "Processing course 1, current order: [0, 1]"
#    puts "Reduced indegree of course 3 to 1"
#    ```

# 3. **コース 2** を修了:
#    - `queue = [2]`
#    - `order = [0, 1]`
#    - コース 2 の依存コース → コース 3
#    - コース 3 の入次数を 1 から 0 に減らす → `indegree = [0, 0, 0, 0]`
#    - 入次数が 0 になったコース 3 をキューに追加 → `queue = [3]`
#    - `order = [0, 1, 2]`

#    ```ruby
#    puts "Processing course 2, current order: [0, 1, 2]"
#    puts "Reduced indegree of course 3 to 0"
#    puts "Course 3 added to queue"
#    ```

# 4. **コース 3** を修了:
#    - `queue = [3]`
#    - `order = [0, 1, 2]`
#    - `order = [0, 1, 2, 3]`
#    - キューが空になり終了

#    ```ruby
#    puts "Processing course 3, current order: [0, 1, 2, 3]"
#    ```

# ### ステップ5: 結果の判定
# - `order` の長さが `num_courses` と等しければ、全コースを修了できたことを意味するので、`order` を返します。
# - もし `order` の長さが `num_courses` より少なければ、循環依存があるため修了不可能です。

# ```ruby
# puts "Final course order: [0, 1, 2, 3]"
# return [0, 1, 2, 3]
# ```
