# Given an integer array nums that may contain duplicates, return all possible 
# subsets
#  (the power set).

# The solution set must not contain duplicate subsets. Return the solution in any order.

# 重複が含まれる可能性がある整数の配列 nums が与えられたとき、その配列のすべての可能な部分集合（パワーセット）を返してください。

# 解答セットには重複した部分集合が含まれてはいけません。解答は任意の順序で返されます。

# Example 1:

# Input: nums = [1,2,2]
# Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]
# Example 2:

# Input: nums = [0]
# Output: [[],[0]]
 

# Constraints:

# 1 <= nums.length <= 10
# -10 <= nums[i] <= 10

# アプローチ
# この問題では、重複した要素を持つ配列からすべての部分集合を生成し、それぞれの部分集合が一度だけ出力されるようにします。再帰的にアプローチすることで、部分集合を構築し、重複する部分集合を回避します。

# ソート: 最初に nums をソートすることで、同じ値が連続して現れるようにします。これにより、同じ値が何度も使われるのを防ぐことが容易になります。

# バックトラッキング: 再帰的に部分集合を生成し、重複を避けるために同じ値を連続して使わないようにする。



def subsets_with_dup(nums)
  result = []
  nums.sort!  # 重複を処理しやすくするためにソート
  backtrack([], nums, 0, result)
  result
end

# バックトラック用のヘルパーメソッド
def backtrack(current_subset, nums, start, result)
  result << current_subset.clone  # 部分集合を保存
  puts "Adding subset: #{current_subset.clone}"  # 経過を表示

  (start...nums.length).each do |i|
    # 同じ値を繰り返さないために、重複をスキップ
    next if i > start && nums[i] == nums[i - 1]
    current_subset << nums[i]
    puts "Using #{nums[i]}, current subset: #{current_subset}"  # 経過を表示
    backtrack(current_subset, nums, i + 1, result)
    removed = current_subset.pop  # 戻るために要素を削除
    puts "Backtracking by removing #{removed}, current subset: #{current_subset}"  # 経過を表示
  end
end

# 実行例
nums = [1, 2, 2]
puts "Input array: #{nums}"
result = subsets_with_dup(nums)
puts "All subsets: #{result}"
