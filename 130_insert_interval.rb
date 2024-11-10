# You are given an array of non-overlapping intervals intervals where intervals[i] = [starti, endi] represent the start and the end of the ith interval and intervals is sorted in ascending order by starti. You are also given an interval newInterval = [start, end] that represents the start and end of another interval.

# Insert newInterval into intervals such that intervals is still sorted in ascending order by starti and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).

# Return intervals after the insertion.

# Note that you don't need to modify intervals in-place. You can make a new array and return it.

# 互いに重ならない区間の配列 intervals が与えられます。各 intervals[i] = [starti, endi] は、i 番目の区間の開始と終了を表しており、intervals は starti に基づいて昇順にソートされています。また、別の区間 newInterval = [start, end] も与えられます。

# この newInterval を intervals に挿入し、intervals が starti に基づいて昇順にソートされ、重ならない区間であることを保つようにします（必要に応じて重なった区間はマージします）。

# 挿入後の区間リストを返してください。

# なお、intervals を直接変更する必要はありません。新しい配列を作成して返しても構いません。

# Example 1:

# Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
# Output: [[1,5],[6,9]]
# Example 2:

# Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
# Output: [[1,2],[3,10],[12,16]]
# Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
 

# Constraints:

# 0 <= intervals.length <= 104
# intervals[i].length == 2
# 0 <= starti <= endi <= 105
# intervals is sorted by starti in ascending order.
# newInterval.length == 2
# 0 <= start <= end <= 105

# アプローチと解説
# この問題では、新しい区間 newInterval を既存の区間に挿入し、重複する区間があればそれをマージする必要があります。以下のステップで解決します。

# アプローチ
# 新しい配列 merged_intervals を用意:

# 挿入結果を保存するために新しい配列を作成します。
# 既存の区間をループ処理:

# 各区間 interval と newInterval の位置関係に応じて、以下の処理を行います。
# 3つのケースを考慮:

# interval が newInterval よりも左側（重ならない場合）：そのまま interval を merged_intervals に追加します。
# interval が newInterval よりも右側（重ならない場合）：newInterval を追加し、newInterval の挿入が終わったため、残りの区間もすべて追加します。
# interval と newInterval が重なる場合：newInterval の開始と終了を、interval と newInterval の範囲の中で最も小さい開始と最大の終了に更新します（マージ）。
# 最後に残った newInterval を追加:

# ループが終了した後、newInterval がまだ挿入されていない場合は追加します。

def insert(intervals, new_interval)
  merged_intervals = []
  
  intervals.each do |interval|
    # 1. 新しい区間が現在の区間の左側にある場合（重ならない）
    if interval[1] < new_interval[0]
      merged_intervals << interval
    # 2. 新しい区間が現在の区間の右側にある場合（重ならない）
    elsif interval[0] > new_interval[1]
      merged_intervals << new_interval
      new_interval = interval
    # 3. 重なっている場合、new_interval を更新してマージ
    else
      new_interval[0] = [new_interval[0], interval[0]].min
      new_interval[1] = [new_interval[1], interval[1]].max
    end
    puts "途中経過: #{merged_intervals}, new_interval: #{new_interval}"
  end

  # 最後の new_interval を追加
  merged_intervals << new_interval
  merged_intervals
end

# テストケース1
puts "テストケース1: intervals = [[1,3],[6,9]], newInterval = [2,5]"
puts "結果: #{insert([[1,3],[6,9]], [2,5])}"  # 期待される出力: [[1,5],[6,9]]

# テストケース2
puts "\nテストケース2: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]"
puts "結果: #{insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8])}"  # 期待される出力: [[1,2],[3,10],[12,16]]
