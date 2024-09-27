# There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

# For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
# Return true if you can finish all courses. Otherwise, return false.

# 大学のコースをすべて履修することができるかを判定する問題です。合計 numCourses 個のコースがあり、各コースは 0 から numCourses - 1 までの番号でラベル付けされています。コース間の順序関係は prerequisites 配列で指定されており、prerequisites[i] = [ai, bi] は、コース ai を受講するには、まずコース bi を受講しなければならないことを示しています。

# 例えば、[0, 1] の場合、コース 0 を取る前にコース 1 を取る必要があります。

# すべてのコースを順序どおりに取ることが可能かどうかを判定して、可能なら true、不可能なら false を返してください。

# Example 1:

# Input: numCourses = 2, prerequisites = [[1,0]]
# Output: true
# Explanation: There are a total of 2 courses to take. 
# To take course 1 you should have finished course 0. So it is possible.
# Example 2:

# Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
# Output: false
# Explanation: There are a total of 2 courses to take. 
# To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
 

# Constraints:

# 1 <= numCourses <= 2000
# 0 <= prerequisites.length <= 5000
# prerequisites[i].length == 2
# 0 <= ai, bi < numCourses
# All the pairs prerequisites[i] are unique.

# 解説:
# この問題は グラフのサイクル検出問題 です。コース間の依存関係をグラフ構造として考え、各コースをノード、順序関係をエッジとして扱います。具体的には、prerequisites は有向グラフを形成します。例えば、[1, 0] はノード 0 からノード 1 へのエッジを意味します。

# すべてのコースを履修できるためには、グラフが**サイクルを含んでいない（有向非巡回グラフ：DAG）**必要があります。サイクルが存在する場合、循環依存が発生し、特定のコースを先に履修することが不可能になります。

# アルゴリズムの手法:
# 有向グラフの作成:
# 各コースをノードとし、順序関係 prerequisites に基づいてグラフを構築します。
# トポロジカルソートを使用してサイクル検出を行います。
# DFS（深さ優先探索）を使用して、訪問済みノードと現在の探索中のノードを追跡します。
# 現在のパスに同じノードが再度登場した場合、サイクルがあることがわかります。


def can_finish(num_courses, prerequisites)
  # 1. グラフを作成（各コースをノードとし、依存関係をエッジとして構築）
  graph = Array.new(num_courses) { [] } # コースの数だけ空の配列を作成
  prerequisites.each do |course, prereq|
    graph[prereq] << course
  end

  # 2. ノードの訪問状況を管理する配列
  # 0: 未訪問, 1: 探索中, 2: 完了
  visit = Array.new(num_courses, 0)

  # 3. DFS関数を定義してサイクルを検出
  def has_cycle?(graph, node, visit)
    return true if visit[node] == 1  # 探索中のノードに再訪問した場合はサイクルあり
    return false if visit[node] == 2 # 完了しているノードはスキップ

    # 現在のノードを「探索中」に設定
    visit[node] = 1

    # 隣接ノードを再帰的に探索
    graph[node].each do |neighbor|
      return true if has_cycle?(graph, neighbor, visit)
    end

    # 現在のノードを「完了」に設定
    visit[node] = 2
    false
  end

  # 4. 各ノードに対してDFSを実行してサイクルを検出
  (0...num_courses).each do |course|
    puts "Checking course #{course}..."
    return false if has_cycle?(graph, course, visit)  # サイクルが見つかった場合
  end

  true  # サイクルがなければ全コースを履修可能
end

# テストケースの実行
puts can_finish(2, [[1,0]])       # 出力: true
puts can_finish(2, [[1,0],[0,1]]) # 出力: false
