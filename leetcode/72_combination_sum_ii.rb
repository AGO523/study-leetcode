# Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.

# Each number in candidates may only be used once in the combination.

# Note: The solution set must not contain duplicate combinations.

# 問題を日本語にしてください。
# 回答をコメント付きで解説してください。
# プログラムを実行したときに、経過がわかるよう、puts を入れてください


# Example 1:

# Input: candidates = [10,1,2,7,6,1,5], target = 8
# Output: 
# [
# [1,1,6],
# [1,2,5],
# [1,7],
# [2,6]
# ]
# Example 2:

# Input: candidates = [2,5,2,1,2], target = 5
# Output: 
# [
# [1,2,2],
# [5]
# ]
 

# Constraints:

# 1 <= candidates.length <= 100
# 1 <= candidates[i] <= 50
# 1 <= target <= 30

# アプローチ
# この問題は、バックトラッキング（再帰）を使って探索を行う問題です。候補の数値を使って、指定された目標値 target を作るすべての組み合わせを求めます。各数値は1回しか使えないため、再帰の際には使った数値を再度使わないように管理します。

# ソート: 最初に candidates をソートします。これにより、重複する数値を処理しやすくし、最適な順序で探索を行います。

# バックトラッキング: 再帰的に組み合わせを探索し、目標値を達成できるかを確認します。重複する組み合わせを防ぐために、同じ数値を連続して使わないようにします。


def combination_sum2(candidates, target)
  result = []
  candidates.sort!  # ソートすることで重複の処理をしやすくする
  backtrack([], candidates, target, 0, result)
  result
end

def backtrack(current_combination, candidates, target, start, result)
  if target == 0
    # targetが0になったら、目標を達成した組み合わせとして結果に追加
    result << current_combination.clone
    return
  end
  
  (start...candidates.length).each do |i|
    # 重複する値をスキップする
    next if i > start && candidates[i] == candidates[i - 1]

    # 現在の候補値がtargetを超えていたら終了（以降の候補値も超えるため）
    break if candidates[i] > target
    current_combination << candidates[i]
    # 再帰呼び出し: 次の候補値を選択する
    # target - candidates[i] で目標値を減らすことで、
    # if target == 0 の条件に合致するまで探索を続ける
    backtrack(current_combination, candidates, target - candidates[i], i + 1, result)
    current_combination.pop
  end
end

# 実行例
candidates = [10, 1, 2, 7, 6, 1, 5]
target = 8
puts "Input candidates: #{candidates}, target: #{target}"
result = combination_sum2(candidates, target)
puts "All combinations: #{result}"
