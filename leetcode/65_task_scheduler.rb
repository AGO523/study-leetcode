# You are given an array of CPU tasks, each represented by letters A to Z, and a cooling time, n. Each cycle or interval allows the completion of one task. Tasks can be completed in any order, but there's a constraint: identical tasks must be separated by at least n intervals due to cooling time.

# ​Return the minimum number of intervals required to complete all tasks.

# CPUタスクの配列 tasks が与えられ、各タスクは "A" から "Z" の文字で表されます。また、クールダウン時間 n が与えられます。各サイクル（またはインターバル）では1つのタスクが完了します。タスクは任意の順序で完了できますが、同じタスクを実行するには、少なくとも n インターバル以上の間隔が必要です。

# 全てのタスクを完了するために必要な最小のインターバル数を返してください。

# Example 1:

# Input: tasks = ["A","A","A","B","B","B"], n = 2

# Output: 8

# Explanation: A possible sequence is: A -> B -> idle -> A -> B -> idle -> A -> B.

# After completing task A, you must wait two cycles before doing A again. The same applies to task B. In the 3rd interval, neither A nor B can be done, so you idle. By the 4th cycle, you can do A again as 2 intervals have passed.

# Example 2:

# Input: tasks = ["A","C","A","B","D","B"], n = 1

# Output: 6

# Explanation: A possible sequence is: A -> B -> C -> D -> A -> B.

# With a cooling interval of 1, you can repeat a task after just one other task.

# Example 3:

# Input: tasks = ["A","A","A", "B","B","B"], n = 3

# Output: 10

# Explanation: A possible sequence is: A -> B -> idle -> idle -> A -> B -> idle -> idle -> A -> B.

# There are only two types of tasks, A and B, which need to be separated by 3 intervals. This leads to idling twice between repetitions of these tasks.

 

# Constraints:

# 1 <= tasks.length <= 104
# tasks[i] is an uppercase English letter.
# 0 <= n <= 100


# 解説
# この問題は、同じタスクが n インターバル離れていないといけないという制約のもとで、すべてのタスクを最も効率的に完了するための最小インターバル数を求める問題です。n が0の場合は、クールダウンなしで連続してタスクを実行できるため、単純な順序のタスク実行だけで解決できます。しかし、n > 0 の場合には、どのようにタスクを並べて idle を最小限にするかが重要です。

# 以下の考え方を用います：

# もっとも頻繁に現れるタスク（例: "A"）を基準にします。
# そのタスクが再度実行されるまでの間に他のタスクを挟むことで idle を最小化します。
# 全体のインターバル数は、タスクの頻度とクールダウン時間 n の関係によって決まります。
# アプローチ
# 各タスクの出現回数をカウントします。
# もっとも多く出現するタスクの頻度とクールダウン n を基に、最小インターバル数を計算します。
# 残りのタスクを挟むか、必要な場合は idle を追加します。

def least_interval(tasks, n)
  # タスクの頻度をカウント
  task_counts = Hash.new(0)
  # ['A','A','A','B','B','B'] => {'A'=>3, 'B'=>3}
  tasks.each { |task| task_counts[task] += 1 }

  # タスクの頻度の最大値を求める
  max_count = task_counts.values.max
  # 最大頻度のタスクがいくつあるかを数える
  max_count_tasks = task_counts.values.count { |count| count == max_count }

  # 必要な最小インターバル数を計算する
  min_intervals = (max_count - 1) * (n + 1) + max_count_tasks

  # 実際のタスクの数と比較して大きい方を返す（最小インターバルがタスク数を下回ることはない）
  [min_intervals, tasks.size].max
end

# 実行例
puts "Example 1: #{least_interval(['A','A','A','B','B','B'], 2)}"  # 出力: 8
puts "Example 2: #{least_interval(['A','C','A','B','D','B'], 1)}"  # 出力: 6
puts "Example 3: #{least_interval(['A','A','A','B','B','B'], 3)}"  # 出力: 10

# (max_count - 1) * (n + 1)
# この部分は、最も頻繁に現れるタスクの再実行のために必要な「枠」の数を表しています。

# max_count - 1：

# 最も頻繁に現れるタスクの出現回数が max_count であるとき、そのタスクの間に空ける間隔は max_count - 1 個です。
# 例えば、タスクAが3回出現する場合、A _ _ A _ _ A というように、タスクAの間には2つの間隔が必要です。
# n + 1：

# クールダウン n のために、同じタスクの間に挟む必要があるタスクの数（または idle 時間）は n です。さらに、実際のタスク（例えば A）自体も考慮するため、n + 1 の「枠」が必要です。
# 結果的に、(max_count - 1) * (n + 1) は、最も頻繁に現れるタスクを配置するために必要な「フレーム」（各タスクとその間の間隔）の数です。

# + max_count_tasks
# この部分は、最も頻繁に現れるタスクの最後のサイクルを加えるために使われます。

# タスクAが max_count 回登場し、クールダウンの間に他のタスクや idle を挟むと、最後のタスクAはそのまま置けます。
# したがって、最後の「枠」には、同じ出現回数のタスク（max_count_tasks の数）を置くことができます。
