# Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

# 整数の区間の配列 intervals が与えられます。各 intervals[i] = [starti, endi] は区間の開始と終了を表します。重なり合うすべての区間をマージし、入力内のすべての区間をカバーする、重ならない区間の配列を返してください。

# 入力: intervals = [[1,3],[2,6],[8,10],[15,18]]

# 出力: [[1,6],[8,10],[15,18]]

# 説明: 区間 [1,3] と [2,6] が重なっているので、これらを [1,6] にマージします。

# Example 1:

# Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
# Output: [[1,6],[8,10],[15,18]]
# Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
# Example 2:

# Input: intervals = [[1,4],[4,5]]
# Output: [[1,5]]
# Explanation: Intervals [1,4] and [4,5] are considered overlapping.
 

# Constraints:

# 1 <= intervals.length <= 104
# intervals[i].length == 2
# 0 <= starti <= endi <= 104

# アプローチと解説
# この問題では、重なり合う区間をすべてマージする必要があります。以下の手順で解決します。

# アプローチ
# 区間を開始位置でソートする:

# まず、区間の開始位置 (starti) に基づいて intervals を昇順にソートします。
# マージ処理:

# ソートされた区間を順に走査し、現在の区間が前の区間と重なっているかを確認します。
# 重なっている場合、区間をマージします（終了位置を更新）。
# 重ならない場合、結果リストに前の区間を追加し、現在の区間を次の比較対象にします。
# 最後の区間を追加:

# ループが終了したら、最後の区間を結果リストに追加します。

def merge_intervals(intervals)
  return intervals if intervals.empty?
  # 区間を開始位置でソート
  sorted_intervals = intervals.sort_by { |interval| interval[0] }
  puts "ソート後の区間: #{sorted_intervals}"

  # マージされた区間を格納する配列
  merged = []

  # 最初の区間を初期の比較対象として設定
  current_interval = sorted_intervals[0]

  sorted_intervals.each_with_index do |interval, index|
    puts "現在の区間: #{current_interval}, 比較対象の区間: #{interval}"

    if current_interval[1] >= interval[0]
      # 重なっている場合、終了位置を更新
      current_interval[1] = [current_interval[1], interval[1]].max
      puts "区間をマージ: #{current_interval}"
    else
      # 重ならない場合、現在の区間を結果に追加し、次の区間を現在の区間に設定
      merged << current_interval
      puts "区間を追加: #{current_interval}"
      current_interval = interval
    end
  end

  # 最後の区間を追加
  merged << current_interval
  puts "最終的な区間を追加: #{current_interval}"

  merged
end

# テストケース1
puts "テストケース1: intervals = [[1,3],[2,6],[8,10],[15,18]]"
result1 = merge_intervals([[1,3],[2,6],[8,10],[15,18]])
puts "結果: #{result1}"  # 期待される出力: [[1,6],[8,10],[15,18]]
