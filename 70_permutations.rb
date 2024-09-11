# Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

# 異なる整数を含む配列 nums が与えられたとき、考えられるすべての順列を返してください。順列はどのような順序でもかまいません。

# Example 1:

# Input: nums = [1,2,3]
# Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
# Example 2:

# Input: nums = [0,1]
# Output: [[0,1],[1,0]]
# Example 3:

# Input: nums = [1]
# Output: [[1]]
 

# Constraints:

# 1 <= nums.length <= 6
# -10 <= nums[i] <= 10
# All the integers of nums are unique.

# 解説
# この問題は「順列の全列挙」を求めるものです。順列の全列挙を行うためにはバックトラッキングを利用するのが適しています。

# 順列を生成するために、各要素を一度だけ使用するようにし、すべての可能な配置を試します。
# 再帰的に部分的な順列を構築し、要素がすべて使用された場合に解答に追加します。
# 各ステップで使用した要素を追跡し、それを再帰的に探索する際に使わないようにします。

def permute(nums)
  result = []  # 順列を格納する配列

  # バックトラッキング関数
  def backtrack(nums, current_permutation, used, result)
    # すべての要素を使った場合、完成した順列を追加
    if current_permutation.length == nums.length
      result << current_permutation.clone
      puts "Complete permutation: #{current_permutation}"
      return
    end

    # 使われていない要素を選んで順列を作る
    nums.each_with_index do |num, i|
      # すでに使われた要素はスキップする
      # 再帰でこの行に戻ってきたときに、同じ要素をスキップする
      next if used[i]

      # 要素を使う
      used[i] = true
      current_permutation << num
      puts "Using #{num}, current permutation: #{current_permutation}"

      # 再帰的に次の要素を選ぶ
      backtrack(nums, current_permutation, used, result)

      # バックトラッキング: 要素を元に戻す
      removed = current_permutation.pop
      used[i] = false
      puts "Backtracking by removing #{removed}, current permutation: #{current_permutation}"
    end
  end

  # 初期状態でバックトラッキングを開始
  backtrack(nums, [], Array.new(nums.length, false), result)

  result
end

# 実行例
nums = [1, 2, 3]
puts "Input: #{nums}"
result = permute(nums)
puts "All permutations: #{result}"
