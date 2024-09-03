# You are given an array of integers stones where stones[i] is the weight of the ith stone.

# We are playing a game with the stones. On each turn, we choose the heaviest two stones and smash them together. Suppose the heaviest two stones have weights x and y with x <= y. The result of this smash is:

# If x == y, both stones are destroyed, and
# If x != y, the stone of weight x is destroyed, and the stone of weight y has new weight y - x.
# At the end of the game, there is at most one stone left.

# Return the weight of the last remaining stone. If there are no stones left, return 0.

# 整数の配列 stones が与えられ、その中の各要素 stones[i] は第 i の石の重さを表します。

# 私たちは石を使ったゲームを行います。各ターンで、最も重い2つの石を選び、それらを衝突させます。最も重い2つの石の重さが x と y （x <= y）であるとします。この衝突の結果は次の通りです：

# もし x == y なら、両方の石が破壊されます。
# もし x != y なら、重さが x の石は破壊され、重さが y の石は新しい重さ y - x になります。
# ゲームの終わりには、石が最大で1つ残ります。

# 最後に残った石の重さを返してください。もし石が1つも残らない場合は 0 を返します。


# Example 1:

# Input: stones = [2,7,4,1,8,1]
# Output: 1
# Explanation: 
# We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
# we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
# we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
# we combine 1 and 1 to get 0 so the array converts to [1] then that's the value of the last stone.
# Example 2:

# Input: stones = [1]
# Output: 1
 

# Constraints:

# 1 <= stones.length <= 30
# 1 <= stones[i] <= 1000

# 実装と解説
# この問題を解決するためには、常に最も重い石2つを選ぶ必要があります。そこで、最大ヒープを使って最も重い2つの石を効率的に取得し、それらを衝突させる処理を行います。

# 最大ヒープは、要素を降順で取り出すことができるデータ構造です。Rubyには組み込みのヒープがないため、負の値を使用して最小ヒープを最大ヒープとして利用します。

class LastStoneWeight
  def last_stone_weight(stones)
    # 負の値を使って最大ヒープをシミュレート
    heap = stones.map { |stone| -stone } # すべての値を負にする
    heap.sort! # 最大ヒープのシミュレートのためにソート

    puts "Initial heap: #{heap.map { |h| -h }}" # 初期のヒープを出力

    while heap.size > 1
      heaviest = -heap.shift # 最も重い石を取り出す
      second_heaviest = -heap.shift # 2番目に重い石を取り出す
      puts "Smashing stones with weights #{heaviest} and #{second_heaviest}"

      if heaviest != second_heaviest
        new_stone = heaviest - second_heaviest
        puts "New stone with weight #{new_stone} added to the heap"
        heap.push(-new_stone) # 新しい石をヒープに追加
        heap.sort! # 再ソートして最大ヒープを維持
      end
      puts "Current heap: #{heap.map { |h| -h }}" # 現在のヒープを出力
    end

    last_stone = heap.empty? ? 0 : -heap.first
    puts "The last stone weight is: #{last_stone}"
    last_stone
  end
end

# 使用例
solver = LastStoneWeight.new
puts solver.last_stone_weight([2,7,4,1,8,1])  # 出力は1
puts solver.last_stone_weight([1])            # 出力は1
