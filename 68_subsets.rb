# Given an integer array nums of unique elements, return all possible 
# subsets
#  (the power set).

# The solution set must not contain duplicate subsets. Return the solution in any order.

# 整数の一意な要素を持つ配列 nums が与えられたとき、すべての 部分集合（パワーセット）を返してください。

# 解の集合には重複する部分集合を含まないようにし、解はどのような順序で返しても構いません。

# Example 1:

# Input: nums = [1,2,3]
# Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
# Example 2:

# Input: nums = [0]
# Output: [[],[0]]
 

# Constraints:

# 1 <= nums.length <= 10
# -10 <= nums[i] <= 10
# All the numbers of nums are unique.

# 回答
# この問題は、与えられた数値リストからすべての部分集合（パワーセット）を生成するという問題です。再帰やバックトラッキングを使うことで、各要素を含むか含まないかを選びながら、全ての部分集合を作成できます。

# 実装
# 再帰的に要素を追加するアプローチを取ります。要素を一つずつ確認し、それを現在の部分集合に含めるかどうかの2通りを試しながら進みます。
# 全ての要素を処理した時点で、生成した部分集合を解として保存します。

def subsets(nums)
  result = []  # 部分集合を格納するためのリスト

  # バックトラッキング関数。部分集合を構築し、最終的な結果に追加する。
  def backtrack(start, current, nums, result)
    # 現在の部分集合を結果に追加
    result << current.clone
    puts "Current subset: #{current}"

    # 各要素を一つずつ確認し、部分集合を構築
    (start...nums.size).each do |i|
      current << nums[i]  # 要素を部分集合に追加
      puts "Adding #{nums[i]} to current subset"
      
      # 次のステップに進む
      backtrack(i + 1, current, nums, result)
      
      # 最後に追加した要素を取り除き、次のループに備える
      current.pop
      puts "Backtracking: removed #{nums[i]} from current subset"
    end
    # 再帰的に処理を行う backtrack 関数では、ループの各ステップで次の要素を追加した後、その状態で再帰的に backtrack が呼ばれます。しかし、その再帰呼び出しが終わると、呼び出し元に戻って処理が再開されます。そして次の要素に進み、再度別の部分集合を構築するために backtrack が呼ばれるのです。
    # 再帰的な呼び出しは深さ優先で進行し、ある分岐の処理が終了するたびに呼び出し元に戻ります。その後、次のループステップで別の分岐が試されます。
  end

  # 初期状態から再帰を開始
  backtrack(0, [], nums, result)
  result
end

# 実行例
nums = [1, 2, 3]
puts "Input: #{nums}"
result = subsets(nums)
puts "Output: #{result}"


# 他の再帰呼び出し
# 再帰的な呼び出しは深さ優先で進行し、ある分岐の処理が終了するたびに呼び出し元に戻ります。その後、次のループステップで別の分岐が試されます。

# この動作により、すべての組み合わせが網羅されるまで再帰が繰り返され、最終的に全ての部分集合が生成されます。
# 空 [] (スタート)
# ├── 1 追加: [1]
# │   ├── 2 追加: [1, 2]
# │   │   ├── 3 追加: [1, 2, 3]  → 終了して戻る
# │   │   └── 3 削除して戻る: [1, 2] → ループの次へ進む
# │   ├── 3 追加: [1, 3]
# │   └── 3 削除して戻る: [1]
# └── 1 削除して戻る: []
#     ├── 2 追加: [2]
#     │   ├── 3 追加: [2, 3]
#     │   └── 3 削除して戻る: [2]
#     └── 2 削除して戻る: []
#         ├── 3 追加: [3]
#         └── 3 削除して終了: []
