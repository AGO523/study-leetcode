# Given an array of intervals intervals where intervals[i] = [starti, endi], return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

# Note that intervals which only touch at a point are non-overlapping. For example, [1, 2] and [2, 3] are non-overlapping.

# 整数区間の配列 intervals が与えられます。各 intervals[i] = [starti, endi] は1つの区間の開始と終了を表しています。重ならないようにするために削除する必要がある最小の区間の数を返してください。

# 注意：ある点でのみ接している区間（例えば [1, 2] と [2, 3]）は、重ならないと見なされます。

# Example 1:

# Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
# Output: 1
# Explanation: [1,3] can be removed and the rest of the intervals are non-overlapping.
# Example 2:

# Input: intervals = [[1,2],[1,2],[1,2]]
# Output: 2
# Explanation: You need to remove two [1,2] to make the rest of the intervals non-overlapping.
# Example 3:

# Input: intervals = [[1,2],[2,3]]
# Output: 0
# Explanation: You don't need to remove any of the intervals since they're already non-overlapping.
 

# Constraints:

# 1 <= intervals.length <= 105
# intervals[i].length == 2
# -5 * 104 <= starti < endi <= 5 * 104

# アプローチと解説
# この問題は、重なる区間をできるだけ少なくするために、いくつかの区間を削除する必要があります。以下の手順で解決できます。

# アプローチ
# 区間を終了時間でソート:

# まず、各区間の終了位置 endi に基づいて intervals を昇順にソートします。終了時間が早い区間を優先して残すことで、次の区間が重ならずに済む可能性が高くなります。
# 重ならない区間の選択:

# last_end を設定し、最初は最も早く終了する区間の終了時間を記録します。
# 各区間をループ処理し、現在の区間が last_end よりも開始時間が早い場合、その区間は重なっているため、削除が必要です。
# 重ならない場合、その区間を残し、last_end をその区間の終了時間に更新します。
# 削除数のカウント:

# 重なった区間の数をカウントし、最終的に削除すべき区間の数として返します。

def erase_overlap_intervals(intervals)
  # 終了時間で区間をソート
  sorted_intervals = intervals.sort_by { |interval| interval[1] }
  puts "ソート後の区間: #{sorted_intervals}"

  # 初期化
  last_end = sorted_intervals[0][1]
  removals = 0

  # 1つ目の区間以降を走査
  sorted_intervals[1..].each do |interval|
    start, end_time = interval
    if start < last_end
      # 重なっている場合、削除が必要
      removals += 1
      puts "削除: 区間 #{interval}"
    else
      # 重ならない場合、last_end を更新
      last_end = end_time
      puts "重ならない: 更新後の last_end = #{last_end}"
    end
  end

  removals
end

# テストケース1
puts "テストケース1: intervals = [[1,2],[2,3],[3,4],[1,3]]"
puts "結果: #{erase_overlap_intervals([[1,2],[2,3],[3,4],[1,3]])}"  # 期待される出力: 1
